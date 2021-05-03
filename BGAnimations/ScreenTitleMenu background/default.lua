local t = Def.ActorFrame{
	--[[
	OnCommand=function(self)
		ResetCustomMods() 
		RandomStartSong()
	end;
	--]]
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_fallback"))..{
		InitCommand=cmd(Center;diffusealpha,0);
		OnCommand=cmd(linear,1.5;diffusealpha,1;);
	};
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/CJ126"))..{
		InitCommand=cmd(Center;FullScreen;diffusealpha,0);
		OnCommand=cmd(linear,1.5;diffusealpha,1;);
	};
	LoadActor("_lower")..{
		InitCommand=cmd(Center;blend,Blend.Add;zoomtowidth,SCREEN_WIDTH;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;linear,3;croptop,1;cropbottom,-0.8;sleep,1;queuecommand,"Anim");
	};
	LoadActor("_upper")..{
		InitCommand=cmd(Center;blend,Blend.Add;zoomtowidth,SCREEN_WIDTH;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;linear,3;croptop,1;cropbottom,-0.8;sleep,1;queuecommand,"Anim");
	};

	LoadActor("_lower")..{
		InitCommand=cmd(Center;blend,Blend.Add;zoomtowidth,SCREEN_WIDTH;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;linear,3;croptop,1;cropbottom,-0.8;sleep,1;queuecommand,"Anim");
	};
	LoadActor("_upper")..{
		InitCommand=cmd(Center;blend,Blend.Add;zoomtowidth,SCREEN_WIDTH;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;linear,3;croptop,1;cropbottom,-0.8;sleep,1;queuecommand,"Anim");
	};

	Def.ActorFrame{
		Name="LogoFrame";
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-10;);
		LoadActor("glow")..{
			InitCommand=cmd(blend,Blend.Add;zoom,0;);
			OnCommand=cmd(sleep,0.1;bounceend,0.4;zoom,1;diffuseshift;effectcolor1,color("#FFFFFFFF");effectcolor2,color("#FFFFFF00");effectperiod,5;effectoffset,.3);
		};
		LoadActor("newlogo")..{
			InitCommand=cmd(zoom,0;);
			OnCommand=cmd(sleep,0.1;bounceend,0.4;zoom,1);
		};
		Def.ActorFrame{
			Name="LightsFrame";
			LoadActor("light")..{
				InitCommand=cmd(zoom,1;blend,Blend.Add;);
				OnCommand=cmd(queuecommand,"Diffuse");
				DiffuseCommand=cmd(diffuse,color("1,1,1,0");diffusealpha,0;sleep,3;linear,.3;diffusealpha,1;sleep,.05;linear,.5;diffusealpha,0;queuecommand,"Diffuse");
			};
			LoadActor("light")..{
				InitCommand=cmd(zoom,1;blend,Blend.Add;diffusealpha,0;);
				GoodEndingMessageCommand=cmd(stoptweening;diffuse,#ffc600;linear,.3;diffusealpha,1;sleep,.25;linear,1;diffusealpha,0;);
			};
			LoadActor("light")..{
				InitCommand=cmd(zoom,1;blend,Blend.Add;diffusealpha,0;);
				GoodEndingMessageCommand=cmd(stoptweening;diffuse,#ffc600;linear,.3;diffusealpha,1;sleep,.25;linear,1;diffusealpha,0;)
			};
		};
	};

	Def.ActorFrame{
		LoadActor("_lside")..{
			InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_BOTTOM+100;halign,0;valign,1);
			OnCommand=cmd(decelerate,0.4;y,SCREEN_BOTTOM);
			OffCommand=cmd(accelerate,0.5;addy,100);
		};
		LoadActor("_lside")..{
			InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM+100;halign,0;valign,1;zoomx,-1;);
			OnCommand=cmd(decelerate,0.4;y,SCREEN_BOTTOM);
			OffCommand=cmd(accelerate,0.5;addy,100);
		};
		LoadActor("width")..{
			InitCommand=cmd(x,SCREEN_LEFT+48;y,SCREEN_BOTTOM+100;halign,0;valign,1;zoomtowidth,SCREEN_WIDTH-96);
			OnCommand=cmd(decelerate,0.4;y,SCREEN_BOTTOM);
			OffCommand=cmd(accelerate,0.5;addy,100);
		};
	};

	Def.ActorFrame{
		LoadActor("_upwidth")..{
			InitCommand=cmd(x,SCREEN_LEFT+310;vertalign,top;horizalign,left;zoomtowidth,SCREEN_WIDTH-630;);
			OnCommand=cmd(y,SCREEN_TOP-100;decelerate,.4;y,SCREEN_TOP);
			OffCommand=cmd(accelerate,.5;addy,-100);
		};
		LoadActor("_upleft")..{
			InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_TOP-100;horizalign,left;vertalign,top);
			OnCommand=cmd(decelerate,.4;y,SCREEN_TOP);
			OffCommand=cmd(accelerate,.5;addy,-100);
		};
		LoadActor("_upright")..{
			InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_TOP-100;horizalign,right;vertalign,top);
			OnCommand=cmd(decelerate,.4;y,SCREEN_TOP);
			OffCommand=cmd(accelerate,.5;addy,-100);
		};
	};

	LoadActor("roxor")..{
		InitCommand=cmd(x,SCREEN_LEFT+135;y,SCREEN_TOP+32;valign,1;zoom,.7;diffusealpha,0;);
		OnCommand=cmd(sleep,0.5;linear,0.5;diffusealpha,1);
		OffCommand=cmd(accelerate,.5;addy,-100);
	};
	LoadActor(THEME:GetPathB("","_thanks/_bx"))..{
		InitCommand=cmd(x,SCREEN_LEFT+268;y,SCREEN_TOP+32;valign,1;zoom,.5;diffusealpha,0;);
		OnCommand=cmd(sleep,0.5;linear,0.5;diffusealpha,1);
		OffCommand=cmd(accelerate,.5;addy,-100);
	};
	-- only works in 16:9 (need to fix that)
	--[[
	LoadActor(THEME:GetPathB("","_thanks/_ssc"))..{
		InitCommand=cmd(x,SCREEN_LEFT+360;y,SCREEN_TOP+16;valign,1;addy,-100);
		OnCommand=cmd(sleep,0.4;linear,0.25;addy,100;);
		OffCommand=cmd(accelerate,.5;addy,-100);
	};
	--]]

	LoadActor("icon")..{ OffCommand=cmd(accelerate,0.5;addy,-100); };
	-- addon OffCommand=cmd(accelerate,0.3;addx,100);

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;);
		OnCommand=cmd(diffusealpha,0;sleep,0.1;accelerate,0.5;diffusealpha,1;sleep,0.2;decelerate,0.5;diffusealpha,0);
	};
	LoadActor(THEME:GetPathS("","_logo"))..{
		OnCommand=cmd(play);
	};
	LoadActor(THEME:GetPathS("_Menu","music"))..{
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	};
};

return t;