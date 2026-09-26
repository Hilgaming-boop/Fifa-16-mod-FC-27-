-- Original Scripts MVNPROD --IMPROVED MOUNTSA --
local Standings = {}
local bndMatchList1 = "bnd_standings_list"
local bndFixturesList = "bnd_fixtures_list"

ligaId = 1
currentMatch = {
  HomeTeamID = 0,
  AwayTeamID = 0,
  HomeKitIndex = 0,
  AwayKitIndex = 1
}

LEAGUE = currentLeagueIndex
local rivalListData = {}
local matchesPlayed = 0

if not round then round = 1 else round = round end
if not selectedteam then selectedteam = 0 else selectedteam = selectedteam end

function Standings:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    settingsService = o.api("SettingsService"),
    SquadManagementService = o.api("SquadMgtService")
  }
  o.currentOptions = o.services.settingsService.GetCurrentOptions()
  o.Init()
  
  o.im.Subscribe(bndMatchList1, function() o:publishStandingsRows() end)
  o.im.Subscribe(bndFixturesList, function() o:publishFixturesRows() end)
  o.im.Subscribe("bnd_matchday_label", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_team_label", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_month_label", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_league_name", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_league_label", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_league_logo", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_background_career", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_standings_career", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_table_career", function() o:publishHomeInfo() end)
  o.im.RegisterAction("act_next_team", function() o:NextTeam() end)
  o.im.RegisterAction("act_prev_team", function() o:PrevTeam() end)
  o.im.RegisterAction("act_next_matchday", function() o:NextMatchday() end)
  o.im.RegisterAction("act_prev_matchday", function() o:PrevMatchday() end)
  return o
end

function Standings:Init()
  local LigaGroupingList = LigaGrouping[ligaId]
  for i = 1, table.getn(LigaGroupingList) do
    local obj = {
      homeID = LigaGroupingList[i][1],
      awayID = LigaGroupingList[i][2],
      homeScore = LigaGroupingList[i][4],
      awayScore = LigaGroupingList[i][5],
      data = {}
    }
    table.insert(rivalListData, obj)
  end
end

function Standings:publishStandingsRows()
    if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
        SelectedTeamID = currentSelectedTeamID
    elseif selectedteam and selectedteam ~= 0 then
        SelectedTeamID = TeamList[selectedteam]
    elseif currentMatch and currentMatch.HomeTeamID and currentMatch.HomeTeamID ~= 0 then
        SelectedTeamID = currentMatch.HomeTeamID
    end

    local teamStats = {}

     -- Kumpulin semua data tim
  for _, teamID in ipairs(TeamList) do
    table.insert(teamStats, {
      id   = teamID,
      name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID), -- ambil nama tim buat sorting alfabet
      pts  = tonumber(GetTeamPoints(teamID)),
      gd   = tonumber(GetTeamGoalsScored(teamID)) - tonumber(GetTeamGoalsConceded(teamID)),
      ga   = tonumber(GetTeamGoalsScored(teamID)),
    })
  end

    ---
    -- 🔹 Cek apakah semua tim masih 0 poin, 0 GD, 0 GF
    local allZero = true
    for _, stat in ipairs(teamStats) do
        if stat.pts ~= 0 or stat.gd ~= 0 or stat.gf ~= 0 then
            allZero = false
            break
        end
    end

    ---
    -- 🔹 Urutkan standings (hanya kalau sudah ada hasil pertandingan)
    if not allZero then
        table.sort(teamStats, function(a, b)
            if a.pts ~= b.pts then
                return a.pts > b.pts
            elseif a.gd ~= b.gd then
                return a.gd > b.gd
            elseif a.gf ~= b.gf then
                return a.gf > b.gf
            else
                return a.name < b.name
            end
        end)
    else
        -- 🚩 Kalau masih kosong semua, urutkan alfabet saja
        table.sort(teamStats, function(a, b)
            return a.name < b.name
        end)
    end

    ---
    -- 🔹 Rank label otomatis sesuai liga
    local leagueRankLabels = {
}

    local rankLabels = leagueRankLabels[IDLeague] or {}

    -- 🔹 Generate daftar tim
