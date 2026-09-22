---- By MounTsa !!

local VirtualButton, EventManager = ...
local MenuCustomizeHub = {}
local BND_LIVE_TILE_SETTINGS = "bnd_live_tile_settings"
local BND_LIVE_TILE_EASPORTSTRACK = "bnd_live_tile_easportstrack"
local bndGeneralAbout = "bnd_general_about"
local bndPrivacyAbout = "bnd_privacy_about"
local bndLicenseagreementAbout = "bnd_licenseagreement_about"
local bndDisableshareAbout = "bnd_disableshare_about"
local bndTermsofserviceAbout = "bnd_termsofservice_about"
local bndCreditsAbout = "bnd_credits_about"
local bndBackVisibility = "bnd_back_visibility"
local actToDisableshareTile = "act_to_disableshare_tile"
local actToPrivacyTile = "act_to_privacy_tile"
local actTeamRoster = "act_team_roster"
local actTeamSheets = "act_team_sheets"
local actToCreditsTile = "act_to_credits_tile"
local actToMOUNTSAcreditsTile = "act_to_MOUNTSAcredits_tile"
local actToAboutTile = "act_to_about_tile"
local actToMusicTile = "act_to_music_tile"
local URL_BASE_EULA = ""
local URL_BASE_IOS_EULA = ""
local URL_BASE_TOS = ""
local URL_BASE_PRIVACY = ""
local URL_BASE_ABOUT = "https://www.youtube.com/mountsa"
local URL_BASE_CREDITS = "https://www.youtube.com/mountsa"
local BND_LIVE_MENU = "bnd_live_menu"

function MenuCustomizeHub:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    EventManagerService = o.api("EventManagerService"),
    HelpAndAboutService = o.api("HelpAndAboutService"),
    GameStateService = o.api("GameStateService"),
    BrowserService = o.api("BrowserService"),
    MiscService = o.api("MiscService")
  }
 
  o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
    o:_handleEvent(...)
  end)
 
  o.hideButton = false
  o.overlayVisible = false
  
  o.Menu = {}
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_Settings"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_to_settings_customize"
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_Profile"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_credits"    
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_OnlineSettings"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_to_credits_tile"
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_Catalogue"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_to_Mountsa_tile"    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_EditTeams"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_team_roster"    
  })
    table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_TeamSheets"},
    autoScaleImageToTileHeight = { "true" },
    clickAction = "act_team_sheets"
  })

  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_CreatePlayer"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_version"    
  })
  
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_EASportsTrack"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_music"    
  })
table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_LoadProfileManager"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_LoadProfileManager1"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_LoadSquad"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_LoadEaFC25"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = "act_load"    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_Delete"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_Legal"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_SaveSquads"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  table.insert(o.Menu, {
    headline = {""},
    description = "",
    images = {"$MenuCustomize_SaveEaFc25"},
    autoScaleImageToTileHeight = {"true"},
    clickAction = ""    
  })
  
  
  
