local pm = GAMESTATE:GetPlayMode()

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))..{
		OnCommand=function(self) self:playcommand("DoOff"):finishtweening():playcommand("Slow"):queuecommand("DoOn") end;
		SlowCommand=function(self) self:SetUpdateRate(1.5) end;
	};
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))..{
		OnCommand=function(self) self:playcommand("DoOff"):finishtweening():playcommand("Slow"):queuecommand("DoOn") end;
		SlowCommand=function(self) self:SetUpdateRate(1.5) end;
	};
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_top"))..{
		OnCommand=function(self) self:playcommand("DoOff"):finishtweening():playcommand("Slow"):queuecommand("DoOn") end;
		SlowCommand=function(self) self:SetUpdateRate(1.5) end;
	};

	LoadActor("../ScreenEvaluation underlay/evaluation banner mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135):zbuffer(true):blend('BlendMode_NoEffect'):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(2.8):diffusealpha(1) end;
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
	};

	Def.ActorFrame{
		Name="LabelFrame";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-142) end;
		
		LoadFont("_v 26px bold shadow")..{
			Text="TIME & DATE";
			SetCommand=function(self) self:settext( string.format('%02i:%02i:%02i %s %02i %04i', Hour(), Minute(), Second(), MonthToString(MonthOfYear()), DayOfMonth(), Year()) ) end;
			InitCommand=function(self) self:y(-48):shadowlength(2):horizalign(center):zoom(0.5):playcommand("Set") end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		};
	};

	Def.ActorFrame{
		LoadActor("frame")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-30):zoomx(0.80):zoomy(1.005):addy(SCREEN_HEIGHT) end;
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addy(-SCREEN_HEIGHT) end;
			OffCommand=function(self) self:accelerate(0.3):addy(SCREEN_HEIGHT) end;
		};
		LoadActor("base frame")..{
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-27):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")-32):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadActor("base frame")..{
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+27):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")-32):zoomx(-1):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
	};

	Def.ActorFrame{
		LoadFont("_v 26px bold shadow")..{
			Text="FANTASTIC";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*0):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.51):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="EXCELLENT";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*1):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="GREAT";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*2):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="DECENT";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*3):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="WAY OFF";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*4):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MISS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*5):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*6):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*7):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MINES";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*8):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*9):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*10):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MAX COMBO";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269):y(SCREEN_CENTER_Y-108+16.5*11):horizalign(left):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
	};

	Def.ActorFrame{
		LoadFont("_v 26px bold shadow")..{
			Text="FANTASTIC";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*0):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.51):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="EXCELLENT";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*1):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="GREAT";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*2):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="DECENT";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*3):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="WAY OFF";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*4):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MISS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*5):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*6):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*7):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MINES";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*8):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*9):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*10):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MAX COMBO";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+93):y(SCREEN_CENTER_Y-108+16.5*11):horizalign(left):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:zoomx(0.65):zoomy(0.5):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
	};

	LoadFont("_angel glow")..{
		Text="Song Title";
		InitCommand=function(self) self:x(SCREEN_CENTER_X-300):halign(0):y(SCREEN_TOP+74,animate,0):maxwidth(700):zoom(0.6):shadowlength(0):playcommand("Update") end;
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.3):diffusealpha(1) end;
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		UpdateCommand=function(self) 
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
			local text = ""
			if song then
				text = song:GetDisplayFullTitle()
			end
			if course then
				text = course:GetDisplayFullTitle();
			end
		
			self:settext( text )
		end;
	};
};

return t;