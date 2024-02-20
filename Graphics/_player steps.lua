local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:y(isFinal() and 72 or 73.5):diffusealpha(0):zoom(isFinal() and 0.4 or 0.333):shadowlength(1):maxwidth(SCREEN_CENTER_X) end,
		OnCommand=function(self) self:sleep(0.85):linear(0.2):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self)
			if ThemePrefs.Get("ShowStepCounter") and isOutFox() and not GAMESTATE:IsCourseMode() then
				local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
				local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				local output = ""
				local loadStepCounter = ""
				local loadScratches = ""
				local loadFoots = ""

				if SongOrCourse and StepsOrTrail then
					loadStepCounter = LoadFromCache(SongOrCourse,StepsOrTrail,"StepCounter")
					if IsGame("be-mu") then
						loadScratches = LoadFromCache(SongOrCourse,StepsOrTrail,"Scratches")
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
					if loadScratches and loadScratches ~= "" then output = addToOutput(output,"Scratches: "..loadScratches," | ") end
					if loadFoots and loadFoots ~= "" then output = addToOutput(output,"Foots: "..loadFoots," | ") end
					
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