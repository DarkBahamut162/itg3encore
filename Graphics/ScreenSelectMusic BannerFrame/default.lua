local initialLoad = false

return Def.ActorFrame{
	Def.ActorFrame{
		Name="Frame",
		LoadActor("frame "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-18*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		LoadActor("flare")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+142*WideScreenDiff()):y(SCREEN_CENTER_Y-18*WideScreenDiff()):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0) end,
			RefreshCommand=function(self) self:stoptweening(5):zoom(WideScreenDiff()):diffusealpha(1):sleep(0.1):accelerate(0.2):zoom(1.2*WideScreenDiff()):diffusealpha(0) end,
			CurrentSongChangedMessageCommand=function(self) if initialLoad then self:playcommand("Refresh") else initialLoad = true end end
		}
	}
}