function Unlock(Title)
    if isEtterna("0.55") then return end
    local id = UNLOCKMAN:FindEntryID(Title)
    if id then UNLOCKMAN:UnlockEntryID(id) end

	local s = SONGMAN:FindSong(Title)
	if not s then return else GAMESTATE:SetPreferredSong(s) end

	if id then
		if not s then setenv("UnlockName","Unknown Song") else setenv("UnlockName",s:GetDisplayFullTitle()) end
		MESSAGEMAN:Broadcast("UnlockEntered")
	end

	SOUND:DimMusic(0.2,5)

	local Path = THEME:GetPathS("Unlocked",s and s:GetDisplayFullTitle() or Title)
	local Bleep = THEME:GetPathS('',"bleep")
	SOUND:PlayOnce(Bleep)
	SOUND:PlayOnce(Path)
end

local unlocks = {
    {"ITG1_01","In The Groove/Disconnected -Hyper-"},
    {"ITG1_02","In The Groove/Disconnected -Mobius-"},
    {"ITG1_03","In The Groove/Infection"},
    {"ITG1_04","In The Groove/Xuxa"},
    {"ITG1_05","In The Groove/Tell"},
    {"ITG1_06","In The Groove/Bubble Dancer"},
    {"ITG1_07","In The Groove/Don't Promise Me"},
    {"ITG1_08","In The Groove/Anubis"},
    {"ITG1_09","In The Groove/DJ Party"},
    {"ITG1_10","In The Groove/Pandemonium"},
    {"ITG2_01","In The Groove 2/Disconnected Disco"},
    {"ITG2_02","In The Groove 2/Vertex^2"},
    {"ITG2_03","In The Groove 2/Wanna Do"},
    {"ITG2_04","In The Groove 2/Know Your Enemy"},
    {"ITG2_05","In The Groove 2/Hardcore Symphony"},
    {"ITG3_01","In The Groove 3 Unlocks/Atom Bomb"},
    {"ITG3_02","In The Groove 3 Unlocks/Blue"},
    {"ITG3_03","In The Groove 3 Unlocks/Chaos Energy"},
    {"ITG3_04","In The Groove 3 Unlocks/Coming Alive"},
    {"ITG3_05","In The Groove 3 Unlocks/Cosmic Unconsciousness"},
    {"ITG3_06","In The Groove 3 Unlocks/Dance Vibrations -Millennium Remix-"},
    {"ITG3_07","In The Groove 3 Unlocks/Elder God Shrine"},
    {"ITG3_08","In The Groove 3 Unlocks/Hava Nagila"},
    {"ITG3_09","In The Groove 3 Unlocks/In The Groove"},
    {"ITG3_10","In The Groove 3 Unlocks/Love Eternal"},
    {"ITG3_11","In The Groove 3 Unlocks/Lover on the Run"},
    {"ITG3_12","In The Groove 3 Unlocks/Shamrock Shebang"},
    {"ITG3_13","In The Groove 3 Unlocks/Shooting Star"},
    {"ITG3_14","In The Groove 3 Unlocks/Take me Back -2007 Re-Edit-"},
    {"ITG3_15","In The Groove 3 Unlocks/What You Gonna Do"},
    {"ITG3_16","In The Groove 3 Unlocks/Wild Thing"}
}

function UnlockNames(code)
    local list = code and "OkayEnding,GoodEnding,PerfectEnding" or ""
    if not isEtterna("0.55") then
        for entry in ivalues(unlocks) do
            if SONGMAN:FindSong(entry[2]) then
                list = addToOutput(list,entry[1],",")
            end
        end
    end
    return list
end