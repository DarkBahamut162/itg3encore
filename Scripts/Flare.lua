flareNew = {
    {0,   10,  50, 150},
    {0,   11,  55, 300},
    {0,   12,  60, 450},
    {0,   29, 145,1100},
    {0,   74, 370,1600},
    {0,   92, 460,1800},
    {0,  128, 640,2200},
    {0,  164, 820,2600},
    {0,  200,1000,3000},
    {100,200,1000,3000}
}
flareOld = {
    {0,   20, 100,1000},
    {0,   29, 145,1100},
    {0,   38, 190,1200},
    {0,   56, 280,1400},
    {0,   74, 370,1600},
    {0,   92, 460,1800},
    {0,  128, 640,2200},
    {0,  164, 820,2600},
    {0,  200,1000,3000},
    {100,200,1000,3000}
}
flareColor = {
    '#00008b',
    '#add8e6',
    '#008000',
    '#ffff00',
    '#ff0000',
    '#800080',
    '#a9a9a9',
    '#c0c0c0',
    '#d4af37',
    'rainbow'
}
flareName = {'I','II','III','IV','V','VI','VII','VIII','IX','X'}

local ProfileSlot = {
    [PLAYER_1] = "ProfileSlot_Player1",
    [PLAYER_2] = "ProfileSlot_Player2",
    ["Machine"] = "ProfileSlot_Machine",
}

local Flares = {}

function getFlares(player)
    return Flares[player] or {}
end

local function getFlaresPath(player)
    return PROFILEMAN:GetProfileDir(ProfileSlot[player]) .. "flares.ini"
end

local function FlareGroup(Song)
    return string.gsub(string.gsub(Song:GetGroupName(), '%[', '<'), '%]', '>')
end

local function FlareStep(Step)
	local filename = split("/",Step:GetFilename())
	local songName = filename[#filename-1]
	local identifier = Step:GetHash()
	if identifier == 0 then identifier = Step:GetMeter() end

    return string.format(
        '%s_%s_%s_%s',
        songName,
        ToEnumShortString(Step:GetStepsType()),
        ToEnumShortString(Step:GetDifficulty()),
        identifier
    )
end

function GetFlare(player,Song,Steps)
    if not Flares[player] then return 0 end
    local group = FlareGroup(Song)
    if not Flares[player][group] then return 0 end
    local step = FlareStep(Steps)
    if not Flares[player][group][step] then
        return 0
    else
        return Flares[player][group][step]
    end
end

function LoadFlare(player)
    local path = getFlaresPath(player)
    if path and FILEMAN:DoesFileExist(path) then Flares[player] = IniFile.ReadFile(path) end
end

function UpdateFlare(Song,Steps,level,player)
    if not Flares[player] then Flares[player] = {} end
    local group = FlareGroup(Song)
    if not Flares[player][group] then Flares[player][group] = {} end
    local step = FlareStep(Steps)
    if not Flares[player][group][step] then
        Flares[player][group][step] = level
        return true
    elseif Flares[player][group][step] < level then
        Flares[player][group][step] = level
        return true
    end
    return false
end

function SaveFlare(player)
    local path = getFlaresPath(player)
    IniFile.WriteFile(path, Flares[player])
    if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
end