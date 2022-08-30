return Def.ActorFrame{
	Def.ActorFrame{
		Name="JudgeFrames",
		Def.ActorFrame{
			Name="W1",
			InitCommand=function(self) self:y(-195) end,
			LoadActor("_A")..{
				InitCommand=function(self) self:x(158):horizalign(right) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.05):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="FANTASTIC",
				InitCommand=function(self) self:x(150):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8):zoomy(0.6):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W2",
			InitCommand=function(self) self:y(-170) end,
			LoadActor("_B")..{
				InitCommand=function(self) self:x(158):horizalign(right) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.10):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.1):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="EXCELLENT",
				InitCommand=function(self) self:x(150):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.75):zoomy(0.6):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W3",
			InitCommand=function(self) self:y(-145) end,
			LoadActor("_C")..{
				InitCommand=function(self) self:x(158):horizalign(right) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.20):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.15):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="GREAT",
				InitCommand=function(self) self:x(150):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8):zoomy(0.6):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W4",
			InitCommand=function(self) self:y(-120) end,
			LoadActor("_D")..{
				InitCommand=function(self) self:x(158):horizalign(right) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.30):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.2):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="DECENT",
				InitCommand=function(self) self:x(150):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8):zoomy(0.6):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W5",
			InitCommand=function(self) self:y(-95) end,
			LoadActor("_E")..{
				InitCommand=function(self) self:x(158):horizalign(right) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.40):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.25):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="WAY OFF",
				InitCommand=function(self) self:x(150):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8):zoomy(0.6):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="Miss",
			InitCommand=function(self) self:y(-70) end,
			LoadActor("_F")..{
				InitCommand=function(self) self:x(158):horizalign(right) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.50):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.3):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="MISS",
				InitCommand=function(self) self:x(150):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8):zoomy(0.6):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		}
	},
	LoadActor("graphp2")..{
		InitCommand=function(self) self:x(58):y(100):addx(EvalTweenDistance()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
	LoadActor("_glass")..{
		InitCommand=function(self) self:diffusealpha(0.2):x(52):y(100):addx(EvalTweenDistance()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
},