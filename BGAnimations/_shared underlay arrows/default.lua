return Def.ActorFrame{
	Def.ActorFrame{
		Name="LeftArrow",
		InitCommand=function(self) self:x(THEME:GetMetric(Var "LoadingScreen","ScrollerX")-190*WideScreenDiff()):CenterY():zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:queuecommand("Bob") end,
		BobCommand=function(self) self:accelerate(0.75):addx(-2):decelerate(0.75):addx(-2):accelerate(0.75):addx(2):decelerate(0.75):addx(2):queuecommand("Bob") end,
		Def.Sprite {
			Texture = "arrow",
			InitCommand=function(self) self:zoom(0.8):addx(-200*WideScreenSemiDiff()) end,
			OnCommand=function(self) self:decelerate(0.5):addx(200*WideScreenSemiDiff()) end,
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(-300*WideScreenSemiDiff()) end,
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):glow(color("1,1,1,1")):linear(0.2):glow(color("1,1,1,0")):zoom(0.8) end,
			MenuLeftP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuUpP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuLeftP2MessageCommand=function(self) self:playcommand("Blink") end,
			MenuUpP2MessageCommand=function(self) self:playcommand("Blink") end,
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end,
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end
		},
		Def.Sprite {
			Texture = "glow",
			InitCommand=function(self) self:diffusealpha(0):zoom(0.8):addx(-200*WideScreenSemiDiff()):blend(Blend.Add) end,
			OnCommand=function(self) self:decelerate(0.5):addx(200*WideScreenSemiDiff()) end,
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(-300*WideScreenSemiDiff()) end,
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):diffusealpha(1):linear(0.4):diffusealpha(0):zoom(0.8) end,
			MenuLeftP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuUpP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuLeftP2MessageCommand=function(self) self:playcommand("Blink") end,
			MenuUpP2MessageCommand=function(self) self:playcommand("Blink") end,
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end,
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end
		}
	},
	Def.ActorFrame{
		Name="RightArrow",
		InitCommand=function(self) self:x(THEME:GetMetric(Var "LoadingScreen","ScrollerX")+190*WideScreenDiff()):CenterY():zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:queuecommand("Bob") end,
		BobCommand=function(self) self:accelerate(0.75):addx(-2):decelerate(0.75):addx(-2):accelerate(0.75):addx(2):decelerate(0.75):addx(2):queuecommand("Bob") end,
		Def.Sprite {
			Texture = "arrow",
			InitCommand=function(self) self:rotationz(180):zoom(0.8):addx(200*WideScreenSemiDiff()) end,
			OnCommand=function(self) self:decelerate(0.5):addx(-200*WideScreenSemiDiff()) end,
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(300*WideScreenSemiDiff()) end,
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):glow(color("1,1,1,1")):linear(0.2):glow(color("1,1,1,0")):zoom(0.8) end,
			MenuRightP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuDownP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuRightP2MessageCommand=function(self) self:playcommand("Blink") end,
			MenuDownP2MessageCommand=function(self) self:playcommand("Blink") end,
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end,
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end
		},
		Def.Sprite {
			Texture = "glow",
			InitCommand=function(self) self:rotationz(180):diffusealpha(0):zoom(0.8):addx(200*WideScreenSemiDiff()):blend(Blend.Add) end,
			OnCommand=function(self) self:decelerate(0.5):addx(-200*WideScreenSemiDiff()) end,
			OffCommand=function(self) self:zbuffer(true):accelerate(0.5):addx(300*WideScreenSemiDiff()) end,
			BlinkCommand=function(self) self:finishtweening():zoom(1.2):diffusealpha(1):linear(0.4):diffusealpha(0):zoom(0.8) end,
			MenuRightP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuDownP1MessageCommand=function(self) self:playcommand("Blink") end,
			MenuRightP2MessageCommand=function(self) self:playcommand("Blink") end,
			MenuDownP2MessageCommand=function(self) self:playcommand("Blink") end,
			MadeChoiceP1MessageCommand=function(self) self:playcommand("Off") end,
			MadeChoiceP2MessageCommand=function(self) self:playcommand("Off") end
		}
	}
}