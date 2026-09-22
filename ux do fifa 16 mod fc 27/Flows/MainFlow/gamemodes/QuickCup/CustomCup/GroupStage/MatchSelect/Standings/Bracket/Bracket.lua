-- Suporta múltiplos formatos: Group + Knockout, Knockout e League

local Bracket = {}

local tourId = GlobalTournamentSettings and GlobalTournamentSettings.tourId or 1

-- DETEKSI CUSTOM CREST UNTUK WORLD CUP 2026
local CREST_NORMAL = (tourId == 2) and "$CrestWorldCup2026" or "$Crest"

local tourIdToNameMap = {
    [1] = "UEFA Champions League", [2] = "FIFA WORLD CUP 2026", [3] = "UEFA Europa League",
    [4] = "CONMEBOL Libertadores", [5] = "Copa do Brasil", [6] = "UEFA Euro",
    [7] = "Dfb Pokal", [8] = "CONMEBOL Sudamericana", [9] = "The Emirates FA Tour",
    [10] = "Copa del Rey", [11] = "Coppa Italia", [12] = "Asean Shopee Cup",
    [13] = "US Open Tour", [14] = "EA Sports Cup", [15] = "FIFA Club World Cup",
    [16] = "UEFA Women CL", [17] = "UEFA Conference League", [18] = "Coupe de France",
    [19] = "Copa Argentina", [20] = "Copa MX", [21] = "AFC Challenge League",
    [22] = "Classic Tour", [23] = "Sea Games U-23", [24] = "AFC Champions League Elit",
    [25] = "Copa America", [26] = "Africa Cup Of Nations", [27] = "ASEAN Hyundai Cup 2026",
    [28] = "UEFA Nations League", [29] = "Kratingdaeng Piala Indonesia", [30] = "ALL STAR CUP",
    [31] = "AFC Champions League Two", [32] = "Piala Presiden", [33] = "Leagues Cup",
    [34] = "AFC Asian Cup 2023", default = "Custom Tournament"
}

local tourIdToColorMap = {
  [1]="0x000026", [2]="0x0051FF", [3]="0x2F0103", [4]="0x1A1A1A", [5]="0x1A1A1A", [6]="0x1A1A1A",
  [7]="0x1A1A1A", [8]="0x1A1A1A", [9]="0x1A1A1A", [10]="0x1A1A1A", [11]="0x1A1A1A", [12]="0x1A1A1A",
  [13]="0x1A1A1A", [14]="0x1A1A1A", [15]="0x1A1A1A", [16]="0x1A1A1A", [17]="0x1A1A1A", [18]="0x1A1A1A",
  [19]="0x1A1A1A", [20]="0x1A1A1A", [21]="0x1A1A1A", [22]="0x1A1A1A", [23]="0x1A1A1A", [24]="0x1A1A1A",
  [25]="0x1A1A1A", [26]="0x1A1A1A", [27]="0x1A1A1A", [28]="0x1A1A1A", [29]="0x1A1A1A", [30]="0x1A1A1A",
  [31]="0x1A1A1A", [32]="0x1A1A1A", [33]="0x1A1A1A", [34]="0x070A91",
  default = "0x1A1A1A"
}
local tourIdToColorTabMap = {
  [1]="0x39414C", [2]="0x39414C", [3]="0xB0272C", [4]="0x39414C", [5]="0x39414C", [6]="0x39414C",
  [7]="0x39414C", [8]="0x39414C", [9]="0x39414C", [10]="0x39414C", [11]="0x39414C", [12]="0x39414C",
  [13]="0x39414C", [14]="0x39414C", [15]="0x39414C", [16]="0x39414C", [17]="0x39414C", [18]="0x39414C",
  [19]="0x39414C", [20]="0x39414C", [21]="0x39414C", [22]="0x39414C", [23]="0x39414C", [24]="0x39414C",
  [25]="0x39414C", [26]="0x39414C", [27]="0x39414C", [28]="0x39414C", [29]="0x39414C", [30]="0x39414C",
  [31]="0x39414C", [32]="0x39414C", [33]="0x39414C", [34]="0x39414C",
  default = "0x39414C"
}

local STAGE_NAMES = {
    R32 = "Round of 32",
    R16 = "Round of 16",
    QF = "Quarter-Finals",
    SF = "Semi-Finals",
    F = "Final"
}

local bndTeamList = {}

function Bracket:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.loc = init.loc
    o.im = init.im
    
    --  LEIA SETTINGS DINÂMICOS
    local settings = GlobalTournamentSettings or {}
    o.teamCount = settings.teamCount or 48
    o.isKnockoutOnly = settings.isKnockoutOnly or false
    
    --  DADOS DO CAMPEÃO
    o.tourData = {
        isFinish = false,
        championCrest = {
            name = CREST_NORMAL,
            id = 0
        }
    }
    
    --  CRIAR LISTA DE BINDINGS DO BRACKET (1-62)
    for i = 1, 62 do
        bndTeamList[i] = "bnd_team" .. i .. "_crest"
        bndTeamList[i + 62] = "bnd_team" .. i .. "_abbr"
        bndTeamList[i + 124] = "bnd_team" .. i .. "_score"
    end
    
    o:setupSubscriptions()
    o:publishAllBracketData()
    
    print(string.format(" Bracket initialized | Team Count: %d | Knockout Only: %s", o.teamCount, tostring(o.isKnockoutOnly)))
    return o
