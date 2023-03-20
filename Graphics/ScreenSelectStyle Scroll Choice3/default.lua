return Def.ActorFrame{
	MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
	MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
	GoOffCommand=function(self)
		self:linear(0.5)
		local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01
		if bHasFocus then
			self:x(0):y(0)
			self:diffuse(color("1,1,1,1"))
			self:zoom(WideScreenDiff())
			self:glowblink()
			self:sleep(0.5)
			self:linear(0.5)
			self:zoom(0)
		else
			self:x(0):y(0):z(0):zoom(0)
		end
		self:sleep(5)
	end,
	GainFocusCommand=function(self) self:zoom(WideScreenDiff()) end,
	LoseFocusCommand=function(self) self:zoom(0.6*WideScreenDiff()) end,
	Def.ActorFrame{
		InitCommand=function(self) self:x(60):y(-50*WideScreenDiff()):zoom(1.2*WideScreenDiff()) end,
		GainFocusCommand=function(self) self:wag():effectmagnitude(0,10,0) end,
		LoseFocusCommand=function(self) self:stopeffect() end,
		LoadActor(THEME:GetPathG("_platform","home single"))..{
			InitCommand=function(self) self:x(-55):rotationx(30) end
		},
		LoadActor(THEME:GetPathG("_platform","home single"))..{
			InitCommand=function(self) self:x(55):rotationx(30) end
		}
	},
	LoadActor("title")..{
		InitCommand=function(self) self:x(60):y(-117*WideScreenDiff()):zoom(WideScreenDiff()):shadowlength(4):ztest(true) end,
		EnabledCommand=function(self) self:stopeffect() end,
		DisabledCommand=function(self) self:diffuseshift():effectcolor1(color("0,0,0,1")):effectcolor2(color("0,0,0,1")) end
	},
	LoadActor(THEME:GetPathG("","redflare"))..{
		InitCommand=function(self) self:x(60):y(-117*WideScreenDiff()):blend(Blend.Add):diffusealpha(0) end,
		GainFocusCommand=function(self) self:finishtweening():zoom(0):diffusealpha(0):zoomx(7*WideScreenDiff()):zoomy(4*WideScreenDiff()):diffusealpha(1):linear(0.2):zoomy(0):diffusealpha(0) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
		OffCommand=function(self) self:diffusealpha(0) end
	},
	LoadActor(THEME:GetPathG("","redflare"))..{
		InitCommand=function(self) self:x(60):y(-117*WideScreenDiff()):blend(Blend.Add):diffusealpha(0) end,
		GainFocusCommand=function(self) self:finishtweening():zoom(0):diffusealpha(0):zoomx(7*WideScreenDiff()):zoomy(4*WideScreenDiff()):diffusealpha(1):linear(0.4):zoomy(0):diffusealpha(0) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
		OffCommand=function(self) self:diffusealpha(0) end
	}
}