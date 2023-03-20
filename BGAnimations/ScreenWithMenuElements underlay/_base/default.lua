return Def.ActorFrame{
	LoadActor("_lside")..{
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom) end,
		OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
		OffCommand=function(self) self:accelerate(0.5):addy(100) end
	},
	LoadActor("width")..{
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_LEFT+48*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end,
		OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
		OffCommand=function(self) self:accelerate(0.5):addy(100) end
	},
	LoadActor("width")..{
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_RIGHT-48*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end,
		OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
		OffCommand=function(self) self:accelerate(0.5):addy(100) end
	},
	LoadActor("_rside")..{
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom) end,
		OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
		OffCommand=function(self) self:accelerate(0.5):addy(100) end
	},
	LoadActor("base "..(isFinal() and "final" or "normal"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM):zoom(WideScreenDiff()):valign(1) if isFinal() then self:zoomtowidth(SCREEN_WIDTH) end end,
		OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
		OffCommand=function(self) self:accelerate(0.5):addy(100) end
	}
}