-- MOD BY MOUNTSA
local TeamSelect = {}

-- Constants
local BND_TOUR_NAME = "bnd_tour_name"
local BND_TOUR_LOGO = "bnd_tour_logo"
local BND_BG_TOUR = "bnd_bg_tour" 
local BND_TEAM_CREST = "bnd_team_crest"
local BND_TEAM_NAME = "bnd_team_name" 
local BND_TEAM_KIT_HOME = "bnd_team_kit_home"
local BND_TEAM_KIT_AWAY = "bnd_team_kit_away"
local BND_TEAM_RATING = "bnd_team_rating"
local BND_TEAM_STAR_RATING = "bnd_rating_star_team" 
local BND_TEAM_OVERALL = "bnd_rating_team"  
local BND_GROUP_NAME = "bnd_group_name"
local BND_TEAM_FLAG = "bnd_flag_team"
local BND_COLOR_CUPID = "bnd_color_tourid"
local BND_COLOR_TOUR2 = "bnd_color_tour2"
local BND_CUP_LABEL = "bnd_tour_label"
local BND_CUP_BG = "bnd_tour_bg"
local BND_TROPHY = "bnd_trophy"
local BND_TEAM_LIST = "bnd_team_list"
local ACT_TEAM_SELECT = "act_team_select"
local ACT_SELECT_TEAM = "act_select_team"
local ACT_RANDOM_TEAMS = "act_random"
local ACT_CHANGE_TEAM = "act_change_team" -- Tambahkan
local BND_TEAM_NAMES = {}
local BND_TEAM_LOGOS = {}
local ACT_TABS = {}
local BND_VISIBLE_TABS = {} -- Tambahkan ini

for i = 1, 32 do
    BND_TEAM_NAMES[i] = "bnd_name_team" .. i
    BND_TEAM_LOGOS[i] = "bnd_logo_team" .. i
    ACT_TABS[i] = "act_tab_team" .. i
    BND_VISIBLE_TABS[i] = "bnd_visible_team" .. i -- Tambahkan ini
end

-- Tournament configuration
local tournamentConfig = {
    useUCLStyle = true,
    teamsPerGroup = 4
}

local tourIdToNameMap = {
    [1]  = "UEFA Champions League",
    [3]  = "UEFA Europa League",
    [4]  = "CONMEBOL Libertadores",
    [8]  = "CONMEBOL Sudamericana",
    [14] = "EA Sports Cup",
    [15] = "FIFA Club World Cup",
    [17] = "UEFA Conference League",
    [21] = "AFC Challenge League",
    [22] = "UCL Classic",
    [24] = "AFC Champions League Elit",
    [30] = "ALL STAR CUP",
    [31] = "AFC Champions League Two",
    default = "Custom Tournament"
}

local tourIdToColorMap = {
    [1]  = "0x000026",
    [3]  = "0x560005",
    [4]  = "0x1A1A1A",
    [8]  = "0x1A1A1A",
    [14]  = "0x1A1A1A",
    [17]  = "0x044508",
    [21]  = "0x3E0118",
    [22]  = "0x1A1A1A",
    [24]  = "0x16002D",
    [30]  = "0x1A1A1A",
    [31]  = "0x00084E",
    default = "0x1A1A1A"
}

local tourIdToColorMap2 = {
    [1]  = "0x000085",
    [3]  = "0x990009",
    [4]  = "0x282A30",
    [8]  = "0x282A30",
    [14] = "0x282A30",
    [17] = "0x099312",
    [21] = "0x760138",
    [22] = "0x282A30",
    [24] = "0x341C5E",
    [30] = "0x282A30",
    [31] = "0x000B70",
    default = "0x282A30"
}

local tourIdToRefereeNameMap = {
    [1]  = "Clément Turpin",
    [3]  = "Carlos del Cerro",
    [4]  = "Wilmar Roldán",
    [8]  = "Facundo Tello",
    [14] = "Yamashita Yoshimi",
    [15] = "Abdulrahman Al-Jassim",
    [17] = "Yudi Nurcahya",
    [21] = "Christopher Beath",
    [22] = "Mark Clattenburg",
    [24] = "Orel Grinfeld",
    [30] = "Bruno Arleu de Araujo",
    [31] = "Szymon Marciniak",
    default = "Default Referee"
}

