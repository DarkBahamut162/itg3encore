if isOutFoxV(20231017) and not PREFSMAN:GetPreference("GimmickMode") then
	PREFSMAN:SetPreference("GimmickMode", 1)
	GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
end

if isOutFoxV() and PREFSMAN:PreferenceExists("KeySoundMode") then
	local KeySoundMode = PREFSMAN:GetPreference("KeySoundMode")
	if KeySoundMode ~= "Auto" then PREFSMAN:SetPreference("KeySoundMode", "Auto") end
end

if isOldStepMania() or (isITGmania() and not VersionDateCheck(20240507)) or (isEtterna() and not EtternaVersionCheck("0.70.99")) then
	local IgnoredDialogs = PREFSMAN:GetPreference("IgnoredDialogs")
	if not string.find(IgnoredDialogs,"FRAME_DIMENSIONS_WARNING") then
		IgnoredDialogs = addToOutput(IgnoredDialogs,"FRAME_DIMENSIONS_WARNING",",")
		PREFSMAN:SetPreference("IgnoredDialogs", IgnoredDialogs)
		GAMEMAN:SetGame(GAMESTATE:GetCurrentGame():GetName(),THEME:GetCurThemeName())
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