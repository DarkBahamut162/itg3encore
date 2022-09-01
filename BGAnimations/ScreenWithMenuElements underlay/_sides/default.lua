return Def.ActorFrame{
	LoadActor("left")..{
		InitCommand=function(self) self:x(SCREEN_LEFT-50):CenterY():halign(0) end,
		OnCommand=function(self) self:sleep(0.2):decelerate(0.6):x(SCREEN_LEFT) end,
		OffCommand=function(self) self:accelerate(0.4):addx(-100) end
	},
	LoadActor("right")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT+50):CenterY():halign(1) end,
		OnCommand=function(self) self:sleep(0.2):decelerate(0.6):x(SCREEN_RIGHT) end,
		OffCommand=function(self) self:accelerate(0.4):addx(100) end
	}
}