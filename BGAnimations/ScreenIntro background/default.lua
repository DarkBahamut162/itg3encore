return Def.ActorFrame{
	LoadActor("Intro by Angel")..{ InitCommand=function(self) self:Center():FullScreen():rate(.92):sleep(35):diffusealpha(0) end; };

	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):vertalign(top):zoomto(SCREEN_WIDTH,(SCREEN_WIDTH/4*.35)/2):diffuse(color("0,0,0,1")) end;
	};
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM):vertalign(bottom):zoomto(SCREEN_WIDTH,(SCREEN_WIDTH/4*.35)/2):diffuse(color("0,0,0,1")) end;
	};

	Def.ActorFrame{
		InitCommand=function(self) self:Center() end;
		LoadActor("swoosh")..{
			InitCommand=function(self) self:y(20):zoomtowidth(SCREEN_WIDTH):blend(Blend.Add):cropright(1):faderight(1) end;
			OnCommand=function(self) self:linear(0.5):cropright(0):faderight(0):sleep(4):linear(0.5):diffusealpha(0.0):addx(50):cropleft(1):fadeleft(1) end;
		};
		LoadFont("_v 26px bold glow")..{
			Text="RoXoR Games Presents";
			InitCommand=function(self) self:blend(Blend.Add):cropright(1):faderight(1) end;
			OnCommand=function(self) self:sleep(.1):linear(.2):cropright(0):faderight(0):sleep(2):linear(0.5):diffusealpha(0) end;
		};
		LoadFont("_v credit")..{
			Text="RoXoR Games Presents";
			InitCommand=function(self) self:cropright(1):faderight(1) end;
			OnCommand=function(self) self:sleep(.1):linear(.2):cropright(0):faderight(0):sleep(2):linear(0.5):diffusealpha(0) end;
		};
	};
	Def.ActorFrame{
		Name="WaveLogo";
		InitCommand=function(self) self:x(SCREEN_CENTER_X-30):y(SCREEN_CENTER_Y-30):addy(20):addx(30) end;
		OnCommand=function(self) self:hibernate(3.2):linear(3.0):sleep(1.2):queuecommand("h") end;
		hCommand=function(self) self:visible(false) end;

		Def.ActorFrame{
			InitCommand=function(self) self:x(-SCREEN_WIDTH/2):y(-240) end;
			-- title menu bg stuff
		};

		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
			InitCommand=function(self) self:zoom(.9):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(1):zoom(1):sleep(1.5):accelerate(0.2):diffusealpha(0):zoom(2.3) end;
		};
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
			InitCommand=function(self) self:blend(Blend.Add):zoom(1):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(1.5):accelerate(.3):diffusealpha(.4):linear(1.2):zoom(1.4):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/light"))..{
			InitCommand=function(self) self:y(10):zoom(1):cropright(1.2):cropleft(-0.2):blend(Blend.Add) end;
			OnCommand=function(self) self:linear(1):cropright(-0.2):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(1.2):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.5) end;
		};
	};

	LoadActor("songs");
	LoadActor("charts");
	LoadActor("courses");
	LoadActor("mods");

	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffusealpha(0) end;
		OnCommand=function(self) self:hibernate(34.5):linear(0.5):diffusealpha(1):linear(0.5):diffusealpha(0) end;
	};
};