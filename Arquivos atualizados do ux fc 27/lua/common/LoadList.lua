-- DAVUNPES SAVE --

local LoadList = {}
local bndMatchList = "bnd_match_list"
local ACT_ADVANCE = "act_advance"
GLOBAL_PLAYERIN = 4
GLOBAL_MATCHUP_COUNT = 20
GLOBAL_DATE_PLACEHOLDER = "04/01/25"
GOALS = {
    [189682] = 2,
    [245336] = 1,
    [224458] = 2,
    [246420] = 1,
    [220697] = 2,
    [180216] = 2,
    [227678] = 1,
    [247090] = 2,
    [216267] = 2,
    [256079] = 1,
    [268438] = 2,
    [210243] = 2,
    [188377] = 1,
    [231281] = 1,
    [200458] = 1,
    [275771] = 2,
    [209989] = 3,
    [205431] = 5,
    [213655] = 1,
    [207599] = 1,
    [260926] = 2,
    [236988] = 3,
    [229880] = 1,
    [206516] = 3,
    [232080] = 2,
    [243715] = 4,
    [267680] = 1,
    [243014] = 9,
    [233866] = 3,
    [234153] = 1,
    [207410] = 1,
    [224081] = 1,
    [229723] = 2,
    [244067] = 2,
    [259399] = 3,
    [203841] = 1,
    [231445] = 2,
    [259240] = 1,
    [235844] = 1,
    [224656] = 1,
    [240243] = 2,
    [235805] = 4,
    [241842] = 2,
    [241159] = 1,
    [210881] = 1,
    [227174] = 2,
    [202695] = 1,
    [226790] = 2,
    [206517] = 5,
    [238756] = 5,
    [227813] = 3,
    [232999] = 2,
    [202849] = 1,
    [213884] = 1,
    [224371] = 2,
    [247851] = 2,
    [240500] = 3,
    [210697] = 1,
    [202048] = 2,
    [229984] = 1,
    [223197] = 2,
    [226380] = 4,
    [202697] = 1,
    [186146] = 5,
    [237692] = 7,
    [263620] = 2,
    [246685] = 1,
    [233731] = 3,
    [248602] = 1,
    [190717] = 2,
    [208135] = 2,
    [245279] = 1,
    [238717] = 1,
    [212484] = 2,
    [221841] = 2,
    [235243] = 1,
    [200104] = 3,
    [232487] = 3,
    [234574] = 4,
    [241236] = 4,
    [212198] = 2,
    [248695] = 3,
    [221697] = 4,
    [200145] = 1,
    [239818] = 2,
    [232730] = 3,
    [231005] = 2,
    [241464] = 2,
    [205569] = 1,
    [231866] = 1,
    [229348] = 3,
    [220710] = 3,
    [259307] = 1,
    [242641] = 4,
    [209331] = 4,
    [254243] = 1,
    [235405] = 1,
    [237477] = 4,
    [247678] = 4,
    [251566] = 5,
    [248793] = 3,
    [273463] = 3,
    [226162] = 4,
    [203502] = 5,
    [250961] = 5,
    [204838] = 5,
    [258930] = 6,
    [231677] = 4,
    [260779] = 4,
    [239901] = 4,
    [262118] = 1,
    [257084] = 1,
    [243057] = 4,
    [236461] = 3,
    [232411] = 2,
    [219693] = 1,
    [235790] = 4,
    [230977] = 4,
    [233049] = 1,
    [213956] = 2,
    [207421] = 3,
    [227535] = 2,
    [251954] = 4,
    [220714] = 1,
    [254088] = 3,
    [205988] = 1,
    [213991] = 3,
    [243282] = 3,
    [206594] = 4,
    [61475] = 5,
    [225783] = 3,
    [254120] = 1,
    [235456] = 1,
    [242964] = 1,
    [237386] = 4,
    [242908] = 3,
    [260145] = 4,
    [247172] = 1,
    [241084] = 3,
    [222501] = 2,
    [232223] = 1,
    [192985] = 3,
    [269495] = 1,
    [231044] = 1,
    [207616] = 1,
    [245388] = 3,
    [252042] = 3,
    [240097] = 1,
    [235794] = 2,
    [259031] = 2,
    [246669] = 4,
    [244472] = 2,
    [234824] = 3,
    [257470] = 1,
    [239301] = 1,
    [236480] = 2,
    [233500] = 2,
    [251892] = 4,
    [257534] = 2,
    [236401] = 1,
    [254796] = 4,
    [260247] = 2,
    [253072] = 3,
    [226012] = 1,
    [245741] = 1,
    [264337] = 1,
    [208830] = 5,
    [248484] = 1,
    [226491] = 1,
    [243606] = 7,
    [224258] = 2,
    [190885] = 1,
    [243702] = 1,
    [257504] = 3,
    [237646] = 1,
    [259608] = 1,
    [198950] = 4,
    [256612] = 4,
    [242619] = 2,
    [230666] = 4,
    [225100] = 1,
    [237916] = 2,
    [271800] = 1,
    [201417] = 1,
    [243576] = 1,
    [258908] = 1,
    [223334] = 2,
    [247497] = 1,
    [205498] = 4,
    [225659] = 1,
    [235353] = 5,
    [240740] = 2,
    [247394] = 4,
    [203574] = 1,
    [234742] = 3,
    [231943] = 4,
    [238095] = 3,
    [227927] = 2,
    [212811] = 2,
    [206085] = 2,
    [197975] = 1,
    [192123] = 3,
    [259197] = 4,
    [224294] = 4,
    [235036] = 1,
    [221479] = 3,
    [239231] = 1,
    [233602] = 1,
    [237161] = 3,
    [266609] = 1,
    [196978] = 3,
    [239085] = 2,
    [210047] = 2,
    [230978] = 4,
    [251421] = 2,
    [259868] = 1,
    [255565] = 2,
    [251517] = 3,
    [225539] = 2,
    [229906] = 4,
    [210736] = 2,
    [233795] = 5,
    [229237] = 4,
    [180819] = 4,
    [245155] = 4,
    [252793] = 1,
    [193474] = 1,
    [236792] = 2,
    [270409] = 3,
    [238616] = 3,
    [259583] = 2,
    [236920] = 1,
    [235167] = 1,
    [216266] = 2,
    [253306] = 2,
    [216393] = 1,
    [269136] = 2,
    [220570] = 1
}
selTeamFORMID = 0
currentSelectedTeamID = 9

