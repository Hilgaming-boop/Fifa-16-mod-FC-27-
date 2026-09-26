local ClassicmatchWomens = {}

local bndMatchList = "bnd_match_list"
local bndRandomAdsText = "bnd_random_ads_text"
local bndNewsImage = "bnd_news_image"
local bndNewsSource = "bnd_news_source"
local bndHomeTeamLogo = "bnd_home_team_logo"
local bndAwayTeamLogo = "bnd_away_team_logo"
local bndNewsComment = "bnd_news_comment"
local ACT_MATCH_PLAY = "act_match_play"
local ACT_REFRESH_ADS = "act_refresh_ads"
local bndBackgroundCareer = "bnd_background_career"
local bndLeagueColor = "bnd_league_color"
local lastNewsType = nil
local refreshCount = 0
local leagueColors = {
    [0] = 0xFF1E1D27,
    [13] = 0xFF160219,
    [16] = 0xFF090D15,
    [19] = 0xFF121212,
    [53] = 0xFF0D0A14
}

currentMode = 1




local newsPhrases = {

    upcoming_matches = {},


    league_news = {
        "Premier League title race reaches boiling point as contenders clash",
"La Liga surprise package keeps delivering week after week against the odds",
"Bundesliga champions put to the test with a difficult away challenge ahead",
"Serie A heavyweights lock horns in a tactical showdown with huge stakes",
"Ligue 1 young stars continue to light up France’s top division with style",
"Premier League mid-table battle intensifies as clubs fight for Europe"
    },


    player_performance = {
        "In-form striker keeps scoring",
        "Veteran midfielder shows class remains intact",
        "Young defender earns praise for solid performances",
        "Goalkeeper makes crucial saves to secure points",
        "Creative playmaker delivers key assists",
        "Winger constantly troubles opposition defenses",
        "Captain leads by example on and off the pitch"
    },


    tactics_training = {
        "Manager tweaks formation for upcoming match",
        "Set-piece specialist shines in training sessions",
        "Team focuses on defensive organization",
        "High-press system delivering positive results",
        "Counter-attacking strategy paying off",
        "Possession-based philosophy successfully implemented",
        "Squad depth tested during a busy schedule"
    },


    injuries_suspensions = {
        "Key player sidelined with muscle strain",
        "Important defender suspended for upcoming matches",
        "Injury crisis tests squad depth",
        "Player returns to full training after absence",
        "Medical team monitors fitness levels closely",
        "Late fitness test for influential midfielder"
    },


    youth_academy = {
        "Academy prospect training with first team",
        "Youngster signs first professional contract",
        "Youth team continues unbeaten run",
        "Talented teenager makes bench debut",
        "Scouting network identifies future stars",
        "Development squad impresses coaching staff"
    },


    stadium_fans = {
        "Sold-out crowd expected for derby clash",
        "Stadium atmosphere rated among the league's best",
        "Traveling supporters make their presence felt",
        "Safe standing areas popular with fans",
        "Community initiatives strengthen club bonds"
    }
}


local newsSources = {

    [13] = {
        "Sky Sports",
        "BBC Sport",
        "Premier League",
        "David Ornstein",
        "Gary Neville",
        "Jamie Carragher"
    },


    [53] = {
        "Marca",
        "AS",
        "La Liga",
        "Guillem Balague",
        "Sid Lowe"
    },


    [19] = {
        "Kicker",
        "Bild",
        "Bundesliga",
        "Christian Falk",
        "Jan Aage Fjortoft"
    },


    [31] = {
        "Gazzetta dello Sport",
        "Corriere dello Sport",
        "Serie A",
        "Fabrizio Romano",
        "Gianluca Di Marzio"
    },


    [16] = {
        "L'Équipe",
        "France Football",
        "Ligue 1",
        "Julien Laurens",
        "Jonathan Johnson"
    },


    famous_journalists = {
        "Fabrizio Romano",
        "David Ornstein",
        "Gianluca Di Marzio",
        "Christian Falk",
        "Jonathan Shrager"
    },


    media_outlets = {
        "ESPN FC",
        "The Athletic",
        "Reuters Sports",
        "AFP Sports"
    },


    official_clubs = {
        "Club Communications",
        "Press Office",
        "Official Statement",
        "Team News"
    }
}


