return Def.ActorFrame{
	Def.ActorFrame{
		Name="ModsList";
		InitCommand=cmd(x,SCREEN_RIGHT-20;y,SCREEN_BOTTOM-200;);
		OnCommand=cmd(sleep,26;linear,6;y,SCREEN_TOP+200);
		LoadFont("_v credit")..{
			Text=GetRandomModifierNames(23);
			InitCommand=cmd(horizalign,right;zoom,0.8;diffusealpha,0;);
			OnCommand=cmd(sleep,26.5;linear,0.5;diffusealpha,0.3;linear,3;linear,0.5;diffusealpha,0.0);
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(CenterX;y,SCREEN_TOP+100;rotationz,3;);
		OnCommand=cmd(sleep,26;linear,6;addx,-10;addy,5);
		LoadActor(THEME:GetPathB("ScreenIntro","background/red"))..{
			InitCommand=cmd(x,SCREEN_RIGHT+SCREEN_WIDTH*2;zoomto,SCREEN_WIDTH*1.5,100;);
			OnCommand=cmd(sleep,26;linear,0.5;fadeleft,0.3;faderight,0.3;x,50;linear,4;addx,-100;accelerate,0.5;addx,-SCREEN_WIDTH*2);
		};
		LoadActor("mods")..{
			InitCommand=cmd(x,-100;zoom,.8;diffusealpha,0;);
			OnCommand=cmd(sleep,26.5;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
		};
	};

	Def.ActorFrame{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+150;);
		LoadActor(THEME:GetPathB("ScreenIntro","background/swoosh"))..{
			InitCommand=cmd(zoomtowidth,SCREEN_WIDTH;zoomy,-1;y,-10;blend,Blend.Add;cropleft,1;fadeleft,1;);
			OnCommand=cmd(sleep,26;linear,0.5;cropleft,0;fadeleft,0;sleep,4;linear,0.5;diffusealpha,0.0;addx,50;cropright,1;faderight,1;);
		};
		Def.ActorFrame{
			OnCommand=cmd(sleep,26;linear,6;addx,20;);
			LoadActor("60")..{
				InitCommand=cmd(x,-75;y,-80;diffusealpha,0;);
				OnCommand=cmd(sleep,26.5;linear,0.5;diffusealpha,1;sleep,4;linear,0.5;diffusealpha,0.0);
			};
		};
	};
};