local ProfileSlot = {
    [PLAYER_1] = "ProfileSlot_Player1",
    [PLAYER_2] = "ProfileSlot_Player2"
}

local DATA = { [PLAYER_1] = {}, [PLAYER_2] = {} }
local category = GAMESTATE:GetCurrentGame():GetName()

function SetCategory(new) category = new end

function GetData(player)
    if DATA[player] and DATA[player][category] then
        if type(DATA[player][category]["LV"]) == "string" then DATA[player][category]["LV"] = tonumber(DATA[player][category]["LV"]) end
        if type(DATA[player][category]["EXP"]) == "string" then DATA[player][category]["EXP"] = tonumber(DATA[player][category]["EXP"]) end
    else
        DATA[player][category] = { ["LV"] = 1, ["EXP"] = 0 }
    end
    return DATA[player][category]
end

local function GetDataPath(player)
    return PROFILEMAN:GetProfileDir(ProfileSlot[player]) .. "DATA.ini"
end

function LoadData(player)
    local path = GetDataPath(player)
    if path and FILEMAN:DoesFileExist(path) then DATA[player] = IniFile.ReadFile(path) end
end

function UpdateData(player,data)
    if data then
        DATA[player][category] = data
        return true
    end
    return false
end

function SaveData(player)
    local path = GetDataPath(player)
    IniFile.WriteFile(path, DATA[player])
    if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
end