return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
		InitCommand=cmd(zoom,.8;diffusealpha,0;);
		OnCommand=cmd(sleep,.2;linear,.4;diffusealpha,1;zoom,1;sleep,1.5;);
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
		InitCommand=cmd(blend,Blend.Add;zoom,1;diffusealpha,0;);
		OnCommand=cmd(sleep,.4;accelerate,.3;diffusealpha,.4;linear,1.8;zoom,1.4;diffusealpha,0;);
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/light"))..{
		InitCommand=cmd(y,10;blend,Blend.Add;zoom,1;cropright,1.2;cropleft,-0.2;);
		OnCommand=cmd(linear,1;cropright,-0.2;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;sleep,.4;linear,0.7;cropleft,1;cropright,-0.3;sleep,0.5;);
	};
	LoadFont("_v 26px bold shadow")..{
		Text="www.inthegroove3.com";
		InitCommand=cmd(x,0;y,115;shadowlength,2;diffusealpha,0;);
		OnCommand=cmd(sleep,1;linear,0.5;diffusealpha,1);
	};
};