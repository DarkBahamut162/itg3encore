-- This is because the "CurrentSongChangedMessageCommand" triggers upon loading the SelectScreen
local InitialLoad = false;

return Def.ActorFrame{

	Def.ActorFrame{
		Name="Frame";
		LoadActor("frame")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+140):y(SCREEN_CENTER_Y-20) end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
		LoadActor("flare")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+140):y(SCREEN_CENTER_Y-20):blend(Blend.Add) end;
			OnCommand=function(self) self:diffusealpha(0) end;
			RefreshCommand=function(self)
				self:stoptweening(5):zoom(1):diffusealpha(1):sleep(0.1):accelerate(0.2):zoom(1.2):diffusealpha(0)
			end;
			CurrentSongChangedMessageCommand=function(self)
				if InitialLoad then
					self:playcommand("Refresh")
				else
					InitialLoad = true
				end
			end;
		};
		LoadFont("titlemenu")..{
			Text="Time:";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+177):y(SCREEN_CENTER_Y-43) end;
			OnCommand=function(self) self:diffusealpha(1):shadowlength(2.5):zoom(0.53):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
		LoadFont("_v 26px bold diffuse")..{
			Text="ARTIST:";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+10):y(SCREEN_CENTER_Y-24) end;
			OnCommand=function(self) self:diffusealpha(1):shadowlength(2.5):zoom(0.5):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
		LoadFont("_v 26px bold diffuse")..{
			Text="BPM:";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+280):y(SCREEN_CENTER_Y-24) end;
			OnCommand=function(self) self:diffusealpha(1):shadowlength(2.5):zoom(0.5):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
	};
};