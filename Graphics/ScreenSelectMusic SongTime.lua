local c
local stepsType = StepsTypeSingle()[GetUserPrefN("StylePosition")]
return Def.ActorFrame{
	BeginCommand = function(self) c = self:GetChildren() end,
	LoadFont("titlemenu")..{
		Name="Time",
		Text="Time:",
		InitCommand=function(self) self:x(-103):zoom(1.05):halign(1) end
	},
	LoadFont("_r bold bevel numbers")..{
		InitCommand=function(self) self:x(98):halign(1) end,
		SetCommand=function(self)
			local curSelection = nil
			local length = 0.0
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse()
				if curSelection then
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
					if trail then
						length = TrailUtil.GetTotalSeconds(trail)
					end
				end
			else
				curSelection = GAMESTATE:GetCurrentSong()
				if curSelection then
					length = curSelection:MusicLengthSeconds()
				else
					local songs = SONGMAN:GetSongsInGroup(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
					for s=1,#songs do
						if songs[s]:HasStepsType(stepsType) then
							length = length + songs[s]:MusicLengthSeconds()
						end
					end
				end
			end
			if length >= 6000 then c.Time:x(-131) else c.Time:x(-103) end
			self:settext( SecondsToMMSSMsMs(length) )
		end,
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end,
		CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end
	}
}