local fanComments = {

    upcoming_matches = {
        "This one’s a must-win clash",
        "Derby day vibes will be electric",
        "Squad depth gets tested here",
        "Season-defining fixture ahead",
        "Tactical battle written all over this",
        "Three points are non-negotiable",
        "The fans will be our 12th player",
        "This fixture never disappoints",
        "Big players need to rise to the occasion",
        "Form means nothing in games like these"
    },


    league_news = {
        "The title race is boiling up",
        "This league gets tougher every year",
        "Quality at the top is unreal",
        "Biggest surprise package so far",
        "Relegation fight will be brutal",
        "European spots wide open",
        "Fixture list is relentless this season",
        "Every match feels like a cup final",
        "The league’s profile keeps growing",
        "This is why it’s the world’s best league"
    },


    player_performance = {
        "He’s in the form of his life",
        "Confidence is flowing through him",
        "Proving the critics wrong week after week",
        "This is the signing we hoped for",
        "Carrying the team on his back",
        "Training hard, delivering harder",
        "He’s become undroppable",
        "A total transformation this season",
        "Playing with real freedom",
        "The manager’s trust is paying off"
    },


    tactics_training = {
        "The system is finally clicking",
        "Training ground work shows on the pitch",
        "Tactical flexibility is on display",
        "Adapting well to every opponent",
        "Coaching staff deserves credit",
        "Players are buying into the philosophy",
        "Preparation has been spot on",
        "We’re tougher to break down now",
        "Game management is improving",
        "Set-piece drills paying dividends"
    },


    injuries_suspensions = {
        "Massive blow for the squad",
        "Squad depth under pressure now",
        "Others must step up in his absence",
        "Medical team has work to do",
        "This could hurt our momentum",
        "Chance for someone else to shine",
        "Timing couldn’t be worse",
        "We’ve got cover in that role",
        "This is why depth matters",
        "Recovery process starts today"
    },


    youth_academy = {
        "The future looks bright here",
        "Another gem from the academy",
        "Youth setup keeps producing quality",
        "This is sustainable football",
        "Clear pathway to the first team",
        "Scouting network is top tier",
        "He’s dominating at youth level",
        "Coaching staff doing wonders",
        "Building long-term foundations",
        "Investment in youth paying off"
    },


    stadium_fans = {
        "Atmosphere at home is unmatched",
        "Fans deserve nights like these",
        "Support is unreal home and away",
        "Our ground is turning into a fortress",
        "Bond with the fans is unbreakable",
        "This is what football’s about",
        "Noise levels off the charts",
        "Fans can push the team to victory",
        "Matchday experience is elite",
        "Passion from the stands is electric"
    }
}


local newsImages = {
    "News_Ads_Result",
    "News_Ads_Training",
    "News_Ads_Stadium",
    "News_Ads_Tactics",
    "News_Ads_Injury",
    "News_Ads_Youth",
    "News_Ads_Matchday"
}

local commenterNames = {

    "Caden Chambers",
    "Marcus Reynolds",
    "Liam O'Connor",
    "Ben Thompson",
    "James Wilson",
    "Oliver Harrison",
    "Noah Peterson",
    "Jack Mitchell",
    "Harry Davies",
    "George Edwards",
    "Samuel Bennett",
    "Joseph Richardson",
    "Daniel Cooper",
    "Thomas Marshall",
    "William Carter",
    "Alexander Hughes",
    "Ethan Parker",
    "Michael Foster",
    "David Murphy",
    "Richard Collins",
    "Charles Russell",
    "Andrew Butler",
    "Edward Simmons",
    "Robert Jenkins",
    "Matthew Price",
    "Joshua Sanders",
    "Ryan Barnes",
    "Jacob Knight",
    "Nathan Powell",
    "Luke Graham",
    "Christian Perry",
    "Jonathan West",
    "Aaron Holmes",
    "Kyle Reed",
    "Brandon Bryant",
    "Tyler Fisher",
    "Jordan Ellis",
    "Cameron Shaw",
    "Dylan Gibson",
    "Logan Tucker",
    "Juan Martinez",
    "Carlos Rodriguez",
    "Miguel Hernandez",
    "Antonio Lopez",
    "Diego Sanchez",
    "Javier Ramirez",
    "Ricardo Flores",
    "Fernando Cruz",
    "Alejandro Morales",
    "Pablo Ortiz",
    "Luca Bianchi",
    "Marco Rossi",
    "Giovanni Conti",
    "Andrea Marino",
    "Francesco Greco",
    "Matteo Costa",
    "Lucas Schmidt",
    "Finn Weber",
    "Niklas Becker",
    "Jonas Hoffmann",
    "Lars Richter",
    "Sebastian Fischer",
    "Patrick Wagner",
    "Dominik Schulz"
}

local commenterImages = {
    "Comments_1",
    "Comments_2",
    "Comments_3",
    "Comments_4",
    "Comments_5",
    "Comments_6",
    "Comments_7",
    "Comments_8",
    "Comments_9",
    "Comments_10",
    "Comments_11",
    "Comments_12",
    "Comments_13",
    "Comments_14"
}


local currentNewsText = ""
local currentNewsSource = ""
local currentNewsImage = ""
local currentNewsComments = {}
local currentHomeTeamID = 0
local currentAwayTeamID = 0


