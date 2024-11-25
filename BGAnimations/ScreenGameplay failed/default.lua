return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("#00000000")) end,
		StartTransitioningCommand=function(self) self:linear(1.5):diffusealpha(1) end
	},
	Def.Sprite {
		Texture = "_stage "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(0):addy(-30) end,
		StartTransitioningCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1):addy(30) end
	},
	Def.ActorFrame{
		Name="NormalFail",
		InitCommand=function(self) self:visible(songfail(false)) end,
		Def.Sprite {
			Texture = "_failed "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:zoom(WideScreenDiff()):x(SCREEN_CENTER_X+2*WideScreenDiff()):y(SCREEN_CENTER_Y+30*WideScreenDiff()):diffusealpha(0):addx(-500) end,
			StartTransitioningCommand=function(self) self:sleep(0.4):decelerate(0.7):addx(500):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Name="VertexFail",
		InitCommand=function(self) self:visible(songfail(true)) end,
		Def.Sprite {
			Texture = "v_failed",
			InitCommand=function(self) self:zoom(WideScreenDiff()):x(SCREEN_CENTER_X+2*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):diffusealpha(0.2):cropleft(0.5):cropright(0.5) end,
			StartTransitioningCommand=function(self) self:sleep(0.7):decelerate(0.75):cropright(0):cropleft(0):diffusealpha(1) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("horiz-line","short"),
			InitCommand=function(self) self:zoomx(2*WideScreenDiff()):rotationz(90):x(SCREEN_CENTER_X+1*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):cropleft(0.5):cropright(0.5) end,
			StartTransitioningCommand=function(self) self:sleep(0.55):accelerate(0.15):cropleft(0):cropright(0):decelerate(0.725):addx(-SCREEN_WIDTH/2):linear(0.15):diffusealpha(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("horiz-line","short"),
			InitCommand=function(self) self:zoomx(2*WideScreenDiff()):rotationz(90):x(SCREEN_CENTER_X+2*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):cropleft(0.5):cropright(0.5) end,
			StartTransitioningCommand=function(self) self:sleep(0.55):accelerate(0.15):cropleft(0):cropright(0):decelerate(0.725):addx(SCREEN_WIDTH/2):linear(0.15):diffusealpha(0) end
		}
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("#00000000")) end,
		StartTransitioningCommand=function(self) self:sleep(3):linear(0.3):diffusealpha(1) end
	},
	Def.Sound {
		File = "bleh.ogg",
		StartTransitioningCommand=function(self) self:play() end
	}
}