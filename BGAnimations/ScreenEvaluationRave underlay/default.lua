return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop")),
	LoadActor("../ScreenEvaluation underlay/evaluation banner mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135):zoom(WideScreenDiff()):zbuffer(true):blend(Blend.NoEffect):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(2.8):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		LoadActor("frame")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-30*WideScreenDiff()):zoomx(0.80*WideScreenDiff()):zoomy(1.005*WideScreenDiff()):addy(SCREEN_HEIGHT) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addy(-SCREEN_HEIGHT) end,
			OffCommand=function(self) self:accelerate(0.3):addy(SCREEN_HEIGHT) end
		},
		LoadActor("base frame "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-27):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")-32*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadActor("base frame "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+27):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")-32*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		}
	},
	Def.ActorFrame{
		LoadFont("_v 26px bold shadow")..{
			Text="FANTASTIC",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*0)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.51*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="EXCELLENT",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*1)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="GREAT",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*2)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text=GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "TOO EARLY" or "DECENT",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*3)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text=GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*4)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MISS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*5)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*6)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*7)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MINES",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*8)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*9)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*10)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MAX COMBO",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*11)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		}
	},
	Def.ActorFrame{
		LoadFont("_v 26px bold shadow")..{
			Text="FANTASTIC",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*0)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.51*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="EXCELLENT",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*1)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="GREAT",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*2)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text=GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == 'Difficulty_Beginner' and "TOO EARLY" or "DECENT",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*3)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text=GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*4)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MISS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*5)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*6)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*7)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MINES",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*8)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*9)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*10)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MAX COMBO",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93*WideScreenDiff()):y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*11)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		}
	},
	LoadFont("_angel glow")..{
		Text="Song Title",
		InitCommand=function(self) self:x(isFinal() and SCREEN_CENTER_X or SCREEN_CENTER_X-300*WideScreenDiff()):halign(isFinal() and 0.5 or 0):y(SCREEN_CENTER_Y-169*WideScreenDiff()):animate(0):maxwidth(700):zoom(0.6*WideScreenDiff()):shadowlength(0):playcommand("Update") end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end,
		UpdateCommand=function(self)
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if SongOrCourse then self:settext(SongOrCourse:GetDisplayFullTitle()) end
		end
	}
}