local function selectRandomPhrase(phraseTable)
    if not phraseTable or #phraseTable == 0 then
        return "Follow all the latest football news and updates"
    end
    math.randomseed(os.clock() * 100000 + os.time())
    return phraseTable[math.random(1, #phraseTable)]
end


local function generateUniqueCommenterImages(count)
    math.randomseed(os.clock() * 100000 + os.time())

    local selectedImages = {}
    local usedIndices = {}

    for i = 1, count do
        if #commenterImages > 0 then
            local randomIndex
            repeat
                randomIndex = math.random(1, #commenterImages)
            until not usedIndices[randomIndex] or #usedIndices >= #commenterImages

            usedIndices[randomIndex] = true
            table.insert(selectedImages, commenterImages[randomIndex])

            if #usedIndices >= #commenterImages then
                break
            end
        end
    end


    while #selectedImages < count do
        local genericImages = {"Comments_1", "Comments_2", "Comments_3"}
        table.insert(selectedImages, genericImages[math.random(1, #genericImages)])
    end

    return selectedImages
end

local function generateUniqueCommenterNames(count)
    math.randomseed(os.clock() * 100000 + os.time())

    local selectedNames = {}
    local usedIndices = {}

    for i = 1, count do
        if #commenterNames > 0 then
            local randomIndex
            repeat
                randomIndex = math.random(1, #commenterNames)
            until not usedIndices[randomIndex] or #usedIndices >= #commenterNames

            usedIndices[randomIndex] = true
            table.insert(selectedNames, commenterNames[randomIndex])

            if #usedIndices >= #commenterNames then
                break
            end
        end
    end


    while #selectedNames < count do
        local genericNames = {"Justin Noguera", "Loyal Supporter", "True Believer", "Match Goer", "Season Ticket Holder"}
        table.insert(selectedNames, genericNames[math.random(1, #genericNames)])
    end

    return selectedNames
end

local function generateContextualCommentsWithNamesAndImages(newsType, newsText)
    math.randomseed(os.clock() * 100000 + os.time())


    local specificComments = fanComments[newsType] or fanComments.upcoming_matches


    local selectedComments = {}
    local usedIndices = {}

    for i = 1, 3 do
        if #specificComments > 0 then
            local randomIndex
            repeat
                randomIndex = math.random(1, #specificComments)
            until not usedIndices[randomIndex] or #usedIndices >= #specificComments

            usedIndices[randomIndex] = true
            table.insert(selectedComments, specificComments[randomIndex])

            if #usedIndices >= #specificComments then
                break
            end
        end
    end


    while #selectedComments < 3 do
        local genericComments = {
            "Check my profile out, I post football highlights! American football...",
            "Time to settle this: football or soccer?",
            "Every game is crucial from now on",
            "The players look determined",
            "This could be a turning point"
        }
        table.insert(selectedComments, genericComments[math.random(1, #genericComments)])
    end


    local commenterNames = generateUniqueCommenterNames(3)


    local commenterImages = generateUniqueCommenterImages(3)


    local commentsWithData = {}
    for i = 1, 3 do
        commentsWithData[i] = {
            name = commenterNames[i],
            image = commenterImages[i],
            comment = selectedComments[i]
        }
    end

    return commentsWithData
end


local function generateContextualCommentsWithNames(newsType, newsText)
    math.randomseed(os.clock() * 100000 + os.time())


    local specificComments = fanComments[newsType] or fanComments.upcoming_matches


    local selectedComments = {}
    local usedIndices = {}

    for i = 1, 3 do
        if #specificComments > 0 then
            local randomIndex
            repeat
                randomIndex = math.random(1, #specificComments)
            until not usedIndices[randomIndex] or #usedIndices >= #specificComments

            usedIndices[randomIndex] = true
            table.insert(selectedComments, specificComments[randomIndex])

            if #usedIndices >= #specificComments then
                break
            end
        end
    end


    while #selectedComments < 3 do
        local genericComments = {
            "Important moment in the season",
            "The team needs to stay focused",
            "Every game is crucial from now on",
            "The players look determined",
            "This could be a turning point"
        }
        table.insert(selectedComments, genericComments[math.random(1, #genericComments)])
    end


    local commenterNames = generateUniqueCommenterNames(3)


    local commentsWithNames = {}
    for i = 1, 3 do
        commentsWithNames[i] = {
            name = commenterNames[i],
            comment = selectedComments[i]
        }
    end

    return commentsWithNames
end


local function selectRandomSource(newsType, currentLeague)
    math.randomseed(os.clock() * 100000 + os.time())


    if newsSources[currentLeague] then
        return newsSources[currentLeague][math.random(1, #newsSources[currentLeague])]
    end


    if newsType == "league_news" then
        return newsSources.media_outlets[math.random(1, #newsSources.media_outlets)]
    end


    if newsType == "injuries_suspensions" or newsType == "tactics_training" then
        local options = {newsSources.famous_journalists, newsSources.official_clubs}
        local selectedOption = options[math.random(1, 2)]
        return selectedOption[math.random(1, #selectedOption)]
    end


    local sourceTypes = {"famous_journalists", "media_outlets", "official_clubs"}
    local selectedType = sourceTypes[math.random(1, 3)]
    return newsSources[selectedType][math.random(1, #newsSources[selectedType])]
end

local function generateContextualComments(newsType, newsText)
    math.randomseed(os.clock() * 100000 + os.time())


    local specificComments = fanComments[newsType] or fanComments.upcoming_matches


    local selectedComments = {}
    local usedIndices = {}

    for i = 1, 3 do
        if #specificComments > 0 then
            local randomIndex
            repeat
                randomIndex = math.random(1, #specificComments)
            until not usedIndices[randomIndex] or #usedIndices >= #specificComments

            usedIndices[randomIndex] = true
            table.insert(selectedComments, specificComments[randomIndex])


            if #usedIndices >= #specificComments then
                break
            end
        end
    end


    while #selectedComments < 3 do
        local genericComments = {
            "Important moment in the season",
            "The team needs to stay focused",
            "Every game is crucial from now on",
            "The players look determined",
            "This could be a turning point"
        }
        table.insert(selectedComments, genericComments[math.random(1, #genericComments)])
    end

    return selectedComments
end


local function generateFanComment(newsText, newsType)
    math.randomseed(os.clock() * 100000 + os.time())


    local tone
    if newsType == "youth_academy" or newsType == "player_performance" then

        tone = math.random(1, 100) <= 70 and "positive" or "critical"
    elseif newsType == "injuries_suspensions" then

        tone = math.random(1, 100) <= 60 and "critical" or "neutral"
    elseif newsType == "upcoming_matches" then

        local rand = math.random(1, 100)
        if rand <= 40 then
            tone = "positive"
        elseif rand <= 70 then
            tone = "neutral"
        else
            tone = "humorous"
        end
    else

        local tones = {"positive", "neutral", "critical", "humorous"}
        tone = tones[math.random(1, 4)]
    end


    return fanComments[tone][math.random(1, #fanComments[tone])]
end


local function selectRandomImage(newsType)
    math.randomseed(os.clock() * 100000 + os.time())


    local imageMapping = {
        upcoming_matches = {"News_Ads_Matchday"},
        league_news = {"News_Ads_Result", "News_Ads_Tactics"},
        player_performance = {"News_Ads_Training"},
        tactics_training = {"News_Ads_Tactics", "News_Ads_Training"},
        injuries_suspensions = {"News_Ads_Injury"},
        youth_academy = {"News_Ads_Youth"},
        stadium_fans = {"News_Ads_Stadium"}
    }

    local availableImages = imageMapping[newsType] or newsImages
    return availableImages[math.random(1, #availableImages)]
end


local function generateUpcomingMatches(self)
    local upcomingMatches = {}
    local matchData = {}


    if currentSelectedTeamID and currentSelectedTeamID ~= 0 then
        local nextMatch = self:findNextMatchForTeam(currentSelectedTeamID)
        if nextMatch then
            local homeName = self.loc.LocalizeString("TeamName_Abbr15_" .. nextMatch.homeID)
            local awayName = self.loc.LocalizeString("TeamName_Abbr15_" .. nextMatch.awayID)
            local matchContexts = {
                "in a crucial league encounter",
                "this weekend in matchday " .. (GLOBAL_MATCHUP_COUNT or 0) + 1,
                "looking to secure important points",
                "in a highly anticipated fixture",
                "with both teams in good form"
            }
            local context = matchContexts[math.random(1, #matchContexts)]

            currentHomeTeamID = nextMatch.homeID
            currentAwayTeamID = nextMatch.awayID

            table.insert(upcomingMatches, homeName .. " vs " .. awayName .. " " .. context)
            matchData = nextMatch
        end
    end


    local bigMatches = {
        {home = "Manchester United", away = "Liverpool", homeID = 11, awayID = 9, context = "in classic Premier League showdown"},
        {home = "Manchester City", away = "Manchester United", homeID = 10, awayID = 11, context = "Manchester derby thrills fans"},
        {home = "Arsenal", away = "Tottenham Hotspur", homeID = 1, awayID = 18, context = "North London derby sparks rivalry"},
        {home = "Chelsea", away = "Tottenham Hotspur", homeID = 5, awayID = 18, context = "London derby heats up"},
        {home = "Barcelona", away = "Real Madrid", homeID = 241, awayID = 243, context = "El Clásico headlines weekend action"},
        {home = "Atlético Madrid", away = "Real Madrid", homeID = 240, awayID = 243, context = "Madrid derby draws huge attention"},
        {home = "Sevilla", away = "Real Betis", homeID = 481, awayID = 449, context = "Seville derby divides the city"},
        {home = "Bayern Munich", away = "Borussia Dortmund", homeID = 21, awayID = 22, context = "Der Klassiker takes center stage"},
        {home = "Schalke 04", away = "Borussia Dortmund", homeID = 175, awayID = 22, context = "Revierderby energizes German fans"},
        {home = "AC Milan", away = "Inter Milan", homeID = 47, awayID = 44, context = "Milan derby promises fireworks"},
        {home = "Roma", away = "Lazio", homeID = 52, awayID = 46, context = "Rome derby stirs passions"},
        {home = "Fiorentina", away = "Juventus", homeID = 54, awayID = 45, context = "Tuscan derby brings tension"},
        {home = "PSG", away = "Marseille", homeID = 73, awayID = 219, context = "Le Classique in French top flight"},
        {home = "Lyon", away = "Saint-Étienne", homeID = 66, awayID = 71, context = "Rhône derby excites fans"}
    }

    for i = 1, 2 do
        if #bigMatches > 0 then
            local randomMatch = bigMatches[math.random(1, #bigMatches)]
            table.insert(upcomingMatches, randomMatch.home .. " vs " .. randomMatch.away .. " " .. randomMatch.context)

            if currentHomeTeamID == 0 then
                currentHomeTeamID = randomMatch.homeID
                currentAwayTeamID = randomMatch.awayID
            end

            for j = #bigMatches, 1, -1 do
                if bigMatches[j].home == randomMatch.home then
                    table.remove(bigMatches, j)
                    break
                end
            end
        end
    end

    return upcomingMatches
end


function ClassicmatchWomens:findNextMatchForTeam(teamID)
    if not GLOBAL_MATCHUP_COUNT then return nil end

    local nextMatchday = GLOBAL_MATCHUP_COUNT + 1
    local matchRangeStart = (nextMatchday-1)*10 + 1
    local matchRangeEnd = nextMatchday*10

    for j = matchRangeStart, matchRangeEnd do
        if LigaGrouping and LigaGrouping[ligaId] and LigaGrouping[ligaId][j] then
            local matchData = LigaGrouping[ligaId][j]
            if matchData[1] == teamID or matchData[2] == teamID then
                return {
                    homeID = matchData[1],
                    awayID = matchData[2],
                    date = matchData[3] or "TBD"
                }
            end
        end
    end
    return nil
end


local function selectNewsTypeAvoidingRepetition()
    math.randomseed(os.clock() * 100000 + os.time())


    local newsTypes = {
        {type = "upcoming_matches", weight = 30},
        {type = "league_news", weight = 20},
        {type = "player_performance", weight = 15},
        {type = "tactics_training", weight = 12},
        {type = "injuries_suspensions", weight = 10},
        {type = "youth_academy", weight = 8},
        {type = "stadium_fans", weight = 5}
    }


    if lastNewsType and refreshCount > 0 then
        for _, newsType in ipairs(newsTypes) do
            if newsType.type == lastNewsType then
                newsType.weight = 0
                break
            end
        end
    end


    local totalWeight = 0
    local availableTypes = {}

    for _, newsType in ipairs(newsTypes) do
        if newsType.weight > 0 then
            totalWeight = totalWeight + newsType.weight
            table.insert(availableTypes, newsType)
        end
    end


    if #availableTypes == 0 then
        resetRefreshCounter()
        return selectNewsTypeAvoidingRepetition()
    end


    local randomValue = math.random(1, totalWeight)
    local currentWeight = 0
    local selectedType = availableTypes[1].type

    for _, newsType in ipairs(availableTypes) do
        currentWeight = currentWeight + newsType.weight
        if randomValue <= currentWeight then
            selectedType = newsType.type
            break
        end
    end


    lastNewsType = selectedType
    refreshCount = refreshCount + 1

    return selectedType
end


function ClassicmatchWomens:getContextualNews()

    local currentLeague = self:getCurrentLeague()


    newsPhrases.upcoming_matches = generateUpcomingMatches(self)


    local selectedType = selectNewsTypeAvoidingRepetition()


    local selectedPhrase = selectRandomPhrase(newsPhrases[selectedType])
    currentNewsSource = selectRandomSource(selectedType, currentLeague)
    currentNewsImage = selectRandomImage(selectedType)
    currentNewsComments = generateContextualCommentsWithNamesAndImages(selectedType, selectedPhrase)

    return selectedPhrase
end


function ClassicmatchWomens:publishNewsComments()

    for i = 1, 3 do
        local commentData = currentNewsComments[i] or {
            name = "Supporter",
            image = "Comments_1",
            comment = "Following this development"
        }

        local nameBinding = "bnd_commenter_name" .. i
        local imageBinding = "bnd_commenter_image" .. i
        local commentBinding = "bnd_news_comment" .. i

        self.im.Publish(nameBinding, commentData.name)
        self.im.Publish(imageBinding, {
            name = "$" .. commentData.image
        })
        self.im.Publish(commentBinding, commentData.comment)
    end
end






local function shuffleArray(array)
  math.randomseed(os.time())
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

local ClassicmatchWomensList = {
  { HomeTeamID = 116327,AwayTeamID = 116326,StadiumID1 = 183,StadiumID2 = 1,data = {} },
  { HomeTeamID = 116325,AwayTeamID = 116330,StadiumID1 = 14,StadiumID2 = 6,data = {} },
  { HomeTeamID = 116010,AwayTeamID = 116012,StadiumID1 = 28,StadiumID2 = 1,data = {} },
  { HomeTeamID = 116018, AwayTeamID = 116033, StadiumID1 = 195, StadiumID2 = 14, data = {} },
  { HomeTeamID = 116013, AwayTeamID = 116386,  data = {},  StadiumID1 = 195, StadiumID2 = 195  },
  { HomeTeamID = 116009, AwayTeamID = 116011, data = {},  StadiumID1 = 156, StadiumID2 = 116  },
  { HomeTeamID = 116014, AwayTeamID = 116016, data = {},  StadiumID1 = 137, StadiumID2 = 30  },
  { HomeTeamID = 116017, AwayTeamID = 116034, data = {},  StadiumID1 = 246, StadiumID2 = 14  },
  { HomeTeamID = 116035, AwayTeamID = 116280,  data = {},  StadiumID1 = 14, StadiumID2 = 247  },
  { HomeTeamID = 116326, AwayTeamID = 116343, data = {},  StadiumID1 = 2, StadiumID2 = 13  },
  { HomeTeamID = 113996, AwayTeamID = 112998, data = {},  StadiumID1 = 264, StadiumID2 = 192  },
  { HomeTeamID = 113394, AwayTeamID = 112999, data = {},  StadiumID1 = 261, StadiumID2 = 158  },
  { HomeTeamID = 113000, AwayTeamID = 113001, data = {},  StadiumID1 = 326, StadiumID2 = 261  },
  { HomeTeamID = 115362, AwayTeamID = 113002, data = {},  StadiumID1 = 2, StadiumID2 = 1  },
  { HomeTeamID = 115511, AwayTeamID = 113006, data = {},  StadiumID1 = 29, StadiumID2 = 176  },
  { HomeTeamID = 113010, AwayTeamID = 131144, data = {},  StadiumID1 = 195, StadiumID2 = 137  },
  { HomeTeamID = 113258, AwayTeamID = 113007, data = {},  StadiumID1 = 183, StadiumID2 = 176  }
}
shuffleArray(ClassicmatchWomensList)

currentMatch = {
   HomeTeamID = 0,
   AwayTeamID = 0,
   Side = 0,
   HomeKitIndex = 0,
   AwayKitIndex = 1,
   StadiumID1 = 0,
   StadiumID2 = 0
}

function ClassicmatchWomens:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService")
  }

  o.player3d = {
    name = "$",
    id = 0
  }
  math.randomseed(os.clock() * 1543 + os.time())
  local currentTime = os.date("%H") + 0
  local random2 = math.random(5)

  o.im.Subscribe("bnd_player3d", function()
    o.player3d.id = random2
    o.im.Publish("bnd_player3d", o.player3d)
  end)

  o.im.Subscribe(bndBackgroundCareer, function()
  local currentLeague = o:getCurrentLeague()
    o.im.Publish(bndBackgroundCareer, {name = "$BackgroundCareer", id = IDLeague})
  end)

  o.im.Subscribe(bndLeagueColor, function()
  local leagueColor = o:getLeagueColor()
  o.im.Publish(bndLeagueColor, leagueColor)
  end)

  o.im.Subscribe(bndMatchList, function()
    o:publishMatchRows()
  end)


  o.im.Subscribe(bndRandomAdsText, function()
    o:publishRandomNewsText()
  end)

  o.im.Subscribe(bndNewsImage, function()
    o:publishNewsImage()
  end)

  o.im.Subscribe(bndNewsSource, function()
    o:publishNewsSource()
  end)


  for i = 1, 3 do
    o.im.Subscribe("bnd_commenter_name" .. i, function()
        o:publishNewsComments()
    end)
    o.im.Subscribe("bnd_commenter_image" .. i, function()
        o:publishNewsComments()
    end)
    o.im.Subscribe("bnd_news_comment" .. i, function()
        o:publishNewsComments()
    end)
  end


  o.im.Subscribe(bndHomeTeamLogo, function()
    o:publishTeamLogos()
  end)

  o.im.Subscribe(bndAwayTeamLogo, function()
    o:publishTeamLogos()
  end)

  o.im.RegisterAction(ACT_MATCH_PLAY, function(actionName, data)
   if data then
     o:PlayMatch(data)
    end
  end)


  o.im.RegisterAction(ACT_REFRESH_ADS, function(actionName, data)
    o:refreshNews()
  end)


  currentNewsText = o:getContextualNews()

  return o
end


function ClassicmatchWomens:publishRandomNewsText()
    self.im.Publish(bndRandomAdsText, currentNewsText)
end


function ClassicmatchWomens:publishNewsImage()
    self.im.Publish(bndNewsImage, {
        name = "$" .. currentNewsImage
    })
end


function ClassicmatchWomens:publishNewsSource()
    self.im.Publish(bndNewsSource, currentNewsSource)
end


function ClassicmatchWomens:publishNewsComment()
    self.im.Publish(bndNewsComment, currentNewsComment)
end


function ClassicmatchWomens:publishTeamLogos()
    if currentHomeTeamID ~= 0 then
        self.im.Publish(bndHomeTeamLogo, {
            name = "$Crest64x64",
            id = currentHomeTeamID
        })
    end

    if currentAwayTeamID ~= 0 then
        self.im.Publish(bndAwayTeamLogo, {
            name = "$Crest64x64",
            id = currentAwayTeamID
        })
    end
end



function ClassicmatchWomens:refreshNews()
    currentNewsText = self:getContextualNews()
    self:publishRandomNewsText()
    self:publishNewsImage()
    self:publishNewsSource()
    self:publishNewsComments()
    self:publishTeamLogos()


    print("[FC25 News]: " .. currentNewsText)
    print("[Category]: " .. (lastNewsType or "unknown"))
    print("[Source]: " .. currentNewsSource)
    print("[Refresh Count]: " .. refreshCount)
    for i, commentData in ipairs(currentNewsComments) do
        print("[Comment " .. i .. " - " .. commentData.name .. " (" .. commentData.image .. ")]: " .. commentData.comment)
    end
end

function ClassicmatchWomens:getLeagueColor()
    local currentLeague = self:getCurrentLeague()
    return leagueColors[currentLeague] or leagueColors[0]
end

function ClassicmatchWomens:publishMatchRows()
  for i, v in ipairs(ClassicmatchWomensList) do
    v.data.HomeTeamCrest = {
      name = "$Crest",
      id = ClassicmatchWomensList[i].HomeTeamID
    }
    v.data.AwayTeamCrest = {
      name = "$Crest",
      id = ClassicmatchWomensList[i].AwayTeamID
    }
    v.data.HomeTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicmatchWomensList[i].HomeTeamID)
    v.data.AwayTeamName = self.loc.LocalizeString("TeamName_Abbr15_"..ClassicmatchWomensList[i].AwayTeamID)
    v.data.HomeTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicmatchWomensList[i].HomeTeamID)
    v.data.AwayTeamShortName = self.loc.LocalizeString("TeamName_Abbr3_"..ClassicmatchWomensList[i].AwayTeamID)
    v.data.clickAction = "act_match_play"
  end
  self.im.Publish(bndMatchList, ClassicmatchWomensList)

  self:refreshNews()
end

function ClassicmatchWomens:getCurrentLeague()
    if not currentSelectedTeamID then
        return 0
    end


    local teamService = self.api("TeamService")
    if teamService and teamService.GetTeamLeague then
        local leagueID = teamService.GetTeamLeague(currentSelectedTeamID)
        if leagueID and leagueID > 0 then
            return leagueID
        end
    end


    local leagueMap = {

[269]=1, [270]=1, [271]=1, [819]=1, [820]=1, [822]=1, [1443]=1, [1447]=1,
[1516]=1, [1786]=1, [1788]=1, [15001]=1,


[681]=4, [1750]=4, [670]=4, [100081]=4, [229]=4, [100087]=4, [110724]=4,
[230]=4, [673]=4, [680]=4, [231]=4, [674]=4, [232]=4, [2014]=4, [537]=4,
[675]=4,


[1629]=7, [598]=7, [1035]=7, [111052]=7, [517]=7, [1048]=7, [383]=7,
[567]=7, [1598]=7, [1041]=7, [111041]=7, [1719]=7, [569]=7, [568]=7,
[1043]=7, [112472]=7, [1053]=7, [111059]=7, [111057]=7, [130361]=7,

[634]=10, [1913]=10, [245]=10, [1903]=10, [247]=10, [1910]=10, [100632]=10,
[1908]=10, [246]=10, [100646]=10, [1906]=10, [1915]=10, [1914]=10,
[100634]=10, [1904]=10, [645]=10, [1971]=10,


[13]=13, [1925]=13, [14]=13, [110]=13, [18]=13, [19]=13, [5]=13, [2]=13,
[10]=13, [144]=13, [1]=13, [11]=13, [1799]=13, [1943]=13, [1808]=13,
[7]=13, [9]=13, [8]=13, [1796]=13, [106]=13, [1794]=13,


[15]=14, [97]=14, [1800]=14, [1919]=14, [109]=14, [1960]=14, [1952]=14,
[1807]=14, [1806]=14, [12]=14, [3]=14, [1795]=14, [1792]=14,
[1951]=14, [1790]=14, [91]=14, [1801]=14, [88]=14, [1947]=14, [17]=14,
[94]=14, [95]=14, [89]=14,


[65]=16, [69]=16, [76]=16, [219]=16, [73]=16, [66]=16, [64]=16, [74]=16,
[1738]=16, [72]=16, [71]=16, [1530]=16, [57]=16, [378]=16, [379]=16,
[1809]=16, [217]=16, [111817]=16,


[210]=17, [62]=17, [294]=17, [1816]=17, [111659]=17, [1815]=17,
[115494]=17, [58]=17, [110321]=17, [1814]=17, [1805]=17, [614]=17,
[68]=17, [67]=17, [111273]=17, [111276]=17, [70]=17, [1819]=17,


[175]=19, [38]=19, [112172]=19, [23]=19, [36]=19, [32]=19, [1831]=19,
[21]=19, [100409]=19, [1824]=19, [25]=19, [111235]=19, [22]=19,
[110329]=19, [10029]=19, [169]=19, [31]=19, [28]=19,


[580]=20, [165]=20, [110500]=20, [10030]=20, [1832]=20, [34]=20, [485]=20,
[166]=20, [171]=20, [110636]=20, [29]=20, [531]=20, [110588]=20,
[110502]=20, [160]=20, [576]=20, [159]=20, [503]=20, [523]=20,


[52]=31, [46]=31, [347]=31, [55]=31, [1842]=31, [110556]=31, [206]=31,
[110374]=31, [39]=31, [48]=31, [44]=31, [54]=31, [45]=31, [189]=31,[50]=31, [1745]=31, [47]=31, [110738]=31, [111974]=31, [111434]=31,

[1746]=32, [205]=32, [111811]=32, [1744]=32, [1837]=32, [1843]=32,
[1848]=32, [110373]=32, [110740]=32, [110908]=32, [110915]=32,
[111433]=32, [111657]=32, [111993]=32, [112124]=32, [112168]=32,
[112493]=32, [112494]=32, [190]=32, [110741]=32,


[111140]=39, [114161]=39, [697]=39, [114640]=39, [111928]=39, [693]=39,
[688]=39, [112828]=39, [694]=39, [691]=39, [113149]=39, [112893]=39,
[114162]=39, [112885]=39, [687]=39, [112134]=39, [101112]=39,
[112996]=39, [112606]=39, [111651]=39, [698]=39, [111065]=39, [696]=39,
[689]=39, [111139]=39, [111138]=39, [695]=39, [111144]=39, [113018]=39,
[115243]=39,


[81]=50, [181]=50, [83]=50, [77]=50, [80]=50, [100805]=50, [78]=50,[86]=50, [82]=50, [180]=50, [79]=50, [621]=50,


[1860]=53, [449]=53, [457]=53, [243]=53, [461]=53, [240]=53, [241]=53,
[453]=53, [448]=53, [450]=53, [483]=53, [110062]=53, [481]=53, [479]=53,
[463]=53, [480]=53, [452]=53, [110827]=53, [1853]=53, [468]=53,


[472]=54, [100888]=54, [462]=54, [467]=54, [456]=54, [1861]=54,
[110839]=54, [1854]=54, [459]=54, [260]=54, [110069]=54, [573]=54,
[100851]=54, [10846]=54, [244]=54, [110832]=54, [1968]=54, [242]=54,
[1867]=54, [100852]=54, [110242]=54, [121110]=54,


[319]=56, [320]=56, [321]=56, [433]=56, [700]=56, [702]=56, [708]=56,
[710]=56, [711]=56, [1439]=56, [111594]=56, [111705]=56, [112072]=56,
[112126]=56, [112180]=56, [113458]=56,


[1797]=60, [1793]=60, [1933]=60, [4]=60, [1930]=60, [1926]=60, [1917]=60,
[1958]=60, [361]=60, [149]=60, [1939]=60, [1932]=60, [1938]=60,
[15015]=60, [1940]=60, [1931]=60, [143]=60, [142]=60, [1928]=60,
[1804]=60, [1923]=60, [1929]=60, [1961]=60, [112259]=60,


[305]=65, [306]=65, [423]=65, [445]=65, [563]=65, [753]=65, [834]=65,
[837]=65, [1571]=65, [1572]=65,


[301]=66, [420]=66, [873]=66, [1871]=66, [110206]=66, [110745]=66,
[110746]=66, [110749]=66, [111083]=66, [111086]=66,
[111088]=66, [111091]=66, [111092]=66, [111097]=66, [114004]=66,
[114326]=66, [114393]=66,


[312]=67, [315]=67, [100764]=67, [100765]=67, [100767]=67, [100769]=67,
[110102]=67, [110109]=67, [110227]=67, [110231]=67, [110232]=67,
[110239]=67, [112217]=67, [112218]=67, [112261]=67, [130988]=67,
[110222]=67,


[326]=68, [325]=68, [110776]=68, [436]=68, [327]=68, [101041]=68,
[101033]=68, [113142]=68, [111339]=68, [101028]=68, [101014]=68,
[101020]=68, [101016]=68, [741]=68, [748]=68, [101026]=68, [101037]=68,
[121174]=68, [121388]=68,


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

    return leagueMap[currentSelectedTeamID] or 0
end

function ClassicmatchWomens:PlayMatch(data)
  local currentMatchIndex = data.id + 1
  currentMatch.HomeTeamID = ClassicmatchWomensList[currentMatchIndex].HomeTeamID
  currentMatch.AwayTeamID = ClassicmatchWomensList[currentMatchIndex].AwayTeamID

  currentMatch.StadiumID1 = ClassicmatchWomensList[currentMatchIndex].StadiumID1
  currentMatch.StadiumID2 = ClassicmatchWomensList[currentMatchIndex].StadiumID2
  local buttonNo = {
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      "evt_match_play",
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = "INFO",
    message = "Are you ready to start the game?",
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end

function ClassicmatchWomens:finalize()
  self.im.Unsubscribe("bnd_player3d")
  self.im.Unsubscribe(bndMatchList)
  self.im.Unsubscribe(bndRandomAdsText)
  self.im.Unsubscribe(bndNewsImage)
  self.im.Unsubscribe(bndNewsSource)
  for i = 1, 3 do
        self.im.Unsubscribe("bnd_commenter_name" .. i)
        self.im.Unsubscribe("bnd_commenter_image" .. i)
        self.im.Unsubscribe("bnd_news_comment" .. i)
    end
  self.im.Unsubscribe(bndHomeTeamLogo)
  self.im.Unsubscribe(bndAwayTeamLogo)
  self.im.UnregisterAction(ACT_MATCH_PLAY)
  self.im.UnregisterAction(ACT_REFRESH_ADS)
end

return ClassicmatchWomens