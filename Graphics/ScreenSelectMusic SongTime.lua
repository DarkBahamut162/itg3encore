local c
local stepsType = StepsTypeSingle()[GetUserPrefN("StylePosition")]
local course = GAMESTATE:IsCourseMode()
local players = GAMESTATE:GetHumanPlayers()
local length = {0.0,0.0,0.0}
local EC = " "
local usesStepCache = ThemePrefs.Get("UseStepCache")

return Def.ActorFrame{
	BeginCommand = function(self) c = self:GetChildren() end,
	Def.BitmapText {
		File = "titlemenu",
		Name="Time",
		Text="Time:",
		InitCommand=function(self) self:x(-103):zoom(1.05):halign(1) end
	},
	Def.BitmapText {
		File = "_r bold bevel numbers",
		InitCommand=function(self) self:x(98):halign(1) end,
		SetCommand=function(self)
			local curSelection = nil
			length = {0.0,0.0,0.0}
			EC = " "
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse()
				if curSelection then
					for pos,player in pairs( players ) do
						local trail = GAMESTATE:GetCurrentTrail(player)
						if trail then
							if length[1] == 0.0 then length[1] = TrailUtil.GetTotalSeconds(trail) end
							local entries = trail:GetTrailEntries()
							for i=1,#entries do
								local trueSeconds = (usesStepCache and not entries[i]:GetSteps():IsAutogen()) and tonumber(LoadFromCache(entries[i]:GetSong(),entries[i]:GetSteps(),"TrueSeconds")) or 0
								--local trueSeconds = getTrueSeconds(entries[i]:GetSong(),entries[i]:GetSteps())["TrueSeconds"]
								if trueSeconds <= 0 then trueSeconds = entries[i]:GetSong():GetFirstSecond() > entries[i]:GetSong():GetLastSecond() and 0 or entries[i]:GetSong():GetLastSecond()-entries[i]:GetSong():GetFirstSecond() end
								length[pos+1] = length[pos+1] + trueSeconds
							end
						end
					end
				end
			else
				curSelection = GAMESTATE:GetCurrentSong()
				if curSelection then
					EC = curSelection:GetPreviewMusicPath()
					length[1] = curSelection:MusicLengthSeconds()
					for pos,player in pairs( players ) do
						local steps = GAMESTATE:GetCurrentSteps(player)
						if steps and not steps:IsAutogen() then length[pos+1] = usesStepCache and tonumber(LoadFromCache(curSelection,steps,"TrueSeconds")) or 0 end
						--if steps then length[pos+1] = getTrueSeconds(curSelection,steps)["TrueSeconds"] end
						if length[pos+1] <= 0 then length[pos+1] = curSelection:GetFirstSecond() > curSelection:GetLastSecond() and 0 or curSelection:GetLastSecond()-curSelection:GetFirstSecond() end
					end
				else
					local songs = SONGMAN:GetSongsInGroup(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
					for s=1,#songs do
						if songs[s]:HasStepsType(stepsType) then
							length[1] = length[1] + songs[s]:MusicLengthSeconds()
							length[2] = length[2] + (songs[s]:GetFirstSecond() > songs[s]:GetLastSecond() and 0 or songs[s]:GetLastSecond()-songs[s]:GetFirstSecond())
						end
					end
				end
			end

			local MusicRate = math.round(GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate(),1)

			for i=1,#length do
				if length[i] < 0 then length[i] = 0.001 else length[i] = math.round(length[i],3) end
				length[i] = length[i] / MusicRate
			end
			MESSAGEMAN:Broadcast('SetTime')
			if length[1] >= 6000 then c.Time:x(-103-(math.floor(math.log10(length[1]/6000)+1)*28)) else c.Time:x(-103) end
			self:settext( SecondsToMMSSMsMs(length[1]) )
		end,
		RateChangedMessageCommand=function(self, params) self:playcommand("Set") end,
		CurrentSongChangedMessageCommand=function(self) if not course then self:queuecommand("Set") end end,
		CurrentStepsP1ChangedMessageCommand=function(self) if not course then self:queuecommand("Set") end end,
		CurrentStepsP2ChangedMessageCommand=function(self) if not course then self:queuecommand("Set") end end,
		CurrentCourseChangedMessageCommand=function(self) if course then self:queuecommand("Set") end end,
		CurrentTrailP1ChangedMessageCommand=function(self) if course then self:queuecommand("Set") end end,
		CurrentTrailP2ChangedMessageCommand=function(self) if course then self:queuecommand("Set") end end
	},
	Def.BitmapText {
		File = "_r bold bevel numbers",
		InitCommand=function(self) self:x(98):y(-30):halign(1) end,
		SetTimeMessageCommand=function(self)
			if length[3] ~= 0.0 then
				local color1 = length[3] == length[2] and PlayerColor(PLAYER_1) or PlayerColor(PLAYER_2)
				local color2 = length[3] == length[2] and PlayerColor(PLAYER_2) or color("#FFFFFF")
				self:diffusealpha(1):settext(SecondsToMMSSMsMs(length[3])):diffuseshift():effectcolor1(color1):effectcolor2(color2):effectclock(EC ~= "" and "beat" or "timerglobal")
			elseif length[2] ~= 0.0 then
				local color1 = #players == 2 and PlayerColor(PLAYER_1) or PlayerColor(GAMESTATE:GetMasterPlayerNumber())
				local color2 = #players == 2 and PlayerColor(PLAYER_2) or color("#FFFFFF")
				self:diffusealpha(1):settext(SecondsToMMSSMsMs(length[2])):diffuseshift():effectcolor1(color1):effectcolor2(color2):effectclock(EC ~= "" and "beat" or "timerglobal")
			else
				self:diffusealpha(0)
			end
		end
	},
	Def.BitmapText {
		File = "_r bold bevel numbers",
		InitCommand=function(self) self:x(98):y(-60):halign(1) end,
		SetTimeMessageCommand=function(self)
			if length[3] ~= 0.0 and length[2] ~= length[3] then
				self:diffusealpha(1):settext(SecondsToMMSSMsMs(length[2])):diffuseshift():effectcolor1(PlayerColor(PLAYER_1)):effectcolor2(color("#FFFFFF")):effectclock(EC ~= "" and "beat" or "timerglobal")
			else
				self:diffusealpha(0)
			end
		end
	}
}