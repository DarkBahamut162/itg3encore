return Def.ActorFrame{
	InitCommand=function(self) self:ztest(true):zoom(0.5) end,
	LoadActor("base")..{ InitCommand=function(self) self:ztest(true) end },
	LoadActor("SPAECESHIPLOL")..{
		InitCommand=function(self) self:ztest(true):addx(-76):addy(-25) end,
		OnCommand=function(self) self:spin(1):effectmagnitude(0,0,50):effectperiod(1) end
	}
}