local CareerHub = {}

local BND_TYPE_LABEL = "bnd_type_toggle"
local BND_TYPE_TEXT = "bnd_type_text"
local BND_CREST = "bnd_crest"
local BND_PREV_CREST = "bnd_prev_crest"
local BND_NEXT_CREST = "bnd_next_crest"
local BND_PREV2_CREST = "bnd_prev2_crest"
local BND_NEXT2_CREST = "bnd_next2_crest"
local ACT_NEXT_TYPE = "act_next_type"
local ACT_PREV_TYPE = "act_prev_type"
local ACT_CONFIRM_SETUP = "act_advance"
local BND_LIVE_MENU = "bnd_live_menu"
local BND_SELECTED_INDEX = "bnd_selected_index"
local BND_DEFAULT_CELL_DATA = "bnd_default_cell_data"
local ACT_CHANGE = "act_change"
local BND_DESCRIPTION = "bnd_description"
local BND_TEAMS_MENU = "bnd_teams_menu"
local BND_SELECTED_TEAM_INDEX = "bnd_selected_team_index"
local ACT_CHANGE_TEAM = "act_change_team"
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_NAME = "bnd_team_name"
local BND_TEAM_STARS = "bnd_team_stars"
local BND_TEAM_OFFENSE = "bnd_team_offense"
local BND_TEAM_MIDFIELD = "bnd_team_midfield"
local BND_TEAM_DEFENSE = "bnd_team_defense"
local devOptions = {
    { name = " MOUNTSA ", value = 1 }, { name = " LAOSIJI ", value = 2 },
    { name = " MA'RUF ID ", value = 3 }, { name = " VOLTA SPORT ", value = 4 },
    { name = " MVNPROD ", value = 5 }, { name = " MELDA14 ", value = 6 },
    { name = " NB PLAYS ", value = 7 }, { name = " AF'ID ", value = 8 },
    { name = " ZHINXI ", value = 9 }, { name = " CROT DI MULUT ", value = 10 },
    { name = " HNFH16 ", value = 11 }, { name = " ROBER FL ", value = 12 },
    { name = " TALAMLEGIT ", value = 13 }, { name = " PRAS 87 ", value = 14 },
    { name = " AKHMAD FARIS ", value = 15 }, { name = " RIANPROSS ", value = 16 },
    { name = " DAVUNPES ", value = 17 }
}
CareerSettings = CareerSettings or {}

function CareerHub:updateDevDisplay()
    local selectedId = GlobalDevSettings and GlobalDevSettings.devId or 1
    local selectedDevData = devOptions[selectedId]

    if selectedDevData then
        self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = selectedDevData.value })
        self.im.Publish("bnd_name_dev", selectedDevData.name)
        print("[CareerHub.lua] Tampilan Dev diperbarui ke: " .. selectedDevData.name)
    else
        print("[CareerHub.lua] GAGAL: Tidak dapat menemukan data untuk Dev ID: " .. tostring(selectedId))
    end
end

