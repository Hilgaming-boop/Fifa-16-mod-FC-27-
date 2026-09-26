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
local ACT_CHANGE_TEAM = "act_change_team"
local BND_TEAM_NAMES = {}
local BND_TEAM_LOGOS = {}
local ACT_TABS = {}
local BND_VISIBLE_TABS = {} -- Tambahkan ini

for i = 1, 36 do
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
    [1] = "UEFA Champions League",  default = "Custom Tournament"
}

local tourIdToColorMap = {
  [1]="0x000026",
    default = "0x1A1A1A"
}

local tourIdToColorMap2 = {
  [1]="0x000086",
    default = "0x1A1A1A"
}

local tourIdToRefereeNameMap = {
    [1] = "Clément Turpin", default = "Default Referee"
}

local teamToCountryMap = {
        [819] = 13, [231] = 7, [2014] = 7, [245] = 34, [247] = 34, [1] = 14, [5] = 14, [9] = 14, [10] = 14, 
        [13] = 14, [18] = 14, [69] = 18, [73] = 18, [219] = 18, [21] = 21, [22] = 21, [32] = 21, [1824] = 21, 
        [39] = 27, [44] = 27, [45] = 27, [48] = 27, [918] = 36, [240] = 45, [241] = 45, [243] = 45, [448] = 45, 
        [483] = 45, [234] = 38, [237] = 38, [325] = 48, [266] = 12, [280] = 22, [110919] = 165, [111282] = 11, [113888] = 5, [126987] = 160,
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
    -- Tour 1
    [1] = {
        73, 21, 243, 9, 44, 10, 1, 241, 240, 22, 52, 237, 2, 236, 11, 231, 449, 247, 246, 65, 918, 48, 112172, 483, 326, 101059, 325, 266, 100810, 36, 278, 252, 1745, 64, 300, 130621
    }
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
    local teamCount = 36 
    
    local potentialTeams = TeamDatabase[tourId] or TeamDatabase[1]
    local uniqueTeams = removeDuplicates(potentialTeams)
    
    -- HAPUS ATAU KOMENTAR BARIS SHUFFLE DI BAWAH INI:
    -- shuffleArray(uniqueTeams) 
    
    TeamList = {}
    for i = 1, math.min(teamCount, #uniqueTeams) do
        table.insert(TeamList, uniqueTeams[i])
    end
    
    print(string.format("✅ Tim turnamen dibuat sesuai Database: %d tim", #TeamList))
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
    
    -- Initialize services (AudioService ditambahkan di sini)
    o.services = {
        SquadManagementService = o.api("SquadMgtService"),
        AudioService = o.api("AudioService")
    }
    o.visible = false
    
    -- Simpan indeks tim yang sedang aktif (default ke tim 1)
    o.currentSelectedIdx = 1
    
    -- STATE BARU: Untuk menyimpan indeks tim pertama yang dipilih saat tukar posisi
    o.swapFirstIdx = nil

    -- ==========================================================
    -- HELPER: UPDATE TAB VISIBILITY (bnd_visible_team1 - 36)
    -- ==========================================================
    local function updateTabVisibility(selectedIdx)
    for i = 1, 36 do
        -- Tab menyala jika itu tab yang sedang aktif 
        -- ATAU tab yang sedang dikunci untuk swap
        local isHighlighted = (i == selectedIdx) or (i == o.swapFirstIdx)
        o.im.Publish("bnd_visible_team" .. i, isHighlighted)
    end
end

    -- ==========================================================
    -- HELPER: UPDATE VISUAL (CREST, NAME, KITS, RATING, STARS, GROUP)
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

            local potIndex = math.ceil(idx / 9) 
            o.im.Publish(BND_GROUP_NAME, "Pot " .. potIndex)
        end
    end
    
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
    -- INITIAL BINDINGS (36 TEAMS LOGO, NAME & VISIBILITY)
    -- ==========================================================
    for i = 1, 36 do
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
            o.im.Publish("bnd_visible_team" .. i, o.currentSelectedIdx == i)
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
        if TeamListData[1] then o.im.Publish(BND_GROUP_NAME, "Pot 1") end
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
    -- ACTIONS & LOGIC
    -- ==========================================================

    o.im.RegisterAction("act_select_team", function()
        if TeamListData[o.currentSelectedIdx] then
            o:StartQuickTour({ id = o.currentSelectedIdx - 1 })
        end
    end)

    -- Registrasi aksi tab secara dinamis
for i = 1, 36 do
    o.im.RegisterAction("act_tab_team" .. i, function() 
        -- Update index saat ini berdasarkan tab yang diklik
        o.currentSelectedIdx = i 
        
        -- Berikan feedback audio
        o.services.AudioService.PlaySoundById("act_move_to_club", "root", {
            soundId = "", type = "", state = { name = "VALID", val = 0 }
        })
        
        -- Update visual detail di layar
        updateTeamVisualsByIndex(i)
        updateTabVisibility(i)
    end)
end

-- ==========================================================
-- ACTIONS: CHANGE TEAM (SWAP LOGIC)
-- ==========================================================
o.im.RegisterAction("act_change_team", function()
    if not o.swapFirstIdx then
        -- KLIK PERTAMA: Kunci indeks posisi awal
        o.swapFirstIdx = o.currentSelectedIdx
        
        -- Efek suara klik pertama
        o.services.AudioService.PlaySoundById("act_move_to_club", "root", {
            soundId = "", type = "", state = { name = "VALID", val = 0 }
        })
        
        -- Update visual agar tab pertama tetap menyala
        updateTabVisibility(o.currentSelectedIdx)
        print("📍 Posisi Awal Dikunci: " .. o.swapFirstIdx)
    else
        -- KLIK KEDUA: Proses pertukaran posisi
        local idx1 = o.swapFirstIdx
        local idx2 = o.currentSelectedIdx

        if idx1 ~= idx2 then
            -- Tukar ID di tabel utama
            local tempId = TeamList[idx1]
            TeamList[idx1] = TeamList[idx2]
            TeamList[idx2] = tempId

            -- Sinkronisasi ulang data
            o:Init() 
            o:InitGrouping()
            o:publishTeamRows() 

            -- Efek suara klik kedua (setelah swap)
            o.services.AudioService.PlaySoundById("act_home_kit_next", "root", {
                soundId = "", type = "", state = { name = "VALID", val = 0 }
            })

            -- Refresh visual semua tab
            for i = 1, 36 do
                if TeamListData[i] then
                    local tId = TeamListData[i].assetId
                    o.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = tId })
                    o.im.Publish("bnd_name_team" .. i, o.loc.LocalizeString("TeamName_Abbr15_" .. tId))
                end
            end
            
            print("✅ BERHASIL: Posisi " .. idx1 .. " ditukar dengan " .. idx2)
        else
            print("⚠️ GAGAL: Memilih tim yang sama, swap dibatalkan.")
        end

        -- Reset state swap dan kembalikan visibilitas tab ke normal (hanya 1 yang nyala)
        o.swapFirstIdx = nil
        updateTabVisibility(idx2)
        updateTeamVisualsByIndex(idx2)
    end
end)

    -- Initialize Data Structures
    GroupStandings[tourId] = GroupStandings[tourId] or {}
    QuickTourGrouping[tourId] = QuickTourGrouping[tourId] or {}
    initTeamList()
    o:cacheAllTeamPlayers()
    InitializeTournamentStats(tourId)
    
    --- PERBAIKAN LOGIKA NAVIGASI OTOMATIS ---
    if currentTourInfo[tourId] and currentTourInfo[tourId].homeID and currentTourInfo[tourId].homeID ~= 0 then
        o.visible = false
        o:publishVisible()
        o.nav.Event(nil, "evt_team_select")
        print("⏩ Melanjutkan Turnamen: Tim ID " .. currentTourInfo[tourId].homeID .. " terdeteksi.")
    else
        o.visible = true
        o:publishVisible()
        o:Init()
        o:InitGrouping()
        o.im.Subscribe(BND_TEAM_LIST, function() o:publishTeamRows() end)
        
        for i = 1, 36 do
            if TeamListData[i] then
                local teamId = TeamListData[i].assetId
                o.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = teamId })
                o.im.Publish("bnd_name_team" .. i, o.loc.LocalizeString("TeamName_Abbr15_" .. teamId))
            end
        end
        
        -- Pastikan baris ini ada di dalam function TeamSelect:new