o.im.Subscribe(BND_LIVE_MENU, function()
    o:_publishMenu()
  end)

  o.im.Subscribe(BND_LIVE_TILE_SETTINGS, function()
    o:BND_LIVE_TILE_SETTINGS()
  end)
  function MenuCustomizeHub:BND_LIVE_TILE_SETTINGS()
    local dataToInsert =
    {
      headline = { "SETTINGS" }
    }
    self.im.Publish(BND_LIVE_TILE_SETTINGS, dataToInsert)
  end

  o.im.Subscribe(BND_LIVE_TILE_EASPORTSTRACK, function()
    o:BND_LIVE_TILE_EASPORTSTRACK()
  end)
  function MenuCustomizeHub:BND_LIVE_TILE_EASPORTSTRACK()
    local dataToInsert =
    {
      headline = { "PLAYLIST" }
    }
    self.im.Publish(BND_LIVE_TILE_EASPORTSTRACK, dataToInsert)
  end

  o.im.Subscribe(bndGeneralAbout, function()
    o:publishGeneralAboutData()
  end)
  
  o.im.Subscribe(bndPrivacyAbout, function()
    o:publishPrivacyAboutData()
  end)
  o.im.Subscribe(bndLicenseagreementAbout, function()
    o:publishLicenseagreementAboutData()
  end)
  o.im.Subscribe(bndDisableshareAbout, function()
    o:publishDisableshareAboutData()
  end)
  o.im.Subscribe(bndTermsofserviceAbout, function()
    o:publishTermsofserviceAboutData()
  end)
  o.im.Subscribe(bndCreditsAbout, function()
    o:publishCreditsAboutData()
  end)
  o.im.Subscribe(bndBackVisibility, function()
    o:publishBackVisibility()
  end)
  
     o.im.RegisterAction("act_version", function(actionName)
    local buttonYes = {
		type = "Confirm",
      icon = "$FooterIconNo",
      label = "Ok",
      clickEvents = {
        "evt_hide_popup"
      }
    }
    local popupData = {
      title = "Info",
      message = "***** \n FC25 [ MOUNTSA ] \n Beta Version 0.5 \n ******",
      buttons = {buttonYes}
    }
    o.nav.Event(nil, "evt_show_popup", popupData)
  end)
    o.im.RegisterAction(actToMOUNTSAcreditsTile, function(actionName)
    o:_openMOUNTSAcreditsPopup(actionName)
  end)
  o.im.RegisterAction(actToDisableshareTile, function(actionName, data)
    o:_openUsageSharingPopup()
  end)
  o.im.RegisterAction(actToPrivacyTile, function(actionName)
    o:openBrowser(actionName)
  end)
  o.im.RegisterAction(actTeamRoster, function(actionName)
    o.nav.Event(nil, "evt_team_roster")
  end)
  o.im.RegisterAction(actTeamSheets, function(actionName)
    o.nav.Event(nil, "evt_team_sheets")
  end)
  o.im.RegisterAction(actToCreditsTile, function(actionName)
    o:openBrowser(actionName)
  end)
  o.im.RegisterAction(actToAboutTile, function(actionName)
    o:openBrowser(actionName)
  end)
  o.im.RegisterAction(actToMusicTile, function(actionName)
    o:_openMusicPopup(actionName)
  end)
 o.nav.AddActionHandler("showBackButton", false, nil, function(action, id)
    o.hideButton = false
    o.overlayVisible = false
    o:publishBackVisibility()
  end)
  o.languages = {
    EULA = {
      "en",
      "br",
      "sc",
      "cs",
      "da",
      "nl",
      "fi",
      "fr",
      "de",
      "hu",
      "it",
      "ja",
      "ko",
      "no",
      "pl",
      "ro",
      "ru",
      "es",
      "co",
      "sv",
      "tr"
    },
    TOSandPRIVACY = {
      "en",
      "sc",
      "tc",
      "nl",
      "fr",
      "de",
      "it",
      "ja",
      "ko",
      "pl",
      "br",
      "ru",
      "es",
      "th",
      "tr"
    }
  }
  o.lang = {
    EULA = "en",
    TOSandPRIVACY = "en",
    ABOUT = "en"
  }
  o:initLanguages()
  return o
end

function MenuCustomizeHub:_publishMenu()
  local dataToPublish = { index = 0, data = self.Menu }
  self.im.Publish(BND_LIVE_MENU, dataToPublish)
end

function MenuCustomizeHub:_handleEvent(eventType, data)
  if eventType == EVENT_TYPES.OnBackPressed then
    if self.overlayVisible then
      self.nav.Event(nil, "evt_close_browser")
      self.nav.Event(nil, "evt_hide_popup")
      self.overlayVisible = false
    else
      self.nav.Event(nil, "evt_back")
    end
  end