local teamToCountryMap = {
    [1] = 14, [2] = 14, [5] = 14, [9] = 14, [10] = 14, [11] = 14, [13] = 13, [14] = 14, [18] = 14, [19] = 14,
    [21] = 21, [22] = 21, [25] = 21, [32] = 21, [36] = 21, [39] = 27, [44] = 27, [45] = 27, [47] = 27, [48] = 27,
    [52] = 27, [65] = 18, [66] = 18, [69] = 18, [72] = 18, [73] = 18, [76] = 18, [77] = 18, [78] = 21, [169] = 21,
    [189] = 27, [191] = 10, [219] = 18, [231] = 7, [234] = 38, [236] = 38, [240] = 45, [241] = 45, [243] = 45, [245] = 45,
    [264] = 13, [266] = 13, [267] = 13, [278] = 13, [280] = 13, [300] = 14, [306] = 14, [320] = 21, [325] = 21, [326] = 21,
    [383] = 54, [393] = 27, [417] = 45, [420] = 45, [448] = 45, [449] = 45, [450] = 45, [480] = 45, [483] = 45, [517] = 54,
    [567] = 54, [568] = 54, [569] = 54, [598] = 54, [605] = 183, [607] = 183, [673] = 7, [711] = 95, [748] = 95, [819] = 13,
    [834] = 13, [873] = 18, [896] = 14, [900] = 14, [918] = 18, [919] = 18, [982] = 103, [1032] = 83, [1035] = 54, [1041] = 54,
    [1043] = 54, [1048] = 54, [1053] = 54, [1473] = 167, [1474] = 167, [1477] = 167, [1478] = 167, [1516] = 13, [1629] = 54, [1799] = 14,
    [1824] = 21, [1871] = 18, [1874] = 52, [1876] = 52, [1877] = 52, [1879] = 83, [1884] = 14, [1887] = 52, [1896] = 21, [1903] = 27,
    [1906] = 27, [2014] = 7, [10032] = 10, [100545] = 18, [100632] = 21, [100761] = 27, [100820] = 13, [101047] = 18, [101059] = 18, [101078] = 27,
    [101083] = 52, [101085] = 52, [101099] = 52, [101100] = 52, [101103] = 52, [101106] = 52, [101108] = 52, [101142] = 183, [101146] = 183, [101151] = 183,
    [110374] = 27, [110395] = 52, [110468] = 45, [110745] = 13, [110751] = 18, [110770] = 18, [110935] = 140, [110961] = 52, [110962] = 52, [110968] = 52,
    [110969] = 52, [110975] = 52, [110980] = 52, [110981] = 52, [110989] = 52, [110990] = 52, [111001] = 52, [111010] = 52, [111011] = 52, [111013] = 52,
    [111014] = 52, [111019] = 52, [111020] = 52, [111144] = 95, [111205] = 75, [111325] = 52, [111326] = 52, [111328] = 52, [111329] = 52, [111353] = 145,
    [111499] = 129, [111575] = 163, [111596] = 75, [111629] = 70, [111637] = 70, [111640] = 70, [111651] = 70, [111658] = 70, [111701] = 190, [111706] = 52,
    [111710] = 52, [111711] = 52, [111724] = 183, [111730] = 183, [111731] = 183, [111733] = 183, [111736] = 183, [111768] = 183, [111836] = 183, [112090] = 183,
    [112093] = 183, [112094] = 183, [112098] = 183, [112099] = 183, [112100] = 183, [112139] = 183, [112190] = 75, [112234] = 183, [112372] = 45, [112387] = 183,
    [112390] = 183, [112393] = 183, [112535] = 52, [112540] = 155, [112584] = 52, [112631] = 70, [112667] = 52, [112716] = 52, [112812] = 183, [112868] = 52,
    [112883] = 183, [112893] = 95, [112908] = 52, [112965] = 52, [112992] = 52, [113146] = 183, [113298] = 183, [114326] = 18, [114421] = 75, [114422] = 75,
    [114424] = 75, [114425] = 75, [114426] = 75, [114427] = 75, [114428] = 75, [114429] = 75, [114430] = 75, [114604] = 183, [114611] = 52, [114615] = 52,
    [114815] = 75, [115536] = 52, [115616] = 183, [115618] = 183, [115623] = 70, [115650] = 183, [115654] = 75, [115655] = 75, [115701] = 75, [116361] = 183,
    [121358] = 27, [121359] = 27, [121360] = 27, [121361] = 27, [121362] = 27, [121363] = 27, [126985] = 75, [126987] = 75, [126989] = 75, [126990] = 75,
    [126991] = 75, [126992] = 75, [127032] = 75, [127819] = 75, [127889] = 75, [127890] = 75, [127924] = 75, [127925] = 75, [127948] = 75, [127949] = 75,
    [127950] = 75, [127951] = 75, [127993] = 75, [128000] = 75, [128004] = 75, [128028] = 75, [128299] = 75, [128322] = 75, [128338] = 75, [128362] = 75,
    [128371] = 75, [128396] = 75, [128397] = 75, [128398] = 75, [128399] = 75, [128400] = 75, [128401] = 75, [128402] = 75, [128403] = 75, [128404] = 75,
    [128405] = 75, [128406] = 75, [128407] = 75, [128884] = 75, [129054] = 183, [129075] = 70, [129082] = 70, [129095] = 70, [129096] = 70, [129098] = 70,
    [130025] = 183, [130026] = 183, [130028] = 183, [130098] = 70, [130180] = 183, [130181] = 183, [130184] = 183, [130185] = 183, [130188] = 70, [130278] = 70,
    [130288] = 183, [130291] = 70, [130293] = 70, [130478] = 70, [130480] = 70, [130578] = 70, [133333] = 75, [150600] = 183, [150602] = 183, [150631] = 183,
    [150634] = 70, [150636] = 70, [150637] = 70, [150639] = 70, [150722] = 70, [150735] = 49, [155450] = 49, [155600] = 160, [155602] = 160, [155603] = 160,
    [155611] = 160, [155612] = 160, [155614] = 160, [1943] = 14, [10029] = 21, [106] = 14, [457] = 45
}

