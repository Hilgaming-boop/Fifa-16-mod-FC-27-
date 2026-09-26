-- ===================================================================
-- CUP MENU SLIDER -- MOUNTSA
-- ===================================================================
local CupHub = {}

local BND_LIVE_MENU = "bnd_live_menu"
local BND_SELECTED_INDEX = "bnd_selected_index"
local BND_DEFAULT_CELL_DATA = "bnd_default_cell_data"
local BND_CUP_LABEL = "bnd_cup_label"
local BND_TROPHY = "bnd_trophy"
local BND_BANNER = "bnd_banner"
local ACT_CHANGE = "act_change"
local ACT_CANCEL = "act_cancel"
local ACT_CONFIRM = "act_confirm"

function CupHub:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self
    o.currentIndex = 1
    o.defaultCellData = { label = "", image = { name = "$CupLogo", id = 0 }, id = -1, selected = false }

    o.Menu = {
        { headline={"UEFA Champions League"}, id=1 }, { headline={"2022 Qatar World Cup"}, id=2 },
        { headline={"UEFA Europa League"}, id=3 }, { headline={"CONMEBOL Libertadores"}, id=4 },
        { headline={"Copa do Brasil"}, id=5 }, { headline={"UEFA Eurocopa"}, id=6 },
        { headline={"DFB Pokal"}, id=7 }, { headline={"CONMEBOL Sudamericana"}, id=8 },
        { headline={"The Emirates FA Cup"}, id=9 }, { headline={"Copa del Rey"}, id=10 },
        { headline={"Coppa Italia"}, id=11 }, { headline={"Saudi Arab Cup"}, id=12 },
        { headline={"US Open Cup"}, id=13 }, { headline={"Club World Cup"}, id=15 },
        { headline={"UEFA Women CL"}, id=16 }, { headline={"Indonesia Cup"}, id=17 },
        { headline={"Coupe de France"}, id=18 }, { headline={"Copa Argentina"}, id=19 },
        { headline={"Copa MX"}, id=20 }, { headline={"Asia CL"}, id=21 },
        { headline={"Nations League"}, id=24 }, { headline={"Copa America"}, id=25 },
        { headline={"Saudi Super Cup"}, id=27 }, { headline={"Paulistão"}, id=28 },
        { headline={"Carioca"}, id=30 }, { headline={"Copa do Nordeste"}, id=31 }
    }

    o:_setupBindingsAndActions()
    o:_publishMenu()
    return o
end

function CupHub:_setupBindingsAndActions()
    self.im.Subscribe(BND_LIVE_MENU, function() self:_publishMenu() end)
    self.im.Subscribe(BND_DEFAULT_CELL_DATA, function() self.im.Publish(BND_DEFAULT_CELL_DATA, self.defaultCellData) end)
    self.im.Subscribe(BND_CUP_LABEL, function() self:_publishCupLabel() end)
    self.im.Subscribe(BND_TROPHY, function() self:_publishTrophy() end)
    self.im.Subscribe(BND_BANNER, function() self:_publishBanner() end)
    self.im.RegisterDataAction(BND_SELECTED_INDEX, ACT_CHANGE, function(_, _, index) self:_setSelectedIndex(index) end)
    self.im.RegisterAction(ACT_CANCEL, function() self:_setSelectedIndex(1) end)
    self.im.RegisterAction(ACT_CONFIRM, function() self:_handleConfirmAction() end)
end

function CupHub:_handleConfirmAction()
    local selectedItem = self.Menu[self.currentIndex]
    if not selectedItem then
        print("Error: Tidak ada item yang dipilih di MenuHub")
        return
    end

    if not currentCupInfo then
        currentCupInfo = {}
    end
    
    -- Menyimpan ID dan NAMA piala yang dipilih
    currentCupInfo.selectedCupId = selectedItem.id
    currentCupInfo.selectedCupName = selectedItem.headline[1] -- INI PENAMBAHANNYA

    print("DEBUG: MenuHub - Menyimpan cupId '"..tostring(currentCupInfo.selectedCupId).."'")
    print("DEBUG: MenuHub - Menyimpan cupName '"..currentCupInfo.selectedCupName.."'")

    -- Pindah ke layar team select
    self.nav.Event(nil, "evt_go_to_team_select")
end

function CupHub:_buildCellData()
    local cellData = {}
    for i, item in ipairs(self.Menu) do
        local isSelected = (self.currentIndex == i)
        table.insert(cellData, {
            label = item.headline[1], image = { name = "$CupLogo", id = item.id },
            id = i, selected = isSelected, clickAction = ACT_CHANGE, confirmAction = ACT_CONFIRM,
            alternateBackground = isSelected, imageHeight = 50, imageWidth = 50, imageMarginTop = 10
        })
    end
    return cellData
end

function CupHub:_publishCupLabel()
    local label = self.Menu[self.currentIndex].headline[1]
    self.im.Publish(BND_CUP_LABEL, label)
end

function CupHub:_publishTrophy()
    local trophyId = self.Menu[self.currentIndex].id
    self.im.Publish(BND_TROPHY, { name = "$CupTrophy", id = trophyId })
end

function CupHub:_publishBanner()
    local bannerId = self.Menu[self.currentIndex].id
    self.im.Publish(BND_BANNER, { name = "$Banner_Cup", id = bannerId })
end

function CupHub:_publishMenu()
    self.im.Publish(BND_LIVE_MENU, { index = self.currentIndex, data  = self:_buildCellData() })
    self.im.Refresh(BND_CUP_LABEL)
    self.im.Refresh(BND_TROPHY)
    self.im.Refresh(BND_BANNER)
end

function CupHub:_setSelectedIndex(index)
    if index < 1 or index > #self.Menu then return end
    self.currentIndex = index
    self:_publishMenu()
end

function CupHub:finalize()
    self.im.Unsubscribe(BND_LIVE_MENU)
    self.im.Unsubscribe(BND_DEFAULT_CELL_DATA)
    self.im.Unsubscribe(BND_CUP_LABEL)
    self.im.Unsubscribe(BND_TROPHY)
    self.im.Unsubscribe(BND_BANNER)
    self.im.UnregisterDataAction(BND_SELECTED_INDEX, ACT_CHANGE)
    self.im.UnregisterAction(ACT_CANCEL)
    self.im.UnregisterAction(ACT_CONFIRM)
end

return CupHub