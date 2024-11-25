return Def.ActorFrame{
	Def.Quad{ InitCommand=function(self) self:zoomto(2,14):diffuse(color("#000000")) end },
	Def.Sprite {
		Texture = "back",
	},
	Def.Sprite {
		Texture = "back",
		OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#000000")):effectperiod(0.3) end
	}
}