local function getFlagIdByTeamId(teamId)
    return teamToCountryMap[teamId] or 0
end

-- Initialize global tables if they don't exist
GroupStandings = GroupStandings or {}
QuickTourGrouping = QuickTourGrouping or {}
currentTourInfo = currentTourInfo or {}
currentTourData = currentTourData or {}
TeamPlayerCache = TeamPlayerCache or {}
TournamentStats = TournamentStats or {}
GroupStageTeams = GroupStageTeams or {}
GOALS = GOALS or {}

local TeamDatabase = {
    [1]  = { 73, 21, 243, 9, 44, 10, 1, 241, 240, 22, 52, 237, 2, 236, 11, 231, 449, 247, 246, 65, 918, 48, 112172, 483, 326, 101059, 325, 266, 100810, 36, 278, 252, 1745, 64, },
    [3]  = { 1943,219,10029,267,45,1799,66,32,78,86,189,191,209,211,280,106,320,1516,327,457,450,673,896,234,919,1516,1874,1884,1896,1903,100545,1906,100761 },
    [4]  = { 1877,111020,101083,101085,111019,111325,111326,101108,110980,101100,101106,101103,383,1043,1629,1053,568,1048,1041,1035,569,567,517,598,112716,15029,111013,110968,110969,110989,101099,111010,110981 },
    [8]  = { 567,110395,111020,15029,111711,111706,112908,101099,112965,111010,101106,110968,114615,111011,1041,568,569,1629,1887,111710,112535,115536,112584,111328,110990,112992,114611,111329,112868,112667,110975,111014,111001 },
    [14] = { 1,5,9,10,11,21,44,45,47,73,241,243,155602,155603,112139,605,111575,112540,150735,111499,110935,155450,111353,112893,1879,1032,111144,111651,567,1877,1876,1043,598,1053 },
    [15] = { 5,10,243,44,45,21,22,73,236,234,240,191,383,1043,567,517,1876,1877,1032,111144,110147,112996,605,111575,1473,111701,150735,111499,110935,112893,241,9,1 },
    [17] = { 110374,1906,101059,918,300,1871,101047,1799,480,169,76,267,873,110745,320,100820,264,278,77,110770,114326,748,711,100325,110751,10032,306,834,101315,420,417,483,19 },
    [21] = { 111674,112098,112631,111731,130188,111629,130480,130478,155614,155611,129096,129082,129075,155612,155600,155603,129098,115623,130098,129095,130293,130291,150634,150639,150636,150637,112390,112883,130278,111658,150722,130578,1478 },
    [22] = { 127948,127949,127924,128000,127889,111205,128398,128396,114422,114421,127993,127950,128362,128299,128338,128004,128400,127951,128028,114420,128399,128397,128401,127925,128322,127819,127794,128371,127032,128402,128403,128884,128405 },
    [24] = { 605, 112094, 130184, 130185, 112139, 112090, 111836, 130025, 607, 101142, 130028, 112234, 112387, 111733, 111701, 112098, 111575, 150602, 111768, 115650, 111730, 150600, 116361, 982, 101151, 115618, 111724, 1474, 101146, 1473, 1477, 112540 },
    [30] = { 112190,111575,114430,114428,114424,115701,114426,114425,111596,114427,114429,133333,115655,132630,126989,115654,126990,127890,127889,128402,128403,114815,128406,128404,111205,128407,114421,114419,114422,115510,126992,126991,126985 },
    [31] = { 110961,101142,110962,130025,112099,112094,112100,130180,111727,130185,113146,112812,112139,112393,130026,113298,111768,114604,129054,150637,112093,150631,130288,130181,111736,115616,111640,155602,1474,150602,115650,111637 }
}
-- Local variables
local TeamList, TeamListData = {}, {}

-- Helper functions
local function removeDuplicates(array)
    local seen, result = {}, {}
    for _, v in ipairs(array) do
        if not seen[v] then
            table.insert(result, v)
            seen[v] = true
        end
    end
    return result
end

local function shuffleArray(array)
    math.randomseed(os.time())
    for i = #array, 2, -1 do
        local j = math.random(i)
        array[i], array[j] = array[j], array[i]
    end
end

