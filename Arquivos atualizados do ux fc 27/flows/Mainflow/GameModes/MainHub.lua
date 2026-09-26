-- LAST PROJECT BY ALPHATRIX 
local MainHub = {}

local ACT_BTN_CLICK = "act_btn_click"
local ACT_BELUM = "act_belum"

function MainHub:updateDevDisplay()

    local devId = (GlobalDevSettings and GlobalDevSettings.devId) or 1
    local devName = (GlobalDevSettings and GlobalDevSettings.devName) or " ALPHATRIX "

    self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = devId })
    self.im.Publish("bnd_name_dev", devName)
end

function MainHub:SetActiveTab(newTabIndex)
    if self.activeTabIndex == newTabIndex then
        return
    end
    if self.activeTabIndex then
        local oldTabName = self.tabs[self.activeTabIndex]
        local oldAnimName = self.animations[self.activeTabIndex]
        self.im.Publish(oldTabName, false)
        self.im.Publish(oldAnimName, false)
    end

    local newTabName = self.tabs[newTabIndex]
    local newAnimName = self.animations[newTabIndex]
    if newTabName and newAnimName then
        self.im.Publish(newTabName, true)
        self.im.Publish(newAnimName, true)
        self.activeTabIndex = newTabIndex
    end
end

function MainHub:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    o.services = {
        BrowserService = o.api("BrowserService"),
        MiscService = o.api("MiscService")
    }

    o.tabs = {}
    o.animations = {}
    local NUM_TABS = 9
    for i = 1, NUM_TABS do
        o.tabs[i] = "bnd_tab" .. i
        o.animations[i] = "bnd_panel_animation" .. i
    end

    o.activeTabIndex = nil

    o.im.Subscribe("bnd_avatar_dev", function() o:updateDevDisplay() end)
    o.im.Subscribe("bnd_name_dev", function() o:updateDevDisplay() end)
    o.refreshHandler = o.nav.AddActionHandler("evt_refresh_mainhub_data", false, nil, function()
        o:updateDevDisplay()
    end)
    
    o.menubg = { name = "$Bg_MenuHome", id = 0 }
    math.randomseed(os.clock() * 1000 + os.time())
    o.menubg.id = math.random(18)
    
    o.im.Subscribe("bnd_menu_bg", function()
        o.im.Publish("bnd_menu_bg", o.menubg)
    end)
	
    o.im.RegisterAction(ACT_BELUM, function(actionName)
        o:PlayMatch()
    end)
    
    o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
        if data and data.buttonID then
            local clickedTabIndex = data.buttonID + 1
            o:SetActiveTab(clickedTabIndex)
        end
    end)

    for i = 1, #o.tabs do
        o.im.Publish(o.tabs[i], false)
        o.im.Publish(o.animations[i], false)
    end
    
    o:SetActiveTab(1)

    o:updateDevDisplay()
    o.im.Publish("bnd_menu_bg", o.menubg)

    return o
end

function MainHub:PlayMatch()
    self.nav.Event(nil, "evt_show_popup", {
        title = "INFO",
        message = "We're working on it. \nPlease check back for upcoming updates.",
        buttons = {
            {
                icon = "$FooterIconYes",
                label = "OK",
                clickEvents = { "evt_hide_popup" }
            }
        }
    })
end

function MainHub:finalize()
    self.im.Unsubscribe("bnd_menu_bg")
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")
    self.im.UnregisterAction(ACT_BTN_CLICK)
    if self.refreshHandler then
        self.nav.RemoveActionHandler("evt_refresh_mainhub_data")
        self.refreshHandler = nil
    end
end

return MainHub
-- LAST PROJECT BY ALPHATRIX 