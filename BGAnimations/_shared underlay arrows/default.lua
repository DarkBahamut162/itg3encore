return Def.ActorFrame{
	Def.ActorFrame{
		Name="LeftArrow";
		InitCommand=function(self) self:x(SCREEN_CENTER_X-278):CenterY() end;
		OnCommand=function(self) self:queuecommand("Bob") end;
		BobCommand=function(self) self:accelerate(.75):addx(-2):decelerate(.75):addx(-2):accelerate(.75):addx(2):decelerate(.75):addx(2):queuecommand("Bob") end;

		LoadActor("arrow")..{
			InitCommand=function(self) self:zoom(0.8):addx(-200) end;
			OnCommand=function(self) self:decelerate(0.5):addx(200) end;
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(-300) end;
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):glow(color("1,1,1,1")):linear(0.2):glow(color("1,1,1,0")):zoom(0.8) end;
			MenuLeftP1MessageCommand=function(self) self:playcommand("Blink") end;
			MenuLeftP2MessageCommand=function(self) self:playcommand("Blink") end;
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end;
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end;
		};
		LoadActor("glow")..{
			InitCommand=function(self) self:diffusealpha(0):zoom(0.8):addx(-200):blend(Blend.Add) end;
			OnCommand=function(self) self:decelerate(0.5):addx(200) end;
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(-300) end;
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):diffusealpha(1):linear(0.4):diffusealpha(0):zoom(0.8) end;
			MenuLeftP1MessageCommand=function(self) self:playcommand("Blink") end;
			MenuLeftP2MessageCommand=function(self) self:playcommand("Blink") end;
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end;
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end;
		};
	};
	Def.ActorFrame{
		Name="RightArrow";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+102):CenterY() end;
		OnCommand=function(self) self:queuecommand("Bob") end;
		BobCommand=function(self) self:accelerate(.75):addx(-2):decelerate(.75):addx(-2):accelerate(.75):addx(2):decelerate(.75):addx(2):queuecommand("Bob") end;

		LoadActor("arrow")..{
			InitCommand=function(self) self:rotationz(180):zoom(0.8):addx(200) end;
			OnCommand=function(self) self:decelerate(0.5):addx(-200) end;
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(300) end;
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):glow(color("1,1,1,1")):linear(0.2):glow(color("1,1,1,0")):zoom(0.8) end;
			MenuRightP1MessageCommand=function(self) self:playcommand("Blink") end;
			MenuRightP2MessageCommand=function(self) self:playcommand("Blink") end;
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end;
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end;
		};
		LoadActor("glow")..{
			InitCommand=function(self) self:rotationz(180):diffusealpha(0):zoom(0.8):addx(200):blend(Blend.Add) end;
			OnCommand=function(self) self:decelerate(0.5):addx(-200) end;
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(300) end;
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):diffusealpha(1):linear(0.4):diffusealpha(0):zoom(0.8) end;
			MenuRightP1MessageCommand=function(self) self:playcommand("Blink") end;
			MenuRightP2MessageCommand=function(self) self:playcommand("Blink") end;
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end;
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end;
		};
	};
};