currentMatch = {
    HomeTeamID = 0,
    AwayTeamID = 0,
    HomeKitIndex = 0,
    AwayKitIndex = 1
}

-- Dev2
local rivalListData = {}
local matchesPlayed = 0  -- Counter to track the number of matches played

-- Score symbol mapping
local SYMBOL_TO_SCORELINE = {
    ["q"]={0,0}, ["w"]={1,0}, ["e"]={2,0}, ["r"]={3,0}, ["t"]={4,0}, ["y"]={5,0}, ["u"]={6,0}, ["i"]={7,0},
    ["o"]={1,1}, ["p"]={2,2}, ["a"]={3,3}, ["s"]={4,4}, ["d"]={5,5},
    ["f"]={0,1}, ["g"]={0,2}, ["h"]={0,3}, ["j"]={0,4}, ["k"]={0,5}, ["@"]={0,6}, ["z"]={0,7},
    ["x"]={2,1}, ["c"]={3,1}, ["v"]={4,1}, ["b"]={5,1}, ["n"]={6,1}, ["m"]={7,1},
    ["Q"]={1,2}, ["W"]={1,3}, ["E"]={1,4}, ["R"]={1,5}, ["T"]={1,6}, ["Y"]={1,7},
    ["U"]={3,2}, ["#"]={4,2}, ["O"]={5,2}, ["P"]={6,2}, ["A"]={7,2},
    ["S"]={4,3}, ["D"]={5,3}, ["F"]={6,3}, ["G"]={7,3}, ["H"]={5,4},
    ["K"]={2,3}, ["L"]={2,4}, ["Z"]={2,5}, ["X"]={2,6}, ["C"]={2,7},
    ["V"]={3,4}, ["B"]={3,5}, ["N"]={3,6}, ["M"]={3,7}, ["J"]={4,5}
}

-- Team position mapping
local SYMBOL_TO_TEAM_POSITION = {
    ["q"]=1, ["w"]=2, ["e"]=3, ["r"]=4, ["t"]=5, ["y"]=6, ["u"]=7, ["i"]=8, ["o"]=9, ["p"]=10,
    ["a"]=11, ["s"]=12, ["d"]=13, ["f"]=14, ["g"]=15, ["h"]=16, ["j"]=17, ["k"]=18, ["l"]=19, ["z"]=20,
    ["x"]=21, ["c"]=22, ["v"]=23, ["b"]=24, ["n"]=25, ["m"]=26
}

