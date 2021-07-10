return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenGameplay","overlay/demonstration gradient"))..{
		InitCommand=function(self) self:Center():FullScreen():diffusealpha(0.8) end;
	};

	LoadFont("_v tutorial")..{
		Text="Colored Arrows\nscroll from\nlow to high.";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):CenterY():addx(SCREEN_WIDTH/2):zoom(1) end;
		OnCommand=function(self) self:sleep(5):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end;
	};
	LoadActor("focus square")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4+26):y(SCREEN_CENTER_Y+60):zoomx(1.0):zoomy(1.05):diffuseblink():effectperiod(0.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(6):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
	};

	LoadFont("_v tutorial")..{
		Text="Step when a\nColored Arrow\noverlaps the\nTarget Arrows\nat the top.";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):CenterY():addx(SCREEN_WIDTH):zoom(1) end;
		OnCommand=function(self) self:sleep(11):decelerate(0.5):addx(-SCREEN_WIDTH):sleep(5):linear(0.3):diffusealpha(0) end;
	};
	LoadActor("focus rect")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-(SCREEN_WIDTH/4)+26):y(SCREEN_CENTER_Y-124):zoomx(1.0):zoomy(0.8):diffuseblink():effectperiod(0.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(12):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
	};

	LoadFont("_v tutorial")..{
		Text="The\nTraffic Light\nhelps you\nunderstand\nthe timing.";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):CenterY():addx(SCREEN_WIDTH/2):zoom(1) end;
		OnCommand=function(self) self:sleep(17):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end;
	};
	LoadActor("focus rect")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-30):zoomx(1.0):zoomy(1):rotationz(90):diffuseblink():effectperiod(0.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(18):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
	};

	LoadFont("_v tutorial")..{
		Text="The direction\nof the arrow\nsays which\nPanel\nto step on.";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):CenterY():addx(SCREEN_WIDTH/2):zoom(1) end;
		OnCommand=function(self) self:sleep(23):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end;
	};
	LoadFont("_v tutorial")..{
		Text="For arrows\nfacing Left,\nstep on the\nLeft Panel.";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y-80):addx(SCREEN_WIDTH/2):zoom(1) end;
		OnCommand=function(self) self:sleep(29):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end;
	};
	LoadActor("arrow")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+(SCREEN_WIDTH/4)-100):y(SCREEN_CENTER_Y+80):rotationz(0):glowblink():effectperiod(0.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
	};
	Def.ActorFrame{
		Name="PlatformLeft";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+210):y(SCREEN_CENTER_Y+80):zoom(0.8):rotationx(-20):fov(45):vanishpoint(SCREEN_CENTER_X+210,SCREEN_CENTER_Y+80) end;
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/platform"))..{
			InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/panelglow"))..{
			InitCommand=function(self) self:x(-45):blend(Blend.Add):diffuseblink():effectperiod(0.5):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
		};
	};

	LoadFont("_v tutorial")..{
		Text="For arrows\nfacing Up,\nstep on the\nUp Panel.";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4+10):y(SCREEN_CENTER_Y-80):addx(SCREEN_WIDTH/2):zoom(1) end;
		OnCommand=function(self) self:sleep(35):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end;
	};
	LoadActor("arrow")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+(SCREEN_WIDTH/4)-100):y(SCREEN_CENTER_Y+80):rotationz(90):glowblink():effectperiod(0.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
	};
	Def.ActorFrame{
		Name="PlatformUp";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+210):y(SCREEN_CENTER_Y+80):zoom(0.8):rotationx(-20):fov(45):vanishpoint(SCREEN_CENTER_X+210,SCREEN_CENTER_Y+80) end;
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/platform"))..{
			InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("ScreenGameplay","underlay/panelglow"))..{
			InitCommand=function(self) self:y(-45):blend(Blend.Add):diffuseblink():effectperiod(0.5):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end;
		};
	};

	LoadFont("_v profile")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-113):y(SCREEN_BOTTOM-75):zoom(0.7):maxwidth(300) end;
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
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("0,0,0,1")) end;
		OnCommand=function(self) self:sleep(3.5):linear(0.5):diffusealpha(0) end;
	};
	Def.ActorFrame{
		LoadActor("instructions")..{
			InitCommand=function(self) self:Center():cropright(1.3) end;
			OnCommand=function(self) self:linear(1):cropright(-0.3):sleep(2):decelerate(0.5):zoom(0.7):y(SCREEN_TOP+40) end;
		};
		LoadActor("white instructions")..{
			InitCommand=function(self) self:Center():cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end;
			OnCommand=function(self) self:linear(1):cropleft(1):cropright(-0.3) end;
		};
	};
	LoadActor(THEME:GetPathB("ScreenAttract","overlay"));
};