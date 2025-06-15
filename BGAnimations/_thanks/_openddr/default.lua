return Def.ActorFrame{
	Def.Sprite {
		Texture = "logo",
		InitCommand=function(self) self:x(2):y(8):zoomto(18,18) end,
		OnCommand=function(self) self:wag():effectclock("beat"):effectperiod(0.83*2):effectmagnitude(4,0,4) end
	},
	Def.Sprite {
		Texture = "text",
		InitCommand=function(self) self:x(12):y(7):halign(0):zoomto(100,20) end
	}
}