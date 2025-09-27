return Def.ActorFrame{
	OnCommand=function(self) if isOutFox(20200500) then GAMESTATE:UpdateDiscordScreenInfo("Selecting PlayMode","",1) end end,
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/back"))(),
	loadfile(THEME:GetPathB("_shared","underlay arrows"))(),
	Def.Sprite {
		Texture = THEME:GetPathG("explanation","frame"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-102*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+120*WideScreenSemiDiff()):zoom(WideScreenDiff_(16/10)):diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1.0) end,
		MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
		MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
		GoOffCommand=function(self) self:linear(0.5):diffusealpha(0) end
	},
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/fore"))()
}