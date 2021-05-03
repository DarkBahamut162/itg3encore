-- ScreenSelectStyle Icon Choice2
return Def.ActorFrame{
	LoadFont("_r bold glow 30px")..{
		Text="Two Players, each use 4 Panels";
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+138;zoom,.68;maxwidth,840;horizalign,center;shadowlength,0);
		GainFocusCommand=cmd(visible,true;finishtweening;cropright,1;linear,0.5;cropright,0);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.3;diffusealpha,0);
	};
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_LEFT+65;y,SCREEN_CENTER_Y-95+240;horizalign,left);
		LoadActor(THEME:GetPathG("_join","icons/versus_icon"))..{
			GainFocusCommand=cmd(accelerate,0.1;diffuse,color("#FFFFFF");x,SCREEN_LEFT+65);
			LoseFocusCommand=cmd(finishtweening;decelerate,0.1;diffuse,color("#636363");x,SCREEN_LEFT+46);
			OffFocusCommand=cmd(accelerate,0.4;addx,-SCREEN_WIDTH*.5);
		};
		LoadActor(THEME:GetPathG("_join","icons/styleglow"))..{
			InitCommand=cmd(blend,Blend.Add);
			GainFocusCommand=cmd(accelerate,0.1;diffusealpha,1;x,SCREEN_LEFT+65;sleep,.07;linear,.2;diffusealpha,0);
			LoseFocusCommand=cmd(finishtweening;decelerate,0.1;x,SCREEN_LEFT+46;diffusealpha,0);
			OffFocusCommand=cmd(accelerate,0.4;addx,-SCREEN_WIDTH*.5);
		};
	};
	LoadActor(THEME:GetPathG("","blueflare"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y-40;blend,Blend.Add;diffusealpha,0);
		GainFocusCommand=cmd(finishtweening;zoom,0;diffusealpha,0;zoomx,7;zoomy,4;diffusealpha,1;linear,.2;zoomy,0;diffusealpha,0);
		LoseFocusCommand=cmd(diffusealpha,0);
		OffCommand=cmd(diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("","blueflare"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y-40;blend,Blend.Add;diffusealpha,0);
		GainFocusCommand=cmd(finishtweening;zoom,0;diffusealpha,0;zoomx,7;zoomy,4;diffusealpha,1;linear,.4;zoomy,0;diffusealpha,0);
		LoseFocusCommand=cmd(diffusealpha,0);
		OffCommand=cmd(diffusealpha,0);
	};
};