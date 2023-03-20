return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		Text="BPM:",
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()):halign(1) end
	},
	Def.BPMDisplay{
		Name="BPMDisplay",
		Font="BPMDisplay bpm",
		InitCommand=function(self) self:halign(1):zoom(0.66*WideScreenDiff()) end,
		SetCommand=function(self) self:SetFromGameState() end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end
	}
}