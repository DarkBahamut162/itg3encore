local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	OnCommand=function(self) self:diffusealpha(0):sleep(0.85):linear(0.2):diffusealpha(1) end,
	OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:y(isFinal() and 72 or 73.5):zoom(isFinal() and 0.4 or 0.333):shadowlength(1):maxwidth(SCREEN_CENTER_X*1.6) end,
		SetCommand=function(self)
			if ThemePrefs.Get("ShowStepCounter") and isOutFox() and not GAMESTATE:IsCourseMode() then
				local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
				local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				local output = ""
				local loadStepCounter = ""
				local loadScratches = ""
				local loadScratchJumps = ""
				local loadFoots = ""

				if SongOrCourse and StepsOrTrail then
					loadStepCounter = LoadFromCache(SongOrCourse,StepsOrTrail,"StepCounter")
					if IsGame("be-mu") then
						loadScratches = LoadFromCache(SongOrCourse,StepsOrTrail,"Scratches")
						loadScratchJumps = LoadFromCache(SongOrCourse,StepsOrTrail,"ScratchJumps")
						if GetUserPrefN("StylePosition") == 2 then
							loadFoots = LoadFromCache(SongOrCourse,StepsOrTrail,"Foots")
						end
					end
					if loadStepCounter and loadStepCounter ~= "" then
						loadStepCounter = split("_",loadStepCounter)
						for i=1,#loadStepCounter do
							local temp = ""
							if loadStepCounter[i] and tonumber(loadStepCounter[i]) > 0 then
								for dot=1,i do temp = addToOutput(temp,"•") end
								output = addToOutput(output,temp.." "..loadStepCounter[i]," | ")
							end
						end
					end
					if loadScratches and not (loadScratches == "" or loadScratches == "0") then output = addToOutput(output,"Scratches: "..loadScratches.."/"..loadScratchJumps," | ") end
					if loadFoots and not (loadFoots == "" or loadFoots == "0") then output = addToOutput(output,"Foots: "..loadFoots," | ") end

					if output == "" then
						local EC = not courseMode and SongOrCourse:GetPreviewMusicPath() or " "
						self:diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#FFFFFF")):effectclock(EC ~= "" and "beat" or "timerglobal")
						if StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds') == 0 then
							output = "NOTHING TO LOAD"
						else
							output = "FAILED TO LOAD"
						end
					else
						self:stopeffect()
					end
					
					local rv = StepsOrTrail:GetRadarValues(player)
					local lifts = rv:GetValue('RadarCategory_Lifts')

					if lifts and lifts ~= 0 then output = addToOutput(output,"Lifts: "..lifts," | ") end
				end

				self:settext(output)
			end
		end,
		EmptyCommand=function(self) self:settext("") end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if not GAMESTATE:GetCurrentSong() then self:playcommand("Empty") end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if not GAMESTATE:GetCurrentCourse() then self:playcommand("Empty") end end end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end
	}
}