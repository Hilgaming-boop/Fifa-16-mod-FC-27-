-- MOUNTSA POPUP --

local TableUtil, EventManager = ...
local EVENT_TYPES = EventManager.FE.FIFA.EventTypes

local Popup = {}

local BND_POPUP_TITLE      = "bnd_popup_title"
local BND_POPUP_MESSAGE    = "bnd_popup_message"
local BND_BUTTON1_VISIBLE  = "bnd_button1_visible"
local BND_BUTTON2_VISIBLE  = "bnd_button2_visible"
local BND_BUTTON3_VISIBLE  = "bnd_button3_visible"
local BND_BUTTON1_LABEL    = "bnd_button1_label"
local BND_BUTTON2_LABEL    = "bnd_button2_label"
local BND_BUTTON3_LABEL    = "bnd_button3_label"
local BND_TAB1             = "bnd_tab1"
local BND_TAB2             = "bnd_tab2"
local BND_TAB3             = "bnd_tab3"

local TAB1, TAB2, TAB3     = 1, 2, 3
local ACT_BTN_CLICK        = "act_btn_click"

function Popup:new(init)
    print("[Popup]: new() - Using dynamic button system.")
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    o.services = {
        ScreenInfoService    = o.api("ScreenInfoService"),
        EventManagerService  = o.api("EventManagerService")
    }

    o.eventHandlerID = o.services.EventManagerService.RegisterHandler(function(...)
        o:_handleEvent(...)
    end)

    o.data    = o.data or {}
    o.title   = o.data.title   or ""
    o.message = o.data.message or ""
    o.buttons = o.data.buttons or {}

    o.im.Subscribe(BND_POPUP_TITLE,   function() o.im.Publish(BND_POPUP_TITLE, o.title) end)
    o.im.Subscribe(BND_POPUP_MESSAGE, function() o.im.Publish(BND_POPUP_MESSAGE, o.message) end)

    local BND_VISIBLE = { BND_BUTTON1_VISIBLE, BND_BUTTON2_VISIBLE, BND_BUTTON3_VISIBLE }
    local BND_LABEL   = { BND_BUTTON1_LABEL,   BND_BUTTON2_LABEL,   BND_BUTTON3_LABEL   }

    local function setupButton(idx)
        local visibleBinding = BND_VISIBLE[idx]
        local labelBinding   = BND_LABEL[idx]

        o.im.Subscribe(visibleBinding, function()
            o.im.Publish(visibleBinding, o.buttons[idx] ~= nil)
        end)

        o.im.Subscribe(labelBinding, function()
            local txt = (o.buttons[idx] and o.buttons[idx].label) or ""
            o.im.Publish(labelBinding, txt)
        end)

        o.im.RegisterAction("act_button_"..idx, function()
            if o.buttons[idx] then
                local button = o.buttons[idx]
                print("[Popup]: Button "..idx.." clicked: "..(button.label or ""))
                if button.clickCallback then button.clickCallback() end
                if button.clickEvents then
                    for _, event in ipairs(button.clickEvents) do
                        o.nav.Event(nil, event)
                    end
                end
            end
        end)
    end

    for i = 1, 3 do setupButton(i) end

    o.selectedTab = TAB1
    o.buttonsID   = { TAB1, TAB2, TAB3 }

    o.im.Subscribe(BND_TAB1, function() o.im.Publish(BND_TAB1, o.selectedTab == TAB1) end)
    o.im.Subscribe(BND_TAB2, function() o.im.Publish(BND_TAB2, o.selectedTab == TAB2) end)
    o.im.Subscribe(BND_TAB3, function() o.im.Publish(BND_TAB3, o.selectedTab == TAB3) end)

    o:PublishButtons()

    o:HideSelections()
    o.im.Publish(BND_TAB1, true)

    o.im.RegisterAction(ACT_BTN_CLICK, function(actionName, data)
        if not data or not data.buttonID then return end
        o:HideSelections()
        local btnID = o.buttonsID[data.buttonID + 1]
        if btnID == TAB1 then
            o.selectedTab = TAB1
            o.im.Publish(BND_TAB1, true)
        elseif btnID == TAB2 then
            o.selectedTab = TAB2
            o.im.Publish(BND_TAB2, true)
        elseif btnID == TAB3 then
            o.selectedTab = TAB3
            o.im.Publish(BND_TAB3, true)
        end
    end)

    o.services.ScreenInfoService.SetScreenName("GenericPopup")
    return o
end

function Popup:PublishButtons()
    for i = 1, 3 do
        local visible = self.buttons[i] ~= nil
        local label   = (self.buttons[i] and self.buttons[i].label) or ""
        self.im.Publish("bnd_button"..i.."_visible", visible)
        self.im.Publish("bnd_button"..i.."_label",   label)
    end
end

function Popup:HideSelections()
    self.im.Publish(BND_TAB1, false)
    self.im.Publish(BND_TAB2, false)
    self.im.Publish(BND_TAB3, false)
end

function Popup:_handleEvent(eventType, data)
    if eventType == EVENT_TYPES.OnBackPressed then
        print("[Popup]: Back button pressed, triggering cancel action.")
        if self.cancelData and self.cancelData.clickCallback then self.cancelData.clickCallback() end
        if self.cancelData and self.cancelData.clickEvents then
            for _, event in ipairs(self.cancelData.clickEvents) do self.nav.Event(nil, event) end
        end
    end
end

function Popup:finalize()
    print("[Popup]: finalize()")
    for i = 1, 3 do
        self.im.UnregisterAction("act_button_"..i)
        self.im.Unsubscribe("bnd_button"..i.."_visible")
        self.im.Unsubscribe("bnd_button"..i.."_label")
    end
    self.im.Unsubscribe(BND_POPUP_TITLE)
    self.im.Unsubscribe(BND_POPUP_MESSAGE)
    self.im.Unsubscribe(BND_TAB1)
    self.im.Unsubscribe(BND_TAB2)
    self.im.Unsubscribe(BND_TAB3)
    self.im.UnregisterAction(ACT_BTN_CLICK)

    self.services.EventManagerService.UnregisterHandler(self.eventHandlerID)
    self.services.ScreenInfoService.UnsetScreenName("GenericPopup")
end

return Popup