local teamDataList = {}
for _, stat in ipairs(teamStats) do
    local teamID = stat.id
    local teamData = {}

    teamData.TeamCrest = { name = "$Crest64x64", id = teamID }
    teamData.TeamName = stat.name
    teamData.TeamWin = tostring(GetTeamWins(teamID))
    teamData.TeamDraw = tostring(GetTeamDraws(teamID))
    teamData.TeamLoss = tostring(GetTeamLosses(teamID))
    teamData.TeamPoint = stat.pts
    teamData.TeamGA = tonumber(GetTeamGoalsScored(teamID))   -- Goals For
    teamData.TeamGC = tonumber(GetTeamGoalsConceded(teamID)) -- Goals Against
    teamData.TeamGD = stat.gd                                -- Goal Difference
    teamData.Teammp = GLOBAL_MATCHUP_COUNT
    teamData.clickAction = "ViewTeamDetails_" .. teamID
    teamData.TeamScoreFontColor = "0xffffff"
    teamData.TeamNameFontColor = "0xffffff"
    teamData.FontColor = "0xffffff"

    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.Icon = { name = "$my_team", id = teamID }
    else
        teamData.Icon = nil
    end

    table.insert(teamDataList, { data = teamData })
end

-- ============================================================
-- 🔹 Sorting utama (Points > GD > Goals For > Nama tim)
-- ============================================================
table.sort(teamDataList, function(a, b)
    if a.data.TeamPoint ~= b.data.TeamPoint then
        return a.data.TeamPoint > b.data.TeamPoint
    end
    if a.data.TeamGD ~= b.data.TeamGD then
        return a.data.TeamGD > b.data.TeamGD
    end
    if a.data.TeamGA ~= b.data.TeamGA then
        return a.data.TeamGA > b.data.TeamGA
    end
    return a.data.TeamName < b.data.TeamName
end)

-- ============================================================
-- 🔹 Kalau semua poin = 0 → urutkan alfabet
-- ============================================================
local allZeroPoints = true
for _, team in ipairs(teamDataList) do
    if team.data.TeamPoint > 0 then
        allZeroPoints = false
        break
    end
end

if allZeroPoints then
    table.sort(teamDataList, function(a, b)
        return a.data.TeamName < b.data.TeamName
    end)
end

-- ============================================================
-- 🔹 Tambahkan posisi & label relegasi/juara sesuai rank
-- ============================================================
for i, team in ipairs(teamDataList) do
    local pos = i
    team.data.Teampos = tostring(pos)

    -- Ambil label dari mapping (misal Champion, UCL, Relegation, dll.)
    local label = rankLabels[pos] or ""
    team.data.RelegationText = label
    team.data.RightText = ""

    -- Debug
    print(string.format(
        "[DEBUG] Team: %s | Posisi: %d | Label: %s",
        team.data.TeamName, pos, label
    ))
end

-- 🔹 Publish ke UI
self.im.Publish(bndMatchList1, teamDataList)
end

function Standings:publishFixturesRows()
  local filteredRivalListData = {}
  local matchCount = (#TeamList / 2)

  for i, v in ipairs(rivalListData) do
    local shouldIncludeMatch = false
    if selectedteam == 0 then
      shouldIncludeMatch = i >= ((round * matchCount) - (matchCount - 1)) and i <= (round * matchCount)
    else
      shouldIncludeMatch = (v.homeID == TeamList[selectedteam] or v.awayID == TeamList[selectedteam])
    end
    
    local SelectedTeamID = nil
  if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
    SelectedTeamID = currentSelectedTeamID
  elseif selectedteam and selectedteam ~= 0 then
    SelectedTeamID = TeamList[selectedteam]
  end

    if shouldIncludeMatch then
      v.data.TeamHomeCrest = { name = "$Crest64x64", id = v.homeID }
      v.data.TeamAwayCrest = { name = "$Crest64x64", id = v.awayID }
      v.data.TeamHomeName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.homeID)
      v.data.TeamAwayName = self.loc.LocalizeString("TeamName_Abbr3_" .. v.awayID)

      local maxRowsWithScores = GLOBAL_MATCHUP_COUNT * 10
      if i <= maxRowsWithScores then
        rivalListData[i].data.MatchScore = rivalListData[i].homeScore .. " - " .. rivalListData[i].awayScore
      else
        rivalListData[i].data.MatchScore = "VS"
      end

      v.data.TeamScoreFontColor = "0xffffff"
      v.data.TeamNameFontColor = "0x4A2C6D"
      v.data.FontColor = "0xffffff"

      v.data.HomeIcon = (rivalListData[i].homeID == SelectedTeamID) and { name = "$my_team", id = rivalListData[i].homeID } or nil
      v.data.AwayIcon = (rivalListData[i].awayID == SelectedTeamID) and { name = "$my_team", id = rivalListData[i].awayID } or nil
      
      v.data.RightText = ""
      table.insert(filteredRivalListData, v)
    end
  end

  self.im.Publish(bndFixturesList, filteredRivalListData)
