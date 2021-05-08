local player = ...
assert(player,"[ScreenEvaluation PeakComboAward] requires player")
--[[
local award
local combo = "combo"
if topScreen then
	stageStats = topScreen:GetStageStats()
	playerStageStats = stageStats:GetPlayerStageStats(player)
	award = playerStageStats:GetPeakComboAward()
	combo = ToEnumShortString(award)
end
combo = "fuck"

local awardRef = {
	PeakComboAward_1000  = { File = THEME:GetPathG("_award","models/ribbon"), Color = "purple" },
	PeakComboAward_2000  = { File = THEME:GetPathG("_award","models/ribbon"), Color = "red" },
	PeakComboAward_3000  = { File = THEME:GetPathG("_award","models/ribbon"), Color = "orange" },
	PeakComboAward_4000  = { File = THEME:GetPathG("_award","models/plaque"), Color = "silver" },
	PeakComboAward_5000  = { File = THEME:GetPathG("_award","models/plaque"), Color = "gold" },
	PeakComboAward_6000  = { File = THEME:GetPathG("_award","models/trophy"), Color = "silver" },
	PeakComboAward_7000  = { File = THEME:GetPathG("_award","models/trophy"), Color = "gold" },
	PeakComboAward_8000  = { File = THEME:GetPathG("_award","models/itg"), Color = "silver" },
	PeakComboAward_9000  = { File = THEME:GetPathG("_award","models/itg"), Color = "gold" },
	PeakComboAward_10000 = { File = THEME:GetPathG("_award","models/itg"), Color = "blue" },
};
--]]

return Def.ActorFrame{
	InitCommand=function(self)
		local comboText = self:GetChild("Combo")

		local topScreen = SCREENMAN:GetTopScreen()
		local stageStats,playerStageStats
		local award, comboNum
		if topScreen then
			stageStats = topScreen:GetStageStats()
			playerStageStats = stageStats:GetPlayerStageStats(player)
			award = playerStageStats:GetPeakComboAward()
			comboNum = ToEnumShortString(award)
		end

		comboText:settext(comboNum)
	end;
	--[[
	LoadActor(awardRef[award].File,awardRef[award].Color)..{
		Name="Trophy";
		InitCommand=function(self) self:zoom(0.7):x(60):y(-80):rotationy(-15) end;
	};
	--]]
	LoadFont("_eurostile normal")..{
		Name="Combo";
		InitCommand=function(self) self:halign(0):shadowlength(2):maxwidth(250) end;
	};
};