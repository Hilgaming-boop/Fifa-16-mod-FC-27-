self.im.Publish("bnd_champions_crest", { name = "$Crest", id = winnerTeamId })






self.im.Publish("bnd_champions_team_name", displayTitle)


function Standings:publishHomeInfo()
    local tourName = tourIdToNameMap[tourId] or tourIdToNameMap.default
    local currentDate = os.date("%d %B %Y")
    local currentTime = os.date("%h %d | %I:%M %p")
    
    -- Ambil ID Tim Juara
    local winnerTeamId = self:getWinnerTeamId()
    
    -- Tentukan nama yang akan ditampilkan
    local displayTitle = tourName -- Default pakai nama turnamen
    if winnerTeamId ~= 0 then
        -- Jika sudah ada juara, ubah displayTitle menjadi nama tim juara
        displayTitle = self.loc.LocalizeString("TeamName_Abbr15_" .. winnerTeamId)
    end