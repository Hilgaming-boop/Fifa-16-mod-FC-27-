-- LAST PROJECT BY MOUNTSA
local General = {}
local BND_GENERAL_SETTINGS_DATA = "bnd_general_settings_data"
local BND_PUSH_NOTES_ROW_DATA = "bnd_push_notes_row_data"
local BND_LIST_Y_COORD = "bnd_list_y_coord"
local BND_PUSH_NOTES_VISIBILITY = "bnd_push_notes_visibility"
local BND_START_LIST_STRIPED = "bnd_start_list_striped"
local ACT_ENABLE_PUSH_NOTIFICATIONS = "act_enable_push_notifications"
local OPTION_TOGGLE_SFX = "act_option_toggle"

function General:updateDevDisplay()
    local devId = (GlobalDevSettings and GlobalDevSettings.devId) or 1
    local devName = string.upper((GlobalDevSettings and GlobalDevSettings.devName) or " MOUNTSA ")

    self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = devId })
    self.im.Publish("bnd_name_dev", devName)
    print("[General.lua] Tampilan Dev diperbarui ke: " .. devName)
end

function General:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = {
        LoginService = o.api("LoginService"),
        UserPlateService = o.api("UserPlateService"),
        SettingsService = o.api("SettingsService"),
        GameStateService = o.api("GameStateService")
    }
    local personaData = o.services.LoginService.GetNucleusPersonaData()
    o.pushNotificationsEnabled = o.services.SettingsService.GetPushNotesOn().pushOn
    o.platform = o.services.GameStateService.GetPlatform()
    o.userID = personaData.userId
    o.displayName = personaData.userName
    
    o.im.Subscribe(BND_GENERAL_SETTINGS_DATA, function() o:publishGeneralSettingsData() end)
    o.im.Subscribe(BND_PUSH_NOTES_ROW_DATA, function() o:publishPushNotesData() end)
    o.im.Subscribe(BND_LIST_Y_COORD, function() o:publishListYCoord() end)
    o.im.Subscribe(BND_PUSH_NOTES_VISIBILITY, function() o:publishPushNotesVisibility() end)
    o.im.Subscribe(BND_START_LIST_STRIPED, function() o:publishStartListStriped() end)
    
    o.im.Subscribe("bnd_avatar_dev", function() o:updateDevDisplay() end)
    o.im.Subscribe("bnd_name_dev", function() o:updateDevDisplay() end)

    o.refreshHandler = o.nav.AddActionHandler("evt_refresh_mainhub_data", false, nil, function()
        print("[General.lua] Menerima sinyal refresh, memperbarui tampilan Dev...")
        o:updateDevDisplay()
    end)
    
    o.im.RegisterAction(ACT_ENABLE_PUSH_NOTIFICATIONS, function(actionName, data)
        local newValue = data.value
        if o.pushNotificationsEnabled ~= newValue then
            o.pushNotificationsEnabled = newValue
            if newValue == true then
                o.services.SettingsService.SetPushNotesOn(1)
            end
        end
    end)
    return o
end

function General:publishGeneralSettingsData()
    print("publishGeneralSettingsData")
    
    local devName = string.upper((GlobalDevSettings and GlobalDevSettings.devName) or "User")

    local dirtyIndices = {}
    local nRows = 2
    for i = 0, nRows do
        table.insert(dirtyIndices, i)
    end
    local dataList = {
        dirty = dirtyIndices,
        data = {
            {
                data = {
                    title = "Alphatrix",
                    value = devName
                }
            },
            {
                data = {
                    title = "Active Players",
                    value = "3.691"
                }
            },
            {
                data = {
                    title = "Data Version",
                    value = "beta "
                }
            }
        }
    }
    self.im.Publish(BND_GENERAL_SETTINGS_DATA, dataList)
end

function General:publishPushNotesData()
    local data = {
        label = "Notification",
        controlType = "binary",
        currentValue = self.pushNotificationsEnabled,
        toggleAction = "act_enable_push_notifications",
        clickSFX = OPTION_TOGGLE_SFX
    }
    self.im.Publish(BND_PUSH_NOTES_ROW_DATA, data)
end

function General:publishListYCoord()
    local data = 0
    if self.platform == 2 or self.platform == 3 then
        data = 90
    end
    self.im.Publish(BND_LIST_Y_COORD, data)
end

function General:publishStartListStriped()
    local data = true
    if self.platform == 2 or self.platform == 3 then
        data = false
    end
    self.im.Publish(BND_START_LIST_STRIPED, data)
end

function General:publishPushNotesVisibility()
    local data = false
    if self.platform == 2 or self.platform == 3 then
        data = true
    end
    self.im.Publish(BND_PUSH_NOTES_VISIBILITY, data)
end

function General:publishPushNotificationsEnabled(value)
end

function General:finalize()
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")
    if self.refreshHandler then
        self.nav.RemoveActionHandler("evt_refresh_mainhub_data")
        self.refreshHandler = nil
    end
    self.im.Unsubscribe(BND_GENERAL_SETTINGS_DATA)
    self.im.Unsubscribe(BND_PUSH_NOTES_ROW_DATA)
    self.im.Unsubscribe(BND_PUSH_NOTES_VISIBILITY)
    self.im.Unsubscribe(BND_START_LIST_STRIPED)
    self.im.Unsubscribe(BND_LIST_Y_COORD)
    self.im.UnregisterAction(ACT_ENABLE_PUSH_NOTIFICATIONS)
end

return General
-- LAST PROJECT BY MOUNTSA