end
function MenuCustomizeHub:initLanguages()
  local deviceCountry = self.services.GameStateService.GetCountry()
  local deviceLang = self.services.GameStateService.GetLang()
  local lang = "en"
  print("MenuCustomizeHub:deviceCountry() " .. deviceCountry)
  print("MenuCustomizeHub:deviceLang() " .. deviceLang)
  if deviceLang == "eng" then
    lang = "en"
  elseif deviceLang == "por" then
    if deviceCountry == "br" then
      lang = "br"
    else
      lang = "pt"
    end
  elseif deviceLang == "rus" then
    lang = "ru"
  elseif deviceLang == "spa" then
    lang = "es"
  elseif deviceLang == "tur" then
    lang = "tr"
  elseif deviceLang == "pol" then
    lang = "pl"
  elseif deviceLang == "fre" then
    lang = "fr"
  elseif deviceLang == "ger" then
    lang = "de"
  elseif deviceLang == "ita" then
    lang = "it"
  end
  self.lang.ABOUT = lang
  for i = 1, #self.languages.EULA do
    if self.languages.EULA[i] == lang then
      self.lang.EULA = lang
      break
    end
  end
  for i = 1, #self.languages.TOSandPRIVACY do
    if self.languages.TOSandPRIVACY[i] == lang then
      self.lang.TOSandPRIVACY = lang
      break
    end
  end
end
function MenuCustomizeHub:openBrowser(actionName)
  if self.overlayVisible then
    return
  end
  if not self.services.MiscService.IsInternetConnectionAvailable() then
    self.nav.Event(nil, "evt_networkstatus_showpopup")
    return
  end
  local url = ""
  local homePageFile = true
  self.overlayVisible = true
  self.hideButton = true
  self:publishBackVisibility()
  if actionName == actTeamRoster then
    if self.services.GameStateService == 1 then
      url = string.format(URL_BASE_IOS_EULA, self.lang.EULA)
    else
      url = string.format(URL_BASE_EULA, self.lang.EULA)
    end
    homePageFile = false
  elseif actionName == actTeamSheets then
    url = string.format(URL_BASE_TOS, self.lang.TOSandPRIVACY)
    homePageFile = false
  elseif actionName == actToPrivacyTile then
    url = string.format(URL_BASE_PRIVACY, self.lang.TOSandPRIVACY)
    homePageFile = false
  elseif actionName == actToCreditsTile then
    url = string.format(URL_BASE_CREDITS, self.lang.TOSandPRIVACY)
    homePageFile = false
  elseif actionName == actToAboutTile then
    url = string.format(URL_BASE_ABOUT, self.lang.TOSandPRIVACY)
    homePageFile = false
  end
  print("MenuCustomizeHub:openBrowser " .. url)
  if homePageFile then
    local urlTemp = ""
    self.services.BrowserService.SetHomePage(urlTemp)
    self.services.BrowserService.SetHomePageFile(url)
  else
    local temp = math.random(1, 100000)
    local link = url.."?temp="..temp
    self.services.BrowserService.SetHomePage(link)
  end
  self.nav.Event(nil, "evt_open_browser")
end
function MenuCustomizeHub:publishGeneralAboutData()
  local headlineText = self.loc.LocalizeString("LTXT_MOB_ABOUT")
  local subHeadlineText = self.loc.LocalizeString("LTXT_MOB_ABOUT_SUB")
  local dataToInsert = {
    headline = {"MOUNTSA"},
    subHeadline = ""
  }
  self.im.Publish(bndGeneralAbout, dataToInsert)
end
function MenuCustomizeHub:publishPrivacyAboutData(actionName)
  local headlineText = self.loc.LocalizeString("LTXT_MOB_ABOUT_PRIVACY_COOKIE")
  local dataToInsert = {
    headline = {"VERSION"},
    subHeadline = ""
  }
  self.im.Publish(bndPrivacyAbout, dataToInsert)
end
function MenuCustomizeHub:publishLicenseagreementAboutData(actionName)
  local headlineText = self.loc.LocalizeString("LTXT_MOB_ABOUT_EULA")
  local dataToInsert = {
    headline = {"CHECK MY ID"},
    subHeadline = ""
  }
  self.im.Publish(bndLicenseagreementAbout, dataToInsert)
