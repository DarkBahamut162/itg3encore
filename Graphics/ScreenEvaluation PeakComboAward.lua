local player = ...
assert(player,"[ScreenEvaluation PeakComboAward] requires player")

local awardRef = {
	["PeakComboAward_1000"]		= { File = THEME:GetPathG("_award","models/ribbon"), Color = "purple" },
	["PeakComboAward_2000"]		= { File = THEME:GetPathG("_award","models/ribbon"), Color = "red" },
	["PeakComboAward_3000"]		= { File = THEME:GetPathG("_award","models/ribbon"), Color = "orange" },
	["PeakComboAward_4000"]		= { File = THEME:GetPathG("_award","models/plaque"), Color = "silver" },
	["PeakComboAward_5000"]		= { File = THEME:GetPathG("_award","models/plaque"), Color = "gold" },
	["PeakComboAward_6000"]		= { File = THEME:GetPathG("_award","models/trophy"), Color = "silver" },
	["PeakComboAward_7000"]		= { File = THEME:GetPathG("_award","models/trophy"), Color = "gold" },
	["PeakComboAward_8000"]		= { File = THEME:GetPathG("_award","models/itg"), Color = "silver" },
	["PeakComboAward_9000"]		= { File = THEME:GetPathG("_award","models/itg"), Color = "gold" },
	["PeakComboAward_10000"]	= { File = THEME:GetPathG("_award","models/itg"), Color = "blue" }
}

local t = Def.ActorFrame{}
local award = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPeakComboAward()

if award then
	t[#t+1] = LoadActor(awardRef[award].File,awardRef[award].Color)..{
		Name="Trophy",
		InitCommand=function(self) self:zoom(0.7*WideScreenDiff()):x(60*WideScreenDiff()):y(-80*WideScreenDiff()):rotationy(-15) end
	}
	t[#t+1] = LoadFont("_eurostile normal")..{
		Name="Combo",
		InitCommand=function(self) self:zoom(WideScreenDiff()):halign(0):shadowlength(2):maxwidth(220):settext(THEME:GetString( "PeakComboAward", ToEnumShortString(award) ) ) end
	}
end

return t