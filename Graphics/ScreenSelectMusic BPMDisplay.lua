local t = Def.ActorFrame{
	Def.BPMDisplay{
		Name="BPMDisplay";
		Font="BPMDisplay bpm";
		InitCommand=cmd(halign,1;zoom,0.66);
		SetCommand=function(self) self:SetFromGameState(); end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
	};
};

return t;