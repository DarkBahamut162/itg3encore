return Def.ActorFrame{
	Def.Sprite {
		Texture = "logo",
		InitCommand=function(self) self:x(4):y(5):zoomto(18,18) end,
		OnCommand=function(self) self:pulse():effectclock("beat"):effectperiod(0.83):effectmagnitude(1,1.25,0) end
	},
	Def.Sprite {
		Texture = "text",
		InitCommand=function(self) self:x(16):y(5):halign(0):zoomto(92,22) end
	}
}