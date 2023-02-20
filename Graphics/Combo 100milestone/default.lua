return Def.ActorFrame{
	LoadActor("explosion")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end,
		MilestoneCommand=function(self) self:finishtweening():zoom(0):linear(0.1):zoom(2.4):diffusealpha(1):linear(0.5):zoom(2):diffusealpha(0) end
	},
	LoadActor("explosion")..{
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end,
		MilestoneCommand=function(self) self:finishtweening():zoom(0):linear(0.1):zoom(2.4):diffusealpha(1):linear(0.5):zoom(2):diffusealpha(0) end
	}
}