local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:y(72):diffusealpha(0):zoomx(1/2):zoomy(1/3):shadowlength(2):maxwidth(SCREEN_CENTER_X) end,
		OnCommand=function(self) self:sleep(0.85):linear(0.2):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self)
			if ThemePrefs.Get("ShowStepCounter") and isOutFox() and not GAMESTATE:IsCourseMode() then
				local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
				local StepOrTrails = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				local output = ""
				local loadStepCounter = ""
				local loadScratches = ""
				local loadFoots = ""

				if SongOrCourse and StepOrTrails then
					loadStepCounter = LoadFromCache(SongOrCourse,StepOrTrails,"StepCounter")
					if IsGame("be-mu") then
						loadScratches = LoadFromCache(SongOrCourse,StepOrTrails,"Scratches")
						if GetUserPrefN("StylePosition") == 2 then
							loadFoots = LoadFromCache(SongOrCourse,StepOrTrails,"Foots")
						end
					end
					if loadStepCounter and loadStepCounter ~= "" then
						loadStepCounter = split("_",loadStepCounter)
						for i=1,#loadStepCounter do
							if loadStepCounter[i] and tonumber(loadStepCounter[i]) > 0 then
								output = addToOutput(output,i.."s: "..loadStepCounter[i]," | ")
							end
						end
					end
					if loadScratches and loadScratches ~= "" then output = addToOutput(output,"Scratches: "..loadScratches," | ") end
					if loadFoots and loadFoots ~= "" then output = addToOutput(output,"Foots: "..loadFoots," | ") end
				end

				self:settext(output)
			end
		end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end
	}
}