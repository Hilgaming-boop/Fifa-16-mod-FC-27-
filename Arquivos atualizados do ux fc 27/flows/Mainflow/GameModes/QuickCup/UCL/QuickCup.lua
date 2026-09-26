local MatchSelect = ... 
local QuickCup = {}
---- IMPROVED ANIM "MOUNTSA" ----
local TIME_DELAY = 0.7
local START_TIME = 1.3
local ACT_ADVANCE = "act_advance"
local ACT_RESTART = "act_restart"
local BND_REALTIME = "bnd_realtime"
local MAX_MATCH_SIZE = 31
local CUP_ID = 1
local NUM_TEAMS = 32
local DEFAULT_CREST = { name = "$Crest", id = 0 }
function QuickCup:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    ScreenInfoService = o.api("ScreenInfoService"),
    QuickEventsService = o.api("QuickEventsService"),
    AudioService = o.api("AudioService")
  }
o.cupData = {
  cupBg = {
    name = "$Bg_Cup",
    id = CUP_ID
  },
  cuplogo = {
    name = "$CupLogo",
    id = CUP_ID
  },
  trophy = {
    name = "$CupTrophy",
    id = CUP_ID
  },
  championCrest = {
    name = "$ChampionCrest",
    id = 0
  },
  homeTeamCrest = {
    name = "$HomeCrest",
    id = 0
  },
  awayTeamCrest = {
    name = "$AwayCrest",
    id = 0
  },
  Round = "Final"
}
  o.count = 9
  o.startTime = START_TIME
  o.isSwiping = o.services.QuickEventsService.ShouldQuickEventDisplaySwipeText()

  for i = 0, 8 do
    local anim = "bnd_animate_count" .. i
    o.im.Subscribe(anim, function() o.im.Publish(anim, false) end)
  end
  o.services.ScreenInfoService.SetScreenName("QuickCup")
     o.im.Subscribe("bnd_cup_bg", function()
    o.im.Publish("bnd_cup_bg", o.cupData.cupBg)
  end)
  return o
end
function QuickCup:update(elapsedTime)
  self.startTime = self.startTime + elapsedTime
  if self.startTime >= TIME_DELAY then
    self.startTime = self.startTime - TIME_DELAY

    if self.count > 0 or (self.count == 0 and self.isSwiping) then
      local isLast = (self.count == 1 and not self.isSwiping)
      local soundId = isLast and "" or "act_toggle_pause"
      self.services.AudioService.PlaySoundById(soundId, "root", {
        soundId = "",---- IMPROVED ANIM "MOUNTSA" ----
        type = "",
        state = { name = "VALID", val = 0 }
      })
      self:_publishCount()
    else
      self.nav.Event(nil, "")
    end
  end
end
---- IMPROVED ANIM "MOUNTSA" ----
function QuickCup:publishChampion()
    local im = self.services.inputOutputService
    local currentCupGrouping = QuickCupGrouping[CUP_ID] or {}
    local finalMatch = currentCupGrouping[MAX_MATCH_SIZE]
    local isChampion = false
    if finalMatch and finalMatch[5] then
        isChampion = true
        self.cupData.championCrest.id = (finalMatch[6] == currentCupInfo[CUP_ID].homeID) 
            and currentCupInfo[CUP_ID].homeID 
            or finalMatch[6]
    end---- IMPROVED ANIM "MOUNTSA" ----
    im.Publish("bnd_champion_visible", isChampion)
    im.Publish("bnd_match_visible", not isChampion)
    if isChampion then
        im.Publish("bnd_text", "The Winner Of Competition")
        im.Publish("bnd_champion_crest", self.cupData.championCrest)
        im.Publish("bnd_champion_team", 
            self.services.localizationService.LocalizeString("TeamName_Abbr15_"..self.cupData.championCrest.id))
    end
end
function QuickCup:publishMatchInfo()
    local im = self.services.inputOutputService
    local loc = self.services.localizationService
    local currentCupGrouping = QuickCupGrouping[CUP_ID] or {}
    local finalMatch = currentCupGrouping[MAX_MATCH_SIZE]
    if not (finalMatch and finalMatch[5]) then
        im.Publish("bnd_match_visible", true)
        im.Publish("bnd_text", self.cupData.Round)
        im.Publish("bnd_home_crest", self.cupData.homeTeamCrest)
        im.Publish("bnd_home_team", loc.LocalizeString("TeamName_Abbr15_"..self.cupData.homeTeamCrest.id))
        im.Publish("bnd_home_team_short", loc.LocalizeString("TeamName_Abbr3_"..self.cupData.homeTeamCrest.id))
        self.cupData.awayTeamCrest.id = self:GetMatchAwayTeamId()
        im.Publish("bnd_away_crest", self.cupData.awayTeamCrest)
        im.Publish("bnd_away_team", loc.LocalizeString("TeamName_Abbr15_"..self.cupData.awayTeamCrest.id))
        im.Publish("bnd_away_team_short", loc.LocalizeString("TeamName_Abbr3_"..self.cupData.awayTeamCrest.id))
    end
end

function QuickCup:_publishCount()
  for i = 1, 9 do ---- IMPROVED ANIM "MOUNTSA" ----
    self.im.Publish("bnd_panel" .. i .. "_visible", false)
  end
  for i = 0, 8 do
    self.im.Publish("bnd_animate_count" .. i, false)
  end

  local panelId = 10 - self.count
  if panelId >= 1 and panelId <= 9 then
    self.im.Publish("bnd_panel" .. panelId .. "_visible", true)
    self.im.Publish("bnd_animate_count" .. (panelId - 1), true)
  end

  self.count = self.count - 1
end

function QuickCup:finalize()
  for i = 0, 8 do
    self.im.Unsubscribe("bnd_animate_count" .. i)
  end
  self.im.Unsubscribe("bnd_text")
  self.im.Unsubscribe("bnd_cup_bg")
  self.services.ScreenInfoService.UnsetScreenName("QuickCup")
end

return QuickCup