local t = Def.ActorFrame{
	LoadActor("wheel cursor glow")..{
		InitCommand=function(self) self:diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1) end;
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
		CurrentSongChangedMessageCommand=function(self) self:stoptweening():linear(0.15):x(10):diffusealpha(0):decelerate(0.3):diffusealpha(1):x(0) end;
	};
	LoadActor("glow")..{
		InitCommand=function(self) self:diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#00FFFF")):effectcolor2(color("#0000CC")):effectclock("beat") end;
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
		CurrentSongChangedMessageCommand=function(self) self:stoptweening():linear(0.15):x(10):decelerate(0.3):x(0) end;
	};
	LoadActor("wheel cursor normal")..{
		InitCommand=function(self) self:diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1) end;
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
		CurrentSongChangedMessageCommand=function(self) self:stoptweening():linear(0.15):x(10):decelerate(0.3):x(0) end;
	};
	LoadActor("blueflare")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end;
		OnCommand=function(self) self:playcommand("Refresh") end;
		RefreshCommand=function(self) self:stoptweening(1):zoom(0):diffusealpha(1):sleep(0.6):accelerate(0.5):zoom(5):diffusealpha(0) end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Refresh") end;
	};
	LoadActor("outline")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end;
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
		RefreshCommand=function(self) self:stoptweening():linear(0.1):diffusealpha(0):sleep(0.2):diffusealpha(1):cropright(-0.3):cropleft(1.1):fadeleft(0.05):faderight(0.05):diffusealpha(1):linear(0.72):cropright(1):cropleft(-0.3) end;
		CurrentSongChangedMessageCommand=function(self) self:diffusealpha(0):stoptweening():playcommand("Refresh") end;
	};
};

return t;