local function initTeamList()
    local settings = GlobalTournamentSettings or {}
    local tourId = settings.tourId or 1
    local teamCount = settings.teamCount or 32
    
    -- Get potential teams for this tournament
    local potentialTeams = TeamDatabase[tourId] or TeamDatabase[1]
    
    -- Remove duplicates 
    local uniqueTeams = removeDuplicates(potentialTeams)
    
    -- JANGAN panggil shuffleArray(uniqueTeams) di sini agar urutan tetap sesuai database
    
    -- Select the required number of teams
    TeamList = {}
    for i = 1, math.min(teamCount, #uniqueTeams) do
        table.insert(TeamList, uniqueTeams[i])
    end
    
    print(string.format("✅ Tournament team list initialized (Sequential) for Tour ID %d", tourId))
end

local function InitializeTournamentStats(tourId)
    if not TournamentStats[tourId] then
        print("📊 Initializing new statistics structure for Tour ID: " .. tourId)
        TournamentStats[tourId] = {
            Goals = {},
            Assists = {},
            YellowCards = {},
            RedCards = {},
            Appearances = {}
        }
    end
end

function TeamSelect:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.im = init.im
    o.nav = init.nav
    o.loc = init.loc
    o.api = init.api
    
    -- Konstanta Binding
    local BND_TEAM_RATING = "bnd_team_rating"
    local BND_TEAM_OVERALL = "bnd_rating_team" 
    local BND_TEAM_STAR_RATING = "bnd_rating_star_team"
    local BND_GROUP_NAME = "bnd_group_name" 
    
    -- Initialize tournament data
    local tourId = GlobalTournamentSettings.tourId or 1
    o.tourData = {
        name = tourIdToNameMap[tourId] or tourIdToNameMap.default,
        color = tourIdToColorMap[tourId] or tourIdToColorMap.default,
        referee = tourIdToRefereeNameMap[tourId] or tourIdToRefereeNameMap.default,
        tourId = tourId,
        tourBg = { name = "$Bg_Tour", id = tourId },
        tourlogo = { name = "$TourLogo", id = tourId },
        trophy = { name = "$TourTrophy", id = tourId }
    }
    
    -- Initialize services
    o.services = {
        SquadManagementService = o.api("SquadMgtService"),
        AudioService = o.api("AudioService")
    }
    o.visible = false
    
    -- Status Seleksi & Swap
    o.currentSelectedIdx = 1
    o.swapSourceIdx = nil 

    -- ==========================================================
    -- HELPER: UPDATE TAB VISIBILITY (DIPERBARUI)
    -- ==========================================================
    local function updateTabVisibility(selectedIdx)
        for i = 1, 32 do
            -- Tetap visible jika dia tim yang dipilih saat ini 
            -- ATAU dia adalah tim sumber yang sedang menunggu swap
            local isVisible = (i == selectedIdx) or (i == o.swapSourceIdx)
            o.im.Publish("bnd_visible_team" .. i, isVisible)
        end
    end

    -- ==========================================================
    -- HELPER: UPDATE VISUAL DETAIL
    -- ==========================================================
    local function updateTeamVisualsByIndex(idx)
        if TeamListData[idx] then
            local team = TeamListData[idx]
            local teamId = team.assetId
            
            o.im.Publish(BND_TEAM_CREST, { name = "$Crest", id = teamId })
            
            local flagId = getFlagIdByTeamId(teamId)
            o.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
            
            local localizedName = o.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
            o.im.Publish("bnd_team_name", localizedName)

            o.im.Publish("bnd_team_kit_home", { name = "$HomeKit", id = teamId })
            o.im.Publish("bnd_team_kit_away", { name = "$AwayKit", id = teamId })

            o.im.Publish(BND_TEAM_OVERALL, team.rating or 0)

            o.im.Publish(BND_TEAM_RATING, {
                attackValue = team.offense or 0,
                middleValue = team.midfield or 0,
                defenseValue = team.defense or 0,
                attackLabel = o.loc.LocalizeString("LTXT_CMN_ATT"),
                middleLabel = o.loc.LocalizeString("LTXT_CMN_MID"),
                defenseLabel = o.loc.LocalizeString("LTXT_CMN_DEF")
            })

            o.im.Publish(BND_TEAM_STAR_RATING, team.starRating or 0)

            local groupIndex = math.ceil(idx / 4)
            local groupLetter = string.char(64 + groupIndex) 
            o.im.Publish(BND_GROUP_NAME, "Group " .. groupLetter)
        end
    end

    -- ==========================================================
    -- LOGIKA SWAP (TUKAR TIM)
    -- ==========================================================
    o.im.RegisterAction("act_change_team", function()
        if o.swapSourceIdx == nil then
            -- --- KLIK PERTAMA ---
            o.services.AudioService.PlaySoundById("act_move_to_club", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            
            o.swapSourceIdx = o.currentSelectedIdx
            updateTabVisibility(o.currentSelectedIdx)
            print("🔄 Swap Source Locked: Team " .. o.swapSourceIdx)
        else
            -- --- KLIK KEDUA ---
            o.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })

            local source = o.swapSourceIdx
            local target = o.currentSelectedIdx

            if source ~= target then
                print("🔄 Swapping Team " .. source .. " with Team " .. target)
                
                -- Tukar posisi ID di TeamList
                local tempId = TeamList[source]
                TeamList[source] = TeamList[target]
                TeamList[target] = tempId

                -- Refresh Data & Grouping
                o:Init()
                o:InitGrouping()
                o:publishTeamRows()

                -- Refresh 32 logo di UI
                for i = 1, 32 do
                    if TeamListData[i] then
                        local tId = TeamListData[i].assetId
                        o.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = tId })
                        o.im.Publish("bnd_name_team" .. i, o.loc.LocalizeString("TeamName_Abbr15_" .. tId))
                    end
                end
                
                -- Refresh visual tim yang aktif sekarang
                updateTeamVisualsByIndex(target)
            end
            
            -- Reset status swap dan update visibilitas (menghilangkan highlight tim sumber)
            o.swapSourceIdx = nil
            updateTabVisibility(o.currentSelectedIdx)
        end
    end)
    
    -- Subscriptions untuk tour settings
    o.im.Subscribe("bnd_color_tour", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        local tourColor = tourIdToColorMap[currentTourId] or tourIdToColorMap.default
        o.im.Publish("bnd_color_tour", tourColor)
    end)
    
    o.im.Subscribe("bnd_color_tour2", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        local tourColor2 = tourIdToColorMap2[currentTourId] or tourIdToColorMap2.default
        o.im.Publish("bnd_color_tour2", tourColor2)
    end)
    
    o.im.Subscribe("bnd_bg_tour", function()
        local currentTourId = GlobalTournamentSettings.tourId or 1
        o.im.Publish("bnd_bg_tour", { name = "$Bg_Cup", id = currentTourId })
    end)
    
    o.im.Subscribe("bnd_tour_logo", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        o.im.Publish("bnd_tour_logo", { name = "$CupLogo", id = currentTourId })
    end)
    
    o.im.Subscribe("bnd_tour_name", function()
        local settings = GlobalTournamentSettings or {}
        local currentTourId = settings.tourId or 1
        local tourName = tourIdToNameMap[currentTourId] or tourIdToNameMap.default
        o.im.Publish("bnd_tour_name", tourName)
    end)

    -- ==========================================================
    -- INITIAL BINDINGS (32 TEAMS)
    -- ==========================================================
    for i = 1, 32 do
        o.im.Subscribe("bnd_logo_team" .. i, function()
            if TeamListData[i] then
                o.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = TeamListData[i].assetId })
            end
        end)

        o.im.Subscribe("bnd_name_team" .. i, function()
            if TeamListData[i] then
                local teamId = TeamListData[i].assetId
                local name = o.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
                o.im.Publish("bnd_name_team" .. i, name)
            end
        end)

        o.im.Subscribe("bnd_visible_team" .. i, function()
            local isVisible = (i == o.currentSelectedIdx) or (i == o.swapSourceIdx)
            o.im.Publish("bnd_visible_team" .. i, isVisible)
        end)
    end

    -- Default details
    o.im.Subscribe(BND_TEAM_RATING, function() updateTeamVisualsByIndex(1) end)
    o.im.Subscribe(BND_TEAM_OVERALL, function()
        if TeamListData[1] then o.im.Publish(BND_TEAM_OVERALL, TeamListData[1].rating or 0) end
    end)
    o.im.Subscribe(BND_TEAM_STAR_RATING, function()
        if TeamListData[1] then o.im.Publish(BND_TEAM_STAR_RATING, TeamListData[1].starRating or 0) end
    end)
    o.im.Subscribe(BND_GROUP_NAME, function()
        if TeamListData[1] then o.im.Publish(BND_GROUP_NAME, "Group A") end
    end)
    o.im.Subscribe(BND_TEAM_CREST, function()
        if TeamListData[1] then o.im.Publish(BND_TEAM_CREST, { name = "$Crest", id = TeamListData[1].assetId }) end
    end)
    o.im.Subscribe("bnd_team_name", function()
        if TeamListData[1] then
            local initialName = o.loc.LocalizeString("TeamName_Abbr15_" .. TeamListData[1].assetId)
            o.im.Publish("bnd_team_name", initialName)
        end
    end)
    o.im.Subscribe("bnd_team_kit_home", function()
        if TeamListData[1] then o.im.Publish("bnd_team_kit_home", { name = "$HomeKit", id = TeamListData[1].assetId }) end
    end)
    o.im.Subscribe("bnd_team_kit_away", function()
        if TeamListData[1] then o.im.Publish("bnd_team_kit_away", { name = "$AwayKit", id = TeamListData[1].assetId }) end
    end)
    
    o.im.Subscribe("bnd_flag_team", function()
        if TeamListData[1] then
            local teamId = TeamListData[1].assetId
            local flagId = getFlagIdByTeamId(teamId)
            o.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
        end
    end)
    
    o.im.Publish(BND_CUP_NAME, o.tourData.name)
    o.im.Publish(BND_COLOR_CUPID, o.tourData.color)
    o.im.Publish("bnd_referee_name", o.tourData.referee)
    o.im.Publish(BND_CUP_BG, o.tourData.tourBg)
    o.im.Publish(BND_CUP_LOGO, o.tourData.tourlogo)
    o.im.Publish(BND_TROPHY, o.tourData.trophy)
    
    GlobalTourData = o.tourData
    
    o.im.Subscribe("bnd_visible", function() o:publishVisible() end)
    o.im.Subscribe("bnd_loading_visible", function() o:publishVisible() end)
    
    -- ==========================================================
    -- ACTIONS
    -- ==========================================================
    o.im.RegisterAction("act_select_team", function()
        if TeamListData[o.currentSelectedIdx] then
            o:StartQuickTour({ id = o.currentSelectedIdx - 1 })
        end
    end)

    for i = 1, 32 do
        o.im.RegisterAction("act_tab_team" .. i, function() 
            o.services.AudioService.PlaySoundById("act_move_to_club", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            o.currentSelectedIdx = i
            updateTeamVisualsByIndex(i)
            updateTabVisibility(i)
        end)
    end

    GroupStandings[tourId] = GroupStandings[tourId] or {}
    QuickTourGrouping[tourId] = QuickTourGrouping[tourId] or {}

    initTeamList()
    o:cacheAllTeamPlayers()
    InitializeTournamentStats(tourId)
    
    if currentTourInfo[tourId] and currentTourInfo[tourId].homeID ~= 0 then
        o.nav.Event(nil, "evt_team_select")
    else
        o.visible = true
        o:publishVisible()
        o:Init()
        o:InitGrouping()
        o.im.Subscribe(BND_TEAM_LIST, function() o:publishTeamRows() end)
        
        if TeamListData[1] then
            updateTeamVisualsByIndex(1)
            updateTabVisibility(1)
        end

        o.im.RegisterAction(ACT_TEAM_SELECT, function(_, data)
           if data then o:StartQuickTour(data) end
        end)
        
        o.im.RegisterAction(ACT_RANDOM_TEAMS, function()
            o.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })
            o:RandomizeTeams()
            updateTeamVisualsByIndex(1)
            updateTabVisibility(1)
        end)
    end
    
    return o