function CareerHub:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = { 
        settingsService = o.api("SettingsService"),
        SquadManagementService = o.api("SquadMgtService"),
        TeamService = o.api("TeamService"),
        loc = o.api("LocalizationService")
    }
    
    o.defaultCellData = { label = "", image = { name = "$LeagueActive", id = 0 }, id = -1, selected = false }

    o.LeaguesByCountry = {
        { name = "England", id = 14, leagues = {
            { headline = "Premier League", id = 13 }, { headline = "League Championship", id = 14 },
            { headline = "League 1", id = 60 }
        }},
        { name = "Germany", id = 21, leagues = {
            { headline = "Bundesliga", id = 19 }, { headline = "Bundesliga 2", id = 20 }
        }},
        { name = "Spain", id = 45, leagues = { 
            { headline = "Liga BBVA", id = 53 }, { headline = "Liga Adelante", id = 54 }
        }},
        { name = "Italy", id = 27, leagues = { 
            { headline = "Serie A TIM", id = 31 }, { headline = "Serie B", id = 32 }
        }},
        { name = "France", id = 18, leagues = {
            { headline = "Ligue 1", id = 16 }, { headline = "Ligue 2", id = 17 }
        }},
        { name = "Indonesia", id = 160, leagues = { { headline = "BRI Liga 1", id = 2235 } }},
        { name = "Netherlands", id = 34, leagues = { { headline = "Eredivisie", id = 10 } }},
        { name = "Portugal", id = 38, leagues = { { headline = "Liga NOS", id = 308 } }},
        { name = "USA", id = 95, leagues = { { headline = "MLS", id = 39 } }},
        { name = "Saudi Arabia", id = 183, leagues = { { headline = "Abdul Latif Jameel League", id = 350 } }},
        { name = "Turkey", id = 48, leagues = { { headline = "Süper Lig", id = 68 } }},
    }
    
    o.im.Subscribe("bnd_avatar_dev", function()
        o:updateDevDisplay()
    end)
    o.im.Subscribe("bnd_name_dev", function()
        o:updateDevDisplay()
    end)

    o.refreshHandler = o.nav.AddActionHandler("evt_refresh_mainhub_data", false, nil, function()
        print("[CareerHub.lua] Menerima sinyal refresh, memperbarui tampilan Dev...")
        o:updateDevDisplay()
    end)
    o.selectedIndices = { country = 1, league = 1, team = 1 }
    o.teamsData = {}
    o.currentTeamInfo = nil

    o:RegisterBindingsAndActions()
    o:PublishInitialData()
    return o
end

function CareerHub:RegisterBindingsAndActions()
    self.im.RegisterAction(ACT_NEXT_TYPE, function() self:nextcountryId() end)
    self.im.RegisterAction(ACT_PREV_TYPE, function() self:prevcountryId() end)
    self.im.RegisterAction(ACT_CONFIRM_SETUP, function() self:ConfirmAndProceed() end)
    self.im.RegisterDataAction(BND_SELECTED_INDEX, ACT_CHANGE, function(_, _, index) self:_setSelectedIndex(index) end)
    self.im.RegisterDataAction(BND_SELECTED_TEAM_INDEX, ACT_CHANGE_TEAM, function(_, _, index) self:_setSelectedTeamIndex(index) end)
    
    self.im.Subscribe(BND_LIVE_MENU, function() self:_publishMenu() end)
    self.im.Subscribe(BND_TEAMS_MENU, function() self:_publishTeamsMenu() end)
    self.im.Subscribe(BND_TYPE_TEXT, function() self:updatecountryIdUI() end)
    self.im.Subscribe(BND_CREST, function() self:updatecountryIdUI() end)
    self.im.Subscribe(BND_TEAM_CREST, function() self:_publishTeamCrest() end)
    self.im.Subscribe(BND_TEAM_NAME, function() self:_publishTeamName() end)
    self.im.Subscribe(BND_TEAM_STARS, function() self:_publishTeamStars() end)
    self.im.Subscribe(BND_TEAM_OFFENSE, function() self:_publishTeamOffense() end)
    self.im.Subscribe(BND_TEAM_MIDFIELD, function() self:_publishTeamMidfield() end)
    self.im.Subscribe(BND_TEAM_DEFENSE, function() self:_publishTeamDefense() end)
end

