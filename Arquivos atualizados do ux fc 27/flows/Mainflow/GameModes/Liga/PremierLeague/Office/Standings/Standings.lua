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
  o.im.Subscribe("bnd_league_label", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_league_logo", function() o:publishHomeInfo() end)
  o.im.Subscribe("bnd_league_name", function() o:publishHomeInfo() end)
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

  -- 🔹 Kumpulin semua data tim
  for _, teamID in ipairs(TeamList) do
    table.insert(teamStats, {
      id   = teamID,
      name = self.loc.LocalizeString("TeamName_Abbr15_" .. teamID), -- ambil nama tim buat sorting alfabet
      pts  = tonumber(GetTeamPoints(teamID)),
      gd   = tonumber(GetTeamGoalsScored(teamID)) - tonumber(GetTeamGoalsConceded(teamID)),
      ga   = tonumber(GetTeamGoalsScored(teamID)),
    })
  end

  ------------------------------------------------------------------
  -- 🔹 Cek apakah semua tim masih 0 poin, 0 GD, 0 GF
  ------------------------------------------------------------------
  local allZero = true
  for _, stat in ipairs(teamStats) do
    if stat.pts ~= 0 or stat.gd ~= 0 or stat.ga ~= 0 then
      allZero = false
      break
    end
  end

  ------------------------------------------------------------------
  -- 🔹 Urutkan standings (hanya kalau sudah ada hasil pertandingan)
  ------------------------------------------------------------------
  if not allZero then
    table.sort(teamStats, function(a, b)
      if a.pts ~= b.pts then
        return a.pts > b.pts
      elseif a.gd ~= b.gd then
        return a.gd > b.gd
      elseif a.ga ~= b.ga then
        return a.ga > b.ga
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

  local leagueRankLabels = {
  ----------------------------------------------------------------
  -- UEFA (Eropa - Liga Utama)
  ----------------------------------------------------------------
  [1]  = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [14]="Relegation" }, -- Denmark Superliga
  [4]  = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [14]="Relegation" }, -- Belgium Pro League
  [7]  = { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana", [18]="Relegation" }, -- Brazil Serie A
  [10] = { [1]="Champion", [2]="UEFA Champions League", [3]="UCL Quals", [4]="UEFA Europa League", [5]="UEFA Conference League", [10]="Relegation" }, -- Netherlands Eredivisie
  [13] = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [18]="Relegation" }, -- England Premier League
  [16] = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [16]="Relegation" }, -- France Ligue 1
  [19] = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [16]="Relegation" }, -- Germany 1. Bundesliga
  [31] = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [18]="Relegation" }, -- Italy Serie A
  [53] = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [18]="Relegation" }, -- Spain Primera División
  [56] = { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League", [14]="Relegation" }, -- Sweden Allsvenskan
  [65] = { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League" }, -- Rep. Ireland Premier Division
  [66] = { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League", [16]="Relegation" }, -- Poland Ekstraklasa
  [67] = { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League", [15]="Relegation" }, -- Russia Premier Liga
  [68] = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [16]="Relegation" }, -- Turkey Süper Lig
  [80] = { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League", [10]="Relegation" }, -- Austria Bundesliga
  [189]= { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League", [11]="Relegation" }, -- Switzerland Super League
  [308]= { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [16]="Relegation" }, -- Portugal Primeira Liga
  [330]= { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [16]="Relegation" }, -- Romania Liga I
  [335]= { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana", [14]="Relegation" }, -- Chile Primera División
  [336]= { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana" }, -- Colombia Categoría Primera A
  [338]= { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana", [14]="Relegation" }, -- Uruguay Primera División
  [341]= { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana", [15]="Relegation" }, -- Mexico Liga MX
  [347]= { [1]="Champion", [2]="CAF Champions League", [3]="CAF Confederation Cup", [14]="Relegation" }, -- South Africa Premier Division
  [349]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [16]="Relegation" }, -- Japan J1 League
  [350]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [16]="Relegation" }, -- Saudi Arabia Pro League
  [351]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [11]="Relegation" }, -- Australia A-League
  [353]= { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana", [27]="Relegation" }, -- Argentina Primera División
  [365]= { [1]="Champion" }, -- AFC generic
  [1107]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Hong Kong Premier League
  [1114]= { [1]="Champion", [2]="AFC Champions League Elite"}, -- Singapore Premier League
  [1115]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [10]="Relegation" }, -- Qatar Stars League
  [1117]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Uzbekistan Super League
  [1170]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Cambodia Premier League
  [1171]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Myanmar National League
  [1172]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Laos League 1
  [1245]= { [1]="Champion" }, -- Classic Team
  [1246]= { [1]="Champion" }, -- Classic Internasional
  [1407]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Bangladesh Premier League
  [2012]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [16]="Relegation" }, -- China Super League
  [2013]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [12]="Relegation" }, -- UAE Pro-League
  [2034]= { [1]="Champion", [2]="CAF Champions League", [3]="CAF Confederation Cup", [14]="Relegation" }, -- Algeria Ligue Professionnelle 1
  [2076]= { [1]="Promoted", [2]="Promoted", [5]="Playoff", [18]="Relegation" }, -- Germany 3. Liga
  [2136]= { [1]="Champion" }, -- International Women
  [2149]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- Indian Super League
  [2215]= { [1]="Champion", [2]="UEFA Women's Champions League", [12]="Relegation" }, -- Germany Frauen-Bundesliga
  [2216]= { [1]="Champion", [2]="UEFA Women's Champions League", [10]="Relegation" }, -- England FA Women's Super League
  [2218]= { [1]="Champion", [2]="UEFA Women's Champions League", [15]="Relegation" }, -- France Division 1 Féminine
  [2221]= { [1]="Champion", [2]="UEFA Women's Champions League" }, -- USA NWSL
  [2222]= { [1]="Champion", [2]="UEFA Women's Champions League", [14]="Relegation" }, -- Spain Liga F Femenina
  [2231]= { [1]="Champion", [2]="CAF Champions League", [3]="CAF Confederation Cup", [17]="Relegation" }, -- Egyptian Premier League
  [2235]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [16]="Relegation" }, -- BRI Liga 1 (Indonesia)
  [2236]= { [1]="Champion" }, -- Champions League Men
  [2237]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [11]="Relegation" }, -- Liga Super Malaysia
  [2238]= { [1]="Champion" }, -- Europa League
  [2240]= { [1]="Champion" }, -- Champions League Women
  [2250]= { [1]="Champion", [2]="CAF Champions League", [3]="CAF Confederation Cup", [14]="Relegation" }, -- Botola Pro Inwi
  [2252]= { [1]="Champion", [2]="AFC Champions League Elite", [4]="AFC Champions League Two", [5]="AFC Challenge League", [14]="Relegation" }, -- Thai League 1
  [2254]= { [1]="Promoted", [2]="Promoted", [5]="Playoff", [18]="Relegation" }, -- Pegadaian Liga 2
  [2255]= { [1]="Champion" }, -- PNM Liga Nusantara
  [2260]= { [1]="Champion", [2]="AFC Champions League Elite" }, -- V.League 1
  [2264]= { [1]="Champion" }, -- ASEAN U23 Championship
  [78]  = { [1]="Champion" }, -- International
  [39]  = { [1]="Champion", [2]="Copa Libertadores", [3]="Copa Sudamericana" }, -- USA Major League Soccer (no relegation)
  [41]  = { [1]="Champion", [2]="UEFA Champions League", [5]="UEFA Europa League", [6]="UEFA Conference League", [16]="Relegation" }, -- Norway Eliteserien
  [50]  = { [1]="Champion", [2]="UEFA Champions League", [3]="UEFA Europa League", [4]="UEFA Conference League", [10]="Relegation" }, -- Scotland Premiership
  [60]  = { [1]="Promoted", [2]="Promoted", [5]="Playoff", [22]="Relegation" }, -- England Football League One
  [61]  = { [1]="Promoted", [2]="Promoted", [5]="Playoff", [24]="Relegation" }, -- England League Two
}
  local rankLabels = leagueRankLabels[IDLeague] or {}

-- ============================================================
-- 🔹 Mapping posisi untuk asset $Baris tambahan per liga
-- ============================================================
local barisMapping = {
    [13] = {1,2,5,6,18}, -- Premier League
    [19] = {1,2,5,6,16}, -- Bundesliga
    [31] = {1,2,5,6,18}, -- Serie A
    [53] = {1,2,5,6,18}, -- La Liga
    [16] = {1,2,5,6,16}, -- Ligue 1
    [10] = {1,2,3,4,5,16}, -- Eredivisie
    [4]  = {1,2,5,6,14}, -- Belgium
    [50] = {1,2,3,4,10}, -- Scotland
    [68] = {1,2,5,6,16}, -- Turkey
    [308]= {1,2,5,6,16}, -- Portugal
    [80] = {1,2,3,4,10}, -- Austria
    [189]= {1,2,3,4,11}, -- Switzerland
    [1]  = {1,2,3,4,10}, -- Denmark
    [65] = {1,2,3,4}, -- Ireland
    [66] = {1,2,3,4,16}, -- Poland
    [56] = {1,2,3,4,14}, -- Sweden
    [67] = {1,2,3,4,15}, -- Russia
    [41] = {1,2,5,6,16}, -- Norway Eliteserien
    [17] = {1,2,5,18}, -- Ligue 2
    [60] = {1,2,5,22}, -- League One
    [61] = {1,2,5,24}, -- League Two
    [2254]= {1,2,5,18}, -- Pegadaian Liga 2
    [7]   = {1,2,3,18}, -- Brazil
    [353] = {1,2,3,27}, -- Argentina
    [341] = {1,2,3,15}, -- Mexico
    [336] = {1,2,3,15}, -- Colombia
    [338] = {1,2,3}, -- Uruguay
    [335] = {1,2,3,14}, -- Chile
    [39]  = {1,2,3},    -- MLS
    [350] = {1,2,4,5,16}, -- Saudi Pro League
    [349] = {1,2,4,5,16}, -- Japan J1
    [83]  = {1,2,4,5,10}, -- Korea K League 1
    [2012]= {1,2,4,5,16}, -- China
    [2149]= {1,2}, -- India
    [2235]= {1,2,4,5,16}, -- Indonesia
    [2237]= {1,2,4,5,11}, -- Malaysia
    [2252]= {1,2,4,5,14}, -- Thailand
    [2260]= {1,2}, -- Vietnam
    [351] = {1,2,4,5,11}, -- Australia A-League
    [1114]= {1,2},  -- Singapore
    [1115]= {1,2,4,5,10}, -- Qatar
    [1117]= {1,2}, -- Uzbekistan
    [1107]= {1,2},  -- Hong Kong
    [1170]= {1,2},  -- Cambodia
    [1407]= {1,2}, -- Bangladesh
    [2013]= {1,2,4,5,12}, -- UAE
    [1171]= {1,2}, -- Myanmar
    [1172]= {1,2},  -- Laos
    [2231]= {1,2,3,17}, -- Egypt
    [2034]= {1,2,3,14}, -- Algeria
    [347] = {1,2,3,14}, -- South Africa
    [2250]= {1,2,3,14}, -- Morocco
    [2216]= {1,2,10}, -- England WSL
    [2218]= {1,2,15}, -- France D1
    [2222]= {1,2,14}, -- Spain Liga F
    [2221]= {1,2},    -- NWSL
    [2215]= {1,2,12}, -- Frauen Bundesliga
    [76]  = {1},
    [77]  = {1},
    [78]  = {1},
    [1245]= {1},
    [1246]= {1},
    [365]= {1},
    [2136]= {1},
    [2236]= {1},
    [2238]= {1},
    [2240]= {1},
    [2255]= {1}, -- Liga Nusantara
    [2264]= {1}, -- ASEAN U23 Championship
    [2076]= {1,2,5,18}, -- Germany 3. Liga
}

-- Fungsi untuk cek apakah posisi termasuk mapping $Baris
local function hasBarisAsset(pos)
    local mapping = barisMapping[IDLeague] or {}
    for _, p in ipairs(mapping) do
        if p == pos then return true end
    end
    return false
end

-- ============================================================
-- 🔹 Opponent Cache (jadwal lawan per tim)
-- ============================================================
local OpponentCache = {}
for _, fixture in ipairs(rivalListData) do
    -- Home lawan Away
    OpponentCache[fixture.homeID] = OpponentCache[fixture.homeID] or {}
    table.insert(OpponentCache[fixture.homeID], fixture.awayID)

    -- Away lawan Home
    OpponentCache[fixture.awayID] = OpponentCache[fixture.awayID] or {}
    table.insert(OpponentCache[fixture.awayID], fixture.homeID)
end

-- ============================================================
-- 🔹 Bangun data standings
-- ============================================================
local teamDataList = {}
for _, stat in ipairs(teamStats) do
    local teamID   = stat.id
    local teamData = {}

    -- Background utama
    teamData.RowBG = { name = "$Baris_Row" }

    -- Crest tim
    teamData.TeamCrest = { name = "$Crest64x64", id = teamID }
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamCrest = { name = "$Crest64x64", id = teamID }
    else
        teamData.myTeamCrest = nil
    end

    -- Statistik utama
    teamData.TeamName  = stat.name
    
    if SelectedTeamID and teamID == SelectedTeamID then
    teamData.myTeamName = stat.name
    else
    teamData.myTeamName = ""  -- atau bisa nil kalau mau benar-benar kosong
    end
    
    teamData.TeamWin   = tostring(GetTeamWins(teamID))
    
    if SelectedTeamID and teamID == SelectedTeamID then
    teamData.myTeamWin = tostring(GetTeamWins(teamID))
    else
    teamData.myTeamWin = ""
    end
    
    teamData.TeamDraw  = tostring(GetTeamDraws(teamID))
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamDraw = tostring(GetTeamDraws(teamID))
    else
        teamData.myTeamDraw = ""
    end
    
    teamData.TeamLoss = tostring(GetTeamLosses(teamID))
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamLoss = tostring(GetTeamLosses(teamID))
    else
        teamData.myTeamLoss = ""
    end

    teamData.TeamPoint = stat.pts
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamPoint = stat.pts
    else
        teamData.myTeamPoint = ""
    end

    teamData.TeamGA = tonumber(GetTeamGoalsScored(teamID))
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamGA = tonumber(GetTeamGoalsScored(teamID))
    else
        teamData.myTeamGA = ""
    end

    teamData.TeamGC = tonumber(GetTeamGoalsConceded(teamID))
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamGC = tonumber(GetTeamGoalsConceded(teamID))
    else
        teamData.myTeamGC = ""
    end

    teamData.TeamGD = stat.gd
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeamGD = stat.gd
    else
        teamData.myTeamGD = ""
    end

    teamData.Teammp = GLOBAL_MATCHUP_COUNT
    
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.myTeammp = GLOBAL_MATCHUP_COUNT
    else
        teamData.myTeammp = ""
    end
    teamData.clickAction          = "ViewTeamDetails_" .. teamID
    teamData.TeamScoreFontColor   = "0xffffff"
    teamData.TeamNameFontColor    = "0xffffff"
    teamData.FontColor            = "0xffffff"

    -- Highlight tim terpilih
    if SelectedTeamID and teamID == SelectedTeamID then
        teamData.Icon = { name = "$my_team", id = teamID }
    else
        teamData.Icon = nil
    end

    -- Next opponent crest
    local opponentList = OpponentCache[teamID] or {}
    local played = tonumber(GLOBAL_MATCHUP_COUNT) or 0
    if played < #opponentList then
        local nextOpponentID = opponentList[played + 1]
        if nextOpponentID and nextOpponentID ~= 0 then
            teamData.NextOpponentCrest = { name = "$Crest64x64", id = nextOpponentID }
        else
            teamData.NextOpponentCrest = nil
        end
    else
        teamData.NextOpponentCrest = nil
    end

    table.insert(teamDataList, { data = teamData })
end

-- ============================================================
-- 🔹 Sorting standings (Points > GD > GF > Nama)
-- ============================================================
table.sort(teamDataList, function(a,b)
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
-- 🔹 Aturan posisi & jumlah baris kosong per liga
-- ============================================================
local emptyRowRules = {
    [1] 	 = { [1]=3,[2]=3,[3]=3,[9]=3 }, -- Denmark Superliga 12 tim
    [4] 	 = { [1]=3,[4]=3,[5]=3,[13]=3 }, -- Belgium Pro League 16 tim
    [7] 	 = { [1]=3,[2]=3,[3]=3,[17]=3 }, -- Brazil Serie A 20 tim
    [10] 	 = { [1]=3,[2]=3,[3]=3,[4]=3,[15]=3 }, -- Netherlands Eredivisie 18 tim
    [13] 	 = { [1]=3,[4]=3,[5]=3,[17]=3 }, -- England Premier League 20 tim
    [16] 	 = { [1]=3,[4]=3,[5]=3,[15]=3 }, -- France Ligue 1 18 tim
    [19] 	 = { [1]=3,[4]=3,[5]=3,[15]=3 }, -- Germany 1. Bundesliga 18 tim
    [31] 	 = { [1]=3,[4]=3,[5]=3,[17]=3 }, -- Italy Serie A 20 tim
    [39] 	 = { [1]=3,[2]=3,[3]=3 }, -- MLS 30 tim
    [41] 	 = { [1]=3,[4]=3,[5]=3,[17]=3 }, -- Norway Eliteserien 18 tim
    [50] 	 = { [1]=3,[2]=3,[3]=3,[9]=3 }, -- Scotland Premiership 12 tim
    [53] 	 = { [1]=3,[4]=3,[5]=3,[17]=3 }, -- Spain Primera 20 tim
    [56] 	 = { [1]=3,[2]=3,[3]=3,[13]=3 }, -- Sweden Allsvenskan 16 tim
    [60] 	 = { [1]=3,[2]=3,[3]=3,[4]=3,[21]=3 }, -- England League One 21 tim
    [61] 	 = { [5]=3 }, -- England League Two 24 tim
    [65] 	 = { [1]=3,[2]=3,[3]=3 }, -- Rep. Ireland Premier Division 10 tim
    [66] 	 = { [1]=3,[2]=3,[3]=3,[15]=3 }, -- Poland Ekstraklasa 18 tim
    [67] 	 = { [1]=3,[2]=3,[3]=3,[14]=3,[17]=3 }, -- Russia Premier Liga 17 tim
    [68] 	 = { [1]=3,[4]=3,[5]=3,[15]=3 }, -- Turkey Süper Lig 18 tim
    [80] 	 = { [1]=3,[2]=3,[3]=3,[9]=3 }, -- Austria Bundesliga 11 tim
    [189] 	 = { [1]=3,[2]=3,[3]=3,[10]=3 }, -- Switzerland Super League 10 tim
    [308] 	 = { [1]=3,[4]=3,[5]=3,[15]=3 }, -- Portugal Primeira Liga 16 tim
    [330] 	 = { [1]=3,[4]=3,[5]=3 }, -- Romania Liga I 16 tim
    [335] 	 = { [1]=3,[2]=3 }, -- Chile Primera División 14 tim
    [336] 	 = { [1]=3,[2]=3,[3]=3,[16]=3 }, -- Colombia 18 tim
    [338] 	 = { [1]=3,[2]=3 }, -- Uruguay 14 tim
    [341] 	 = { [1]=3,[2]=3,[14]=3 }, -- Mexico Liga MX 16 tim
    [347] 	 = { [1]=3,[2]=3,[13]=3 }, -- South Africa 14 tim
    [349] 	 = { [1]=3,[4]=3,[5]=3,[17]=3 }, -- Japan J1 League 18 tim
    [350] 	 = { [1]=3,[3]=3,[4]=3,[15]=3 }, -- Saudi Arabia Pro League 16 tim
    [351] 	 = { [1]=3,[3]=3,[4]=3,[9]=3 }, -- Australia A-League 13 tim
    [353] 	 = { [1]=3,[2]=3,[26]=3 }, -- Argentina Primera División 14 tim
    [1107] 	 = { [1]=3 }, -- Hong Kong Premier League 9 tim
    [1114] 	 = { [1]=3 }, -- Singapore Premier League 8 tim
    [1115] 	 = { [1]=3,[3]=3,[4]=3,[9]=3 }, -- Qatar Stars League 12 tim
    [1117] 	 = { [1]=3 }, -- Uzbekistan Super League 14 tim
    [1170] 	 = { [1]=3 }, -- Cambodia Premier League 10 tim
    [1171] 	 = { [1]=3 }, -- Myanmar National League 12 tim
    [1172] 	 = { [1]=3 }, -- Laos League 1 8 tim
    [1407] 	 = { [1]=3 }, -- Bangladesh Premier League 10 tim
    [2012] 	 = { [1]=3,[3]=3,[4]=3,[15]=3 }, -- China Super League 16 tim
    [2013] 	 = { [1]=3,[3]=3,[4]=3,[11]=3 }, -- UAE Pro-League 14 tim
    [2034] 	 = { [1]=3,[2]=3,[3]=3,[13]=3 }, -- Algeria Ligue Professionnelle 1 16 tim
    [2149] 	 = { [1]=3 }, -- Indian Super League 14 tim
    [2215] 	 = { [1]=3,[11]=3 }, -- Germany Frauen-Bundesliga 10 tim
    [2216] 	 = { [1]=3,[9]=3 }, -- England FA Women's Super League 10 tim
    [2218] 	 = { [1]=3,[14]=3 }, -- France Division 1 Féminine 10 tim
    [2221] 	 = { [1]=3,[13]=3 }, -- USA NWSL 10 tim
    [2222] 	 = { [1]=3,[13]=3 }, -- Spain Liga F Femenina 10 tim
    [2231] 	 = { [1]=3,[2]=3,[15]=3,[16]=3 }, -- Egyptian Premier League 10 tim
    [2235] 	 = { [1]=3,[3]=3,[4]=3,[15]=3 }, -- BRI Liga 1 10 tim
    [2237] 	 = { [1]=3,[3]=3,[4]=3,[10]=3 }, -- Liga Super Malaysia
    [2250] 	 = { [1]=3,[2]=3,[13]=3 }, -- Botola Pro Inwi 10 tim
    [2252] 	 = { [1]=3,[3]=3,[4]=3,[13]=3 }, -- Thai League 1 16 tim
    [2254] 	 = { [1]=3,[4]=3,[17]=3 }, -- Pegadaian Liga 2 10 tim
    [2260] 	 = { [1]=3 } -- V.League 1 10 tim
}

local function getEmptyRows(tourId, rowIndex)
    local rules = emptyRowRules[tourId]

    if rules and rules[rowIndex] then
        return rules[rowIndex]
    end

    return 2 -- default semua baris kosong = 2
end


local emptyRule = emptyRowRules[IDLeague] or {}

local finalDataList = {}

-- header spacer
table.insert(finalDataList, { data = {   
    Teampos = "",
    TeamCrest = { name = "$Crest640x640", id = 0 },
    TeamName = "",
    TeamWin="", TeamDraw="", TeamLoss="", TeamPoint="",
    TeamGA="", TeamGC="", TeamGD="",
    NextOpponentCrest={ name="$Crest640x640", id=0 },
    RelegationText="", RightText="",
    RowBG={ name="$Baris_Rowx" }, RowBG2=nil
}})

for i, team in ipairs(teamDataList) do
    local pos = i
    team.data.Teampos = tostring(pos)
    team.data.RelegationText = rankLabels[pos] or ""
    team.data.RightText = ""

    if hasBarisAsset(pos) then
        team.data.RowBG2 = { name = "$Baris_Row" }
        team.data.RowBG3 = { name = "$Baris_Row_Aseet" }
    else
        team.data.RowBG2 = nil
        team.data.RowBG3 = nil
    end

    table.insert(finalDataList, team)

    -- gunakan getEmptyRows
    local numEmptyRows = getEmptyRows(IDLeague, pos)

    for n = 1, numEmptyRows do
        table.insert(finalDataList, { data = {
            Teampos = "", 
            TeamCrest = { name="$Crest640x640", id=0 }, 
            TeamName=" ", TeamWin=" ", TeamDraw=" ", 
            TeamLoss=" ", TeamPoint=" ", TeamGA=" ", 
            TeamGC=" ", TeamGD=" ",
            NextOpponentCrest = { name="$Crest640x640", id=0 }, 
            RelegationText="", RightText="", 
            FontScale=0.6, TextColor="0x80FFFFFF",
            RowBG = { name="$Baris_Rowx" },
            RowBG2 = hasBarisAsset(pos) and { name="$Baris_Rowx" } or nil,
            RowBG3 = hasBarisAsset(pos) and { name="$Baris_Row_Aseetx" } or nil
        }, smallRow=true })
    end
end

self.im.Publish(bndMatchList1, finalDataList)
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
  local l = self.loc.LocalizeString("" .. IDLeague)
  local leagueCrest = { name = "$LeagueLogo2", id = IDLeague }
  LeagueName = leagueLabels
  LeagueLogo = leagueCrest
  leagueName = GetLeagueNameByID(IDLeague)  -- 🔹 pakai fallback 0

  local dateString = GLOBAL_DATE_PLACEHOLDER
  local currentDay, currentMonth, currentYear = dateString:match("^(%d%d)/(%d%d)/(%d%d)")
  local mmdd = string.format("%02d%02d", tonumber(currentMonth), tonumber(currentDay))

  local excludedDates = {
    "0817", "0824", "0902", "0908", "0914", "0921", "0929", "1006", "1012", "1019", "1026",
    "1103", "1110", "1116", "1124", "1207", "1214", "1222", "1228", "1231", "0104", "0112",
    "0119", "0125", "0202", "0209", "0215", "0222", "0302", "0315", "0322", "0329", "0405",
    "0419", "0427", "0503", "0510", "0518"
  }

  local isExcludedDate = false
  for _, date in ipairs(excludedDates) do
    if mmdd == date then
      isExcludedDate = true
      break
    end
  end

  if GLOBAL_MATCHUP_COUNT > lastMatchupCount then
    isExcludedDate = false
    lastMatchupCount = GLOBAL_MATCHUP_COUNT
  end

  local daysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  if (tonumber(currentYear) % 4 == 0 and tonumber(currentYear) % 100 ~= 0) or (tonumber(currentYear) % 400 == 0) then
    daysInMonth[2] = 29
  end

  local displayDays = string.format("%02d", tonumber(currentDay))
  local monthNames = {
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  }
  local currentMonthName = monthNames[tonumber(currentMonth)]

  local dayNames = {
    "Sunday, ", "Monday, ", "Thursday, ", "Wednesday, ", "Thursday, ", "Friday, ", "Saturday, "
  }
  local currentdayName = dayNames[tonumber(currentDay) % 7 + 1]

  self.im.Publish("bnd_matchday_label", "MATCHDAY " .. round)
  if selectedteam == 0 then
    self.im.Publish("bnd_team_label", currentMonthName)
  else
    self.im.Publish("bnd_team_label", self.loc.LocalizeString("TeamName_Abbr15_" .. TeamList[selectedteam]))
  end
  self.im.Publish("bnd_month_label", currentMonthName)
  self.im.Publish("bnd_league_label", LeagueName)
  self.im.Publish("bnd_league_logo", LeagueLogo)
  self.im.Publish("bnd_league_name", leagueName)
  self.im.Publish("bnd_background_career", {name = "$BackgroundCareer", id = IDLeague})
  self.im.Publish("bnd_standings_career", {name = "$BackgroundOffice", id = IDLeague})
  self.im.Publish("bnd_table_career", {name = "$TableCareer", id = IDLeague})
end

function Standings:NextMatchday()
  if not TeamList or #rivalListData == 0 then return end
  local matchCount = #TeamList / 2
  local maxRound = #rivalListData / matchCount
  if round < maxRound then
    round = round + 1
    self:publishFixturesRows()
    self:publishHomeInfo()
  end
end

function Standings:PrevMatchday()
  if round > 1 then
    round = round - 1
    self:publishFixturesRows()
    self:publishHomeInfo()
  end
end

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
  self.im.Unsubscribe("bnd_league_logo")
  self.im.Unsubscribe("bnd_league_name")
  self.im.Unsubscribe("bnd_background_career")
  self.im.Unsubscribe("bnd_standings_career")
  self.im.Unsubscribe("bnd_table_career")
  rivalListData = {}
end

return Standings
-- Original Scripts MVNPROD --IMPROVED MOUNTSA --