-- All In One Dev MounTsa --
-- LAST PROJECT BY MOUNTSA
local Dev = {}

local BND_DEV_TYPE_LABEL = "bnd_dev_type_toggle"
local BND_DEV_TYPE_TEXT = "bnd_dev_type_text"
local BND_DEV_CREST = "bnd_dev_crest"
local BND_PREV_DEV_CREST = "bnd_prev_dev_crest"
local BND_NEXT_DEV_CREST = "bnd_next_dev_crest"
local BND_PREV2_DEV_CREST = "bnd_prev2_dev_crest"
local BND_NEXT2_DEV_CREST = "bnd_next2_dev_crest"
local ACT_NEXT_DEV_TYPE = "act_next_dev_type"
local ACT_PREV_DEV_TYPE = "act_prev_dev_type"
local ACT_ADVANCE = "act_advance"
local ACT_CONFIRM_NAME = "act_confirm_name"
local BND_DESCRIPTION = "bnd_description"
local BND_MANUAL_INPUT = "bnd_dev_name_label"
local ACT_TEXT_CHANGE = "act_text_change"
local BND_MANUAL_INPUT_VISIBLE = "bnd_manual_input_visible"
local BND_NAME_VALID = "bnd_name_valid"
local BND_INPUT_PLACEHOLDER = "bnd_input_placeholder"

GlobalDevSettings = GlobalDevSettings or {}

function Dev:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.services = { settingsService = o.api("SettingsService") }

    Dev.options = {
        devType = {
            { name = " INPUT MANUAL ", value = 1 },
            { name = " BILLZ12 ", value = 2 },
            { name = " MA'RUF ID ", value = 3 },
            { name = " VOLTA SPORT ", value = 4 },
            { name = " MVNPROD ", value = 5 },
            { name = " MELDA14 ", value = 6 },
            { name = " SMR21 ", value = 7 },
            { name = " AF'ID ", value = 8 },
            { name = " ZHINXI ", value = 9 },
            { name = " CROT DI MULUT ", value = 10 },
            { name = " HNFH16 ", value = 11 },
            { name = " ROBER FL ", value = 12 },
            { name = " LAOSIJI ", value = 13 },
            { name = " PRAS 87 ", value = 14 },
            { name = " AKHMAD FARIS ", value = 15 },
            { name = " RIANPROSS ", value = 16 },
            { name = " DAVUNPES ", value = 17 },
            { name = " MOUNTSA ", value = 18 }
        }
    }
    o.options = Dev.options
    o.selectedIndices = { devType = 1 }
    
    o.manualInputText = ""
    o.showManualInput = false
    o.isInputValid = false

    o:RegisterBindingsAndActions()
    o:PublishInitialData()
    return o
end

function Dev:RegisterBindingsAndActions()
    self.im.RegisterAction(ACT_NEXT_DEV_TYPE, function() self:nextDevType() end)
    self.im.RegisterAction(ACT_PREV_DEV_TYPE, function() self:prevDevType() end)
    self.im.RegisterAction(ACT_ADVANCE, function() self:ConfirmAndProceed() end)
    self.im.RegisterAction(ACT_TEXT_CHANGE, function(actionName, value) self:HandleTextChange(value) end)
    self.im.RegisterAction(ACT_CONFIRM_NAME, function() self:ConfirmAndProceed() end)
    
    self.im.Subscribe(BND_INPUT_PLACEHOLDER, function() self:UpdateNameValidation() end)
    self.im.Subscribe(BND_DEV_TYPE_TEXT, function() self:updateDevTypeUI() end)
    self.im.Subscribe(BND_DEV_CREST, function() self:updateDevTypeUI() end)
    self.im.Subscribe(BND_PREV_DEV_CREST, function() self:updateDevTypeUI() end)
    self.im.Subscribe(BND_NEXT_DEV_CREST, function() self:updateDevTypeUI() end)
    self.im.Subscribe(BND_PREV2_DEV_CREST, function() self:updateDevTypeUI() end)
    self.im.Subscribe(BND_NEXT2_DEV_CREST, function() self:updateDevTypeUI() end)
    self.im.Subscribe(BND_DESCRIPTION, function() self:PublishDescription() end)
    self.im.Subscribe(BND_MANUAL_INPUT, function() self:UpdateManualInput() end)
    self.im.Subscribe(BND_MANUAL_INPUT_VISIBLE, function() self:UpdateManualInputVisibility() end)
    self.im.Subscribe(BND_NAME_VALID, function() self:UpdateNameValidation() end)
end

function Dev:HandleTextChange(value)
    if value then
        self.manualInputText = value.text
        self:ValidateInput()
        self:PublishDescription()
        self:UpdateNameValidation()
    end
end

function Dev:ValidateInput()
    if self.manualInputText and self.manualInputText ~= "" then
        if string.len(self.manualInputText) <= 20 and string.len(self.manualInputText) >= 2 then
            self.isInputValid = true
        else
            self.isInputValid = false
        end
    else
        self.isInputValid = false
    end
end

function Dev:navigate(settingName, direction)
    local options = self.options[settingName]
    local currentIndex = self.selectedIndices[settingName]
    local newIndex = currentIndex + direction
    
    if newIndex > #options then newIndex = 1
    elseif newIndex < 1 then newIndex = #options end
    
    local oldOpt = options[currentIndex]
    local newOpt = options[newIndex]
    
    if oldOpt and newOpt then
        local wasManual = (oldOpt.value == 1)
        local isManual = (newOpt.value == 1)
        
        if wasManual ~= isManual then
            self.showManualInput = isManual
            self:UpdateManualInputVisibility()
        end
    end
    
    self.selectedIndices[settingName] = newIndex
