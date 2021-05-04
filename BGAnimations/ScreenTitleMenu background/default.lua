local t = Def.ActorFrame{
	--[[
	OnCommand=function(self)
		ResetCustomMods()
	end;
	--]]
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_fallback"))..{
		InitCommand=cmd(Center;diffusealpha,0);
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end;
	};
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_CJ126"))..{
		InitCommand=function(self) self:Center():FullScreen():diffusealpha(0) end;
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end;
	};
	LoadActor("_lower")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};
	LoadActor("_upper")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};

	LoadActor("_lower")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};
	LoadActor("_upper")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};

	--ENCORE ADD
	LoadActor("_topright")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=cmd(diffusealpha,1;sleep,0.3;diffusealpha,1;croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;sleep,0.5;diffusealpha,1;linear,3;croptop,1;cropbottom,-0.8;sleep,0.3;queuecommand,"Anim");
	};
	LoadActor("_center")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=cmd(diffusealpha,1;sleep,0.3;diffusealpha,1;croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;sleep,0.8;diffusealpha,1.5;linear,3;croptop,1;cropbottom,-0.8;sleep,0.3;queuecommand,"Anim");
	};
	LoadActor("_2top")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=cmd(cropright,-0.8;cropleft,1;fadeleft,.45;faderight,.45;sleep,.1;diffusealpha,1;linear,3;cropright,1;cropleft,-0.8;sleep,0.25;queuecommand,"Anim");
	};
	LoadActor("_left")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=cmd(cropright,-0.8;cropleft,1;fadeleft,.45;faderight,.45;sleep,.4;diffusealpha,1;linear,3;cropright,1;cropleft,-0.8;sleep,0.2;queuecommand,"Anim");
	};
	LoadActor("_right")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=cmd(cropleft,-0.8;cropleft,1;faderight,.45;fadeleft,.45;sleep,.2;diffusealpha,1;linear,3;cropleft,1;cropright,-0.8;sleep,0.5;queuecommand,"Anim");
	};
	LoadActor("_2center")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=cmd(cropright,-0.8;cropleft,1;fadeleft,.45;faderight,.45;sleep,.4;diffusealpha,1;linear,3;cropright,1;cropleft,-0.8;sleep,0.2;queuecommand,"Anim");
	};

	Def.ActorFrame{
		Name="LogoFrame";
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-10;);
		LoadActor("glow")..{
			InitCommand=cmd(blend,Blend.Add;zoom,0;);
			OnCommand=cmd(sleep,0.1;bounceend,0.4;zoom,1;diffuseshift;effectcolor1,color("#FFFFFFFF");effectcolor2,color("#FFFFFF00");effectperiod,5;effectoffset,.3);
		};
		LoadActor("newlogo")..{
			InitCommand=function(self) self:zoom(0) end;
			OnCommand=cmd(sleep,0.1;bounceend,0.4;zoom,1);
		};
		Def.ActorFrame{
			Name="LightsFrame";
			LoadActor("light")..{
				InitCommand=cmd(zoom,1;blend,Blend.Add;);
				OnCommand=function(self) self:queuecommand("Diffuse") end;
				DiffuseCommand=cmd(diffusealpha,0;sleep,2;linear,.3;diffusealpha,1;sleep,.05;linear,.5;diffusealpha,0;queuecommand,"Diffuse");
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

	--ENCORE ADD
	LoadActor("encore")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+103;y,SCREEN_CENTER_Y+95);
		OnCommand=cmd(horizalign,center;cropright,1.3;sleep,0.7;linear,1;cropright,-0.3);
	};
	LoadActor("_encoreglow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+103;y,SCREEN_CENTER_Y+95);
		OnCommand=cmd(horizalign,center;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;sleep,0.7;linear,1;cropleft,1;cropright,-0.3);
	};

	Def.ActorFrame{
		LoadActor("_lside")..{
			InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_BOTTOM+100;halign,0;valign,1);
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
		LoadActor("_rside")..{
			InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM+100;halign,1;valign,1;);
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
		LoadActor("width")..{
			InitCommand=cmd(x,SCREEN_LEFT+48;y,SCREEN_BOTTOM+100;halign,0;valign,1;zoomtowidth,SCREEN_WIDTH-96);
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
		LoadActor("base")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+100;valign,1;);
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
	};

	Def.ActorFrame{
		LoadActor("_upwidth")..{
			InitCommand=cmd(x,SCREEN_LEFT+310;vertalign,top;horizalign,left;zoomtowidth,SCREEN_WIDTH-630;);
			OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.4):y(SCREEN_TOP) end;
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
		InitCommand=cmd(x,SCREEN_LEFT+135;y,SCREEN_TOP+32;valign,1;zoom,1;diffusealpha,0;);
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

	LoadActor("icon")..{ OffCommand=function(self) self:accelerate(0.5):addy(-100) end; };
	-- addon OffCommand=cmd(accelerate,0.3;addx,100);

	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen() end;
		OnCommand=cmd(diffusealpha,0;sleep,0.1;accelerate,0.5;diffusealpha,1;sleep,0.2;decelerate,0.5;diffusealpha,0);
	};
	LoadActor(THEME:GetPathS("","_logo"))..{
		OnCommand=function(self) self:play() end;
	};
	LoadActor(THEME:GetPathS("_Menu","music"))..{
		OnCommand=function(self) self:play() end;
		OffCommand=cmd(stop);
	};

	LoadFont("_v 26px bold black")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-33+100;diffusealpha,0;horizalign,center;shadowlength,0;zoom,.5;);
		OnCommand=cmd(decelerate,0.4;addy,-100;diffusealpha,1;playcommand,"Refresh");
		OffCommand=cmd(accelerate,0.5;addy,100;diffusealpha,0;);
		RefreshCommand=function(self)
			self:settext("In The Groove 3 Encore r35")
		end;
	};

	LoadFont("ScreenOptions serial number")..{
		InitCommand=cmd(x,SCREEN_RIGHT-30;y,SCREEN_BOTTOM-42;shadowlength,2;horizalign,right;wrapwidthpixels,1000;zoom,0.5);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.5;diffusealpha,1;playcommand,"Refresh");
		RefreshCommand=function(self)
			self:settext("ITG-(H/B)-2011/12/12-ITG3-r35-Encore")
		end;
	};
	LoadFont("_r bold 30px")..{
		InitCommand=cmd(x,SCREEN_LEFT+35;y,SCREEN_TOP+50;shadowlength,2;horizalign,left;wrapwidthpixels,1000;zoom,0.6);
		OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.5;diffusealpha,1;playcommand,"Refresh");
		RefreshCommand=function(self)
			local songs = SONGMAN:GetNumSongs();
			local groups = SONGMAN:GetNumSongGroups();
			local courses = SONGMAN:GetNumCourses();
			self:settext(songs.." songs in "..groups.." groups, "..courses.." courses")
		end;
	};
};

return t;