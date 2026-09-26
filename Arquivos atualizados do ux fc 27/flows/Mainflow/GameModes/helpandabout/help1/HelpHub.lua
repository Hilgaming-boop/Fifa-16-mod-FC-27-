local HelpHub = {}

local devOptions = {
    { name = " MOUNTSA ", value = 1 }, { name = " LAOSIJI ", value = 2 },
    { name = " MA'RUF ID ", value = 3 }, { name = " VOLTA SPORT ", value = 4 },
    { name = " MVNPROD ", value = 5 }, { name = " MELDA14 ", value = 6 },
    { name = " NB PLAYS ", value = 7 }, { name = " AF'ID ", value = 8 },
    { name = " ZHINXI ", value = 9 }, { name = " CROT DI MULUT ", value = 10 },
    { name = " HNFH16 ", value = 11 }, { name = " ROBER FL ", value = 12 },
    { name = " TALAMLEGIT ", value = 13 }, { name = " PRAS 87 ", value = 14 },
    { name = " AKHMAD FARIS ", value = 15 }, { name = " RIANPROSS ", value = 16 },
    { name = " DAVUNPES ", value = 17 }
}
	
function HelpHub:updateDevDisplay()
    local selectedId = GlobalDevSettings.devId or 1
    local selectedDevData = devOptions[selectedId]

    if selectedDevData then
        self.im.Publish("bnd_avatar_dev", { name = "$Dev", id = selectedDevData.value })
        self.im.Publish("bnd_name_dev", selectedDevData.name)
        print("[HelpHub.lua] Tampilan Dev diperbarui ke: " .. selectedDevData.name)
    else
        print("[HelpHub.lua] GAGAL: Tidak dapat menemukan data untuk Dev ID: " .. tostring(selectedId))
    end
end

function HelpHub:new(init)
    local o = init or {}
    setmetatable(o, self)
    self.__index = self

    o.services = {
        BrowserService = o.api and o.api("BrowserService"),
        MiscService = o.api and o.api("MiscService")
    }
    
    o.im.Subscribe("bnd_avatar_dev", function()
        o:updateDevDisplay()
    end)
    o.im.Subscribe("bnd_name_dev", function()
        o:updateDevDisplay()
    end)

    o.refreshHandler = o.nav.AddActionHandler("evt_refresh_mainhub_data", false, nil, function()
        print("[HelpHub.lua] Menerima sinyal refresh, memperbarui tampilan Dev...")
        o:updateDevDisplay()
    end)
    
    return o
end

function HelpHub:finalize()
    self.im.Unsubscribe("bnd_avatar_dev")
    self.im.Unsubscribe("bnd_name_dev")

    if self.refreshHandler then
        self.nav.RemoveActionHandler("evt_refresh_mainhub_data")
        self.refreshHandler = nil
    end
end

return HelpHub