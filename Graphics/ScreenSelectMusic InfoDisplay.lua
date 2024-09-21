local enableRounds = ThemePrefs.Get("ShowRounds")
local enableLua = ThemePrefs.Get("ShowHasLua")
local courseMode = GAMESTATE:IsCourseMode()
local eventMode = GAMESTATE:IsEventMode()

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local output = ""
			if courseMode then
				if SongOrCourse then
					if SongOrCourse:HasMods() or SongOrCourse:HasTimedMods() then output = "HAS MODS" end
					if output == "" then
						local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
						if trail then
							local entries = trail:GetTrailEntries()
							for i=1,#entries do
								if entries[i]:GetNormalModifiers() ~= "" then
									output = "HAS MODS"
									break
								end
							end
						end
					end
				end
			else
				--[[ Automate my video timestamping this way... Work smarter not harder... ]]--
				--lua.ReportScriptError( SongOrCourse:GetGroupName().." | "..SongOrCourse:GetDisplayFullTitle().." / "..SongOrCourse:GetDisplayArtist() )
				if SongOrCourse and (enableRounds or enableLua) then
					local EC = SongOrCourse:GetPreviewMusicPath()
					if enableRounds then
						if SongOrCourse:IsLong() then
							output = eventMode and "LONG" or "COUNTS AS 2 ROUNDS"
							self:diffuseshift():effectcolor1(color("#FFFF00")):effectcolor2(color("#FFFFFF")):effectclock(EC ~= "" and "beat" or "timerglobal")
						elseif SongOrCourse:IsMarathon() then
							output = eventMode and "MARATHON" or "COUNTS AS 3 ROUNDS"
							self:diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#FFFFFF")):effectclock(EC ~= "" and "beat" or "timerglobal")
						else
							self:stopeffect()
						end
					end
					if enableLua then
						if isOutFox() then
							local step = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
							if step and tobool(LoadFromCache(SongOrCourse,step,"HasLua")) then
								self:rainbow():effectclock(EC ~= "" and "beat" or "timerglobal")
								output = addToOutput(output,"LUA"," & ")
							end
						else
							if HasLuaCheck() then
								self:rainbow():effectclock(EC ~= "" and "beat" or "timerglobal")
								output = addToOutput(output,"LUA"," & ")
							end
						end
					end
					if SongOrCourse:HasLyrics() then
						output = addToOutput(output,"LYRICS"," & ")
					end
				else
					self:stopeffect()
				end
			end
			self:settext(output)
		end,
		EmptyCommand=function(self) self:settext("") end,
		CurrentSongChangedMessageCommand=function(self) if not course then if GAMESTATE:GetCurrentSong() then else self:playcommand("Empty") end end end,
		CurrentCourseChangedMessageCommand=function(self) if course then if GAMESTATE:GetCurrentCourse() then else self:playcommand("Empty") end end end,
		CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentTrailP1ChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
		CurrentTrailP2ChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
	}
}