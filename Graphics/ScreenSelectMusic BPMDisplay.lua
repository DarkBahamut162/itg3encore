return Def.ActorFrame{
	Def.BPMDisplay{
		Name="BPMDisplay";
		Font="BPMDisplay bpm";
		InitCommand=function(self) self:halign(1):zoom(0.66) end;
		SetCommand=function(self) self:SetFromGameState() end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
	};
};