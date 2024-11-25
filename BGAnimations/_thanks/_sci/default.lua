return Def.ActorFrame{
	InitCommand=function(self) self:ztest(true):zoom(0.5) end,
	Def.Sprite {
		Texture = "base",
		InitCommand=function(self) self:ztest(true) end
	},
	Def.Sprite {
		Texture = "SPAECESHIPLOL",
		InitCommand=function(self) self:ztest(true):addx(-76):addy(-25) end,
		OnCommand=function(self) self:spin(1):effectmagnitude(0,0,50):effectperiod(1) end
	}
}