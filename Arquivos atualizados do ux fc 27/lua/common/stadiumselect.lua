local StadiumSelectModel = {}
StadiumSelectModel.__index = StadiumSelectModel

local BND_SELECTED_STADIUM_ID = "bnd_selected_stadium_id"

local stadiumList = {
    { id = 33, name = "Old Trafford" },
    { id = 195, name = "Camp Nou" },
    { id = 137, name = "Anfield" },
    { id = 156, name = "San Siro" },
    { id = 172, name = "Santiago Bernabéu" },
    { id = 247, name = "Signal Iduna Park" }
}

function StadiumSelectModel:new()
    local self = setmetatable({}, StadiumSelectModel)
    self.currentIndex = 1
    self:_loadSavedSelection()
    return self
end

function StadiumSelectModel:_loadSavedSelection()
    local savedID = self.services.SettingsService:GetInt("selectedStadiumID")
    if savedID and savedID > 0 then
        for i, stadium in ipairs(stadiumList) do
            if stadium.id == savedID then
                self.currentIndex = i
                break
            end
        end
    end
    self:_publishSelection()
end

function StadiumSelectModel:Next()
    self.currentIndex = self.currentIndex + 1
    if self.currentIndex > #stadiumList then
        self.currentIndex = 1
    end
    self:_publishSelection()
end

function StadiumSelectModel:Previous()
    self.currentIndex = self.currentIndex - 1
    if self.currentIndex < 1 then
        self.currentIndex = #stadiumList
    end
    self:_publishSelection()
end

function StadiumSelectModel:_publishSelection()
    local selected = stadiumList[self.currentIndex]
    self.services.SettingsService:SetInt("selectedStadiumID", selected.id)
    self.im:Publish(BND_SELECTED_STADIUM_ID, { id = selected.id, name = selected.name })
end

function StadiumSelectModel:GetSelectedStadiumID()
    return stadiumList[self.currentIndex].id
end

return StadiumSelectModel