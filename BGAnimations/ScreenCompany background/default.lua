return Def.ActorFrame{
	Def.Sprite {
		Texture="roxor video",
		Condition=not isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture="bga",
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Sprite {
		Texture="particle",
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen():blend(Blend.Add) end
	},
	Def.Sprite {
		Texture="roxor logo",
		Condition=isFinal(),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoomtowidth(SCREEN_WIDTH/5*4):zoomtoheight(SCREEN_HEIGHT/2) end
	}
}