o.im.RegisterAction("act_team_select", function(_, data)
    if data then 
        o:StartQuickTour(data) 
    end
end)

        -- Di dalam function TeamSelect:new(init)

-- Registrasi aksi Random Teams
o.im.RegisterAction(ACT_RANDOM_TEAMS, function()
    -- Memberikan feedback suara saat tombol acak ditekan
    local soundId = "act_home_kit_next" 
    o.services.AudioService.PlaySoundById(soundId, "root", {
        soundId = "", type = "", state = { name = "VALID", val = 0 }
    })
    
    -- Memanggil fungsi pengacakan utama
    o:RandomizeTeams()
    
    print("🎲 Action Random Berhasil Dieksekusi")
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
    -- Reset TeamListData agar sesuai dengan urutan TeamList terbaru
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

        -- Memasukkan data tim ke dalam TeamListData
        table.insert(TeamListData, {
            assetId = id,
            -- Pastikan ACT_TEAM_SELECT ("act_team_select") terpasang dengan benar
            clickAction = ACT_TEAM_SELECT,
            teamName = self.loc.LocalizeString("TeamName_Abbr15_" .. id),
            shortTeamName = self.loc.LocalizeString("TeamName_Abbr3_" .. id),
            rating = ratingPuluhan, 
            starRating = starRating,
            -- Data rating detail tetap diambil dari info
            offense = info.offense or 70,
            midfield = info.midfield or 70,
            defense = info.defense or 70,
            -- Data tabel kosong untuk diisi saat publishTeamRows
            data = {}
        })
    end
    
    -- Opsional: Print log untuk memastikan sinkronisasi berhasil
    print("🔄 TeamListData Re-Initialized: " .. #TeamListData .. " teams ready.")
end

function TeamSelect:InitGrouping()
    local tourId = GlobalTournamentSettings.tourId or 1
    local teams = TeamList -- Menggunakan urutan TeamList yang ada (hasil swap manual)

    -- ===== POT (9 tim per pot) =====
    local pots = { {}, {}, {}, {} }
    local teamPot = {}

    for i, teamId in ipairs(teams) do
        local p = math.ceil(i / 9)
        table.insert(pots[p], teamId)
        teamPot[teamId] = p
    end

    local finalFixtures = {}
    local opponents = {}
    local potHome = {}
    local potAway = {}

    local function resetData()
        finalFixtures = {}
        opponents = {}
        potHome = {}
        potAway = {}

        for _, t in ipairs(teams) do
            opponents[t] = {}
            potHome[t] = {0,0,0,0}
            potAway[t] = {0,0,0,0}
        end
    end

    local function alreadyPlayed(a, b)
        for _, o in ipairs(opponents[a]) do
            if o == b then return true end
        end
        return false
    end

    local function addMatch(home, away, potH, potA)
        potHome[home][potA] = 1
        potAway[away][potH] = 1

        table.insert(opponents[home], away)
        table.insert(opponents[away], home)

        table.insert(finalFixtures, {
            home, away,
            math.random(0,2), math.random(0,2),
            false, 0, false,
            true, "A", #finalFixtures + 1
        })
    end

    -- ===== GENERATOR =====
    local success = false

    for attempt = 1, 200 do
        resetData()
        success = true

        -- BARIS SHUFFLE DIHAPUS agar posisi tim yang ditukar manual tetap konsisten

        for _, team in ipairs(teams) do
            local pA = teamPot[team]

            for pot = 1, 4 do
                -- cari HOME vs pot
                if potHome[team][pot] == 0 then
                    local found = false
                    -- Shuffle pot tetap aman agar variasi lawan berubah, tapi posisi tim tetap
                    shuffleArray(pots[pot])

                    for _, opp in ipairs(pots[pot]) do
                        if opp ~= team
                        and not alreadyPlayed(team, opp)
                        and potAway[opp][pA] == 0 then

                            addMatch(team, opp, pA, pot)
                            found = true
                            break
                        end
                    end

                    if not found then
                        success = false
                        break
                    end
                end

                -- cari AWAY vs pot
                if potAway[team][pot] == 0 then
                    local found = false
                    shuffleArray(pots[pot])

                    for _, opp in ipairs(pots[pot]) do
                        if opp ~= team
                        and not alreadyPlayed(team, opp)
                        and potHome[opp][pA] == 0 then

                            addMatch(opp, team, pot, pA)
                            found = true
                            break
                        end
                    end

                    if not found then
                        success = false
                        break
                    end
                end
            end

            if not success then break end
        end

        if success then break end
    end

    -- ===== VALIDASI KERAS =====
    for _, t in ipairs(teams) do
        local total = #opponents[t]
        local h, a = 0, 0
        for p = 1,4 do
            h = h + potHome[t][p]
            a = a + potAway[t][p]
        end

        if total ~= 8 or h ~= 4 or a ~= 4 then
            -- Pastikan tetap 8 match: 4 Home, 4 Away
            error("❌ FIXTURE INVALID: Tim "..t.." match="..total.." H="..h.." A="..a)
        end
    end

    QuickTourGrouping[tourId] = finalFixtures
    currentTourInfo[tourId] = {
        tourIndex = tourId,
        stage = "GROUP",
        totalGroupMatches = #finalFixtures
    }

    print("✅ SUKSES: Jadwal dibuat berdasarkan posisi tim terbaru (8 match/tim)")
end

function TeamSelect:RandomizeTeams()
    -- 1. Acak ulang urutan TeamList yang sudah ada
    shuffleArray(TeamList)
    
    -- 2. Re-inisialisasi data internal (TeamListData) berdasarkan urutan TeamList yang baru
    -- Fungsi Init() menghapus tabel lama dan membangun ulang sesuai urutan TeamList
    self:Init()
    
    -- 3. Inisialisasi ulang grup/jadwal agar mengikuti urutan tim yang baru diacak
    self:InitGrouping()
    
    -- 4. Publish tabel utama ke UI agar list/grid tim di layar berubah
    self:publishTeamRows()

    -- 5. Reset indeks pilihan ke Tim ke-1 hasil acakan baru
    self.currentSelectedIdx = 1
    
    -- ==========================================================
    -- FORCE REFRESH: UPDATE SEMUA 36 TAB (LOGO, NAMA & HIGHLIGHT)
    -- ==========================================================
    for i = 1, 36 do
        local teamData = TeamListData[i]
        if teamData then
            local tId = teamData.assetId
            
            -- Update Logo Tim di setiap slot tab
            self.im.Publish("bnd_logo_team" .. i, { 
                name = "$Crest", 
                id = tId 
            })

            -- Update Nama Tim di setiap slot tab
            local localizedName = self.loc.LocalizeString("TeamName_Abbr15_" .. tId)
            self.im.Publish("bnd_name_team" .. i, localizedName)
        end

        -- Update visibilitas highlight: Hanya tab 1 yang aktif (TRUE), sisanya mati (FALSE)
        self.im.Publish("bnd_visible_team" .. i, (i == 1))
    end
    -- ==========================================================

    -- 6. UPDATE DETAIL VISUAL UNTUK TIM PERTAMA (POSISI 1)
    if TeamListData[1] then
        local team = TeamListData[1]
        local teamId = team.assetId
        
        -- Update Crest Utama (Area Detail Tengah)
        self.im.Publish("bnd_team_crest", { name = "$Crest", id = teamId })
        
        -- Update Bendera Kebangsaan
        local flagId = getFlagIdByTeamId(teamId)
        self.im.Publish("bnd_flag_team", { name = "$Flag128x128", id = flagId })
        
        -- Update Nama Tim Utama
        local mainName = self.loc.LocalizeString("TeamName_Abbr15_" .. teamId)
        self.im.Publish("bnd_team_name", mainName)

        -- Update Pratinjau Jersey (Home & Away)
        self.im.Publish("bnd_team_kit_home", { name = "$HomeKit", id = teamId })
        self.im.Publish("bnd_team_kit_away", { name = "$AwayKit", id = teamId })

        -- Update Label Pot (Indeks 1 selalu masuk Pot 1)
        self.im.Publish("bnd_group_name", "Pot 1")

        -- Update Rating Angka (Overall)
        self.im.Publish("bnd_rating_team", team.rating or 0)

        -- Update Rating Detail (Bar Attack, Midfield, Defense)
        self.im.Publish("bnd_team_rating", {
            attackValue = team.offense or 0,
            middleValue = team.midfield or 0,
            defenseValue = team.defense or 0,
            attackLabel = self.loc.LocalizeString("LTXT_CMN_ATT"),
            middleLabel = self.loc.LocalizeString("LTXT_CMN_MID"),
            defenseLabel = self.loc.LocalizeString("LTXT_CMN_DEF")
        })

        -- Update Star Rating (Bintang)
        self.im.Publish("bnd_rating_star_team", team.starRating or 0)
        
        -- Jika ada fungsi reset animasi atau seleksi, panggil di sini
        if self.HideSelections then
            self:HideSelections()
        end
    end
    
    print("🎲 Berhasil: 36 Tim diacak, Jadwal diperbarui, dan UI di-refresh ke Tim 1.")
end

function TeamSelect:SwapTeams(idx1, idx2)
    -- 1. Tukar di TeamList (Daftar ID Utama)
    local tempId = TeamList[idx1]
    TeamList[idx1] = TeamList[idx2]
    TeamList[idx2] = tempId

    -- 2. Re-Init Data (Memperbarui TeamListData berdasarkan urutan baru)
    self:Init()

    -- 3. Re-Init Grouping (Agar jadwal liga/pot mengikuti urutan baru)
    self:InitGrouping()

    -- 4. Publish ke UI untuk semua 36 tim agar logo & nama di daftar berubah
    for i = 1, 36 do
        if TeamListData[i] then
            local tId = TeamListData[i].assetId
            self.im.Publish("bnd_logo_team" .. i, { name = "$Crest", id = tId })
            self.im.Publish("bnd_name_team" .. i, self.loc.LocalizeString("TeamName_Abbr15_" .. tId))
        end
    end

    -- 5. Update Visual Detail untuk tim yang baru saja dipilih
    local activeTeam = TeamListData[idx2]
    if activeTeam then
        self.im.Publish("bnd_team_crest", { name = "$Crest", id = activeTeam.assetId })
        self.im.Publish("bnd_team_name", self.loc.LocalizeString("TeamName_Abbr15_" .. activeTeam.assetId))
        self.im.Publish("bnd_rating_team", activeTeam.rating or 0)
        self.im.Publish("bnd_rating_star_team", activeTeam.starRating or 0)
    end

    self:publishTeamRows()
    print("🔄 Tim ditukar: Posisi " .. idx1 .. " <-> " .. idx2)
end

function TeamSelect:StartQuickTour(data)
    local tourId = GlobalTournamentSettings.tourId or 1
    local teamIndex = data.id + 1
    local selectedID = TeamListData[teamIndex].assetId
    
    currentTourInfo[tourId].homeID = selectedID
    
    local opponents = {}
    local fixtures = QuickTourGrouping[tourId] or {}

    -- helper: cari pot dari assetId
    local function getPotByAssetId(assetId)
        for i, t in ipairs(TeamListData) do
            if t.assetId == assetId then
                return math.ceil(i / 9)
            end
        end
        return 0
    end

    for _, match in ipairs(fixtures) do
        if match[1] == selectedID then
            local oppPot = getPotByAssetId(match[2])
            table.insert(
                opponents,
                string.format(
                    "%s(H-P%d)",
                    self.loc.LocalizeString("TeamName_Abbr3_" .. match[2]),
                    oppPot
                )
            )
        elseif match[2] == selectedID then
            local oppPot = getPotByAssetId(match[1])
            table.insert(
                opponents,
                string.format(
                    "%s(A-P%d)",
                    self.loc.LocalizeString("TeamName_Abbr3_" .. match[1]),
                    oppPot
                )
            )
        end
    end

    local popupMessage = string.format(
        "%s\n%s (POT %d)\nOPPONENTS:\n%s\nReady?",
        self.tourData.name,
        TeamListData[teamIndex].teamName,
        math.ceil(teamIndex / 9),
        table.concat(opponents, " • ")
    )

    self.nav.Event(nil, "evt_show_popup", {
        title = "LEAGUE PHASE",
        message = popupMessage,
        buttons = {
            {label="Cancel", clickEvents={"evt_hide_popup"}},
            {label="Confirm", clickEvents={"evt_team_select","evt_hide_popup"}}
        }
    })
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

    for i = 1, 36 do
        self.im.Unsubscribe("bnd_logo_team" .. i)
        self.im.Unsubscribe("bnd_name_team" .. i)
        -- Tambahkan ini:
        self.im.Unsubscribe("bnd_visible_team" .. i)
        
        self.im.UnregisterAction("act_tab_team" .. i)
    end
    
    print("✅ TeamSelect Finalized: All 36 team subscriptions and actions cleared.")
end

return TeamSelect