end

function TeamSelect:publishVisible()
    self.im.Publish("bnd_visible", self.visible)
    self.im.Publish("bnd_loading_visible", not self.visible)
end

function TeamSelect:publishTeamRows()
    -- Tabel konfigurasi posisi grup
    local groupMapping = {
        [1] = "Group A",
        [5] = "Group B",
        [9] = "Group C",
        [13] = "Group D",
        [17] = "Group E",
        [21] = "Group F",
        [25] = "Group G",
        [29] = "Group H"
    }

    for i, team in ipairs(TeamListData) do
        -- Ambil teks grup berdasarkan baris i, jika tidak ada maka string kosong
        local groupLabel = groupMapping[i] or ""

        team.data = {
            GroupName = groupLabel, 
            TeamCrest = { name = "$Crest", id = team.assetId },
            TeamName = team.teamName,
            Rating = team.rating,
            clickAction = team.clickAction,
            FontColor = "0xffffff",
            TeamNameFontColor = "0xffffff",
            Icon = { name = "$IconMatchBall", id = 2 }
        }
    end
    self.im.Publish(BND_TEAM_LIST, TeamListData)
end

function TeamSelect:Init()
    TeamListData = {}
    for _, id in ipairs(TeamList) do
        local info = self.services.SquadManagementService.GetTeamInfo(id)
        
        local starRating = info.starRating or 0 
        
        --- MODIFIKASI DISINI ---
        -- Mengambil nilai overall langsung dari TeamInfo (seperti TeamManagementModel)
        -- Jika info.overall nil, kita beri default 0
        local ratingPuluhan = info.overall or 0
        --------------------------

        if ratingPuluhan > 99 then ratingPuluhan = 99 end

        table.insert(TeamListData, {
            assetId = id,
            clickAction = ACT_TEAM_SELECT,
            teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. id),
            shortTeamName = self.loc.LocalizeString("TeamName_Abbr3_" .. id),
            rating = ratingPuluhan, 
            starRating = starRating,
            -- Data rating detail tetap diambil dari info
            offense = info.offense or 70,
            midfield = info.midfield or 70,
            defense = info.defense or 70,
            data = {}
        })
    end
