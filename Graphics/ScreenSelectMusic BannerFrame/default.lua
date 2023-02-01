local InitialLoad = false

return Def.ActorFrame{
	Def.ActorFrame{
		Name="Frame",
		LoadActor("frame "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+141):y(SCREEN_CENTER_Y-18) end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		LoadActor("flare")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+143):y(SCREEN_CENTER_Y-18):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0) end,
			RefreshCommand=function(self)
				self:stoptweening(5):zoom(1):diffusealpha(1):sleep(0.1):accelerate(0.2):zoom(1.2):diffusealpha(0)
			end,
			CurrentSongChangedMessageCommand=function(self)
				if InitialLoad then
					self:playcommand("Refresh")
				else
					InitialLoad = true
				end
			end
		}
	}
}