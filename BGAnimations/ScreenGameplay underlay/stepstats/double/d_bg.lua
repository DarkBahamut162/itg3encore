local pn = ...

return Def.ActorFrame{
	Def.Sprite {
		Texture = "base",
		InitCommand=function(self) self:y(35) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("horiz-line","short"),
		Condition=getenv("ShowStats"..pname(pn)) == 7,
		InitCommand=function(self)
			local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(pn))))
			self:y(-target*268+164):valign(0):zoomx(0.08):zoomy(0.5):diffusealpha(0.5):fadeleft(0.25):faderight(0.25):diffuse(color("#FF0000")):diffuseramp():effectcolor1(color("#FF000080")):effectcolor2(color("#FF0000FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
		end
	},
	Def.Sprite {
		Texture = "streak",
		InitCommand=function(self) self:y(185):addy(100) end,
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addy(-100) end
	},
	Def.Sprite {
		Texture = "streak",
		InitCommand=function(self) self:y(204):addy(100) end,
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addy(-100) end
	}
}