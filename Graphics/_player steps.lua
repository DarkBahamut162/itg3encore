local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()
local Steps, Techs

return Def.ActorFrame{
	BeginCommand=function(self)
		if ThemePrefs.Get("ShowStepCounter") and ThemePrefs.Get("ShowTechCounter") then
			Steps:queuecommand("AnimateSteps")
			Techs:queuecommand("AnimateTechs")
		else
			Steps:stoptweening():diffusealpha(1)
			Techs:stoptweening():diffusealpha(0)
		end
	end,
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	Def.BitmapText {
		Name="Steps",
		File = "_r bold 30px",
		InitCommand=function(self) Steps = self self:y(isFinal() and 72 or 73.5):zoom(isFinal() and 0.4 or 0.333):shadowlength(1):maxwidth(SCREEN_CENTER_X*1.6) end,
		SetCommand=function(self)
			if ThemePrefs.Get("ShowStepCounter") and ThemePrefs.Get("UseStepCache") and not courseMode then
				local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				local output = ""

				if SongOrCourse and StepsOrTrail then
					local loadStepCounter = LoadFromCache(SongOrCourse,StepsOrTrail,"StepCounter")
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
					if IsGame("be-mu") or IsGame("beat") then
						local loadScratches = LoadFromCache(SongOrCourse,StepsOrTrail,"Scratches")
						if loadScratches and not (loadScratches == "" or loadScratches == "0") then output = addToOutput(output,"Scratches: "..loadScratches," | ") end
						if GetUserPrefN("StylePosition") == 2 then
							local loadFoots = LoadFromCache(SongOrCourse,StepsOrTrail,"Foots")
							if loadFoots and not (loadFoots == "" or loadFoots == "0") then output = addToOutput(output,"Foots: "..loadFoots," | ") end
						end
					end

					if output == "" then
						local EC = not courseMode and (VersionDateCheck(20150300) and SongOrCourse:GetPreviewMusicPath() or GetPreviewMusicPath(SongOrCourse)) or " "
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
		AnimateStepsCommand=function(self) self:diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):queuecommand("AnimateSteps") end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if not GAMESTATE:GetCurrentSong() then self:playcommand("Empty") end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if not GAMESTATE:GetCurrentCourse() then self:playcommand("Empty") end end end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end
	},
	Def.BitmapText {
		Name="Techs",
		File = "_r bold 30px",
		InitCommand=function(self) Techs = self self:y(isFinal() and 72 or 73.5):zoom(isFinal() and 0.4 or 0.333):shadowlength(1):maxwidth(SCREEN_CENTER_X*1.6) end,
		SetCommand=function(self)
			if ThemePrefs.Get("ShowTechCounter") then
				local steps = not courseMode and GAMESTATE:GetCurrentSteps(player) or nil
				local output = ""
				if steps then
					if isITGmania(20250313) then
						local techCounts = steps:CalculateTechCounts(player)

						local Crossovers = techCounts:GetValue("TechCountsCategory_Crossovers")
						local Footswitches = techCounts:GetValue("TechCountsCategory_Footswitches")
						local Sideswitches = techCounts:GetValue("TechCountsCategory_Sideswitches")
						local Jacks = techCounts:GetValue("TechCountsCategory_Jacks")
						local Brackets = techCounts:GetValue("TechCountsCategory_Brackets")
						if Crossovers > 0 then output = addToOutput(output,Crossovers.." Crossover"..(Crossovers > 1 and "s" or "")," | ") end
						if Footswitches > 0 then output = addToOutput(output,Footswitches.." Footswitch"..(Footswitches > 1 and "es" or "")," | ") end
						if Sideswitches > 0 then output = addToOutput(output,Sideswitches.." Sideswitch"..(Sideswitches > 1 and "es" or "")," | ") end
						if Jacks > 0 then output = addToOutput(output,Jacks.." Jack"..(Jacks > 1 and "s" or "")," | ") end
						if Brackets > 0 then output = addToOutput(output,Brackets.." Bracket"..(Brackets > 1 and "s" or "")," | ") end
					else
						local Crossovers, Footswitches, Sideswitches, Jacks, Brackets = GetTechniques(SMParser(steps).."\n")
						if Crossovers > 0 then output = addToOutput(output,Crossovers.." Crossover"..(Crossovers > 1 and "s" or "")," | ") end
						if Footswitches > 0 then output = addToOutput(output,Footswitches.." Footswitch"..(Footswitches > 1 and "es" or "")," | ") end
						if Sideswitches > 0 then output = addToOutput(output,Sideswitches.." Sideswitch"..(Sideswitches > 1 and "es" or "")," | ") end
						if Jacks > 0 then output = addToOutput(output,Jacks.." Jack"..(Jacks > 1 and "s" or "")," | ") end
						if Brackets > 0 then output = addToOutput(output,Brackets.." Bracket"..(Brackets > 1 and "s" or "")," | ") end
					end
					self:settext(output == "" and "No Tech" or output)
				end
			end
		end,
		EmptyCommand=function(self) self:settext("") end,
		AnimateTechsCommand=function(self) self:diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):queuecommand("AnimateTechs") end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if not GAMESTATE:GetCurrentSong() then self:playcommand("Empty") end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if not GAMESTATE:GetCurrentCourse() then self:playcommand("Empty") end end end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end
	}
}