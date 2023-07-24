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
			local length = {0.0,0.0}
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse()
				if curSelection then
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
					if trail then
						length[1] = TrailUtil.GetTotalSeconds(trail)
					end
				end
			else
				curSelection = GAMESTATE:GetCurrentSong()
				if curSelection then
					length[1] = curSelection:MusicLengthSeconds()
					length[2] = length[2] + curSelection:GetLastSecond()-curSelection:GetFirstSecond()
				else
					local songs = SONGMAN:GetSongsInGroup(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
					for s=1,#songs do
						if songs[s]:HasStepsType(stepsType) then
							length[1] = length[1] + songs[s]:MusicLengthSeconds()
							length[2] = length[2] + songs[s]:GetLastSecond()-songs[s]:GetFirstSecond()
						end
					end
				end
				MESSAGEMAN:Broadcast('SetTimeP1', {Time = length[2]})
			end
			if length[1] >= 6000 then c.Time:x(-131) else c.Time:x(-103) end
			self:settext( SecondsToMMSSMsMs(length[1]) )
		end,
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end,
		CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end
	},
	LoadFont("_r bold bevel numbers")..{
		Condition=not GAMESTATE:IsCourseMode(),
		Name="P1",
		InitCommand=function(self)
			self:x(98):y(-30):halign(1):diffuseshift():effectcolor1(PlayerColor(GAMESTATE:GetMasterPlayerNumber())):effectcolor2(color("#FFFFFF")):effectclock("beat")
		end,
		SetTimeP1MessageCommand=function(self,param) self:settext(SecondsToMMSSMsMs(param.Time)) end
	}
}