-- League teams
local LEAGUES = {
    [1] = {1,2,7,5,9,10,11,13,14,18,19,110,144,1799,1808,1943,1925,94,17,95}  -- EPL
}

function LoadList:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = {
        settingsService = o.api("SettingsService"),
        SquadManagementService = o.api("SquadMgtService")
    }
    o.currentOptions = o.services.settingsService.GetCurrentOptions()
    o.Init()
    o.im.Subscribe(bndMatchList, function()
        o:publishMatchRows()
    end)
    o.im.Subscribe("bnd_match_label", function()
        o:publishMatchLabel()
    end)
    o.im.Subscribe("bnd_finish_label", function()
        o:publishFinishLabel()
    end)
    o.im.RegisterAction(ACT_ADVANCE, function(actionName, data)
        if data then
            o:PlayMatch(data)
        end
    end)
    return o
end

function LoadList:Init()
    -- Initialize if needed
end

function LoadList:publishMatchRows()
    local LoadListData = {}
    
    -- Rows 1-5 (indices 0-4): Dummy entries with no action
    for i = 1, 5 do
        local row = {
            data = {
                PlayerName = "Option " .. i,
                Position = i,
                Rating = i,
                PlayerTeam = i,
                PlayerHead = {
                    name = "Head",
                    id = 1
                },
                Player1Team = {
                    name = "Crest",
                    id = 1
                },
                clickAction = nil  -- No action
            }
        }
        table.insert(LoadListData, row)
    end
    
    -- Row 6 (index 5): Load save codes
    local row6 = {
        data = {
            PlayerName = "Load Save Codes",
            Position = 6,
            Rating = 6,
            PlayerTeam = 6,
            PlayerHead = {
                name = "Head",
                id = 1
            },
            Player1Team = {
                name = "Crest",
                id = 1
            },
            clickAction = "act_advance"
        }
    }
    table.insert(LoadListData, row6)
    
    self.im.Publish(bndMatchList, LoadListData)
end

