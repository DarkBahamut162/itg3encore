return Def.ActorFrame{
	LoadActor("roxor video")..{
		Condition=not isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	LoadActor("bga")..{
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen() end
	},
	LoadActor("particle")..{
		Condition=isFinal(),
		InitCommand=function(self) self:FullScreen():blend(Blend.Add) end
	},
	LoadActor("roxor logo")..{
		Condition=isFinal(),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoomtowidth(SCREEN_WIDTH/5*4):zoomtoheight(SCREEN_HEIGHT/2) end
	}
}