function CareerHub:GetTeamsByLeague(leagueId)
    local teams = {}
    
    print("Mengambil tim untuk liga ID:", leagueId)
    
    local leagueTeams = {
        [4] = {229, 230, 231, 232, 537, 670, 673, 674, 675, 680, 681, 1750, 2014, 100081, 100087, 110724},
        [7] = {383, 517, 567, 568, 569, 598, 1035, 1041, 1043, 1048, 1053, 1598, 1629, 1719, 111041, 111052, 111057, 111059, 112472, 130361},
        [10] = {245, 246, 247, 634, 645, 1903, 1904, 1906, 1908, 1910, 1913, 1914, 1915, 1971, 100632, 100634, 100646},
        [13] = {1, 2, 5, 7, 8, 9, 10, 11, 13, 14, 18, 19, 106, 110, 144, 1796, 1799, 1808, 1925, 1943},
        [14] = {3, 12, 15, 17, 88, 89, 91, 94, 95, 97, 109, 1790, 1792, 1794, 1795, 1800, 1801, 1806, 1807, 1919, 1947, 1951, 1952, 1960},
        [16] = {57, 64, 65, 66, 69, 71, 72, 73, 74, 76, 217, 219, 378, 379, 1530, 1738, 1809, 111817},
        [17] = {58, 62, 67, 68, 70, 210, 294, 614, 1805, 1814, 1815, 1816, 1819, 110321, 111273, 111276, 111659, 115494},
        [19] = {21, 22, 23, 25, 28, 31, 32, 36, 38, 169, 175, 1824, 1831, 10029, 100409, 110329, 111235, 112172},
        [20] = {29, 34, 159, 160, 165, 166, 171, 485, 503, 523, 531, 576, 580, 1832, 10030, 110500, 110502, 110588, 110636},
        [31] = {39, 44, 45, 46, 47, 48, 50, 52, 54, 55, 189, 205, 206, 347, 1745, 1746, 1842, 110374, 110556, 111811},
        [32] = {190, 1744, 1837, 1843, 1848, 110373, 110738, 110740, 110741, 110908, 110915, 111433, 111434, 111657, 111974, 111993, 112124, 112168, 112493, 112494},
        [39] = {687, 688, 689, 691, 693, 694, 695, 696, 697, 698, 101112, 111065, 111138, 111139, 111140, 111144, 111651, 111928, 112134, 112606, 112828, 112885, 112893, 112996, 113018, 113149, 114161, 114162, 114640, 115243},
        [50] = {77, 78, 79, 80, 81, 82, 83, 86, 180, 181, 621, 100805},
        [53] = {240, 241, 243, 448, 449, 450, 452, 453, 457, 461, 462, 463, 472, 479, 480, 481, 483, 1860, 100888, 110062},
        [54] = {242, 244, 260, 456, 459, 467, 468, 573, 1853, 1854, 1861, 1867, 1968, 10846, 100851, 100852, 110069, 110242, 110827, 110832, 110839, 121110},
        [60] = {4, 142, 143, 149, 361, 1793, 1797, 1804, 1917, 1923, 1926, 1928, 1929, 1930, 1931, 1932, 1933, 1938, 1939, 1940, 1958, 1961, 15015, 112259},
        [66] = {301, 420, 873, 1871, 110206, 110745, 110746, 110747, 110749, 111083, 111086, 111088, 111091, 111092, 111097, 114004, 114326, 114393},
        [68] = {325, 326, 327, 436, 741, 748, 101014, 101016, 101020, 101026, 101028, 101037, 101041, 110776, 111339, 113142, 121174, 121388},
        [76] = {257, 263, 264, 269, 278, 306, 315, 322, 393, 417, 710, 819, 896, 898, 1202, 1884, 10032, 100135, 100325, 100769, 100818, 100820, 101070, 101099, 101100, 101101, 101102, 101105, 101110, 101142, 101315, 110472, 110870, 110940, 110941, 110943, 110968, 110969, 110978, 110980, 110981, 110986, 110989, 110990, 111008, 111010, 111014, 111160, 111172, 111282, 111325, 111326, 111327, 111328, 111353, 111596, 111727, 111731, 111969, 112028, 112090, 112208, 112218, 112716, 112812, 112908, 115650, 115651, 115652, 115700, 115701, 116493, 129032, 129033, 129050, 129105, 129107, 129108, 129109, 129112, 129113, 129114, 129115, 129116, 129117, 129118, 129119, 129120, 129121, 129122, 129123, 129125, 129126, 129127, 129128, 129129, 129130, 129131, 129133, 129134, 129135, 129136, 129137, 129138, 129140, 129141, 129142, 129143, 129145, 129147, 129148, 129149, 129151, 129152, 129155, 129156, 129157, 129158, 129159, 129194, 129195, 129196, 129197, 129198, 129200, 129201, 129202, 129203, 129205, 129209, 129217, 129222, 129225, 129229, 130025, 130026, 130028, 130053, 130109, 130163, 130180, 130184, 130185, 130187, 130188, 130227, 130238, 130243, 130244, 130245, 130246, 130247, 130248, 130249, 130250, 130251, 130255, 130256, 130257, 130258, 130259, 130615, 130633, 130678, 130733, 130927, 130929, 130930, 130932, 130933, 130936, 133333},
        [308] = {234, 236, 237, 489, 718, 744, 1438, 1887, 1888, 1891, 1896, 1898, 1900, 10020, 112513, 112809, 114510, 121463},
        [350] = {605, 607, 111674, 112096, 112139, 112387, 112390, 112391, 112392, 112393, 112408, 112675, 112883, 113037, 113057, 113060, 113217, 121735},
		[2235] = {155600, 155601, 155602, 155603, 155604, 155606, 155607, 155609, 155611, 155612, 155614, 155616, 155617, 155618, 155620, 155621, 155624, 155630}
    }
    
    local teamIds = leagueTeams[leagueId] or {}
    
    if #teamIds > 0 then
        for i, teamId in ipairs(teamIds) do
            local success, teamInfo = pcall(function() return self.services.SquadManagementService.GetTeamInfo(teamId) end)
            local teamName = self.loc.LocalizeString("TeamName_Abbr3_" .. teamId)
            if teamName == "TeamName_Abbr3_" .. teamId then teamName = (teamInfo and teamInfo.name) or "Team " .. teamId end
            
            if success and teamInfo then
                table.insert(teams, { id = teamId, name = teamName, crestId = teamInfo.crestId or teamId, starRating = teamInfo.starRating or 3, offense = teamInfo.offense or 70, midfield = teamInfo.midfield or 70, defense = teamInfo.defense or 70 })
            else
                table.insert(teams, { id = teamId, name = teamName, crestId = teamId, starRating = 3, offense = 70, midfield = 70, defense = 70 })
            end
        end
    else
        local success, teamList = pcall(function() return self.services.TeamService.GetTeams(leagueId, 0, 0, false) end)
        if success and teamList and #teamList > 0 then
            for _, teamData in ipairs(teamList) do
                local teamInfo = self.services.SquadManagementService.GetTeamInfo(teamData.id) or teamData
                local teamName = self.loc.LocalizeString("TeamName_Abbr3_" .. teamData.id)
                if teamName == "TeamName_Abbr3_" .. teamData.id then teamName = teamInfo.name or "Team " .. teamData.id end
                table.insert(teams, { id = teamData.id, name = teamName, crestId = teamInfo.crestId or teamData.id, starRating = teamInfo.starRating or 3, offense = teamInfo.offense or 70, midfield = teamInfo.midfield or 70, defense = teamInfo.defense or 70 })
            end
        end
    end
    
    return teams
