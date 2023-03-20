return Def.ActorFrame{
	OnCommand=function(self) if isOutFox() then GAMESTATE:UpdateDiscordScreenInfo("Selecting Style","",1) end end,
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenSemiDiff()):y(SCREEN_CENTER_Y+13*WideScreenSemiDiff()):z(-100):zoom(1.3*WideScreenDiff()) end,
		LoadActor("char")..{
			InitCommand=function(self) self:zoom(0.5):glow(color("1,1,1,0")):diffusealpha(0):linear(0.3):glow(color("1,1,1,1")):sleep(0.001):diffusealpha(1):linear(0.3):glow(color("1,1,1,0")) end,
			MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
			MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
			GoOffCommand=function(self) self:sleep(0.2):linear(0.3):diffusealpha(0) end
		}
	},
	LoadActor(THEME:GetPathG("explanation","frame"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+130):zoom(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1.0) end,
		MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
		MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
		GoOffCommand=function(self) self:sleep(0.2):linear(0.3):diffusealpha(0) end
	},
	LoadActor(THEME:GetPathB("_shared","underlay arrows")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/fore"))
}