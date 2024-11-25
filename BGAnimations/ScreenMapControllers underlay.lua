return Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop"))(),
	Def.ActorFrame{
		Name="Page",
		InitCommand=function(self) self:Center() end,
		Def.Sprite {
			Texture = THEME:GetPathG("_mapcontrollers","page"),
			InitCommand=function(self) self:zoom(WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_mapcontrollers","line"),
			Name="LeftLine",
			InitCommand=function(self) self:x(-64*WideScreenDiff()):y(-25*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_mapcontrollers","line"),
			Name="RightLine",
			InitCommand=function(self) self:x(64*WideScreenDiff()):y(-25*WideScreenDiff()):zoom(WideScreenDiff()) end
		}
	}
}