end

function Dev:nextDevType()
    self:navigate("devType", 1)
    self:updateDevTypeUI()
end

function Dev:prevDevType()
    self:navigate("devType", -1)
    self:updateDevTypeUI()
end

function Dev:updateDevTypeUI()
    local options = self.options.devType
    local totalOptions = #options
    local currentIndex = self.selectedIndices.devType
    local currentOpt = options[currentIndex]
    if not currentOpt then return end

    local prevIndex = (currentIndex - 2 + totalOptions) % totalOptions + 1
    local nextIndex = (currentIndex % totalOptions) + 1
    local prev2Index = (currentIndex - 3 + totalOptions) % totalOptions + 1
    local next2Index = (currentIndex + 1) % totalOptions + 1

    self.im.Publish(BND_DEV_TYPE_LABEL, { data = {{ name = currentOpt.name }}, index = 0 })
    self.im.Publish(BND_DEV_TYPE_TEXT, currentOpt.name)
    self.im.Publish(BND_DEV_CREST, { name = "$Dev", id = currentOpt.value })
    self.im.Publish(BND_PREV_DEV_CREST, { name = "$Dev", id = options[prevIndex].value })
    self.im.Publish(BND_NEXT_DEV_CREST, { name = "$Dev", id = options[nextIndex].value })
    self.im.Publish(BND_PREV2_DEV_CREST, { name = "$Dev", id = options[prev2Index].value })
    self.im.Publish(BND_NEXT2_DEV_CREST, { name = "$Dev", id = options[next2Index].value })
    
    self.showManualInput = (currentOpt.value == 1)
    self:UpdateManualInputVisibility()
    self:UpdateManualInput()
    self:UpdateNameValidation()
    self:PublishDescription()
end

function Dev:UpdateManualInputVisibility()
    self.im.Publish(BND_MANUAL_INPUT_VISIBLE, self.showManualInput)
end

function Dev:UpdateManualInput()
    if self.showManualInput then
        self.im.Publish(BND_MANUAL_INPUT, self.manualInputText)
    else
        self.im.Publish(BND_MANUAL_INPUT, "")
    end
end

function Dev:UpdateNameValidation()
    if self.showManualInput then
        if self.isInputValid then
            self.im.Publish(BND_NAME_VALID, self.manualInputText)
        else
            if self.manualInputText == "" then
                self.im.Publish(BND_NAME_VALID, "Player Name")
            else
                self.im.Publish(BND_NAME_VALID, "Name 2-20 Characters")
            end
        end
    else
        local currentOpt = self.options.devType[self.selectedIndices.devType]
        if currentOpt then
            self.im.Publish(BND_NAME_VALID, currentOpt.name)
        end
    end
end

function Dev:PublishInitialData()
    self:updateDevTypeUI()
end

function Dev:PublishDescription()
    local typeOpt = self.options.devType[self.selectedIndices.devType]
    if typeOpt then
        local desc = ""
        
        if typeOpt.value == 1 then
            if self.isInputValid then
                desc = "Press Advance to Continue"
            else
                if self.manualInputText == "" then
                    desc = "Enter Your Name"
                else
                    desc = "Name must be 2–20 characters"
                end
            end
        else
            desc = string.format("To the Legends of Modding – You Are the Best", string.upper(typeOpt.name))
        end
        
        self.im.Publish(BND_DESCRIPTION, desc)
    end
end

function Dev:ConfirmAndProceed()
    local selectedDev = self.options.devType[self.selectedIndices.devType]
    
    if selectedDev.value == 1 then
        self:ValidateInput()
        if not self.isInputValid then
            self.im.Publish(BND_DESCRIPTION, "Invalid name! Please check your input.")
            return
        end
    end
    
    GlobalDevSettings = {
        devId = selectedDev.value,
        devName = selectedDev.name
    }
    
    if selectedDev.value == 1 and self.manualInputText ~= "" then
        GlobalDevSettings.devName = self.manualInputText
        GlobalDevSettings.isCustom = true
    end
    
    self.nav.Event(nil, "evt_advance")
end

function Dev:finalize()
    self.im.UnregisterAction(ACT_NEXT_DEV_TYPE)
    self.im.UnregisterAction(ACT_PREV_DEV_TYPE)
    self.im.UnregisterAction(ACT_ADVANCE)
    self.im.UnregisterAction(ACT_TEXT_CHANGE)
    self.im.UnregisterAction(ACT_CONFIRM_NAME)
    
    self.im.Unsubscribe(BND_DEV_TYPE_LABEL)
    self.im.Unsubscribe(BND_DEV_TYPE_TEXT)
    self.im.Unsubscribe(BND_DEV_CREST)
    self.im.Unsubscribe(BND_PREV_DEV_CREST)
    self.im.Unsubscribe(BND_NEXT_DEV_CREST)
    self.im.Unsubscribe(BND_PREV2_DEV_CREST)
    self.im.Unsubscribe(BND_NEXT2_DEV_CREST)
    self.im.Unsubscribe(BND_MANUAL_INPUT)
    self.im.Unsubscribe(BND_DESCRIPTION)
    self.im.Unsubscribe(BND_MANUAL_INPUT_VISIBLE)
    self.im.Unsubscribe(BND_INPUT_PLACEHOLDER)
    self.im.Unsubscribe(BND_NAME_VALID)
end

return Dev

-- LAST PROJECT BY MOUNTSA