end

function CareerHub:_buildCellData()
    local cellData = {}
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    if not selectedCountry or not selectedCountry.leagues then return cellData end

    for i, league in ipairs(selectedCountry.leagues) do
        local isSelected = (self.selectedIndices.league == i)
        local cell = {
            label = "",
            image = { name = "$LeagueCrest", id = league.id },
            id = i,
            selected = isSelected,
            clickAction = ACT_CHANGE,
            alternateBackground = isSelected,
            imageHeight = 50,
            imageWidth = 150,
            imageMarginTop = 0
        }
        table.insert(cellData, cell)
    end
    return cellData
end

function CareerHub:_buildTeamCellData()
    local cellData = {}
    
    if #self.teamsData == 0 then
        table.insert(cellData, { 
            label = "No teams available", 
            id = -1,
            selected = false,
            clickAction = nil
        })
        return cellData
    end
    
    for i, team in ipairs(self.teamsData) do
        local isSelected = (self.selectedIndices.team == i)
        local cell = {
            label = team.name or "Team " .. team.id,
            image = { name = "$Crest", id = team.crestId or team.id },
            id = i,
            selected = isSelected,
            clickAction = ACT_CHANGE_TEAM,
            alternateBackground = isSelected,
            imageHeight = 50,
            imageWidth = 50,
            imageMarginTop = 0
        }
        table.insert(cellData, cell)
    end
    return cellData
