return Def.ActorFrame{
	OnCommand=function(self) if isOutFox() then GAMESTATE:UpdateDiscordScreenInfo("Selecting PlayMode","",1) end end,
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/back")),
	LoadActor(THEME:GetPathB("_shared","underlay arrows")),
	LoadActor(THEME:GetPathG("explanation","frame"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-102*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+120*WideScreenSemiDiff()):zoom(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1.0) end,
		MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
		MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
		GoOffCommand=function(self) self:linear(0.5):diffusealpha(0) end
	},
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/fore"))
}