end

-- ============================================================
-- 🔹 Generator Kalender Matchday: Mulai 1 Agustus - Akhir 31 Mei
-- ============================================================
local function generateMatchdayDates(teamCount)
    local matchdayDates = {}
    local totalMatchday = (teamCount - 1) * 2   -- double round robin

    -- Rentang musim
    local startTime = os.time{year=2025, month=8, day=1}
    local endTime   = os.time{year=2026, month=5, day=31}
    local seasonDays = os.difftime(endTime, startTime) / (24 * 60 * 60)

    -- Jeda rata-rata antar matchday
    local interval = math.floor(seasonDays / (totalMatchday - 1)) * 24 * 60 * 60

    for md = 1, totalMatchday do
        local date = os.date("*t", startTime + (md - 1) * interval)
        matchdayDates[md] = {day=date.day, month=date.month, year=date.year}
    end

    return matchdayDates
end

-- ============================================================
-- 🔹 Ambil tanggal utk matchday tertentu
-- ============================================================
local function getMatchdayDate(matchdayNumber, matchdayDates)
    return matchdayDates[matchdayNumber] or {day=31, month=5, year=2026}
end

-- ============================================================
-- 🔹 Update publishHomeInfo
-- ============================================================
function Standings:publishHomeInfo()
    
leagueNames = {
    [1]    = "3F Superliga",
    [4]    = "Jupiler Pro League",
    [7]    = "Brasileirão Serie A",
    [10]   = "Eredivisie",
    [13]   = "Premier League",
    [14]   = "Sky Bet Championship",
    [16]   = "Ligue 1 McDonald’s",
    [17]   = "Ligue 2 BKT",
    [19]   = "Bundesliga",
    [20]   = "2. Bundesliga",
    [31]   = "Serie A Enilive",
    [32]   = "Serie BKT",
    [39]   = "MLS",
    [41]   = "Eliteserien",
    [50]   = "cinch Premiership",
    [53]   = "LaLiga EA SPORTS",
    [54]   = "LaLiga HYPERMOTION",
    [56]   = "Allsvenskan",
    [60]   = "League One",
    [61]   = "League Two",
    [65]   = "SSE Premier Div",
    [66]   = "Ekstraklasa",
    [67]   = "Russian Premier",
    [68]   = "Süper Lig",
    [76]   = "Rest of World",
    [77]   = "Rest of World (2)",
    [78]   = "International",
    [80]   = "ADMIRAL Bundesliga",
    [83]   = "K League 1",
    [189]  = "Super League",
    [308]  = "Liga Portugal",
    [330]  = "SuperLiga Romania",
    [335]  = "Campeonato Scotiabank",
    [336]  = "Liga Colombia",
    [338]  = "Campeonato Uruguay",
    [341]  = "Liga MX",
    [347]  = "DStv Premiership",
    [349]  = "J1 League",
    [350]  = "Saudi League",
    [351]  = "A-League Men",
    [353]  = "Torneo Binance",
    [365]  = "AFC",
    [1107] = "HK Premier",
    [1114] = "Singapore Premier",
    [1115] = "Qatar Stars League",
    [1117] = "Uzbek Super League",
    [1170] = "Cambodian Premier",
    [1171] = "Myanmar National",
    [1172] = "Laos League 1",
    [1245] = "Classic Team",
    [1246] = "Classic Internasional",
    [1407] = "Bashundhara Premier",
    [2012] = "Chinese Super League",
    [2013] = "ADNOC Pro League",
    [2034] = "Mobilis Ligue 1",
    [2076] = "3. Liga",
    [2136] = "Intl Women",
    [2149] = "Indian Super League",
    [2215] = "Frauen-Bundesliga",
    [2216] = "WSL",
    [2218] = "Division 1 Féminine",
    [2221] = "NWSL",
    [2222] = "Liga F",
    [2231] = "Egypt Premier",
    [2235] = "BRI Super League",
    [2236] = "UCL",
    [2237] = "Super League Malaysia",
    [2238] = "UEL",
    [2240] = "UEFA WCL",
    [2250] = "Botola Pro",
    [2252] = "Thai League 1",
    [2254] = "Pegadaian Championship",
    [2255] = "PNM Liga Nusantara",
    [2260] = "V.League 1",
    [2264] = "ASEAN U23",
}

