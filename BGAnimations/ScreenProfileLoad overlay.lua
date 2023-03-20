return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+158*WideScreenDiff()):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-158*WideScreenDiff()):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()) end
	},
	LoadActor("lolhi")..{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
	},
	LoadFont("_z 36px shadowx")..{
		Text="LOADING PROFILES...",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+42*WideScreenDiff()):CenterY():zoom(0.75*WideScreenDiff()) end,
		OnCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToLoad() then
				self:sleep(1):linear(0.25):diffusealpha(0)
			end
		end
	},
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+42*WideScreenDiff()):CenterY():zoom(0.7*WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToLoad() then
				self:sleep(1):linear(0.25):diffusealpha(1)
			end
		end
	},
	LoadActor("_disk")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY():zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:decelerate(0.2):addx(-56*WideScreenDiff()):sleep(0.6):linear(0.2):zoom(0):rotationz(360) end
	},
	Def.Actor{
		BeginCommand=function(self)
			InitRotationOptions()
			if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1.5) end
			self:queuecommand("Load")
		end,
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
	}
}