function LoadList:loadSaveCodes(targetLigaId)
    targetLigaId = targetLigaId or 1
    
    -- Paste your codes here
    local fixtureCode = "yeftljuawihkqzrpsgdoytejfaliukwzhpqgrosdjyatiekfzlpugwohdqsryajitkezfplguowdhsqryiakzjtpegfoldusrwhqkyizpagjotdesfrlquwhyzkpigaojdtserfqlhuwypzgokdiasjrtqhefwlugypozdskriqahjwteulfyogdpsrzkqihawujtlefdyosrgqpzhkwiualfjtesydroqhgwpzulkfieajtyrsqhdwougplfzkeitajqyrhwsduolgfpetzkjiayhqwrulsdfeogtjpzaikywuhlqfrsetdojagpizkuywlhfqertsjdaoikgpzylfuewhtjqraisdkzogpyfletuwjahqikrszpdogzypkgioadjstreqfhlwuyulwfheqtrjsadiogkzpiykajzptgeofdlsuwrqhtyjeafilkuzwphgqordsryqsdhowgulpzfektijaeytfjlauiwkhzqprgsodfyelutjwhaiqrkzsdpgoayijktzepfgloudwshrqykziapjgtoedfslruqhwysrdqoghpwuzklifaetjpygzkoidsarjqtehwfulygopdzksiraqjhtwueflydsogrpqhzwkuilajfetoydgspzrqkhiwajultfeyjtaeifklzupwghoqdrswyhuqlrfesdtjogaipkzlyufwethqjarsikdozpgyqhrswudlofgepztjkaihywqurslfdoetgpjazki"
    local scoreCode = "qfQxqoxexqpoxtwpxrjwqqhwoffKxpHQwtwrKwgxroDocfxeygcuxUxwwqfqxffqEwoKocFUexxKxeceqogQowxwowqorcVeveofeafWqWfxafgxfqvjeofhKVUwpQyoxgwqffUcwoowpowxQcZgpaWeoxvxoqxExqgrqQfxweQoworptrweUWxxrroowwSeQxpgxwwQooorwqgoqWqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    
    if (not fixtureCode or #fixtureCode == 0) and (not scoreCode or #scoreCode == 0) then
        print("[LoadList] Error: At least one of fixtureCode or scoreCode must be provided")
        return false
    end
    if fixtureCode and #fixtureCode > 0 and #fixtureCode % 2 ~= 0 then
        print("[LoadList] Error: Fixture code must have even number of symbols")
        return false
    end
    
    local teamList = LEAGUES[targetLigaId] or {}
    if #teamList == 0 then
        print("[LoadList] Error: No teams defined for league " .. targetLigaId)
        return false
    end
    local positionToTeam = {}
    for i, teamId in ipairs(teamList) do
        positionToTeam[i] = teamId
    end
    
    local teamID = currentSelectedTeamID
    local fixedPlayerIDs = {
        212831, 231281, 237678, 203376, 216267, 239837, 232487, 209331, 242516, 236772, 224458, 240913, 232223, 225100, 246104, 242434, 235805, 241084, 253428, 264298, 273651, 246174, 253072
    }
    self.services.SquadManagementService.SetCurrentPlayerLineup(0, teamID, 0, 0, fixedPlayerIDs)
    
    local matches = {}
    local matchCount = 0
    local matchday = 1
    local maxMatches = 0
    if fixtureCode and #fixtureCode > 0 then
        maxMatches = #fixtureCode / 2
    elseif scoreCode and #scoreCode > 0 then
        maxMatches = #scoreCode
    end
    
    for matchIndex = 1, maxMatches do
        matchCount = matchCount + 1
        if matchCount % 10 == 1 and matchCount > 1 then
            matchday = matchday + 1
        end
        
        local homeId, awayId = 0, 0
        if fixtureCode and #fixtureCode > 0 then
            local i = (matchIndex - 1) * 2 + 1
            local homeSymbol = fixtureCode:sub(i,i):lower()
            local awaySymbol = fixtureCode:sub(i+1,i+1):lower()
            
            local homePos = SYMBOL_TO_TEAM_POSITION[homeSymbol]
            local awayPos = SYMBOL_TO_TEAM_POSITION[awaySymbol]
            if homePos and awayPos and homePos <= #teamList and awayPos <= #teamList then
                homeId = positionToTeam[homePos]
                awayId = positionToTeam[awayPos]
            else
                print("[LoadList] Warning: Invalid fixture symbols '" .. homeSymbol .. awaySymbol .. "' at position " .. i)
            end
        end
        
        local homeScore, awayScore = 0, 0
        if scoreCode and matchIndex <= #scoreCode then
            local scoreSymbol = scoreCode:sub(matchIndex, matchIndex)
            local scores = SYMBOL_TO_SCORELINE[scoreSymbol]
            if scores then
                homeScore = scores[1]
                awayScore = scores[2]
            else
                print("[LoadList] Warning: Invalid score symbol '" .. scoreSymbol .. "' at match " .. matchCount)
            end
        end
        
        table.insert(matches, {
            homeId = homeId,
            awayId = awayId,
            homeScore = homeScore,
            awayScore = awayScore,
            matchday = matchday
        })
    end
    
    rivalListData = matches
    matchesPlayed = #rivalListData
    LigaGrouping = LigaGrouping or {}
    LigaGrouping[targetLigaId] = LigaGrouping[targetLigaId] or {}
    
    for i, match in ipairs(rivalListData) do
        LigaGrouping[targetLigaId][i] = {
            match.homeId,
            match.awayId,
            0,
            match.homeScore,
            match.awayScore,
            data = {homeScorers = {}, awayScorers = {}}
        }
    end
    
    print("[LoadList] Successfully loaded " .. matchCount .. " matches across " .. matchday .. " matchdays")
    return true
end

function LoadList:PlayMatch(data)
    -- data.id is 0-based (0-5 corresponds to rows 1-6)
    if data.id + 1 <= 5 then
        -- Rows 1-5: No action
        print("[LoadList] Clicked row " .. (data.id + 1) .. ": No action")
    elseif data.id + 1 == 6 then
        -- Row 6: Load and run save codes
        if self:loadSaveCodes(1) then
            -- After loading, you might want to refresh the display or perform another action
            self:publishMatchRows()
            self.nav.Event(nil, "evt_back") -- Optional: Go back after loading
        end
    end
end

function LoadList:publishMatchLabel()
    -- Implement if needed
end

function LoadList:publishFinishLabel()
    -- Implement if needed
end

function LoadList:finalize()
    self.im.UnregisterAction(ACT_ADVANCE)
    self.im.Unsubscribe("bnd_match_list")
    self.im.Unsubscribe("bnd_match_label")
    self.im.Unsubscribe("bnd_finish_label")
    rivalListData = {}
end

return LoadList