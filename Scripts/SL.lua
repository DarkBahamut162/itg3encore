local ProfileSlot = {
    [PLAYER_1] = "ProfileSlot_Player1",
    [PLAYER_2] = "ProfileSlot_Player2"
}

local SLFavorites = {}
local OFFavorites = {}

function getSLFavorites(player)
    return SLFavorites[player] or {}
end

function getOFFavorites(player)
    return OFFavorites[player] or {}
end

local function SL2Other(player,profilePath)
	local fileSL = RageFileUtil.CreateRageFile()
	local contentSL
	if fileSL:Open(profilePath, 1) then
		contentSL = fileSL:Read()
		fileSL:Close()
		fileSL:destroy()
	end
	local fileOF = RageFileUtil.CreateRageFile()
	if fileOF:Open(THEME:GetCurrentThemeDirectory().."Other/SongManager "..player..".txt", 2) then
		fileOF:Write(contentSL)
		fileOF:Close()
		fileOF:destroy()
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(THEME:GetCurrentThemeDirectory().."Other/") end
	end
    SONGMAN:SetPreferredSongs(player)
end

--not sure if needed anymore... shouldn't cross systems...
function SL2OF(profile,filePath)
	local file = RageFileUtil.CreateRageFile()
	file:Open(filePath,1)
	file:Seek(1)
	local line
	local song
	while true do
		if file:AtEOF() then break elseif file then
			line = file:GetLine()
			song = SONGMAN:FindSong(line)
			if song then profile:AddSongToFavorites(song) end
            song = nil
		end
	end
	file:Close()
	file:destroy()
end

local function strPlainText(strText)
    return strText:gsub("(%W)", "%%%1")
end

local function getSLFavoritesPath(player)
    return PROFILEMAN:GetProfileDir(ProfileSlot[player]) .. "favorites.txt"
end

local function getOFFavoritesPath(player)
    return PROFILEMAN:GetProfileDir(ProfileSlot[player]) .. "Stats.xml"
end

local function SLCombine()
	local fileSL1 = RageFileUtil.CreateRageFile()
	local fileSL2 = RageFileUtil.CreateRageFile()
	local contentSL = {}
	if fileSL1:Open(getSLFavoritesPath(PLAYER_1), 1) then
		contentSL[PLAYER_1] = fileSL1:Read()
		fileSL1:Close()
		fileSL1:destroy()
	end
	if fileSL2:Open(getSLFavoritesPath(PLAYER_2), 1) then
		contentSL[PLAYER_2] = fileSL2:Read()
		fileSL2:Close()
		fileSL2:destroy()
	end
	local fileOF = RageFileUtil.CreateRageFile()
	if fileOF:Open(THEME:GetCurrentThemeDirectory().."Other/SongManager both.txt", 2) then
		fileOF:Write(contentSL[PLAYER_1].."\n"..contentSL[PLAYER_2])
		fileOF:Close()
		fileOF:destroy()
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(THEME:GetCurrentThemeDirectory().."Other/") end
	end
    SONGMAN:SetPreferredSongs("both")
end

