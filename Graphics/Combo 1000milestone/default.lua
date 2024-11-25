return Def.ActorFrame{
	Def.Sprite {
		Texture = "shot",
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end,
		ThousandMilestoneCommand=function(self) self:finishtweening():queuecommand("Milestone") end,
		MilestoneCommand=function(self) self:zoomx(-2):zoomy(2):diffusealpha(1):x(0):linear(0.5):diffusealpha(0):x(-150) end
	},
	Def.Sprite {
		Texture = "shot",
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end,
		ThousandMilestoneCommand=function(self) self:finishtweening():queuecommand("Milestone") end,
		MilestoneCommand=function(self) self:zoomx(2):zoomy(2):diffusealpha(1):x(0):linear(0.5):diffusealpha(0):x(150) end
	}
}