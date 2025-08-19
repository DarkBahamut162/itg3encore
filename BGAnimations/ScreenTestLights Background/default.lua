return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenStageInformation","in/rear"),
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:Center() end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenStageInformation","in/bottom/lines"),
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:Center():diffusealpha(0):accelerate(0.3):diffusealpha(1) end
	}
}