function setOFFavorites(pn)
    OFFavorites[ToEnumShortString(pn)] = {}
	local file = RageFileUtil.CreateRageFile()
	file:Open(getOFFavoritesPath(pn),1)
	file:Seek(1)
	local line
    local reading = false
	while true do
		if file:AtEOF() then break elseif file then
			line = file:GetLine()
            if line == "<FavSongs/>" or line == "</FavSongs>" then break elseif line == "<FavSongs>" then reading = true elseif reading then
                local line = split("/", line)
                OFFavorites[ToEnumShortString(pn)][#OFFavorites[ToEnumShortString(pn)] + 1] = SONGMAN:FindSong(line[3] .. "/" .. line[4])
            end
		end
	end
	file:Close()
	file:destroy()
end

function generateFavoritesForMusicWheel()
    local check = 0
    local loadPlayer = nil
    for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
        SLFavorites[ToEnumShortString(pn)] = {}
        if PROFILEMAN:IsPersistentProfile(pn) then
            local strToWrite = ""
            local listofavorites = {}
            local path = getSLFavoritesPath(pn)

            if FILEMAN:DoesFileExist(path) then
                local favs = lua.ReadFile(path)
                if favs:len() > 2 then
					local profileName = PROFILEMAN:GetPlayerName(pn) == "" and ToEnumShortString(pn) or PROFILEMAN:GetPlayerName(pn) 
                    if not favs:find("^---") then
                        listofavorites[1] = {
                            Name = ("%s's Favorites\n"):format(profileName),
                            Songs = {}
                        }
                    end

                    for line in favs:gmatch("[^\r\n]+") do
                        if line:find("^---") then
                            listofavorites[#listofavorites + 1] = {
                                Name = line:gsub("---", ""),
                                Songs = {}
                            }
                        else
                            listofavorites[#listofavorites].Songs[#listofavorites[#listofavorites].Songs + 1] = {
                                Path = line,
                                Title = SONGMAN:FindSong(line) and SONGMAN:FindSong(line):GetDisplayMainTitle() or nil
                            }
                            SLFavorites[ToEnumShortString(pn)][#SLFavorites[ToEnumShortString(pn)] + 1] = SONGMAN:FindSong(line)
                        end
                    end

                    for i = 1, #listofavorites do
                        table.sort(listofavorites[i].Songs, function(a, b)
                            if a.Title == nil then
                                return false
                            elseif b.Title == nil then
                                return true
                            end
                            return a.Title:lower() < b.Title:lower()
                        end)
                    end

                    for fav, _ in ivalues(listofavorites) do
                        strToWrite = strToWrite .. ("---%s\n"):format(fav.Name)
                        for song, i in ivalues(fav.Songs) do
                            strToWrite = strToWrite .. ("%s\n"):format(song.Path)
                        end
                    end
                end
            end
            if isOutFox() and not isOutFoxV() then setOFFavorites(pn) end

            if strToWrite ~= "" then
                local path = getSLFavoritesPath(pn)
                local file = RageFileUtil.CreateRageFile()
                if file:Open(path, 2) then
                    loadPlayer = pn
                    check = check + 1
                    file:Write(strToWrite)
                    file:Close()
                    file:destroy()
                end
            end
        end
    end
    if check == 2 then
        SLCombine()
	elseif check == 1 then
        if isITGmania() then
            SONGMAN:SetPreferredSongs(getSLFavoritesPath(loadPlayer), true)
        else
            SL2Other(ToEnumShortString(loadPlayer),getSLFavoritesPath(loadPlayer))
        end
    end
end

function addOrRemoveFavorite(player)
    if GAMESTATE:GetCurrentSong() then
		local path = getSLFavoritesPath(player)
        local songDir = GAMESTATE:GetCurrentSong():GetSongDir()
        local arr = split("/", songDir)
        songDir = arr[3] .. "/" .. arr[4]
        local favoritesString = lua.ReadFile(path) or ""

        if not PROFILEMAN:IsPersistentProfile(player) then
            favoritesString = ""
        elseif favoritesString then
			local songTitle = GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
			local profileName = PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)
            if string.match(favoritesString, strPlainText(arr[3] .. "/" .. arr[4]) .. "\n") then
                favoritesString = string.gsub(favoritesString, strPlainText(arr[3] .. "/" .. arr[4]) .. "\n", "")
                if SONGMAN:FindSong(songDir) then
                    local song = SONGMAN:FindSong(songDir)
                    local foundIndex = FindInTable(song, SLFavorites[ToEnumShortString(player)])
                    table.remove(SLFavorites[ToEnumShortString(player)], foundIndex)
                end
                SCREENMAN:SystemMessage(songTitle .. " removed from " .. profileName .. "'s Favorites.")
            else
                favoritesString = favoritesString .. arr[3] .. "/" .. arr[4] .. "\n";
                SCREENMAN:SystemMessage(songTitle .. " added to " .. profileName .. "'s Favorites.")
            end
        end

        local file = RageFileUtil.CreateRageFile()
        if file:Open(path, 2) then
            file:Write(favoritesString)
            file:Close()
            file:destroy()
        end

        generateFavoritesForMusicWheel()
    end
end