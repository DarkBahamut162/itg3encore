local pn = ...

return Def.ActorFrame{
	Def.Sprite {
		Texture = "light "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:blend(Blend.Add):addx(-146):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FFFFFF00")):effectclock('beat'):effectperiod(4) end
	},
	Def.Sprite {
		Texture = "base "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:addx(-5) end
	},
	Def.Sprite {
		Texture = "base glow final",
		Condition=isFinal(),
		InitCommand=function(self) self:addx(-5):blend(Blend.Add):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
	},
	Def.Sprite {
		Texture = "light "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:blend(Blend.Add):addx(-164):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FFFFFF00")):effectclock('beat'):effectperiod(4) end
	},
	Def.Sprite {
		Texture = "streak "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:addx(-155):addx(-100) end,
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addx(100) end
	},
	Def.Sprite {
		Texture = "streak "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:addx(-174):addx(-100) end,
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addx(100) end
	},
	Def.Sprite {
		Texture = "glow1",
		InitCommand=function(self) self:blend(Blend.Add):addx(-5):visible(false) end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == pn then
				self:visible(true)
				if param.Color == "rainbow" then
					self:rainbow()
				else
					self:stopeffect():diffuse(color(param.Color))
				end
			end
		end,
	},
	Def.Sprite {
		Texture = "glow2 "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:blend(Blend.Add):addx(-5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(1.8):decelerate(0.3):diffusealpha(1):sleep(0.2):accelerate(0.6):diffusealpha(0):queuecommand("Destroy") end,
		DestroyCommand=function(self) self:visible(false) end
	},
	Def.Sprite {
		Texture = "light1",
		InitCommand=function(self) self:blend(Blend.Add):addx(-155):addx(-100):visible(false) end,
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addx(100) end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == pn then
				self:visible(true)
				if param.Color == "rainbow" then
					self:rainbow()
				else
					self:stopeffect():diffuse(color(param.Color))
				end
			end
		end
	},
	Def.Sprite {
		Texture = "light1",
		InitCommand=function(self) self:blend(Blend.Add):addx(-174):addx(-100):visible(false) end,
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addx(100) end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == pn then
				self:visible(true)
				if param.Color == "rainbow" then
					self:rainbow()
				else
					self:stopeffect():diffuse(color(param.Color))
				end
			end
		end
	}
}