end

function TeamSelect:InitGrouping()
    local tourId = GlobalTournamentSettings.tourId or 1

    -- KONFIGURASI TURNAMEN
    tournamentConfig.totalTeams = 32
    tournamentConfig.totalGroups = 8
    tournamentConfig.teamsPerGroup = 4
    tournamentConfig.qualifyPerGroup = 2 -- juara & runner-up -> R16

    currentTourInfo[tourId] = {
        tourIndex = tourId,
        homeID = 0,
        stage = "GROUP",
        totalMatches = 0,
        totalGroupMatches = 0
    }

    -- ===============================
    -- BUAT GRUP (8 GRUP A–H)
    -- ===============================
    local groupList = {}
    for g = 1, tournamentConfig.totalGroups do
        groupList[g] = {}
        for i = 1, tournamentConfig.teamsPerGroup do
            local index = (g - 1) * tournamentConfig.teamsPerGroup + i
            if TeamList[index] then
                table.insert(groupList[g], TeamList[index])
            end
        end
    end

    -- ===============================
    -- JADWAL DOUBLE ROUND ROBIN (SEMUA MATCHDAY)
    -- ===============================
    local fixtureList = {}
    local doubleRoundSchedule = {
        {1,2}, {3,4}, {1,3}, {2,4}, {1,4}, {2,3}, -- Leg 1
        {2,1}, {4,3}, {3,1}, {4,2}, {4,1}, {3,2}  -- Leg 2
    }

    for gIndex, group in ipairs(groupList) do
        for matchNum, pair in ipairs(doubleRoundSchedule) do
            
            local homeScore = 0
            local awayScore = 0
            
            -- ========================================================
            -- LOGIKA EXTREME DRAW (95% PROBABILITY)
            -- ========================================================
            local probabilityRoll = math.random(1, 100)
            
            if probabilityRoll <= 95 then
                -- 95% Peluang Masuk Sini (DRAW)
                -- Variasi skor draw agar tidak 0-0 terus (0-0, 1-1, 2-2)
                local drawScore = math.random(0, 2)
                homeScore = drawScore
                awayScore = drawScore
            else
                -- 5% Peluang Masuk Sini (MENANG/KALAH)
                homeScore = math.random(1, 3)
                awayScore = 0 -- Memastikan ada pemenang jelas
            end

            table.insert(fixtureList, {
                group[pair[1]], -- [1] home team
                group[pair[2]], -- [2] away team
                homeScore,      -- [3] score home
                awayScore,      -- [4] score away
                false,          -- [5] isExtraTime
                0,              -- [6] extraTimeScore
                false,          -- [7] isPenalty
                true,           -- [8] isGroupMatch
                string.char(64 + gIndex), -- [9] Label Grup
                matchNum        -- [10] Nomor urut match
            })
        end
    end

    -- ===============================
    -- SIMPAN DATA
    -- ===============================
    GroupStageTeams[tourId] = groupList
    QuickTourGrouping[tourId] = fixtureList
    
    currentTourInfo[tourId].totalGroupMatches = #fixtureList

    print("⚠️ WARNING: 95% Draw Probability Enabled. Most matches will end in a tie.")
