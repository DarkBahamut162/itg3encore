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
	},
	Def.ActorFrame{
		Name="Mask",
		InitCommand=function(self) self:Center() end,
		Def.Sprite {
			Texture = THEME:GetPathG("","MapController Mask"),
			InitCommand=function(self) self:addy(40*WideScreenDiff()):zoom(WideScreenDiff()):zwrite(true):z(1):blend("BlendMode_NoEffect") end
		},
	},
	Def.BitmapText{
		Font="_r bold 30px",
		Text="P1 slots",
		OnCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-155*WideScreenDiff()):halign(0):zoom(0.7*WideScreenDiff()):shadowlength(1):diffuse(PlayerColor(PLAYER_1)) end,
		OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
	},
	Def.BitmapText{
		Font="_r bold 30px",
		Text="P2 slots",
		OnCommand=function(self) self:xy(SCREEN_CENTER_X+272*WideScreenDiff(),SCREEN_CENTER_Y-155*WideScreenDiff()):halign(1):zoom(0.7*WideScreenDiff()):shadowlength(1):diffuse(PlayerColor(PLAYER_2)) end,
		OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
	}
}