-- 🔹 Fungsi ambil nama liga
function GetLeagueNameByID(leagueID)
    if leagueNames[leagueID] then
        return leagueNames[leagueID]
    else
        return leagueNames[0] -- fallback → League 0
    end
end
    self.leagueIDs = { 13, 14, 16, 19, 2235, 31, 341, 10, 308, 350, 50, 53, 68, 39, 353, 4, 7 }
    local l = self.loc.LocalizeString("" .. IDLeague)
    local leagueCrest = { name = "$LeagueLogo2", id = IDLeague }
    leagueName = GetLeagueNameByID(IDLeague)  -- fallback 0
    LeagueLogo = leagueCrest

    local monthNames = {
        "January","February","March","April","May","June",
        "July","August","September","October","November","December"
    }

    -- 🔹 Generate kalender sesuai jumlah tim
    local matchdayDates = generateMatchdayDates(#TeamList)

    -- 🔹 Ambil tanggal utk round saat ini
    local matchDate = getMatchdayDate(round, matchdayDates)
    local currentMonthName = monthNames[matchDate.month]
    local dateString = matchDate.day .. " " .. currentMonthName .. " " .. matchDate.year

    -- 🔹 Publish label Matchday + tanggal
    self.im.Publish("bnd_matchday_label", "Matchday " .. round)
    self.im.Publish("bnd_date_label", dateString)

    -- 🔹 Nama bulan / tim + FIXTURES
    if selectedteam == 0 then
        self.im.Publish("bnd_team_label", currentMonthName .. "")
    else
        local teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. TeamList[selectedteam])
        self.im.Publish("bnd_team_label", teamName .. " FIXTURES")
    end

    -- 🔹 Bulan bawah juga ditambah FIXTURES
    self.im.Publish("bnd_month_label", currentMonthName .. "")

    -- 🔹 Logo & background
    self.im.Publish("bnd_league_logo", LeagueLogo)
    self.im.Publish("bnd_league_name", leagueName)
    self.im.Publish("bnd_background_career", {name = "$BackgroundCareer", id = IDLeague})
  self.im.Publish("bnd_standings_career", {name = "$Logo_Standing", id = IDLeague})
  self.im.Publish("bnd_table_career", {name = "$TableCareer", id = IDLeague})
end

-- ============================================================
-- 🔹 Navigasi Matchday (Circular)
-- ============================================================
function Standings:NextMatchday()
    if not TeamList or #rivalListData == 0 then return end

    local matchCount = math.floor(#TeamList / 2)
    local maxRound = #rivalListData / matchCount

    if round < maxRound then
        round = round + 1
    else
        -- Kalau sudah di matchday terakhir, balik ke awal
        round = 1
    end

    self:publishFixturesRows()
    self:publishHomeInfo()
end

function Standings:PrevMatchday()
    if not TeamList or #rivalListData == 0 then return end

    local matchCount = math.floor(#TeamList / 2)
    local maxRound = #rivalListData / matchCount

    if round > 1 then
        round = round - 1
    else
        -- Kalau sudah di matchday pertama, lompat ke matchday terakhir
        round = maxRound
    end

    self:publishFixturesRows()
    self:publishHomeInfo()
end


-- ============================================================
-- 🔹 Navigasi Team
-- ============================================================
function Standings:NextTeam()
    if not TeamList then return end

    local teamCount = #TeamList
    selectedteam = selectedteam + 1

    if selectedteam > teamCount then
        selectedteam = 0
    end

    self:publishFixturesRows()
    self:publishHomeInfo()
end

function Standings:PrevTeam()
    if not TeamList then return end

    local teamCount = #TeamList

    if selectedteam > 0 then
        selectedteam = selectedteam - 1
    else
        selectedteam = teamCount
    end

    self:publishFixturesRows()
    self:publishHomeInfo()
end

function Standings:finalize()
  self.im.Unsubscribe("bnd_standings_list")
  self.im.Unsubscribe("bnd_fixtures_list")
  self.im.Unsubscribe("bnd_matchday_label")
  self.im.Unsubscribe("bnd_team_label")
  self.im.Unsubscribe("bnd_month_label")
  self.im.Unsubscribe("bnd_league_label")
  self.im.Unsubscribe("bnd_league_name")
  self.im.Unsubscribe("bnd_league_logo")
  self.im.Unsubscribe("bnd_background_career")
  self.im.Unsubscribe("bnd_standings_career")
  self.im.Unsubscribe("bnd_table_career")
  rivalListData = {}
end

return Standings
-- Original Scripts MVNPROD --IMPROVED MOUNTSA --