end

function CareerHub:_loadAndDisplayTeams()
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    if not selectedCountry or not selectedCountry.leagues then return end
    
    local selectedLeague = selectedCountry.leagues[self.selectedIndices.league]
    if selectedLeague then
        self.teamsData = self:GetTeamsByLeague(selectedLeague.id)
        self.selectedIndices.team = 1
        self.currentTeamInfo = self.teamsData[1] or nil
        self:_publishTeamsMenu()
        self:_updateAllTeamInfoUI()
    end
end

function CareerHub:_publishMenu()
    local cellData = self:_buildCellData()
    self.im.Publish(BND_LIVE_MENU, { 
        index = self.selectedIndices.league - 1,
        data = cellData 
    })
end

function CareerHub:_publishTeamsMenu()
    local cellData = self:_buildTeamCellData()
    self.im.Publish(BND_TEAMS_MENU, { 
        index = self.selectedIndices.team - 1,
        data = cellData 
    })
end

function CareerHub:_setSelectedIndex(index)
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    if not selectedCountry or index < 1 or index > #selectedCountry.leagues then return end
    
    self.selectedIndices.league = index
    self:_publishMenu()
    self:_loadAndDisplayTeams()
end

function CareerHub:_setSelectedTeamIndex(index)
    if index < 1 or index > #self.teamsData then return end
    
    self.selectedIndices.team = index
    self.currentTeamInfo = self.teamsData[index]
    self:_publishTeamsMenu()
    self:_updateAllTeamInfoUI()
end

function CareerHub:navigate(direction)
    local totalCountries = #self.LeaguesByCountry
    local newIndex = self.selectedIndices.country + direction
    if newIndex > totalCountries then newIndex = 1 
    elseif newIndex < 1 then newIndex = totalCountries end
    
    self.selectedIndices.country = newIndex
    self.selectedIndices.league = 1
    self.selectedIndices.team = 1
    self.teamsData = {}
    self.currentTeamInfo = nil
end

function CareerHub:nextcountryId()
    self:navigate(1)
    self:updatecountryIdUI()
    self:_publishMenu()
    self:_loadAndDisplayTeams()
end

function CareerHub:prevcountryId()
    self:navigate(-1)
    self:updatecountryIdUI()
    self:_publishMenu()
    self:_loadAndDisplayTeams()
end

function CareerHub:updatecountryIdUI()
    local options = self.LeaguesByCountry
    local totalOptions = #options
    local currentIndex = self.selectedIndices.country
    local currentOpt = options[currentIndex]
    if not currentOpt then return end

    local prevIndex = (currentIndex - 2 + totalOptions) % totalOptions + 1
    local nextIndex = (currentIndex % totalOptions) + 1
    local prev2Index = (currentIndex - 3 + totalOptions) % totalOptions + 1
    local next2Index = (currentIndex + 1) % totalOptions + 1
    
    local prevOpt = options[prevIndex]
    local nextOpt = options[nextIndex]
    local prev2Opt = options[prev2Index]
    local next2Opt = options[next2Index]

    self.im.Publish(BND_TYPE_TEXT, currentOpt.name)
    self.im.Publish(BND_CREST, { name = "$Flag128x128", id = currentOpt.id })
    self.im.Publish(BND_PREV_CREST, { name = "$Flag128x128", id = prevOpt.id })
    self.im.Publish(BND_NEXT_CREST, { name = "$Flag128x128", id = nextOpt.id })
    self.im.Publish(BND_PREV2_CREST, { name = "$Flag128x128", id = prev2Opt.id })
    self.im.Publish(BND_NEXT2_CREST, { name = "$Flag128x128", id = next2Opt.id })