end

function TeamSelect:RandomizeTeams()
    -- 1. Acak ulang urutan TeamList yang sudah ada
    shuffleArray(TeamList)
    
    -- 2. Re-inisialisasi data tampilan berdasarkan urutan TeamList yang baru
    self:Init()
    
    -- 3. Inisialisasi ulang grup agar jadwal pertandingan mengikuti urutan tim baru
    self:InitGrouping()
    
    -- 4. Publish ulang ke UI agar daftar tim di layar berubah
    self:publishTeamRows()

    -- 5. Reset indeks pilihan ke Tim ke-1 hasil acakan baru
    self.currentSelectedIdx = 1
    
    -- ==========================================================
    -- UPDATE STATIS & VISIBILITAS UNTUK SEMUA 32 TIM
    -- ==========================================================
    for i = 1, 32 do
        if TeamListData[i] then
            local tId = TeamListData[i].assetId
            
            -- Update Logo Tim ke-i
            self.im.Publish("bnd_logo_team" .. i, { 
                name = "$Crest", 
                id = tId 
            })

            -- Update Nama Tim ke-i
            local localizedName = self.loc.LocalizeString("TeamName_Abbr15_" .. tId)
            self.im.Publish("bnd_name_team" .. i, localizedName)
        end

        -- LOGIKA BARU: Reset visibilitas tab. 
        -- Team 1 jadi TRUE, lainnya jadi FALSE
        self.im.Publish("bnd_visible_team" .. i, i == 1)
    end
    -- ==========================================================

    if TeamListData[1] then
        local team = TeamListData[1]
        local teamId = team.assetId
        
        -- Update Crest Utama (Visual Area Tengah/Detail)
        self.im.Publish("bnd_team_crest", { 
            name = "$Crest", 
            id = teamId 
        })
        
        local flagId = getFlagIdByTeamId(teamId)
        self.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
        
        -- Update Nama Tim Utama (Visual Detail)
        local mainName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
        self.im.Publish("bnd_team_name", mainName)

        -- Update Kit Home & Away secara visual
        self.im.Publish("bnd_team_kit_home", { 
            name = "$HomeKit", 
            id = teamId 
        })
        self.im.Publish("bnd_team_kit_away", { 
            name = "$AwayKit", 
            id = teamId 
        })

        -- UPDATE NAMA GRUP (Indeks 1 selalu Group A setelah pengacakan)
        self.im.Publish("bnd_group_name", "Group A")

        -- Tambahan: UPDATE RATING OVERALL (Angka Utama) UNTUK HASIL RANDOM
        self.im.Publish("bnd_rating_team", team.rating or 0)

        -- 6. UPDATE RATING DETAIL (ATT MID DEF) UNTUK HASIL RANDOM
        self.im.Publish("bnd_team_rating", {
            attackValue = team.offense or 0,
            middleValue = team.midfield or 0,
            defenseValue = team.defense or 0,
            attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
            middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
            defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
        })

        -- 7. UPDATE RATING BINTANG UNTUK HASIL RANDOM
        self.im.Publish("bnd_rating_star_team", team.starRating or 0)
        
        -- Reset visual Tab ke Tab 1 (jika fungsi ini ada di script asli Anda)
        if self.HideSelections then
            self:HideSelections()
        end
    end
    
    print("🎲 Teams re-shuffled: All 32 Logos, Names, Group & Visibility Reset to Team 1.")
end

