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

if FILEMAN:DoesFileExist("Save/Keymaps.ini") then
	local keys = IniFile.ReadFile("Save/Keymaps.ini")
	local altAvailable = {true,true}
	local ctrlAvailable = {true,true}
	local shiftAvailable = {true,true}
	if keys[GAMESTATE:GetCurrentGame():GetName()] then
		for key, value in pairs(keys[GAMESTATE:GetCurrentGame():GetName()]) do
			if string.find(value,"alt") then if string.find(value,"left") then altAvailable[1] = false else altAvailable[2] = false end end
			if string.find(value,"ctrl") then if string.find(value,"left") then ctrlAvailable[1] = false else ctrlAvailable[2] = false end end
			if string.find(value,"shift") then if string.find(value,"left") then shiftAvailable[1] = false else shiftAvailable[2] = false end end
		end
	end

	local err = ""
	if not altAvailable[1] then err = addToOutput(err,"LEFT ALT"," & ") end
	if not altAvailable[2] then err = addToOutput(err,"RIGHT ALT"," & ") end
	if not ctrlAvailable[1] then err = addToOutput(err,"LEFT CTRL"," & ") end
	if not ctrlAvailable[2] then err = addToOutput(err,"RIGHT CTRL"," & ") end
	if not shiftAvailable[1] then err = addToOutput(err,"LEFT SHIFT"," & ") end
	if not shiftAvailable[2] then err = addToOutput(err,"RIGHT SHIFT"," & ") end
	if err ~= "" then
		SCREENMAN:SystemMessage("These keys have been mapped elsewhere: "..err.."\nPlease check the \"Config Key/Joy Mappings\" options or the \"Save\\Keymaps.ini\" file!")
	end
end

if isOutFox(20220900) and not isOutFox(20230400) then
	if "glad" == string.lower(split(',',PREFSMAN:GetPreference('VideoRenderers'))[1]) then
		SCREENMAN:SystemMessage("Please switch your VideoRenderer!\nGLAD is bugged in this version of OutFox!")
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