end

function Bracket:setupSubscriptions()
    --  SUBSCRIPTIONS PARA BRACKET
    for i = 1, 62 do
        self.im.Subscribe("bnd_team" .. i .. "_crest", function() self:publishBracketData() end)
        self.im.Subscribe("bnd_team" .. i .. "_abbr", function() self:publishBracketData() end)
        self.im.Subscribe("bnd_team" .. i .. "_score", function() self:publishBracketData() end)
    end
    
    --  SUBSCRIPTIONS PARA CAMPEÃO
    self.im.Subscribe("bnd_champion_visible", function() self:publishChampion() end)
    self.im.Subscribe("bnd_champion_crest", function() self:publishChampion() end)
    self.im.Subscribe("bnd_champion_team", function() self:publishChampion() end)
    self.im.Subscribe("bnd_text", function() self:publishChampion() end)
    
    --  SUBSCRIPTIONS PARA INFO DO TORNEIO
    self.im.Subscribe("bnd_tour_label", function() self:publishTourInfo() end)
    self.im.Subscribe("bnd_tour_trophy", function() self:publishTourInfo() end)
    self.im.Subscribe("bnd_bg_tour", function() self:publishTourInfo() end)
    self.im.Subscribe("bnd_tour_map", function() self:publishTourInfo() end)
    self.im.Subscribe("bnd_tour_logo", function() self:publishTourInfo() end)
end

function Bracket:publishAllBracketData()
    self:publishBracketData()
    self:publishChampion()
    self:publishTourInfo()
end

--  PUBLICAR INFORMAÇÕES DO TORNEIO
function Bracket:publishTourInfo()
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    
    self.im.Publish("bnd_tour_label", tourName)
    self.im.Publish("bnd_tour_trophy", { name = "$CustomTrophy", id = tourId })
    self.im.Publish("bnd_bg_tour", { name = "$Bg_Cup", id = tourId })
    self.im.Publish("bnd_tour_map", { name = "$CupMap", id = tourId })
    self.im.Publish("bnd_tour_logo", { name = "$CustomLogo", id = tourId })
    
    print(string.format(" Tournament info published: %s", tourName))
end

--  DETERMINAR ESTÁGIOS BASEADO NO TOTAL DE TIMES - SINCRONIZADO
function Bracket:getStageOrder()
    local stageOrder = {}
    
    --  SINCRONIZADO COM TeamSelect.lua, MatchSelect.lua E Standings.lua
    -- IMPORTANTE: Para 16 times knockout direto, COMEÇA COM ROUND OF 16 (Oitavas)
    if self.teamCount == 32 then
        -- 32 times: R32 → R16 → QF → SF → F
        stageOrder = {STAGE_NAMES.R32, STAGE_NAMES.R16, STAGE_NAMES.QF, STAGE_NAMES.SF, STAGE_NAMES.F}
        print("    32-team tournament: R32 → R16 → QF → SF → F")
    elseif self.teamCount == 48 then
        -- 48 times: R16 → QF → SF → F
        stageOrder = {STAGE_NAMES.R16, STAGE_NAMES.QF, STAGE_NAMES.SF, STAGE_NAMES.F}
        print("    48-team tournament: R16 → QF → SF → F")
    elseif self.teamCount == 16 then
        --  16 times KNOCKOUT DIRETO: R16 (Oitavas) → QF (Quartas) → SF (Semis) → F (Final)
        stageOrder = {STAGE_NAMES.R16, STAGE_NAMES.QF, STAGE_NAMES.SF, STAGE_NAMES.F}
        print("    16-team knockout tournament: R16 (Oitavas) → QF (Quartas) → SF (Semis) → F (Final)")
    else
        -- Fallback
        stageOrder = {STAGE_NAMES.F}
        print("    Unknown team count: " .. self.teamCount)
    end
    
    return stageOrder
end

