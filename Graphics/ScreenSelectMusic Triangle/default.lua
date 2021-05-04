local t = Def.ActorFrame{
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
	LoadActor("outline")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end;
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
		-- original version
		RefreshCommand=function(self) self:stoptweening():linear(.1):diffusealpha(0):sleep(.2):diffusealpha(1):cropright(-0.3):cropleft(1.1):fadeleft(.05):faderight(.05):diffusealpha(1):linear(0.72):cropright(1):cropleft(-0.3) end;
		CurrentSongChangedMessageCommand=function(self) self:diffusealpha(0):stoptweening():playcommand("Refresh") end;

		-- freem's version
		--[[
		NextSongMessageCommand=function(self) self:diffusealpha(0):stoptweening():playcommand("GoRight") end;
		PreviousSongMessageCommand=function(self) self:diffusealpha(0):stoptweening():playcommand("GoLeft") end;
		GoLeftCommand=function(self) self:stoptweening():linear(.1):diffusealpha(0):sleep(.2):diffusealpha(1):cropright(-0.3):cropleft(1.1):fadeleft(.05):faderight(.05):diffusealpha(1):linear(0.72):cropright(1):cropleft(-0.3) end;
		GoRightCommand=function(self) self:stoptweening():linear(.1):diffusealpha(0):sleep(.2):diffusealpha(1):cropleft(-0.3):cropright(1.1):faderight(.05):fadeleft(.05):diffusealpha(1):linear(0.72):cropleft(1):cropright(-0.3) end;
		--]]
	};
};

return t;