return Def.ActorFrame{
	MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end,
	MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end,
	GoOffCommand=function(self)
		self:linear(0.5)
		local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01
		if bHasFocus then
			self:x(0):y(0):z(200)
			self:diffuse(1,1,1,1)
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
	GainFocusCommand=function(self) self:zoom(1.0*WideScreenDiff()) end,
	LoseFocusCommand=function(self) self:zoom(0.6*WideScreenDiff()) end,
	Def.Sprite {
		Texture = "title",
		InitCommand=function(self) self:zoom(0):x(-73):y(-117*WideScreenDiff()) end,
		GainFocusCommand=function(self) self:finishtweening():zoom(0):bounceend(0.1):zoom(0.4425*WideScreenDiff()) end,
		LoseFocusCommand=function(self) self:bouncebegin(0.1):zoom(0) end
	},
	Def.Sprite {
		Texture = "../ScreenSelectPlayMode Scroll Choice1/frame",
		InitCommand=function(self) self:zoom(0):x(-73):y(-80*WideScreenDiff()) end,
		GainFocusCommand=function(self) self:finishtweening():zoom(0):bounceend(0.1):zoom(1.1*WideScreenDiff()) end,
		LoseFocusCommand=function(self) self:bouncebegin(0.1):zoom(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","blueflare"),
		InitCommand=function(self) self:x(-73):y(-70*WideScreenDiff()):blend(Blend.Add):diffusealpha(0) end,
		GainFocusCommand=function(self) self:finishtweening():zoom(0):diffusealpha(0):zoomx(7*WideScreenDiff()):zoomy(4*WideScreenDiff()):diffusealpha(1):linear(0.2):zoomy(0):diffusealpha(0) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
		OffCommand=function(self) self:diffusealpha(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","blueflare"),
		InitCommand=function(self) self:x(-73):y(-70*WideScreenDiff()):blend(Blend.Add):diffusealpha(0) end,
		GainFocusCommand=function(self) self:finishtweening():zoom(0):diffusealpha(0):zoomx(7*WideScreenDiff()):zoomy(4*WideScreenDiff()):diffusealpha(1):linear(0.4):zoomy(0):diffusealpha(0) end,
		LoseFocusCommand=function(self) self:diffusealpha(0) end,
		OffCommand=function(self) self:diffusealpha(0) end
	}
}