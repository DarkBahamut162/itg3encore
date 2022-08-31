return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop")),
	Def.ActorFrame{
		Name="Page",
		InitCommand=function(self) self:Center() end,
		LoadActor(THEME:GetPathG("_mapcontrollers","page")),
		LoadActor(THEME:GetPathG("_mapcontrollers","line"))..{
			Name="LeftLine",
			InitCommand=function(self) self:x(-64):y(-25) end
		},
		LoadActor(THEME:GetPathG("_mapcontrollers","line"))..{
			Name="RightLine",
			InitCommand=function(self) self:x(64):y(-25) end
		}
	}
}