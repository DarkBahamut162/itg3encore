return Def.ActorFrame{
	Def.Sprite {
		Texture = "_lside",
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_LEFT):zoom(WideScreenDiff()):halign(0):valign(0) end,
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	},
	Def.Sprite {
		Texture = "_width "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:x(isFinal() and SCREEN_LEFT or 180*WideScreenDiff()):zoom(WideScreenDiff()):valign(0):halign(0):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	},
	Def.Sprite {
		Texture = "_rside",
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_RIGHT):zoom(WideScreenDiff()):halign(1):valign(0) end,
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	},
	Def.Sprite {
		Texture = "_lmask",
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_LEFT):zoom(WideScreenDiff()):halign(0):valign(0):zwrite(true):blend(Blend.NoEffect):draworder(110) end,
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	}
}