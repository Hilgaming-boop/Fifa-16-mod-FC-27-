local SaveHub = {}

-- ==============================================================
-- LOGIKA PERAKITAN KODE SAVE
-- ==============================================================
local SCORELINE_TO_SYMBOL = {
    ["0-0"]="q", ["1-0"]="w", ["2-0"]="e", ["3-0"]="r", ["4-0"]="t", ["5-0"]="y", ["6-0"]="u", ["7-0"]="i",
    ["1-1"]="o", ["2-2"]="p", ["3-3"]="a", ["4-4"]="s", ["5-5"]="d", ["0-1"]="f", ["0-2"]="g", ["0-3"]="h",
    ["0-4"]="j", ["0-5"]="k", ["0-6"]="@", ["0-7"]="z", ["2-1"]="x", ["3-1"]="c", ["4-1"]="v", ["5-1"]="b",
    ["6-1"]="n", ["7-1"]="m", ["1-2"]="Q", ["1-3"]="W", ["1-4"]="E", ["1-5"]="R", ["1-6"]="T", ["1-7"]="Y",
    ["3-2"]="U", ["4-2"]="*", ["5-2"]="O", ["6-2"]="P", ["7-2"]="A", ["4-3"]="S", ["5-3"]="D", ["6-3"]="F",
    ["7-3"]="G", ["5-4"]="H", ["2-3"]="K", ["2-4"]="L", ["2-5"]="Z", ["2-6"]="X", ["2-7"]="C", ["3-4"]="V",
    ["3-5"]="B", ["3-6"]="N", ["3-7"]="M", ["4-5"]="J"
}

local function safeConcat(tbl, sep, mapFn)
    if not tbl or type(tbl) ~= "table" then return "" end
    local result = {}
    if mapFn then
        if #tbl > 0 then
            for i, v in ipairs(tbl) do
                local mapped = mapFn(i, v)
                if mapped then table.insert(result, mapped) end
            end
        else
            for k, v in pairs(tbl) do
                local mapped = mapFn(k, v)
                if mapped then table.insert(result, mapped) end
            end
        end
    else
        for _, v in ipairs(tbl) do
            table.insert(result, tostring(v))
        end
    end
    return #result > 0 and table.concat(result, sep) or ""
end

local function wrapField(name, value)
    return string.format("<%s>%s</%s>", name, value or "", name)
end

function SaveHub:generateSaveCode()
    local tourId = (GlobalTournamentSettings and GlobalTournamentSettings.tourId) or 1
    local teamCount = (GlobalTournamentSettings and GlobalTournamentSettings.teamCount) or 0
    local tournamentType = (GlobalTournamentSettings and GlobalTournamentSettings.tournamentType) or "Custom"
    local status = (GlobalTournamentSettings and GlobalTournamentSettings.tournamentName) and "complete" or "incomplete"
    local userTeamId = (currentTourInfo and currentTourInfo[tourId] and currentTourInfo[tourId].homeID) or 1
    local goalsData = (TournamentStats and TournamentStats[tourId] and TournamentStats[tourId].Goals) or {}
    local hasStandings = tostring(GroupStandings and GroupStandings[tourId] ~= nil)
    local fixtureIndex = tonumber(currentPlayedMatchIndex) or 0

    -- Encode hasil pertandingan
    local matchCodes = {}
    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            local hScore = tonumber(match[3]) or 0
            local aScore = tonumber(match[4]) or 0
            local scoreKey = string.format("%d-%d", hScore, aScore)
            table.insert(matchCodes, SCORELINE_TO_SYMBOL[scoreKey] or "q")
        end
    end
    local saveCode = table.concat(matchCodes)

    -- Simpan seluruh peserta turnamen
    local participants = {}
    local added = {}

    if QuickTourGrouping and QuickTourGrouping[tourId] then
        for _, match in ipairs(QuickTourGrouping[tourId]) do
            local home = tonumber(match[1])
            local away = tonumber(match[2])

            if home and not added[home] then
                added[home] = true
                table.insert(participants, home)
            end

            if away and not added[away] then
                added[away] = true
                table.insert(participants, away)
            end
        end
    end

    local participantsString = table.concat(participants, ",")

    -- Simpan seluruh fixture
    local fixtureData = ""

    if QuickTourGrouping and QuickTourGrouping[tourId] then
        local temp = {}

        for _, match in ipairs(QuickTourGrouping[tourId]) do
            table.insert(temp, table.concat({
                tonumber(match[1]) or 0,
                tonumber(match[2]) or 0,
                tonumber(match[3]) or 0,
                tonumber(match[4]) or 0,
                match[5] and 1 or 0,
                tonumber(match[6]) or 0,
                match[7] and 1 or 0,
                match[8] and 1 or 0,
                tostring(match[9] or ""),
                tonumber(match[10]) or 0
            }, ","))
        end

        fixtureData = table.concat(temp, ";")
    end

    local fields = {
        { name = "Version", value = "v2" },
        { name = "Status", value = status },
        { name = "TourID", value = tostring(tourId) },
        { name = "TeamID", value = tostring(userTeamId) },
        { name = "TeamCount", value = tostring(teamCount) },
        { name = "FixtureIndex", value = tostring(fixtureIndex) },
        { name = "Participants", value = participantsString },
        { name = "TournamentType", value = tostring(tournamentType) },
        { name = "Fixtures", value = fixtureData },
        { name = "Results", value = saveCode },
        {
            name = "Goals",
            value = safeConcat(goalsData, ";", function(cardID, goals)
                return string.format("%s:%s", cardID, goals)
            end)
        },
        { name = "GroupStandings", value = hasStandings }
    }

    local saveParts = {}
    for _, field in ipairs(fields) do
        table.insert(saveParts, wrapField(field.name, field.value))
    end

    return table.concat(saveParts, "|")
end

-- ==============================================================

function SaveHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  
  o.services = {
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }

  -- 1. Racik kode save secara otomatis
  local success, result = pcall(function()
      return o:generateSaveCode()
  end)

  if success and result and result ~= "" then
      davunSave = result
  else
      davunSave = "Error: Gagal merakit data save."
  end

  -- 2. Buka lewat browser game dengan mengarahkan ke file save.html lokal
  o:openBrowser()
  
  return o
end

function SaveHub:openBrowser()
    -- Jalur lokal file html yang sejajar dengan folder save/profil game kamu
    local htmlPath = "file:///storage/emulated/0/Android/data/com.ea.gp.fifaworld/data/ux/Flows/MainFlow/gamemodes/Save/save.html?code=" .. tostring(davunSave)
    
    print("[SaveHub] Membuka Browser lokal: " .. htmlPath)
    
    if self.services and self.services.BrowserService then
        self.services.BrowserService.SetHomePage(htmlPath)
        if self.services.BrowserService.LoadHomePage then
            self.services.BrowserService.LoadHomePage()
        end
    end
    
    self.nav.Event(nil, "evt_open_browser")
end


function SaveHub:finalize()
end

return SaveHub
