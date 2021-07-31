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
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))..{
		OnCommand=function(self) self:playcommand("DoOff"):finishtweening():playcommand("Slow"):queuecommand("DoOn") end;
		SlowCommand=function(self) self:SetUpdateRate(1.5) end;
	};

	LoadActor("evaluation banner mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135):zbuffer(true):blend('BlendMode_NoEffect'):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(2.8):diffusealpha(1) end;
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
	};
	LoadActor("mask")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-200):y(SCREEN_CENTER_Y+151):addx(-EvalTweenDistance()):zbuffer(true):blend('BlendMode_NoEffect') end;
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
	};
	LoadActor("mask")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+200):y(SCREEN_CENTER_Y+151):addx(EvalTweenDistance()):zbuffer(true):blend('BlendMode_NoEffect') end;
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
	};
	LoadActor("light")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-2):y(SCREEN_CENTER_Y-40):diffusealpha(0) end;
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			local pm = GAMESTATE:GetPlayMode()
			local validMode = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Nonstop' or pm == 'PlayMode_Oni')
			self:visible(not doubles and validMode)
		end;
		OnCommand=function(self) self:sleep(3.5):linear(0.8):diffusealpha(1):diffuseramp():effectperiod(2):effectoffset(0.20):effectclock("beat"):effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFFFF")) end;
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
	};
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-34) end;
		LoadActor("modsframe")..{
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		};
		LoadActor("modsframe")..{
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		};
	};
	LoadActor("trapezoid")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-109):shadowlength(2):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(3):linear(0.8):diffusealpha(1) end;
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
	};
	-- custom mods p1/p2
	LoadFont("_v 26px bold shadow")..{
		Text="";
		InitCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_1) then self:settext(DisplayCustomModifiersText(PLAYER_1)) end self:maxwidth(350):zoom(0.5):x(SCREEN_CENTER_X-9-2):y(SCREEN_CENTER_Y+9):horizalign(right):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
	};
	LoadFont("_v 26px bold shadow")..{
		Text="";
		InitCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_2) then self:settext(DisplayCustomModifiersText(PLAYER_2)) end self:maxwidth(350):zoom(0.5):x(SCREEN_CENTER_X+10-2):y(SCREEN_CENTER_Y+9):horizalign(left):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
	};

	-- detail labels
	Def.ActorFrame{
		Name="LabelFrame";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-142) end;

		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS";
			InitCommand=function(self) self:zoomx(0.5):zoomy(0.4):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS";
			InitCommand=function(self) self:y(13*1):zoomx(0.5):zoomy(0.4):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MINES";
			InitCommand=function(self) self:y(13*2):zoomx(0.5):zoomy(0.4):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS";
			InitCommand=function(self) self:y(13*3):zoomx(0.5):zoomy(0.4):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS";
			InitCommand=function(self) self:y(13*4):zoomx(0.5):zoomy(0.4):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold shadow")..{
			Text="PEAK COMBO";
			InitCommand=function(self) self:y(13*5):zoomx(0.5):zoomy(0.4):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end;
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end;
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
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
		LoadActor(THEME:GetPathG("ScreenEvaluation","GradeFrame p1/_graph base"))..{
			InitCommand=function(self) self:player(PLAYER_1):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-55):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")+101):addx(-EvalTweenDistance()) end;
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
		};
		LoadActor(THEME:GetPathG("ScreenEvaluation","GradeFrame p1/_graph base"))..{
			InitCommand=function(self) self:player(PLAYER_2):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+55):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")+101):zoomx(-1):addx(EvalTweenDistance()) end;
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
		};
	};

	LoadFont("_angel glow")..{
		Text="Song Title";
		InitCommand=function(self) self:x(SCREEN_CENTER_X-300):halign(0):y(SCREEN_TOP+74,animate,0):maxwidth(545):zoom(0.6):shadowlength(0):playcommand("Update") end;
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