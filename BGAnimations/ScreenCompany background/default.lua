return Def.ActorFrame{
	LoadActor("roxor video")..{
		Condition=not isFinal(),
		InitCommand=function(self) self:Center():zoom(4/3) end
	},
	LoadActor("bga")..{
		Condition=isFinal(),
		InitCommand=function(self) self:Center():zoomtoheight(SCREEN_HEIGHT) end
	},
	LoadActor("particle")..{
		Condition=isFinal(),
		InitCommand=function(self) self:Center():zoomtoheight(SCREEN_HEIGHT):blend(Blend.Add) end
	},
	LoadActor("roxor logo")..{
		Condition=isFinal(),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoomtowidth(SCREEN_WIDTH/5*4):zoomtoheight(SCREEN_HEIGHT/2) end
	}
}