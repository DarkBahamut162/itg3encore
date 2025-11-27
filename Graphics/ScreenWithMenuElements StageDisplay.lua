local screen = Var "LoadingScreen"
local isEvaluation = screen:find("Evaluation")
local before = GetTotalStageCost(isEvaluation)
local enableTrueRounds = ThemePrefs.Get("TrueRounds")

return Def.ActorFrame{
	Def.BitmapText {
		File = "_z bold 19px",
		InitCommand=function(self) self:shadowlength(1) end,
		BeginCommand=function(self) self:playcommand("Set") end,
		CurrentSongChangedMessageCommand=function(self) self:finishtweening():playcommand("Set") end,
		CurrentStepsP1ChangedMessageCommand=function(self) self:finishtweening():playcommand("Set") end,
		CurrentStepsChangedMessageCommand=function(self) self:finishtweening():playcommand("Set") end,
		CurrentStepsP2ChangedMessageCommand=function(self) self:finishtweening():playcommand("Set") end,
		SetCommand=function(self)
			local curStage = isEtterna() and 'Stage_Event' or isEvaluation and STATSMAN:GetCurStageStats():GetStage() or GAMESTATE:GetCurrentStage()
			local stageNum = curStage:gsub("%D+", "")
			local songsPerPlay = isEtterna("0.55") and 0 or PREFSMAN:GetPreference("SongsPerPlay")
			if stageNum == songsPerPlay then curStage = 'Stage_Final' end
			if curStage == "Stage_Final" then stageNum = songsPerPlay end
			if GAMESTATE:IsEventMode() then curStage = 'Stage_Event'else
				if not GAMESTATE:IsCourseMode() and not isEtterna() and enableTrueRounds then
					local current = GetCurrentTrueStageCost()
					local total = before+current
					if total == songsPerPlay then
						curStage = 'Stage_Final'
					elseif before+1 ~= stageNum then
						local add = {
							[1] = "st",
							[2] = "nd",
							[3] = "rd"
						}
						curStage = "Stage_"..(before+1)..(add[(before+1)] and add[(before+1)] or "th")
					end
				end
			end
			if IsNetSMOnline() then curStage = 'Stage_Online' end
			self:settext(THEME:GetString("Stages",ToEnumShortString(curStage))):maxwidth(240)
		end
	}
}