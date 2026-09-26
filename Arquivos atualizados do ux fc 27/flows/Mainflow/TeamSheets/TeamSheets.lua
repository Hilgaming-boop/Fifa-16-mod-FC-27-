-- Modified By MVNPROD Youtube Channel --

local TeamSheets = {}

local bndPlayerList = "bnd_player_list"

local ACT_PLAYER_SELECT = "act_player_select"

local PlayerListData = {}

TeamID = 0

function TeamSheets:new(init)
  local o = init or {}
  setmetatable(o, self)
  self.__index = self
  o.services = {
    SquadManagementService = o.api("SquadMgtService"),
    gameSetup = o.api("GameSetupService")
  }
   TeamID = o.services.gameSetup.GetHomeAssetId()
    o.visible = false
    o.im.Subscribe("bnd_visible", function()
        o:publishVisible()
    end)
    o.im.Subscribe("bnd_loading_visible", function()
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
    o.im.Subscribe("bnd_player_country", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_player_rating", function()
        o:publishPlayerInfo()
    end)
    o.im.Subscribe("bnd_3d_player", function()
        o:publishPlayerInfo()
    end)

    for i = 1, 6 do
        o.im.Subscribe("bnd_player_stat"..i, function()
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
    
  return o
end

function TeamSheets:publishVisible()
   self.im.Publish("bnd_visible", self.visible)
   self.im.Publish("bnd_loading_visible", not self.visible)
end


function TeamSheets:publishPlayerInfo(data)
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
        self.im.Publish("bnd_player_rating", data.rating)
        self.im.Publish("bnd_3d_player", {
            name = "$PLAYER_ID",
            id = data.CARD_ID
        })
        for i = 1, 6 do
            self.im.Publish("bnd_player_stat"..i, data["stat"..i])
        end
    end
end

-- Tabel prioritas posisi (Angka lebih kecil muncul lebih dulu)
local positionPriority = {
    ["GK"]  = 1, 
    ["CB"]  = 2, ["LB"] = 3, ["RB"] = 4, ["LWB"] = 5, ["RWB"] = 6,
    ["CDM"] = 7, ["CM"] = 8, ["CAM"] = 9, ["LM"] = 10, ["RM"] = 11,
    ["CF"]  = 12, ["LW"] = 13, ["RW"] = 14,
    ["ST"]  = 15 -- ST diletakkan paling akhir
}

function TeamSheets:Init()
    local teamLineup = self.services.SquadManagementService.GetCurrentPlayerLineup(0, TeamID, 0)
    
    -- Reset data
    PlayerListData = {}

    for i = 1, table.getn(teamLineup) do
        local obj = {
            assetId = teamLineup[i].CARD_ID,
            clickAction = "act_player_select",
            playerInfo = teamLineup[i],
            data = {}
        }
        table.insert(PlayerListData, obj)
    end

    -- Proses pengurutan
    table.sort(PlayerListData, function(a, b)
        local posA = a.playerInfo.position or ""
        local posB = b.playerInfo.position or ""
        
        -- Jika posisi tidak ada di tabel, diberi nilai 90 agar tetap di atas ST namun di bawah lainnya
        local priorityA = positionPriority[posA] or 90
        local priorityB = positionPriority[posB] or 90
        
        return priorityA < priorityB
    end)
end

function TeamSheets:publishPlayerRows()
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
    self:publishPlayerDetail({
        id = 0
    })
end

function TeamSheets:publishPlayerDetail(data)
    local playerIndex = data.id + 1
    local playerData = PlayerListData[playerIndex].playerInfo
    self:publishPlayerInfo(playerData)
    
end

function TeamSheets:finalize()
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
  for i = 1, 6 do
    self.im.Unsubscribe("bnd_player_stat"..i)
  end
  self.im.Unsubscribe(bndPlayerList)
  self.im.UnregisterAction(ACT_PLAYER_SELECT)
end

return TeamSheets