function TeamSelect:StartQuickTour(data)
    local tourId = GlobalTournamentSettings.tourId or 1
    local teamIndex = data.id + 1
    local selectedID = TeamListData[teamIndex].assetId
    
    -- Update current tour info
    currentTourInfo[tourId] = currentTourInfo[tourId] or {}
    currentTourInfo[tourId].homeID = selectedID
    currentTourInfo[tourId].referee = self.tourData.referee
    
    currentTourData = {
        matchIndex = 0,
        tourIndex = tourId,
        homeID = selectedID,
        awayID = 0
    }

    -- Determine tournament type and prepare popup message
    local isGroupStage = (#TeamList == 32)
    currentTourInfo[tourId].stage = isGroupStage and "GROUP" or "KNOCKOUT"
    
    local popupTitle = isGroupStage and "GROUP STAGE" or "KNOCKOUT"
    local tournamentName = self.tourData.name
    local teamName = TeamListData[teamIndex].teamName
    
    local popupMessage
    if isGroupStage then
        -- Find group information for the selected team
        local groupLabel = ""
        for g, group in ipairs(GroupStageTeams[tourId] or {}) do
            for _, teamID in ipairs(group) do
                if teamID == selectedID then
                    groupLabel = "Group " .. string.char(64 + g)
                    break
                end
            end
            if groupLabel ~= "" then break end
        end
        
        currentTourInfo[tourId].groupIndex = groupLabel:sub(-1):byte() - 64 -- Convert 'A' to 1, etc.
        currentTourInfo[tourId].groupLabel = groupLabel
        
        popupMessage = string.format(
            "%s\n%s\n%s\n%s",
            tournamentName,
            teamName,
            groupLabel,
            "Ready To Begin Your Journey?"
        )
    else
        -- Knockout stage information
        currentTourInfo[tourId].groupIndex = 0
        currentTourInfo[tourId].groupLabel = "Round of 16"
        
        popupMessage = string.format(
            "%s\n%s\n%s\n%s",
            tournamentName,
            teamName,
            "Round Of 16",
            "Ready To Begin Your KNOCKOUT Challenge?"
        )
    end

    -- Show confirmation popup
    local popupData = {
        title = popupTitle,
        message = popupMessage,
        buttons = {
            { 
				label = "Cancel",
                icon = "$FooterIconNo", 
                label = "Cancel", 
                clickEvents = { "evt_hide_popup" } 
            },
            { 
				label = "Confirm",
                icon = "$FooterIconYes", 
                label = "Confirm", 
                clickEvents = { "evt_team_select", "evt_hide_popup" } 
            }
        }
    }
    self.nav.Event(nil, "evt_show_popup", popupData)
end

function TeamSelect:cacheAllTeamPlayers()
    local tourId = GlobalTournamentSettings.tourId or 1
    print("⏳ Caching player data for all teams...")
    
    TeamPlayerCache[tourId] = TeamPlayerCache[tourId] or {}
 
    for i, teamID in ipairs(TeamList) do
        if not TeamPlayerCache[tourId][teamID] then
            local players = self.services.SquadManagementService.GetCurrentPlayerLineup(0, teamID, 0)
            TeamPlayerCache[tourId][teamID] = players
            print(string.format("   (%d/%d) Cached team %d", i, #TeamList, teamID))
        end
    end
    
    GOALS[tourId] = GOALS[tourId] or {}
    print("✅ Player caching completed for " .. #TeamList .. " teams.")
end

function TeamSelect:finalize()
    -- Unsubscribe dari semua event binding utama
    self.im.Unsubscribe("bnd_visible")
    self.im.Unsubscribe("bnd_loading_visible")
    self.im.Unsubscribe(BND_TEAM_LIST)
    self.im.Unsubscribe("bnd_tour_logo")
    self.im.Unsubscribe("bnd_bg_tour")
    self.im.Unsubscribe("bnd_tour_name")
    self.im.Unsubscribe("bnd_color_tour")
    self.im.Unsubscribe("bnd_color_tour2")
    self.im.Unsubscribe(BND_CUP_LABEL)
    self.im.Unsubscribe(BND_CUP_BG)
    self.im.Unsubscribe(BND_TROPHY)
    self.im.Unsubscribe(BND_TEAM_CREST)
    self.im.Unsubscribe("bnd_team_name") 
    self.im.Unsubscribe("bnd_team_kit_home")
    self.im.Unsubscribe("bnd_team_kit_away") 
    self.im.Unsubscribe(BND_TEAM_RATING)
    self.im.Unsubscribe("bnd_rating_star_team")
    self.im.Unsubscribe("bnd_rating_team")
    self.im.Unsubscribe(BND_GROUP_NAME)
    self.im.Unsubscribe("bnd_flag_team")

    -- Unregister action global
    self.im.UnregisterAction(ACT_TEAM_SELECT)
    self.im.UnregisterAction(ACT_SELECT_TEAM)
    self.im.UnregisterAction(ACT_RANDOM_TEAMS)
    self.im.UnregisterAction("act_change_team")

    for i = 1, 32 do
        self.im.Unsubscribe("bnd_logo_team" .. i)
        self.im.Unsubscribe("bnd_name_team" .. i)
        -- Tambahkan ini:
        self.im.Unsubscribe("bnd_visible_team" .. i)
        
        self.im.UnregisterAction("act_tab_team" .. i)
    end
    
    print("✅ TeamSelect Finalized: All 32 team subscriptions and actions cleared.")
end

return TeamSelect

