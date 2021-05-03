local t = Def.ActorFrame{
	Def.BPMDisplay{
		Name="BPMDisplay";
		Font="BPMDisplay bpm";
		InitCommand=cmd(halign,1;zoom,0.66);
		SetCommand=function(self) self:SetFromGameState(); end;
		CurrentSongChangedMessageCommand=cmd(playcommand,'Set');
		CurrentCourseChangedMessageCommand=cmd(playcommand,'Set');
	};
};

return t;