--  PUBLICAR BRACKET DE FORMA COMPATÍVEL COM O LAYOUT
function Bracket:publishBracketData()
    local playerTeamID = currentTourInfo[tourId] and currentTourInfo[tourId].homeID or 0
    
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then
        print(" No bracket data available")
        return
    end
    
    --  VERIFICAR CONCLUSÃO DO TORNEIO
    self:checkTournamentCompletion()
    
    --  DETERMINAR ESTÁGIOS BASEADO NO TOTAL DE TIMES
    local stageOrder = self:getStageOrder()
    
    --  COLETAR MATCHES POR ESTÁGIO
    local bracketMatches = {}
    for _, stage in ipairs(stageOrder) do
        bracketMatches[stage] = {}
    end
    
    --  ADICIONAR MATCHES AO BRACKET
    for _, match in ipairs(QuickTourGrouping[tourId]) do
        local stage = match[9]
        -- Verificar se é um match knockout (match[7] == true)
        if match[7] and bracketMatches[stage] then
            table.insert(bracketMatches[stage], match)
        end
    end
    
    --  DEBUG: Mostrar matches coletados
    print(string.format(" Bracket data collection for %d teams:", self.teamCount))
    for _, stage in ipairs(stageOrder) do
        print(string.format("   %s: %d matches", stage, #bracketMatches[stage]))
    end
    
    --  PREENCHER DADOS DOS 62 SLOTS
    local slotIndex = 1
    
    for _, stage in ipairs(stageOrder) do
        if #bracketMatches[stage] > 0 then
            print(string.format("   Publishing %s matches to bracket...", stage))
            
            --  ORDENAR MATCHES POR MATCHDAY PARA CONSISTÊNCIA
            table.sort(bracketMatches[stage], function(a, b)
                return a[10] < b[10]  -- Ordenar por matchday (índice 10)
            end)
            
            for _, match in ipairs(bracketMatches[stage]) do
                if slotIndex <= 62 then
                    local homeTeamID = match[1]
                    local awayTeamID = match[2]
                    local homeScore = match[3] or 0
                    local awayScore = match[4] or 0
                    
                    --  PUBLICAR HOME TEAM
                    self.im.Publish("bnd_team" .. slotIndex .. "_crest", {
                        name = CREST_NORMAL,
                        id = homeTeamID
                    })
                    self.im.Publish("bnd_team" .. slotIndex .. "_abbr", 
                        self.loc.LocalizeString("TeamName_Abbr3_" .. homeTeamID))
                    self.im.Publish("bnd_team" .. slotIndex .. "_score", tostring(homeScore))
                    
                    slotIndex = slotIndex + 1
                    
                    --  PUBLICAR AWAY TEAM
                    if slotIndex <= 62 then
                        self.im.Publish("bnd_team" .. slotIndex .. "_crest", {
                            name = CREST_NORMAL,
                            id = awayTeamID
                        })
                        self.im.Publish("bnd_team" .. slotIndex .. "_abbr", 
                            self.loc.LocalizeString("TeamName_Abbr3_" .. awayTeamID))
                        self.im.Publish("bnd_team" .. slotIndex .. "_score", tostring(awayScore))
                        
                        slotIndex = slotIndex + 1
                    end
                end
            end
        end
    end
    
    --  LIMPAR SLOTS VAZIOS
    while slotIndex <= 62 do
        self.im.Publish("bnd_team" .. slotIndex .. "_crest", { name = CREST_NORMAL, id = 0 })
        self.im.Publish("bnd_team" .. slotIndex .. "_abbr", "")
        self.im.Publish("bnd_team" .. slotIndex .. "_score", "")
        slotIndex = slotIndex + 1
    end
    
    print(string.format(" Bracket published successfully (slots filled: %d)", slotIndex - 1))
end

--  PUBLICAR CAMPEÃO
function Bracket:publishChampion()
    if self.tourData.isFinish and self.tourData.championCrest.id ~= 0 then
        local championId = self.tourData.championCrest.id
        print(" Displaying champion: " .. self.loc.LocalizeString("TeamName_Abbr15_" .. championId))
        self.im.Publish("bnd_champion_visible", true)
        self.im.Publish("bnd_text", "THE CHAMPION")
        self.im.Publish("bnd_champion_crest", self.tourData.championCrest)
        self.im.Publish("bnd_champion_team", self.loc.LocalizeString("TeamName_Abbr15_" .. championId))
    else
        self.im.Publish("bnd_champion_visible", false)
    end
end

--  VERIFICAR E ATUALIZAR STATUS DO CAMPEÃO
function Bracket:checkTournamentCompletion()
    if not QuickTourGrouping or not QuickTourGrouping[tourId] then
        return
    end
    
    --  Verificar se o final foi jogado
    local finalMatch = nil
    for _, match in ipairs(QuickTourGrouping[tourId]) do
        if match[9] == STAGE_NAMES.F then
            finalMatch = match
            break
        end
    end
    
    if finalMatch and finalMatch[5] then  -- Match played
        self.tourData.isFinish = true
        self.tourData.championCrest.id = finalMatch[6] or 0  -- Winner ID
        self:publishChampion()
        print(" Tournament completed! Champion: " .. tostring(finalMatch[6]))
    end
end

function Bracket:finalize()
    local subsToClean = {
        "bnd_champion_visible", "bnd_champion_crest", "bnd_champion_team", "bnd_text",
        "bnd_tour_label", "bnd_tour_trophy", "bnd_bg_tour", "bnd_tour_map", "bnd_tour_logo"
    }
    
    for _, s in ipairs(subsToClean) do 
        self.im.Unsubscribe(s) 
    end
    
    -- Limpar subscriptions do bracket
    for i = 1, 62 do
        self.im.Unsubscribe("bnd_team" .. i .. "_crest")
        self.im.Unsubscribe("bnd_team" .. i .. "_abbr")
        self.im.Unsubscribe("bnd_team" .. i .. "_score")
    end
    
    print(" Bracket module finalized")
end

return Bracket