end

function CareerHub:_updateAllTeamInfoUI()
    self:_publishTeamCrest()
    self:_publishTeamName()
    self:_publishTeamStars()
    self:_publishTeamOffense()
    self:_publishTeamMidfield()
    self:_publishTeamDefense()
end

function CareerHub:_publishTeamCrest() 
    self.im.Publish(BND_TEAM_CREST, {
        name = "$Crest", 
        id = self.currentTeamInfo and self.currentTeamInfo.crestId or 0
    }) 
end

function CareerHub:_publishTeamName() 
    self.im.Publish(BND_TEAM_NAME, self.currentTeamInfo and self.currentTeamInfo.name or "Select a team") 
end

function CareerHub:_publishTeamStars() 
    self.im.Publish(BND_TEAM_STARS, self.currentTeamInfo and self.currentTeamInfo.starRating or 0) 
end

function CareerHub:_publishTeamOffense() 
    self.im.Publish(BND_TEAM_OFFENSE, self.currentTeamInfo and self.currentTeamInfo.offense or 0) 
end

function CareerHub:_publishTeamMidfield() 
    self.im.Publish(BND_TEAM_MIDFIELD, self.currentTeamInfo and self.currentTeamInfo.midfield or 0) 
end

function CareerHub:_publishTeamDefense() 
    self.im.Publish(BND_TEAM_DEFENSE, self.currentTeamInfo and self.currentTeamInfo.defense or 0) 
end

function CareerHub:PublishInitialData()
    self:updatecountryIdUI()
    self:_publishMenu()
    self:_loadAndDisplayTeams()
end

function CareerHub:ConfirmAndProceed()
    local selectedCountry = self.LeaguesByCountry[self.selectedIndices.country]
    local selectedLeague = selectedCountry and selectedCountry.leagues[self.selectedIndices.league]
    local selectedTeam = self.teamsData[self.selectedIndices.team]

    if not selectedTeam or not selectedLeague then
        self.im.Publish(BND_DESCRIPTION, "Please select a team first!")
        return
    end

    CareerSettings = {
        countryId = selectedCountry.id,
        leagueId = selectedLeague.id,
        teamId = selectedTeam.id,
        teamName = selectedTeam.name,
        teamStars = selectedTeam.starRating
    }
    
    print("Team selected:", selectedTeam.name, "ID:", selectedTeam.id)
    self.nav.Event(nil, "evt_missionmode1")
end

function CareerHub:finalize()
    self.im.UnregisterAction(ACT_NEXT_TYPE)
    self.im.UnregisterAction(ACT_PREV_TYPE)
    self.im.UnregisterAction(ACT_CONFIRM_SETUP)
    self.im.UnregisterDataAction(BND_SELECTED_INDEX, ACT_CHANGE)
    self.im.UnregisterDataAction(BND_SELECTED_TEAM_INDEX, ACT_CHANGE_TEAM)
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")

    if self.refreshHandler then
        self.nav.RemoveActionHandler("evt_refresh_mainhub_data")
        self.refreshHandler = nil
    end
    self.im.Unsubscribe(BND_LIVE_MENU)
    self.im.Unsubscribe(BND_TEAMS_MENU)
    self.im.Unsubscribe(BND_TYPE_TEXT)
    self.im.Unsubscribe(BND_CREST)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe(BND_TEAM_NAME)
    self.im.Unsubscribe(BND_TEAM_STARS)
    self.im.Unsubscribe(BND_TEAM_OFFENSE)
    self.im.Unsubscribe(BND_TEAM_MIDFIELD)
    self.im.Unsubscribe(BND_TEAM_DEFENSE)
end

return CareerHub