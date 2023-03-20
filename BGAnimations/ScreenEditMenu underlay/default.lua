return Def.ActorFrame{
	LoadActor("main")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-32*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	LoadActor("explanation")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+138*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay"))
}