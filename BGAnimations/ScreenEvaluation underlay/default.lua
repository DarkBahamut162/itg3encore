local pm = GAMESTATE:GetPlayMode()

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))..{
		OnCommand=cmd(playcommand,"DoOff";finishtweening;playcommand,"Slow";queuecommand,"DoOn");
		SlowCommand=cmd(SetUpdateRate,1.5);
	};
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))..{
		OnCommand=cmd(playcommand,"DoOff";finishtweening;playcommand,"Slow";queuecommand,"DoOn");
		SlowCommand=cmd(SetUpdateRate,1.5);
	};
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))..{
		OnCommand=cmd(playcommand,"DoOff";finishtweening;playcommand,"Slow";queuecommand,"DoOn");
		SlowCommand=cmd(SetUpdateRate,1.5);
	};

	LoadActor("evaluation banner mask")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+135;zbuffer,true;blend,'BlendMode_NoEffect';diffusealpha,0;);
		OnCommand=cmd(sleep,2.8;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
	};
	LoadActor("light")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-2;y,SCREEN_CENTER_Y-40;diffusealpha,0;);
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			local pm = GAMESTATE:GetPlayMode()
			local validMode = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Nonstop' or pm == 'PlayMode_Oni')
			self:visible(not doubles and validMode)
		end;
		OnCommand=cmd(sleep,3.5;linear,0.8;diffusealpha,1;diffuseramp;effectperiod,2;effectoffset,0.20;effectclock,"beat";effectcolor1,color("#FFFFFF00");effectcolor2,color("#FFFFFFFF"););
		OffCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
	};
	Def.ActorFrame{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-34;);
		BeginCommand=function(self)
			self:visible(pm == 'PlayMode_Regular' or pm == 'PlayMode_Nonstop' or pm == 'PlayMode_Oni')
		end;
		LoadActor("modsframe")..{
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
		};
		LoadActor("modsframe")..{
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
		};
	};
	LoadActor("trapezoid")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-109;shadowlength,2;diffusealpha,0;);
		OnCommand=cmd(sleep,3;linear,0.8;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.2;diffusealpha,0);
	};
	-- custom mods p1/p2

	-- detail labels
	Def.ActorFrame{
		Name="LabelFrame";
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-142);

		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS";
			InitCommand=cmd(zoomx,0.5;zoomy,0.4;shadowlength,0;diffusebottomedge,color("#BBB9FB"));
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(linear,0.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS";
			InitCommand=cmd(y,13*1;zoomx,0.5;zoomy,0.4;shadowlength,0;diffusebottomedge,color("#BBB9FB"));
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(linear,0.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold shadow")..{
			Text="MINES";
			InitCommand=cmd(y,13*2;zoomx,0.5;zoomy,0.4;shadowlength,0;diffusebottomedge,color("#BBB9FB"));
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(linear,0.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS";
			InitCommand=cmd(y,13*3;zoomx,0.5;zoomy,0.4;shadowlength,0;diffusebottomedge,color("#BBB9FB"));
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(linear,0.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS";
			InitCommand=cmd(y,13*4;zoomx,0.5;zoomy,0.4;shadowlength,0;diffusebottomedge,color("#BBB9FB"));
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(linear,0.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold shadow")..{
			Text="PEAK COMBO";
			InitCommand=cmd(y,13*5;zoomx,0.5;zoomy,0.4;shadowlength,0;diffusebottomedge,color("#BBB9FB"));
			OnCommand=cmd(diffusealpha,0;sleep,3;linear,0.8;diffusealpha,1);
			OffCommand=cmd(linear,0.2;diffusealpha,0);
		};
	};

	Def.ActorFrame{
		LoadActor(THEME:GetPathG("ScreenEvaluation","GradeFrame p1/_graph base"))..{
			InitCommand=cmd(player,PLAYER_1;x,THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-55;y,THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")+101;addx,-EvalTweenDistance(););
			OnCommand=cmd(sleep,3;decelerate,0.3;addx,EvalTweenDistance());
			OffCommand=cmd(accelerate,0.3;addx,-EvalTweenDistance());
		};
		LoadActor(THEME:GetPathG("ScreenEvaluation","GradeFrame p1/_graph base"))..{
			InitCommand=cmd(player,PLAYER_2;x,THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+55;y,THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")+101;zoomx,-1;addx,EvalTweenDistance(););
			OnCommand=cmd(sleep,3;decelerate,0.3;addx,-EvalTweenDistance());
			OffCommand=cmd(accelerate,0.3;addx,EvalTweenDistance());
		};
	};
};

return t;