return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenGameplay","overlay/demonstration gradient"))..{
		InitCommand=cmd(Center;FullScreen;diffusealpha,0.8);
	};

	LoadFont("_v tutorial")..{
		Text="Colored Arrows\nscroll from\nlow to high.";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4+10;CenterY;addx,SCREEN_WIDTH/2;zoom,1;);
		OnCommand=cmd(sleep,5;decelerate,0.5;addx,-SCREEN_WIDTH/2;sleep,5;linear,0.3;diffusealpha,0);
	};
	LoadActor("focus square")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH/4+26;y,SCREEN_CENTER_Y+60;zoomx,1.0;zoomy,1.05;diffuseblink;effectperiod,0.5;diffusealpha,0;);
		OnCommand=cmd(sleep,6;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
	};

	LoadFont("_v tutorial")..{
		Text="Step when a\nColored Arrow\noverlaps the\nTarget Arrows\nat the top.";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4+10;CenterY;addx,SCREEN_WIDTH;zoom,1;);
		OnCommand=cmd(sleep,11;decelerate,0.5;addx,-SCREEN_WIDTH;sleep,5;linear,0.3;diffusealpha,0);
	};
	LoadActor("focus rect")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-(SCREEN_WIDTH/4)+26;y,SCREEN_CENTER_Y-124;zoomx,1.0;zoomy,0.8;diffuseblink;effectperiod,0.5;diffusealpha,0;);
		OnCommand=cmd(sleep,12;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
	};

	LoadFont("_v tutorial")..{
		Text="The\nTraffic Light\nhelps you\nunderstand\nthe timing.";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4+10;CenterY;addx,SCREEN_WIDTH/2;zoom,1;);
		OnCommand=cmd(sleep,17;decelerate,0.5;addx,-SCREEN_WIDTH/2;sleep,5;linear,0.3;diffusealpha,0);
	};
	LoadActor("focus rect")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-30;zoomx,1.0;zoomy,1;rotationz,90;diffuseblink;effectperiod,0.5;diffusealpha,0;);
		OnCommand=cmd(sleep,18;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
	};

	LoadFont("_v tutorial")..{
		Text="The direction\nof the arrow\nsays which\nPanel\nto step on.";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4+10;CenterY;addx,SCREEN_WIDTH/2;zoom,1;);
		OnCommand=cmd(sleep,23;decelerate,0.5;addx,-SCREEN_WIDTH/2;sleep,5;linear,0.3;diffusealpha,0);
	};
	LoadFont("_v tutorial")..{
		Text="For arrows\nfacing Left,\nstep on the\nLeft Panel.";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4+10;y,SCREEN_CENTER_Y-80;addx,SCREEN_WIDTH/2;zoom,1;);
		OnCommand=cmd(sleep,29;decelerate,0.5;addx,-SCREEN_WIDTH/2;sleep,5;linear,0.3;diffusealpha,0);
	};
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+(SCREEN_WIDTH/4)-100;y,SCREEN_CENTER_Y+80;rotationz,0;glowblink;effectperiod,0.5;diffusealpha,0;);
		OnCommand=cmd(sleep,30;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
	};
	Def.ActorFrame{
		Name="PlatformLeft";
		InitCommand=cmd(x,SCREEN_CENTER_X+210;y,SCREEN_CENTER_Y+80;zoom,0.8;rotationx,-20;fov,45;vanishpoint,SCREEN_CENTER_X+210,SCREEN_CENTER_Y+80);
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/platform"))..{
			InitCommand=cmd(y,7;diffuse,color("0.6,0.6,0.6,0.8");diffusealpha,0;);
			OnCommand=cmd(sleep,30;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
		};
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/panelglow"))..{
			InitCommand=cmd(x,-45;blend,Blend.Add;diffuseblink;effectperiod,0.5;diffusealpha,0;);
			OnCommand=cmd(sleep,30;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
		};
	};

	LoadFont("_v tutorial")..{
		Text="For arrows\nfacing Up,\nstep on the\nUp Panel.";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4+10;y,SCREEN_CENTER_Y-80;addx,SCREEN_WIDTH/2;zoom,1;);
		OnCommand=cmd(sleep,35;decelerate,0.5;addx,-SCREEN_WIDTH/2;sleep,5;linear,0.3;diffusealpha,0);
	};
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+(SCREEN_WIDTH/4)-100;y,SCREEN_CENTER_Y+80;rotationz,90;glowblink;effectperiod,0.5;diffusealpha,0;);
		OnCommand=cmd(sleep,36;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
	};
	Def.ActorFrame{
		Name="PlatformUp";
		InitCommand=cmd(x,SCREEN_CENTER_X+210;y,SCREEN_CENTER_Y+80;zoom,0.8;rotationx,-20;fov,45;vanishpoint,SCREEN_CENTER_X+210,SCREEN_CENTER_Y+80);
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/platform"))..{
			InitCommand=cmd(y,7;diffuse,color("0.6,0.6,0.6,0.8");diffusealpha,0;);
			OnCommand=cmd(sleep,36;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
		};
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/panelglow"))..{
			InitCommand=cmd(y,-45;blend,Blend.Add;diffuseblink;effectperiod,0.5;diffusealpha,0;);
			OnCommand=cmd(sleep,36;linear,0.3;diffusealpha,1;sleep,4;linear,0.3;diffusealpha,0);
		};
	};

	LoadFont("_v profile")..{
		InitCommand=cmd(x,SCREEN_RIGHT-113;y,SCREEN_BOTTOM-75;zoom,.7;maxwidth,300);
		BeginCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text
			if not song then
				text = ""
			else
				text = "Now playing:\n" ..song:GetDisplayFullTitle().."\nby "..song:GetDisplayArtist()
			end
			self:settext(text)
		end;
	};

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,1"););
		OnCommand=cmd(sleep,3.5;linear,0.5;diffusealpha,0);
	};
	Def.ActorFrame{
		LoadActor("instructions")..{
			InitCommand=cmd(Center;cropright,1.3;);
			OnCommand=cmd(linear,1;cropright,-0.3;sleep,2;decelerate,0.5;zoom,0.7;y,SCREEN_TOP+40);
		};
		LoadActor("white instructions")..{
			InitCommand=cmd(Center;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;);
			OnCommand=cmd(linear,1;cropleft,1;cropright,-0.3);
		};
	};
	LoadActor(THEME:GetPathB("ScreenAttract","overlay"));
};
