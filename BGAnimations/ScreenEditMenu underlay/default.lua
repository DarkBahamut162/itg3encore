return Def.ActorFrame{
	Def.Sprite {
		Texture = "main",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-32*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = "explanation",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+138*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay"))()
}