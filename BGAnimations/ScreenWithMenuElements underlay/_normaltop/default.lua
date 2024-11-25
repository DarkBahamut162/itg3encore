local length1 = 180*WideScreenDiff()
local length2 = 630*WideScreenDiff()
local length3 = 450*WideScreenDiff()

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
		InitCommand=function(self) self:x(isFinal() and SCREEN_LEFT or SCREEN_LEFT+length1):zoom(WideScreenDiff()):valign(0):halign(0):zoomtowidth(isFinal() and SCREEN_WIDTH or SCREEN_WIDTH-length2) end,
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
		InitCommand=function(self) self:x(SCREEN_LEFT):zoom(WideScreenDiff()):halign(0):valign(0):blend(Blend.NoEffect):zwrite(true):draworder(110) end,
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	},
	Def.Sprite {
		Texture = "up1",
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_LEFT):zoom(WideScreenDiff()):halign(0):valign(0):diffusealpha(0) end,
		OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:sleep(0.9):diffusealpha(1)
			:cropleft(-0.3*(SCREEN_WIDTH/length1)):cropright(1):faderight(0.1*(SCREEN_WIDTH/length1)):fadeleft(0.1*(SCREEN_WIDTH/length1))
			:linear(2.5*(length1/SCREEN_WIDTH))
			:cropleft(1):cropright(-0.3*(SCREEN_WIDTH/length1))
			:sleep(0.1+(2.5*((SCREEN_WIDTH-length1)/SCREEN_WIDTH))):queuecommand("On") end,
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(-100) end
	},
	Def.Sprite {
		Texture = "up2",
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_LEFT+length1):zoom(WideScreenDiff()):valign(0):halign(0):zoomtowidth(SCREEN_WIDTH-length2):diffusealpha(0) end,
		OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:sleep(0.9+(2.5*(length1*0.6/SCREEN_WIDTH))):diffusealpha(1)
			:cropleft(-0.3*(SCREEN_WIDTH/(SCREEN_WIDTH-length2))):cropright(1):faderight(0.1*(SCREEN_WIDTH/(SCREEN_WIDTH-length2))):fadeleft(0.1*(SCREEN_WIDTH/(SCREEN_WIDTH-length2)))
			:linear(2.5*((SCREEN_WIDTH-length2)/SCREEN_WIDTH))
			:cropleft(1):cropright(-0.3*(SCREEN_WIDTH/(SCREEN_WIDTH-length2)))
			:sleep(0.1+(2.5*(length1*0.4/SCREEN_WIDTH))+(2.5*(length3/SCREEN_WIDTH))):queuecommand("On") end,
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(-100) end
	},
	Def.Sprite {
		Texture = "up3",
		Condition=not isFinal(),
		InitCommand=function(self) self:x(SCREEN_RIGHT):zoom(WideScreenDiff()):halign(1):valign(0):diffusealpha(0) end,
		OnCommand=function(self) self:queuecommand("Animate") end,
		AnimateCommand=function(self) self:sleep(0.9+(2.5*((SCREEN_WIDTH-length3)*0.6/SCREEN_WIDTH))):diffusealpha(1)
			:cropleft(-0.3*(SCREEN_WIDTH/length3)):cropright(1):faderight(0.1*(SCREEN_WIDTH/length3)):fadeleft(0.1*(SCREEN_WIDTH/length3))
			:linear(2.5*(length3/SCREEN_WIDTH))
			:cropleft(1):cropright(-0.3*(SCREEN_WIDTH/length3))
			:sleep(0.1+(2.5*((SCREEN_WIDTH-length3)*0.4/SCREEN_WIDTH))):queuecommand("On") end,
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(-100) end
	}
}