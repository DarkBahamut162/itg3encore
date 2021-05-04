return Def.ActorFrame{
	LoadActor("_otherred")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120):y(SCREEN_CENTER_Y+30):horizalign(left):zoomy(.3):zoomtowidth(430):faderight(1) end;
		OnCommand=function(self) self:addx(-430):cropleft(1):sleep(.6):decelerate(.3):cropleft(0):addx(430) end;
	};
	LoadActor("_otherred")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120):y(SCREEN_CENTER_Y+30):horizalign(left):zoomy(.3):zoomtowidth(430):faderight(1) end;
		OnCommand=function(self) self:addx(-430):cropleft(1):sleep(.6):decelerate(.3):cropleft(0):addx(430) end;
	};
	LoadActor("arrow")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-190):y(SCREEN_CENTER_Y-25):zoom(.8):glow(color("1,1,1,1")):addx(SCREEN_WIDTH/2):addy(SCREEN_HEIGHT/1.2) end;
		OnCommand=function(self) self:sleep(.2):decelerate(.5):addx(-SCREEN_WIDTH/2):addy(-SCREEN_HEIGHT/1.2):glow(color("1,1,1,0")):wag():effectmagnitude(4,0,4):effectperiod(8) end;
	};

	Def.ActorFrame{
		Name="OpenITGText";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+90):y(SCREEN_CENTER_Y+30):zoom(.8):draworder(1) end;
		LoadActor("_openitg normal")..{
			InitCommand=function(self) self:cropright(1):faderight(1) end;
			OnCommand=function(self) self:sleep(.7):linear(.3):cropright(0):faderight(.1):linear(.03):faderight(0) end;
		};
		LoadActor("_openitg glow")..{
			InitCommand=function(self) self:diffusealpha(.8):cropright(1):faderight(1) end;
			OnCommand=function(self) self:sleep(.7):linear(.3):cropright(0):faderight(.1):linear(.03):faderight(0):linear(.5):diffusealpha(0) end;
		};
	};

	LoadFont("_v profile")..{
		Text="Powered by";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-28):shadowlength(2) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
	LoadFont("_v 26px bold shadow")..{
		Text="http://github.com/openitg/";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+90):y(SCREEN_CENTER_Y+88):shadowlength(2) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
};