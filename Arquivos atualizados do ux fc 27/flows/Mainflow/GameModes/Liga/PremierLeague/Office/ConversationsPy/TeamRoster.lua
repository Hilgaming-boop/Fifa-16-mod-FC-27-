-- Modified By MVNPROD Youtube Channel --
local Timer = ...
local TeamRoster = {}

local bndPlayerList = "bnd_player_list"
local ACT_PLAYER_SELECT = "act_player_select"
local bndBackgroundCareer = "bnd_background_career"
local ACT_HIDE = "act_hide"
local ACT_RELEASE = "act_release"
local ACT_TOGGLE = "act_toggle"
local BND_RANDOM_PHRASE = "bnd_random_phrase"

local phrases = {
    wonderkid = {
        future_star = { -- 85+
            "I know I'm destined for greatness, just need time to develop.",
            "The scouts say I could be world class in a few years.",
            "I'm soaking up everything like a sponge in training.",
            "My progress this season has been incredible, don't you think?",
            "Big clubs are already asking about me, but I want to stay here."
        },
        promising = { -- 75-84
            "I'm improving faster than anyone expected!",
            "These minutes are crucial for my development.",
            "I can feel myself getting better with each match.",
            "Coach, I promise I'll repay your faith in me.",
            "The veterans say I have incredible potential."
        },
        raw_talent = { -- 60-74
            "I know I'm rough around the edges but I'm working hard.",
            "Could you give me some extra training sessions?",
            "I need to work on my consistency during matches.",
            "Sometimes I feel overwhelmed but I'm learning quickly.",
            "I watch videos of my idols to improve my game."
        }
    },
    
    young = {
        elite = { -- 85+
            "I'm ready for a starting spot, coach!",
            "My stats are among the best in the league for my age.",
            "Big clubs are watching me but I want to stay here.",
            "I'm not just a prospect anymore - I'm delivering now.",
            "This could be my breakout season if I get more minutes."
        },
        solid = { -- 75-84
            "I've earned my place in the squad, now I want more.",
            "My performances deserve more minutes, don't they?",
            "I'm no longer just a youngster - I'm a real option.",
            "This could be my breakout season if I get chances.",
            "I'm pushing for a regular starting position."
        },
        inconsistent = { -- 60-74
            "I have good matches but need more consistency.",
            "Sometimes I doubt myself during games.",
            "I know I can do better than what I've shown.",
            "The pressure to perform gets to me sometimes.",
            "I need the coach's trust to show my true quality."
        }
    },
    
    early_prime = {
        superstar = { -- 88+
            "I'm entering my prime and dominating matches!",
            "Top clubs are circling but I'm focused here.",
            "This is just the beginning of my best years.",
            "My stats speak for themselves - I'm elite now.",
            "I want to be the face of this team for years to come."
        },
        key_player = { -- 80-87
            "I've become a vital piece of this team.",
            "The manager knows he can count on me.",
            "I'm hitting my stride at the perfect time.",
            "My experience and energy are peaking together.",
            "I'm taking more leadership responsibility now."
        },
        rotation = { -- 70-79
            "I deserve more starts with my performances.",
            "I'm good enough to play regularly somewhere.",
            "When I get minutes, I deliver - play me more!",
            "I'm stuck between prospect and established player.",
            "A run of games would really help my confidence."
        }
    },
    
    peak = {
        world_class = { -- 90+
            "I'm among the best in the world at my position!",
            "The team should be built around players like me.",
            "This is what peak performance looks like.",
            "I'm not just playing - I'm dominating every match.",
            "Individual awards would be nice, but I want trophies."
        },
        star = { -- 85-89
            "I'm in the form of my life right now!",
            "This is why you invested in me years ago.",
            "Every training, every match - I give 100%.",
            "My experience and skills are perfectly balanced.",
            "I'm entering my legacy years at this club."
        },
        reliable = { -- 75-84
            "I'm a solid professional who delivers consistently.",
            "You know exactly what you'll get from me.",
            "I may not be flashy but I get the job done.",
            "My versatility makes me invaluable to the squad.",
            "I pride myself on being available every match."
        }
    },
    
    veteran = {
        elite = { -- 87+
            "I'm proving age is just a number!",
            "My game intelligence compensates for lost speed.",
            "Young players should study my professionalism.",
            "I've adapted my game and I'm still dominant.",
            "They said I'd decline by now - look at my stats!"
        },
        experienced = { -- 80-86
            "I've seen it all and it shows in my play.",
            "My leadership is as important as my skills now.",
            "I make those around me better with my experience.",
            "I've simplified my game to stay effective.",
            "I'm the bridge between the staff and players."
        },
        useful = { -- 70-79
            "I can still contribute in specific roles.",
            "My know-how helps in tight situations.",
            "I'm not as fast but my positioning is better.",
            "Ask the young players - they learn from me daily.",
            "I accept my reduced role but still have quality."
        }
    },
    
    old_guard = {
        legend = { -- 85+
            "They said I'd decline by now - look at my stats!",
            "I'm rewriting what's possible at my age.",
            "Decades of experience give me an edge.",
            "The young guys can't believe my fitness levels.",
            "I'm playing smarter than ever before."
        },
        captain = { -- 80-84
            "I lead by example in training and matches.",
            "The club's values run through my veins.",
            "I bridge the gap between staff and players.",
            "My presence stabilizes the whole team.",
            "The armband gives me extra responsibility."
        },
        mentor = { -- 70-79
            "I'm here to guide the next generation now.",
            "Coaching is in my near future, I can feel it.",
            "I make up for lost pace with anticipation.",
            "Every minute I play is a bonus at this stage.",
            "I'm passing on my knowledge to the youngsters."
        }
    },
    
    -- PORTEROS (Categoría especial)
    goalkeeper = {
        young = { -- 16-22
            "I'm learning from every shot I face.",
            "Goalkeepers peak later - I'm just getting started.",
            "Mistakes hurt more but I'm growing from them.",
            "I'm working harder than anyone to be the better.",
            "I study the best keepers to improve my game."
        },
        prime = { -- 23-30
            "I'm in my best years physically and mentally.",
            "Commanding my area comes naturally now.",
            "I study opponents' tendencies religiously.",
            "The defense trusts me completely.",
            "Clean sheets mean more to me than goals."
        },
        veteran = { -- 31+
            "I see the game slower than when I was young.",
            "Positioning and anticipation beat reflexes now.",
            "I organize the defense like a coach on the field.",
            "Young keepers should watch how I prepare.",
            "Experience helps me read the game before it happens."
        }
    },
    
    star_goalkeeper = {
        "A clean sheet gives me more joy than any goal.",
        "The team's defense starts with me.",
        "Big saves in key moments define my career.",
        "I thrive under pressure when the team needs me most.",
        "I take responsibility for organizing our back line."
    },
    
    injured = {
        short_term = {
            "I'll be back stronger from this minor setback.",
            "The medical staff says my recovery is ahead of schedule.",
            "I'm working double time to return asap.",
            "This small injury won't keep me out long.",
            "I'm doing everything to return for the next match."
        },
        long_term = {
            "This injury is testing me but I'll overcome it.",
            "I'm using this time to study the game mentally.",
            "The squad needs me - I'm pushing hard in rehab.",
            "This is tough but I'll come back better than ever.",
            "Watching from the stands is killing me - I'll be back."
        }
    },
    
    benchwarmer = {
        "I need minutes to show what I can really do.",
        "Sitting on the bench is frustrating but I stay ready.",
        "Give me a run of games and I'll prove my worth.",
        "I train harder than anyone waiting for my chance.",
        "Being a backup is tough but I remain professional."
    },
    
    in_form = {
        "I'm in the zone right now - keep playing me!",
        "The ball seems to follow me everywhere lately.",
        "Everything I try on the pitch is coming off.",
        "I want to ride this wave of good form as long as possible.",
        "Confidence is high and it shows in my performances."
    },
    
    out_of_form = {
        "I'm working extra to regain my best level.",
        "This slump won't last - I'm too professional.",
        "I need the coach's trust during these tough times.",
        "True quality shows in how you bounce back.",
        "I'm analyzing my game to fix what's not working."
    },
    
    contract_talk = {
        "Can we discuss improving my contract?",
        "My performances deserve better terms.",
        "I want to commit my future to this club.",
        "Let's sit down and talk about an extension.",
        "I'm happy here but my contract needs addressing."
    }
}

