local t = Def.ActorFrame{
	Def.ActorFrame{
		Name="JudgeFrames";
		Def.ActorFrame{
			Name="W1";
			InitCommand=cmd(y,-195;);
			LoadActor("_A")..{
				InitCommand=cmd(x,-156;horizalign,left);
				OnCommand=cmd(addx,-100;diffusealpha,0;sleep,3;bounceend,0.4;addx,100;diffusealpha,1);
				OffCommand=cmd(sleep,.05;bouncebegin,0.4;addx,-100;diffusealpha,0);
			};
			LoadFont("_v 26px bold shadow")..{
				Text="FANTASTIC";
				InitCommand=cmd(x,-150;horizalign,left;);
				OnCommand=cmd(zoomx,0.8;zoomy,.6;diffusebottomedge,color("#BBB9FB");cropright,1.3;faderight,0.1;sleep,3.60;linear,0.7;cropright,-0.3);
				OffCommand=cmd(linear,0.2;diffusealpha,0);
			};
		};
		Def.ActorFrame{
			Name="W2";
			InitCommand=cmd(y,-170;);
			LoadActor("_B")..{
				InitCommand=cmd(x,-156;horizalign,left);
				OnCommand=cmd(addx,-100;diffusealpha,0;sleep,3.10;bounceend,0.4;addx,100;diffusealpha,1);
				OffCommand=cmd(sleep,.1;bouncebegin,0.4;addx,-100;diffusealpha,0);
			};
			LoadFont("_v 26px bold shadow")..{
				Text="EXCELLENT";
				InitCommand=cmd(x,-150;horizalign,left;);
				OnCommand=cmd(zoomx,0.75;zoomy,.6;diffusebottomedge,color("#BBB9FB");cropright,1.3;faderight,0.1;sleep,3.60;linear,0.7;cropright,-0.3);
				OffCommand=cmd(linear,0.2;diffusealpha,0);
			};
		};
		Def.ActorFrame{
			Name="W3";
			InitCommand=cmd(y,-145;);
			LoadActor("_C")..{
				InitCommand=cmd(x,-156;horizalign,left);
				OnCommand=cmd(addx,-100;diffusealpha,0;sleep,3.20;bounceend,0.4;addx,100;diffusealpha,1);
				OffCommand=cmd(sleep,.15;bouncebegin,0.4;addx,-100;diffusealpha,0);
			};
			LoadFont("_v 26px bold shadow")..{
				Text="GREAT";
				InitCommand=cmd(x,-150;horizalign,left;);
				OnCommand=cmd(zoomx,0.8;zoomy,.6;diffusebottomedge,color("#BBB9FB");cropright,1.3;faderight,0.1;sleep,3.60;linear,0.7;cropright,-0.3);
				OffCommand=cmd(linear,0.2;diffusealpha,0);
			};
		};
		Def.ActorFrame{
			Name="W4";
			InitCommand=cmd(y,-120;);
			LoadActor("_D")..{
				InitCommand=cmd(x,-156;horizalign,left);
				OnCommand=cmd(addx,-100;diffusealpha,0;sleep,3.30;bounceend,0.4;addx,100;diffusealpha,1);
				OffCommand=cmd(sleep,.2;bouncebegin,0.4;addx,-100;diffusealpha,0);
			};
			LoadFont("_v 26px bold shadow")..{
				Text="DECENT";
				InitCommand=cmd(x,-150;horizalign,left;);
				OnCommand=cmd(zoomx,.8;zoomy,.6;diffusebottomedge,color("#BBB9FB");cropright,1.3;faderight,0.1;sleep,3.60;linear,0.7;cropright,-0.3);
				OffCommand=cmd(linear,0.2;diffusealpha,0);
			};
		};
		Def.ActorFrame{
			Name="W5";
			InitCommand=cmd(y,-95;);
			LoadActor("_E")..{
				InitCommand=cmd(x,-156;horizalign,left);
				OnCommand=cmd(addx,-100;diffusealpha,0;sleep,3.40;bounceend,0.4;addx,100;diffusealpha,1);
				OffCommand=cmd(sleep,.25;bouncebegin,0.4;addx,-100;diffusealpha,0);
			};
			LoadFont("_v 26px bold shadow")..{
				Text="WAY OFF";
				InitCommand=cmd(x,-150;horizalign,left;);
				OnCommand=cmd(zoomx,.8;zoomy,.6;diffusebottomedge,color("#BBB9FB");cropright,1.3;faderight,0.1;sleep,3.60;linear,0.7;cropright,-0.3);
				OffCommand=cmd(linear,0.2;diffusealpha,0);
			};
		};
		Def.ActorFrame{
			Name="Miss";
			InitCommand=cmd(y,-70;);
			LoadActor("_F")..{
				InitCommand=cmd(x,-156;horizalign,left);
				OnCommand=cmd(addx,-100;diffusealpha,0;sleep,3.50;bounceend,0.4;addx,100;diffusealpha,1);
				OffCommand=cmd(sleep,.3;bouncebegin,0.4;addx,-100;diffusealpha,0);
			};
			LoadFont("_v 26px bold shadow")..{
				Text="MISS";
				InitCommand=cmd(x,-150;horizalign,left;);
				OnCommand=cmd(zoomx,0.8;zoomy,.6;diffusebottomedge,color("#BBB9FB");cropright,1.3;faderight,0.1;sleep,3.60;linear,0.7;cropright,-0.3);
				OffCommand=cmd(linear,0.2;diffusealpha,0);
			};
		};
	};

	LoadActor("graphp1")..{
		InitCommand=cmd(x,-52;y,100;addx,-EvalTweenDistance(););
		OnCommand=cmd(sleep,3;decelerate,0.3;addx,EvalTweenDistance());
		OffCommand=cmd(accelerate,0.3;addx,-EvalTweenDistance());
	};
	LoadActor("mask")..{
		InitCommand=cmd(x,-18;y,93;addx,-EvalTweenDistance();zbuffer,true;blend,'BlendMode_NoEffect');
		OnCommand=cmd(sleep,3;decelerate,0.3;addx,EvalTweenDistance());
		OffCommand=cmd(accelerate,0.3;addx,-EvalTweenDistance());
	};
	LoadActor("_glass")..{
		InitCommand=cmd(diffusealpha,.2;x,-52;y,100;addx,-EvalTweenDistance(););
		OnCommand=cmd(sleep,3;decelerate,0.3;addx,EvalTweenDistance());
		OffCommand=cmd(accelerate,0.3;addx,-EvalTweenDistance());
	};
};

return t;