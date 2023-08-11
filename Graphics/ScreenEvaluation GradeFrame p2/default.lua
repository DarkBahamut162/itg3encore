return Def.ActorFrame{
	Def.ActorFrame{
		Name="JudgeFrames",
		Def.ActorFrame{
			Name="W1",
			InitCommand=function(self) self:y(-195*WideScreenDiff()) end,
			LoadActor("../ScreenEvaluation GradeFrame p1/_A "..(isFinal() and "Final" or "Normal"))..{
				InitCommand=function(self) self:x(158*WideScreenDiff()):horizalign(left):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.05):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="FANTASTIC",
				InitCommand=function(self) self:x(150*WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W2",
			InitCommand=function(self) self:y(-170*WideScreenDiff()) end,
			LoadActor("../ScreenEvaluation GradeFrame p1/_B "..(isFinal() and "Final" or "Normal"))..{
				InitCommand=function(self) self:x(158*WideScreenDiff()):horizalign(left):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.10):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.1):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="EXCELLENT",
				InitCommand=function(self) self:x(150*WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.75*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W3",
			InitCommand=function(self) self:y(-145*WideScreenDiff()) end,
			LoadActor("../ScreenEvaluation GradeFrame p1/_C "..(isFinal() and "Final" or "Normal"))..{
				InitCommand=function(self) self:x(158*WideScreenDiff()):horizalign(left):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.20):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.15):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="GREAT",
				InitCommand=function(self) self:x(150*WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W4",
			InitCommand=function(self) self:y(-120*WideScreenDiff()) end,
			LoadActor("../ScreenEvaluation GradeFrame p1/_D "..(isFinal() and "Final" or "Normal"))..{
				InitCommand=function(self) self:x(158*WideScreenDiff()):horizalign(left):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.30):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.2):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text=GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == 'Difficulty_Beginner' and "TOO EARLY" or "DECENT",
				InitCommand=function(self) self:x(150*WideScreenDiff()):horizalign(right):maxwidth(120) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W5",
			InitCommand=function(self) self:y(-95*WideScreenDiff()) end,
			LoadActor("../ScreenEvaluation GradeFrame p1/_E "..(isFinal() and "Final" or "Normal"))..{
				InitCommand=function(self) self:x(158*WideScreenDiff()):horizalign(left):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.40):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.25):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text=GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
				InitCommand=function(self) self:x(150*WideScreenDiff()):horizalign(right):maxwidth(115) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="Miss",
			InitCommand=function(self) self:y(-70*WideScreenDiff()) end,
			LoadActor("../ScreenEvaluation GradeFrame p1/_F "..(isFinal() and "Final" or "Normal"))..{
				InitCommand=function(self) self:x(158*WideScreenDiff()):horizalign(left):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
				OnCommand=function(self) self:addx(100):diffusealpha(0):sleep(3.50):bounceend(0.4):addx(-100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.3):bouncebegin(0.4):addx(100):diffusealpha(0) end
			},
			LoadFont("_v 26px bold shadow")..{
				Text="MISS",
				InitCommand=function(self) self:x(150*WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		}
	},
	LoadActor("graph")..{
		InitCommand=function(self) self:x(58*WideScreenDiff()):y(100*WideScreenDiff()):addx(EvalTweenDistance()):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
	LoadActor("../ScreenEvaluation GradeFrame p1/_glass")..{
		InitCommand=function(self) self:diffusealpha(0.2):x(52*WideScreenDiff()):y(100*WideScreenDiff()):addx(EvalTweenDistance()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	}
}