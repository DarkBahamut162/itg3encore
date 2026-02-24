if isOutFoxV(20231017) and not PREFSMAN:GetPreference("GimmickMode") then
	PREFSMAN:SetPreference("GimmickMode", 1)
	GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
end

if isOutFoxV() and PREFSMAN:PreferenceExists("KeySoundMode") then
	local KeySoundMode = PREFSMAN:GetPreference("KeySoundMode")
	if KeySoundMode ~= "Auto" then PREFSMAN:SetPreference("KeySoundMode", "Auto") end
end

if isOldStepMania() and not VersionDateCheck(20160000) then
	local IgnoredDialogs = PREFSMAN:GetPreference("IgnoredDialogs")
	if not string.find(IgnoredDialogs,"LUA_ERROR") then
		IgnoredDialogs = addToOutput(IgnoredDialogs,"LUA_ERROR",",")
		PREFSMAN:SetPreference("IgnoredDialogs", IgnoredDialogs)
		GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
	end
end

if isOldStepMania() or isStepMania(20250000) or (isITGmania() and not VersionDateCheck(20240507)) or (not isEtterna("0.71")) then
	local IgnoredDialogs = PREFSMAN:GetPreference("IgnoredDialogs")
	if not string.find(IgnoredDialogs,"FRAME_DIMENSIONS_WARNING") then
		IgnoredDialogs = addToOutput(IgnoredDialogs,"FRAME_DIMENSIONS_WARNING",",")
		PREFSMAN:SetPreference("IgnoredDialogs", IgnoredDialogs)
		GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
	end
end

if isOutFox(20220900) and not isOutFox(20230400) then
	if "glad" == string.lower(split(',',PREFSMAN:GetPreference('VideoRenderers'))[1]) then
		SCREENMAN:SystemMessage("Please switch your VideoRenderer!\nGLAD is bugged in this version of OutFox!")
	end
end

if isITGmania() then CheckThemeVersion() end

local path = "Save/DefaultLuaModifiers.ini"
local file = {
	LuaOptions = {
		Rotation = 1,

		Flare = 0,
		FlareFloat = 0,
		FlareType = 1,
		FlareAccurate = false,

		Effect = 0,

		HideScore = false,
		HideJudgment = false,
		HideCombo = false,
		HideLife = false,

		UnderCombo = false,
		UnderTapJudgments = false,
		UnderHoldJudgments = false,

		ShowMovePlayerfieldStats = 3,
		SetScoreType = 2,
		ErrorBar = 0,
		ShowColumns = 0,
		SetScoreDirection = 1,
		SetScoreFA = false,
		ScreenFilter = 0,

		ShowStats = 0,
		ShowStatsSize = 1,
		ShowStatsPos = 0,
		PlayerNoteGraph = 1,
		PlayerNoteGraphType = 2,
		PlayerNoteGraphRange = 1,
		PlayerNoteGraphData = false,
		SetPacemaker = 0,
		SetPacemakerFail = 0,

		ShowMods = false,
		ShowSpeedAssist = false,
		ShowStopAssist = false,
		SongFrame = "_normal",
		HoldJudgment = "_itg3",
		Judgment = "_itg3",
		GreenNumber = false,

		IIDXFrame = "_random",
		IIDXDouble = false,
		IIDXJudgment = "default",
		IIDXNote = "default",
		IIDXNoteLength = "normal",
		IIDXBeam = "default",
		IIDXBeamLength = "normal",
		IIDXTurntable = "_default",
		IIDXExplosion ="_default"
	}
}

if not FILEMAN:DoesFileExist(path) then
	IniFile.WriteFile(path, file)
	if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
else
	local loaded = IniFile.ReadFile("Save/DefaultLuaModifiers.ini")
	local missing = false
	for key,value in pairs(file["LuaOptions"]) do
		if loaded["LuaOptions"][key] == nil then
			loaded["LuaOptions"][key] = file["LuaOptions"][key]
			missing = true
		end
	end
	if missing then
		lua.ReportScriptError("MISSING")
		IniFile.WriteFile(path, loaded)
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
	end
end

return Def.ActorFrame{
	Def.Sprite {
		Texture="roxor video",
		Condition=not isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture="bga",
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture="particle",
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen():blend(Blend.Add) end
	},
	Def.Sprite {
		Texture="roxor logo",
		Condition=isFinal(),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoomtowidth(SCREEN_WIDTH/5*4):zoomtoheight(SCREEN_HEIGHT/2) end
	}
}