local function selectRandomPhrase(phraseTable)
    if not phraseTable or #phraseTable == 0 then
        return "I'm focused on helping the team succeed."
    end
    math.randomseed(os.clock()*100000 + os.time())  -- Semilla más robusta
    return phraseTable[math.random(1, #phraseTable)]
end

function TeamRoster:getContextualPhrase(player)
    if not player or type(player) ~= "table" then
        return selectRandomPhrase({"Ready to contribute.", "Focused on the next match."})
    end
    
    local age = tonumber(GetPlayerAge(player.CARD_ID)) or 25
    local rating = tonumber(player.rating) or 70
    local position = player.position or "CM"
    local isInjured = (isSuspended and isSuspended[player.playerName] == 2) or false
    local isGK = position == "GK"
    
    print(string.format("[DEBUG] Player: %s, Age: %d, Rating: %d, Position: %s, Injured: %s", 
        player.playerName or "Unknown", age, rating, position, tostring(isInjured)))
    
    if isGK then
        if rating >= 85 then
            return selectRandomPhrase(phrases.star_goalkeeper)
        elseif age <= 22 then
            return selectRandomPhrase(phrases.goalkeeper.young)
        elseif age <= 30 then
            return selectRandomPhrase(phrases.goalkeeper.prime)
        else
            return selectRandomPhrase(phrases.goalkeeper.veteran)
        end
    elseif isInjured then
        local injuryType = "short_term"  -- Default
        if injuryRecoveryDate and injuryRecoveryDate[player.playerName] then
            injuryType = (injuryRecoveryDate[player.playerName]:find("month")) and "long_term" or "short_term"
        end
        return selectRandomPhrase(phrases.injured[injuryType])
    elseif age <= 19 then
        if rating >= 85 then return selectRandomPhrase(phrases.wonderkid.future_star)
        elseif rating >= 75 then return selectRandomPhrase(phrases.wonderkid.promising)
        else return selectRandomPhrase(phrases.wonderkid.raw_talent) end
    elseif age <= 22 then
        if rating >= 85 then return selectRandomPhrase(phrases.young.elite)
        elseif rating >= 75 then return selectRandomPhrase(phrases.young.solid)
        else return selectRandomPhrase(phrases.young.inconsistent) end
    elseif age <= 25 then
        if rating >= 88 then return selectRandomPhrase(phrases.early_prime.superstar)
        elseif rating >= 80 then return selectRandomPhrase(phrases.early_prime.key_player)
        else return selectRandomPhrase(phrases.early_prime.rotation) end
    elseif age <= 28 then
        if rating >= 90 then return selectRandomPhrase(phrases.peak.world_class)
        elseif rating >= 85 then return selectRandomPhrase(phrases.peak.star)
        else return selectRandomPhrase(phrases.peak.reliable) end
    elseif age <= 32 then
        if rating >= 87 then return selectRandomPhrase(phrases.veteran.elite)
        elseif rating >= 80 then return selectRandomPhrase(phrases.veteran.experienced)
        else return selectRandomPhrase(phrases.veteran.useful) end
    else
        if rating >= 85 then return selectRandomPhrase(phrases.old_guard.legend)
        elseif rating >= 80 then return selectRandomPhrase(phrases.old_guard.captain)
        else return selectRandomPhrase(phrases.old_guard.mentor) end
    end
end

local PlayerListData = {}
local teamPlayers = {}
local playerData
local statsubs = {"gs", "cs", "yc", "rc"}
local toggle = false
local lastRefreshDate = nil  
local randomPlayers = {}     
local MAX_RANDOM_PLAYERS = 9

TeamID = 0

function TeamRoster:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService"),
    gameSetup = o.api("GameSetupService")
  }
  TeamID = currentSelectedTeamID
  o.visible = true
  o.rowvisible = true
  o.panelvisible = false
  o.statvisible = false
  o.infovisible = true
  o.currentIndex = 0
  o.oldIndex = -1
  
  o.im.Subscribe("bnd_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe(bndBackgroundCareer, function()  
  local currentLeague = o:getCurrentLeague()
    o.im.Publish(bndBackgroundCareer, {name = "$BackgroundCareer", id = IDLeague})
  end)
  o.im.Subscribe("bnd_loading_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_rowvisible", function()
    o:publishVisible()
  end)
  -- o.im.Subscribe("bnd_panelvisible", function()
--   o:publishVisible()
-- end)
-- o.im.Subscribe("bnd_panelanim", function()
--   o:publishVisible()
-- end)
  o.im.Subscribe("bnd_plstat_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_plinfo_visible", function()
    o:publishVisible()
  end)
  o.im.Subscribe("bnd_team_crest", function()
    o.im.Publish("bnd_team_crest", {
      name = "$Crest",
      id = TeamID
    })
  end)
  o.im.Subscribe("bnd_team_name", function()
    o.im.Publish("bnd_team_name", o.loc.LocalizeString("TeamName_Abbr15_"..TeamID))
  end)
  o.im.Subscribe("bnd_player_avatar", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_name", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_ID", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_position", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_value", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_fitness", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_suspstatus", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_country", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_player_rating", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe("bnd_3d_player", function()
    o:publishPlayerInfo()
  end)
  o.im.Subscribe(BND_RANDOM_PHRASE, function()
    if not playerData and #PlayerListData > 0 then
        playerData = PlayerListData[1].playerInfo  
    end
    
    if playerData then
        if GLOBAL_DATE_PLACEHOLDER and type(GLOBAL_DATE_PLACEHOLDER) == "string" then
            local day, month = GLOBAL_DATE_PLACEHOLDER:match("^(%d%d)/(%d%d)/")
            
            if day and month and day == "01" and month == "08" then
                local welcomePhrases = {
                    "Welcome to the club, coach! Excited to learn and improve under you.",
"Glad to have you leading us this season. Let’s aim high together.",
"Big welcome, boss! I’ll work hard to earn my place in the squad.",
"Happy you’re here! I believe we can achieve something special.",
"Looking forward to playing for you. I’ll give everything for the badge.",
"Welcome, coach! The whole squad is ready to fight for success.",
"Good to meet you, boss. Let’s make this season unforgettable.",
"Pleased to have you here! I’ll do whatever it takes to help the team.",
"Excited about your arrival, coach. Let’s build something strong together.",
"Happy to see new energy in the club. Count on me for this challenge."
                }
                
                math.randomseed(os.time())
                local welcomeMessage = welcomePhrases[math.random(1, #welcomePhrases)]
                o.im.Publish(BND_RANDOM_PHRASE, welcomeMessage)
            else
                local phrase = o:getContextualPhrase(playerData)
                o.im.Publish(BND_RANDOM_PHRASE, phrase)
            end
        else
            local phrase = o:getContextualPhrase(playerData)
            o.im.Publish(BND_RANDOM_PHRASE, phrase)
        end
    else
        o.im.Publish(BND_RANDOM_PHRASE, "Ready to contribute to the team.")
    end
end)

  for i = 1, 6 do
    o.im.Subscribe("bnd_player_stat"..i, function()
      o:publishPlayerInfo()
    end)
  end
        
  for i = 1, 4 do
    o.im.Subscribe("bnd_friendly".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end
  for i = 1, 4 do
    o.im.Subscribe("bnd_dom".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end
  for i = 1, 4 do
    o.im.Subscribe("bnd_total".. statsubs[i], function()
      o:publishPlayerInfo()
    end)
  end

  o:Init()
  o.im.Subscribe(bndPlayerList, function()
    o:publishPlayerRows()
  end)
  o.im.RegisterAction(ACT_PLAYER_SELECT, function(actionName, data)
    if data then
      o:publishPlayerDetail(data)
    end
  end)
  o.im.RegisterAction(ACT_HIDE, function(actionName, data)
    o:hidePanel()
  end)
  o.im.RegisterAction(ACT_RELEASE, function(actionName, data)
    o:releasePlayer()
  end)
  o.im.RegisterAction(ACT_TOGGLE, function(actionName, data)
    o:toggleView()
  end)
  
  return o
end

function TeamRoster:getCurrentLeague()
    if not currentSelectedTeamID then
        return 0 -- Premier League por defecto
    end
    
    -- Intentar obtener la liga del equipo actual
    local teamService = self.api("TeamService")
    if teamService and teamService.GetTeamLeague then
        local leagueID = teamService.GetTeamLeague(currentSelectedTeamID)
        if leagueID and leagueID > 0 then
            return leagueID
        end
    end
    
    -- Fallback: determinar liga basado en el ID del equipo
    local leagueMap = {
        -- 1
[269]=1, [270]=1, [271]=1, [819]=1, [820]=1, [822]=1, [1443]=1, [1447]=1,
[1516]=1, [1786]=1, [1788]=1, [15001]=1,

-- 4
[681]=4, [1750]=4, [670]=4, [100081]=4, [229]=4, [100087]=4, [110724]=4,
[230]=4, [673]=4, [680]=4, [231]=4, [674]=4, [232]=4, [2014]=4, [537]=4,
[675]=4,

-- 7
[1629]=7, [598]=7, [1035]=7, [111052]=7, [517]=7, [1048]=7, [383]=7,
[567]=7, [1598]=7, [1041]=7, [111041]=7, [1719]=7, [569]=7, [568]=7,
[1043]=7, [112472]=7, [1053]=7, [111059]=7, [111057]=7, [130361]=7,

-- 10
[634]=10, [1913]=10, [245]=10, [1903]=10, [247]=10, [1910]=10, [100632]=10,
[1908]=10, [246]=10, [100646]=10, [1906]=10, [1915]=10, [1914]=10,
[100634]=10, [1904]=10, [645]=10, [1971]=10,

-- 13
[13]=13, [1925]=13, [14]=13, [110]=13, [18]=13, [19]=13, [5]=13, [2]=13,
[10]=13, [144]=13, [1]=13, [11]=13, [1799]=13, [1943]=13, [1808]=13,
[7]=13, [9]=13, [8]=13, [1796]=13, [106]=13, [1794]=13,

-- 14
[15]=14, [97]=14, [1800]=14, [1919]=14, [109]=14, [1960]=14, [1952]=14,
[1807]=14, [1806]=14, [12]=14, [3]=14, [1795]=14, [1792]=14,
[1951]=14, [1790]=14, [91]=14, [1801]=14, [88]=14, [1947]=14, [17]=14,
[94]=14, [95]=14, [89]=14,

-- 16
[65]=16, [69]=16, [76]=16, [219]=16, [73]=16, [66]=16, [64]=16, [74]=16,
[1738]=16, [72]=16, [71]=16, [1530]=16, [57]=16, [378]=16, [379]=16,
[1809]=16, [217]=16, [111817]=16,

-- 17
[210]=17, [62]=17, [294]=17, [1816]=17, [111659]=17, [1815]=17,
[115494]=17, [58]=17, [110321]=17, [1814]=17, [1805]=17, [614]=17,
[68]=17, [67]=17, [111273]=17, [111276]=17, [70]=17, [1819]=17,

-- 19
[175]=19, [38]=19, [112172]=19, [23]=19, [36]=19, [32]=19, [1831]=19,
[21]=19, [100409]=19, [1824]=19, [25]=19, [111235]=19, [22]=19,
[110329]=19, [10029]=19, [169]=19, [31]=19, [28]=19,

-- 20
[580]=20, [165]=20, [110500]=20, [10030]=20, [1832]=20, [34]=20, [485]=20,
[166]=20, [171]=20, [110636]=20, [29]=20, [531]=20, [110588]=20,
[110502]=20, [160]=20, [576]=20, [159]=20, [503]=20, [523]=20,

-- 31
[52]=31, [46]=31, [347]=31, [55]=31, [1842]=31, [110556]=31, [206]=31,
[110374]=31, [39]=31, [48]=31, [44]=31, [54]=31, [45]=31, [189]=31,
[50]=31, [1745]=31, [47]=31, [110738]=31, [111974]=31, [111434]=31,

-- 32
[1746]=32, [205]=32, [111811]=32, [1744]=32, [1837]=32, [1843]=32,
[1848]=32, [110373]=32, [110740]=32, [110908]=32, [110915]=32,
[111433]=32, [111657]=32, [111993]=32, [112124]=32, [112168]=32,
[112493]=32, [112494]=32, [190]=32, [110741]=32,

-- 39
[111140]=39, [114161]=39, [697]=39, [114640]=39, [111928]=39, [693]=39,
[688]=39, [112828]=39, [694]=39, [691]=39, [113149]=39, [112893]=39,
[114162]=39, [112885]=39, [687]=39, [112134]=39, [101112]=39,
[112996]=39, [112606]=39, [111651]=39, [698]=39, [111065]=39, [696]=39,
[689]=39, [111139]=39, [111138]=39, [695]=39, [111144]=39, [113018]=39,
[115243]=39,

-- 50
[81]=50, [181]=50, [83]=50, [77]=50, [80]=50, [100805]=50, [78]=50,
[86]=50, [82]=50, [180]=50, [79]=50, [621]=50,

-- 53
[1860]=53, [449]=53, [457]=53, [243]=53, [461]=53, [240]=53, [241]=53,
[453]=53, [448]=53, [450]=53, [483]=53, [110062]=53, [481]=53, [479]=53,
[463]=53, [480]=53, [452]=53, [110827]=53, [1853]=53, [468]=53,

-- 54
[472]=54, [100888]=54, [462]=54, [467]=54, [456]=54, [1861]=54,
[110839]=54, [1854]=54, [459]=54, [260]=54, [110069]=54, [573]=54,
[100851]=54, [10846]=54, [244]=54, [110832]=54, [1968]=54, [242]=54,
[1867]=54, [100852]=54, [110242]=54, [121110]=54,

-- 56
[319]=56, [320]=56, [321]=56, [433]=56, [700]=56, [702]=56, [708]=56,
[710]=56, [711]=56, [1439]=56, [111594]=56, [111705]=56, [112072]=56,
[112126]=56, [112180]=56, [113458]=56,

-- 60
[1797]=60, [1793]=60, [1933]=60, [4]=60, [1930]=60, [1926]=60, [1917]=60,
[1958]=60, [361]=60, [149]=60, [1939]=60, [1932]=60, [1938]=60,
[15015]=60, [1940]=60, [1931]=60, [143]=60, [142]=60, [1928]=60,
[1804]=60, [1923]=60, [1929]=60, [1961]=60, [112259]=60,

-- 65
[305]=65, [306]=65, [423]=65, [445]=65, [563]=65, [753]=65, [834]=65,
[837]=65, [1571]=65, [1572]=65,

-- 66
[301]=66, [420]=66, [873]=66, [1871]=66, [110206]=66, [110745]=66,
[110746]=66, [110747]=66, [110749]=66, [111083]=66, [111086]=66,
[111088]=66, [111091]=66, [111092]=66, [111097]=66, [114004]=66,
[114326]=66, [114393]=66,

-- 67
[312]=67, [315]=67, [100764]=67, [100765]=67, [100767]=67, [100769]=67,
[110102]=67, [110109]=67, [110227]=67, [110231]=67, [110232]=67,
[110239]=67, [112217]=67, [112218]=67, [112261]=67, [130988]=67,
[110222]=67,

-- 68
[326]=68, [325]=68, [110776]=68, [436]=68, [327]=68, [101041]=68,
[101033]=68, [113142]=68, [111339]=68, [101028]=68, [101014]=68,
[101020]=68, [101016]=68, [741]=68, [748]=68, [101026]=68, [101037]=68,
[121174]=68, [121388]=68,

-- 76
[133333]=76, [263]=76, [110870]=76, [393]=76, [1884]=76, [278]=76,
[111596]=76, [110943]=76, [111353]=76, [110981]=76, [115650]=76,
[115651]=76, [115652]=76, [115700]=76, [110969]=76, [110968]=76,
[110986]=76, [112908]=76, [112716]=76, [111008]=76, [111010]=76,
[111014]=76, [110989]=76, [110990]=76, [130109]=76, [257]=76, [130633]=76,
[100135]=76, [100325]=76, [130678]=76, [130733]=76, [101315]=76,
[100820]=76, [101070]=76, [130615]=76, [111969]=76, [264]=76, [100818]=76,
[111282]=76, [417]=76, [110472]=76, [130053]=76, [1202]=76, [112028]=76,
[129105]=76, [129107]=76, [130250]=76, [129108]=76, [129109]=76,
[111160]=76, [129229]=76, [129112]=76, [129113]=76, [129114]=76,
[129148]=76, [129117]=76, [130258]=76, [130927]=76, [129115]=76,
[129116]=76, [130246]=76, [129128]=76, [129129]=76, [129130]=76,
[130244]=76, [129118]=76, [129119]=76, [129155]=76, [129120]=76,
[129121]=76, [130249]=76, [129122]=76, [129123]=76, [129125]=76,
[129126]=76, [129127]=76, [130259]=76, [129205]=76, [130245]=76,
[130929]=76, [129131]=76, [129156]=76, [129157]=76, [129158]=76,
[129197]=76, [129201]=76, [129202]=76, [129203]=76, [130257]=76,
[129159]=76, [129133]=76, [129196]=76, [110941]=76, [130247]=76,
[130930]=76, [130251]=76, [129050]=76, [129134]=76, [129135]=76,
[129136]=76, [129137]=76, [130248]=76, [111172]=76, [129147]=76,
[129195]=76, [129138]=76, [129194]=76, [129145]=76, [129149]=76,
[129209]=76, [130255]=76, [130256]=76, [129143]=76, [129151]=76,
[129217]=76, [129222]=76, [129225]=76, [130243]=76, [130932]=76,
[129140]=76, [129141]=76, [129032]=76, [129033]=76, [129142]=76,
[129200]=76, [130238]=76, [130933]=76, [129152]=76, [110940]=76,
[129198]=76, [130936]=76, [130180]=76, [112090]=76, [101142]=76,
[111727]=76, [112812]=76, [116493]=76, [130184]=76, [130028]=76,
[130025]=76, [130185]=76, [111731]=76, [130187]=76, [130163]=76,
[130026]=76, [130188]=76, [112208]=76, [130227]=76, [115701]=76,
[114423]=76, [114427]=76, [114424]=76, [114426]=76, [114430]=76,
[114428]=76, [114429]=76, [114425]=76, [112190]=76
    }
    
    return leagueMap[currentSelectedTeamID] or 0 -- Premier League por defecto
end

function TeamRoster:publishVisible()
  self.im.Publish("bnd_visible", self.visible)
  self.im.Publish("bnd_rowvisible", self.rowvisible)
  self.im.Publish("bnd_plstat_visible", self.statvisible)
  self.im.Publish("bnd_plinfo_visible", self.infovisible)
  self.im.Publish("bnd_loading_visible", not self.visible)
end

function TeamRoster:publishPlayerInfo(data)
  local suspStatus = "Conform"
  local fitnessStatus = "Match Fit"
  local plgoals = 0
  local plcleansheets = 0
  local plyellowcard = 0
  local plredcard = 0
  if data then 
    self.im.Publish("bnd_player_avatar", {
      name = "$Head",
      id = data.CARD_ID
    })
    self.im.Publish("bnd_player_name", data.playerName)
    self.im.Publish("bnd_player_ID", data.CARD_ID)
    self.im.Publish("bnd_player_position", data.position)
    self.im.Publish("bnd_player_country", {
      name = "$Flag128x128",
      id = data.nationalityID
    })
    if isSuspended[data.playerName] == 2 then
      fitnessStatus = "Injured. Back (" .. injuryRecoveryDate[data.playerName] .. ")"
    elseif isSuspended[data.playerName] == 1 then
      suspStatus = "Red Carded"
    end
    local playerInfo = getPlayerInfo(data.CARD_ID, currentSelectedTeamID)
    local Index = playerInfo and playerInfo.index
    local repCount = playerReplacementCount(currentSelectedTeamID, data.position)
    local days = daysLeftInTransferWindow(GLOBAL_DATE_PLACEHOLDER)
    local playervalue, minvalue = computeTransferValue(GetPlayerAge(data.CARD_ID), data.rating, data.position, Index, repCount, days)
    self.im.Publish("bnd_value", "$" .. self.loc.LocalizeInteger(playervalue))
    self.im.Publish("bnd_suspstatus", suspStatus)
    self.im.Publish("bnd_fitness", fitnessStatus)
    self.im.Publish("bnd_player_rating", data.rating)
    self.im.Publish("bnd_3d_player", {
      name = "$PLAYER_ID",
      id = data.CARD_ID
    })
    for i = 1, 6 do
      self.im.Publish("bnd_player_stat"..i, data["stat"..i])
    end
    plgoals = GOALS[data.CARD_ID] or 0
    plcleansheets = 0
    plyellowcard = yellowCardRecords[data.playerName] or 0
    plredcard = redCardRecords[data.playerName] or 0
    local stats = {plgoals, plcleansheets, plyellowcard, plredcard}
    for i = 1, 4 do
      self.im.Publish("bnd_dom" .. statsubs[i], stats[i])
      self.im.Publish("bnd_friendly" .. statsubs[i], 0)
      self.im.Publish("bnd_total" .. statsubs[i], stats[i])
    end
  end
end

function TeamRoster:Init()
  local shouldRefresh = false
  if GLOBAL_DATE_PLACEHOLDER and type(GLOBAL_DATE_PLACEHOLDER) == "string" then
    shouldRefresh = lastRefreshDate ~= GLOBAL_DATE_PLACEHOLDER
  else
    local currentDate = os.date("%d/%m/%y")
    shouldRefresh = lastRefreshDate ~= currentDate
  end
  
  if shouldRefresh or #randomPlayers == 0 then
    if GLOBAL_DATE_PLACEHOLDER and type(GLOBAL_DATE_PLACEHOLDER) == "string" then
      lastRefreshDate = GLOBAL_DATE_PLACEHOLDER
    else
      lastRefreshDate = os.date("%d/%m/%y")
    end
    
    local teamInfo = self.services.SquadManagementService.GetTeamInfo(TeamID)
    local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, TeamID, 0)
    
    local previouslySelectedId = nil
    if self.currentIndex >= 1 and self.currentIndex <= #PlayerListData then
      previouslySelectedId = PlayerListData[self.currentIndex].playerInfo.CARD_ID
    end
    
    PlayerListData = {}
    randomPlayers = {}
    
    if teamLineup then
      local allPlayers = {}
      for i = 1, #teamLineup do
        local obj = {
          assetId = teamLineup[i].CARD_ID,
          clickAction = "act_player_select",
          playerInfo = teamLineup[i],
          data = {
            PlayerAvatar = {
              name = "$Head",
              id = teamLineup[i].CARD_ID
            },
            PlayerName = teamLineup[i].playerName,
            Rating = teamLineup[i].rating,
            clickAction = "act_player_select",
            FontColor = "0xffffff",
            Position = teamLineup[i].position
          }
        }
        table.insert(allPlayers, obj)
      end
      
      local numPlayers = math.min(MAX_RANDOM_PLAYERS, #allPlayers)
      local selectedIndices = {}
      
      for i = 1, numPlayers do
        local randomIndex
        repeat
          randomIndex = math.random(1, #allPlayers)
        until not selectedIndices[randomIndex]
        
        selectedIndices[randomIndex] = true
        table.insert(randomPlayers, allPlayers[randomIndex])
      end
      
      PlayerListData = randomPlayers
      
      if previouslySelectedId then
        for i, player in ipairs(PlayerListData) do
          if player.playerInfo.CARD_ID == previouslySelectedId then
            self.currentIndex = i
            break
          end
        end
      else
        self.currentIndex = 1
      end
    end
  end
end

function TeamRoster:publishPlayerRows()
  for i, v in ipairs(PlayerListData) do
    v.data.PlayerAvatar = {
      name = "$Head",
      id = PlayerListData[i].assetId
    }
    v.data.PlayerName = PlayerListData[i].playerInfo.playerName
    v.data.Rating = PlayerListData[i].playerInfo.rating
    v.data.clickAction = PlayerListData[i].clickAction
    v.data.FontColor = "0xffffff"
    v.data.Position = PlayerListData[i].playerInfo.position
  end
  self.im.Publish(bndPlayerList, PlayerListData)
  self.visible = true
  self:publishVisible()
  
  if not playerData and #PlayerListData > 0 then
    playerData = PlayerListData[1].playerInfo
    self:publishPlayerInfo(playerData)
    
    if GLOBAL_DATE_PLACEHOLDER and type(GLOBAL_DATE_PLACEHOLDER) == "string" then
        local day, month = GLOBAL_DATE_PLACEHOLDER:match("^(%d%d)/(%d%d)/")
        
        if day and month and day == "01" and month == "08" then
            local welcomePhrases = {
                "Welcome to the club, coach! Excited to learn and improve under you.",
"Glad to have you leading us this season. Let’s aim high together.",
"Big welcome, boss! I’ll work hard to earn my place in the squad.",
"Happy you’re here! I believe we can achieve something special.",
"Looking forward to playing for you. I’ll give everything for the badge.",
"Welcome, coach! The whole squad is ready to fight for success.",
"Good to meet you, boss. Let’s make this season unforgettable.",
"Pleased to have you here! I’ll do whatever it takes to help the team.",
"Excited about your arrival, coach. Let’s build something strong together.",
"Happy to see new energy in the club. Count on me for this challenge."
            }
            
            math.randomseed(os.time())
            local welcomeMessage = welcomePhrases[math.random(1, #welcomePhrases)]
            self.im.Publish(BND_RANDOM_PHRASE, welcomeMessage)
        else
            local phrase = self:getContextualPhrase(playerData)
            self.im.Publish(BND_RANDOM_PHRASE, phrase)
        end
    else
        local phrase = self:getContextualPhrase(playerData)
        self.im.Publish(BND_RANDOM_PHRASE, phrase)
    end
  end
end

function TeamRoster:publishPlayerDetail(data)
    if not data or type(data) ~= "table" then
        print("[ERROR] Invalid data in publishPlayerDetail")
        return
    end
    
    local playerIndex = (data.id or 0) + 1
    
    if playerIndex < 1 or playerIndex > #PlayerListData then
        print(string.format("[ERROR] Invalid player index: %d", playerIndex))
        return
    end
    
    if self.currentIndex == playerIndex then
        return
    end
    
    self.oldIndex = self.currentIndex
    self.currentIndex = playerIndex
    
    playerData = PlayerListData[playerIndex].playerInfo    
    
    if playerData then
        print(string.format("[DEBUG] Selected player: %s (ID: %d, Rating: %d, Position: %s)", 
            playerData.playerName or "Unknown", 
            playerData.CARD_ID or 0, 
            playerData.rating or 0, 
            playerData.position or "Unknown"))
    else
        print("[ERROR] playerData is nil")
        return 
    end
    
    if GLOBAL_DATE_PLACEHOLDER and type(GLOBAL_DATE_PLACEHOLDER) == "string" then
        local day, month = GLOBAL_DATE_PLACEHOLDER:match("^(%d%d)/(%d%d)/")
        
        if day and month and day == "01" and month == "08" then
            local welcomePhrases = {
                "Welcome to the club, coach! Excited to learn and improve under you.",
"Glad to have you leading us this season. Let’s aim high together.",
"Big welcome, boss! I’ll work hard to earn my place in the squad.",
"Happy you’re here! I believe we can achieve something special.",
"Looking forward to playing for you. I’ll give everything for the badge.",
"Welcome, coach! The whole squad is ready to fight for success.",
"Good to meet you, boss. Let’s make this season unforgettable.",
"Pleased to have you here! I’ll do whatever it takes to help the team.",
"Excited about your arrival, coach. Let’s build something strong together.",
"Happy to see new energy in the club. Count on me for this challenge."
            }
            
            math.randomseed(os.time())
            local welcomeMessage = welcomePhrases[math.random(1, #welcomePhrases)]
            self.im.Publish(BND_RANDOM_PHRASE, welcomeMessage)
        else
            local phrase = self:getContextualPhrase(playerData)
            self.im.Publish(BND_RANDOM_PHRASE, phrase)
        end
    else
        local phrase = self:getContextualPhrase(playerData)
        self.im.Publish(BND_RANDOM_PHRASE, phrase)
    end
    
    self:publishPlayerInfo(playerData)  
end

-- function TeamRoster:hidePanel()
--   self.panelvisible = false
--   self.im.Publish("bnd_panelvisible", self.panelvisible)
--   self.im.Publish("bnd_rowvisible", true)
--   self:publishVisible()
-- end

function TeamRoster:toggleView()
  if toggle == false then
    self.im.Publish("bnd_plinfo_visible", false)
    self.im.Publish("bnd_plstat_visible", true)
    toggle = true
  else
    self.im.Publish("bnd_plinfo_visible", true)
    self.im.Publish("bnd_plstat_visible", false)
    toggle = false
  end
end

function TeamRoster:releasePlayer()
  releasePlayer(playerData.CARD_ID, currentSelectedTeamID)
  PlayerListData = {}
  self:Init()
  self:publishPlayerRows()
  self.panelvisible = false 
  self.im.Publish("bnd_panelvisible", self.panelvisible)
  self.im.Publish("bnd_rowvisible", true)
  self:publishVisible()
end

function TeamRoster:update(elapsedTime)
  if self.panelAnimTimer then
    self.panelAnimTimer:update(elapsedTime)
  end
end

function TeamRoster:finalize()
  if self.panelAnimTimer then
    self.panelAnimTimer:finalize()
    self.panelAnimTimer = nil
    print("[TeamRoster]: Panel anim timer finalized")
  end
  self.im.Unsubscribe("bnd_visible")
  self.im.Unsubscribe("bnd_loading_visible")
  self.im.Unsubscribe("bnd_team_crest")
  self.im.Unsubscribe("bnd_team_name")
  self.im.Unsubscribe("bnd_player_name")
  self.im.Unsubscribe("bnd_player_avatar")
  self.im.Unsubscribe("bnd_player_ID")
  self.im.Unsubscribe("bnd_player_position")
  self.im.Unsubscribe("bnd_player_country")
  self.im.Unsubscribe("bnd_player_rating")
  self.im.Unsubscribe("bnd_3d_player")
  self.im.Unsubscribe(BND_RANDOM_PHRASE)
  for i = 1, 6 do
    self.im.Unsubscribe("bnd_player_stat"..i)
  end
  self.im.Unsubscribe(bndPlayerList)
  self.im.UnregisterAction(ACT_PLAYER_SELECT)
end

return TeamRoster