end
function MenuCustomizeHub:publishDisableshareAboutData()
  local titleText = self.loc.LocalizeString("LTXT_MOB_ABOUT_ENABLE_SHARE")
  local usageSharing = self.services.HelpAndAboutService.GetUsageSharing()
  if usageSharing then
    titleText = self.loc.LocalizeString("LTXT_MOB_ABOUT_DISABLE_SHARE")
    messageText = self.loc.LocalizeString("LTXT_MOB_DATA_DISABLE_SHARE")
  end
  local headlineText = titleText
  local dataToInsert = {
    headline = {"-"},
    subHeadline = ""
  }
  self.im.Publish(bndDisableshareAbout, dataToInsert)
end
function MenuCustomizeHub:publishTermsofserviceAboutData(actionName)
  local headlineText = self.loc.LocalizeString("LTXT_MOB_ABOUT_TOS")
  local dataToInsert = {
    headline = {"-"},
    subHeadline = ""
  }
  self.im.Publish(bndTermsofserviceAbout, dataToInsert)
end
function MenuCustomizeHub:publishCreditsAboutData()
  local headlineText = self.loc.LocalizeString("LTXT_MOB_ABOUT_CREDITS")
  local dataToInsert = {
    headline = {"-"},
    subHeadline = ""
  }
  self.im.Publish(bndCreditsAbout, dataToInsert)
end
function MenuCustomizeHub:publishBackVisibility()
  self.im.Publish(bndBackVisibility, self.hideButton)
end
function MenuCustomizeHub:_openMusicPopup()
  local titleText = "PLAYLIST*"
  local messageText = "***** \n Official Soundtrack \n EAFC 25"
  local buttonClose = {
	  type = "Cancel",
    icon = "$FooterIconNo",
    label = "Close",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local popupData = {
    title = titleText,
    message = messageText,
    buttons = {buttonClose}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end
function MenuCustomizeHub:_openUsageSharingPopup()
  local usageSharing = self.services.HelpAndAboutService.GetUsageSharing()
  local titleText = "Enable Sharing"
  local messageText = self.loc.LocalizeString("LTXT_MOB_DATA_ENABLE_SHARE")
  local buttonNo = {
	  type = "Cancel",
    icon = "$FooterIconNo",
    label = "Cancel",
    clickEvents = {
      "evt_hide_popup"
    }
  }
  local buttonYes = {
	  type = "Confirm",
    icon = "$FooterIconYes",
    label = "Confirm",
    clickEvents = {
      "evt_hide_popup"
    }
    
  }
  if usageSharing then
    titleText = "Disable Sharing"
    messageText = self.loc.LocalizeString("LTXT_MOB_DATA_DISABLE_SHARE")
  end
  if usageSharing then
    usageSharing = false
  else
    usageSharing = true
  end
  function buttonYes.clickCallback()
    self.services.HelpAndAboutService.SetUsageSharing(usageSharing)
    self:publishDisableshareAboutData()
  end
  local popupData = {
    title = titleText,
    message = messageText,
    buttons = {buttonNo, buttonYes}
  }
  self.nav.Event(nil, "evt_show_popup", popupData)
end
function MenuCustomizeHub:finalize()
  print("MenuCustomizeHub:finalize()")
  self.im.Unsubscribe(bndGeneralAbout)
  self.im.Unsubscribe(bndPrivacyAbout)
  self.im.Unsubscribe(bndLicenseagreementAbout)
  self.im.Unsubscribe(bndDisableshareAbout)
  self.im.Unsubscribe(bndTermsofserviceAbout)
  self.im.Unsubscribe(bndCreditsAbout)
  self.im.Unsubscribe(bndBackVisibility)
  self.im.UnregisterAction(actToDisableshareTile)
  self.im.UnregisterAction(actToPrivacyTile)
  self.im.UnregisterAction(actTeamRoster)
  self.im.UnregisterAction(actTeamSheets)
  self.im.UnregisterAction(actToCreditsTile)
  self.im.UnregisterAction(actToAboutTile)
  self.im.UnregisterAction(actToMusicTile)
  self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
  self.nav.RemoveActionHandler("showBackButton")
end
return MenuCustomizeHub



-- Thanks : Ma'ruf Id & Laosiji --
-- MOUNTSA - Remain Be Creative --
