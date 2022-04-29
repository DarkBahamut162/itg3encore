local player = ...
assert(player,"[ScreenEvaluation StageAward] requires player")
local award = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetStageAward();
local failed = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed()

local awardRef = {
	["StageAward_80PercentW3"]		= { File = THEME:GetPathG("_award","models/ribbon"), Color = "green" },
	["StageAward_90PercentW3"]		= { File = THEME:GetPathG("_award","models/plaque"), Color = "green" },
	["StageAward_100PercentW3"]		= { File = THEME:GetPathG("_award","models/trophy"), Color = "green" },
	["StageAward_SingleDigitW3"]	= { File = THEME:GetPathG("_award","models/ribbon"), Color = "pink" },
	["StageAward_OneW3"]			= { File = THEME:GetPathG("_award","models/flag"), Color = "green" },
	["StageAward_FullComboW3"]		= { File = THEME:GetPathG("_award","models/ribbon"), Color = "blue" },
	["StageAward_SingleDigitW2"]	= { File = THEME:GetPathG("_award","models/plaque"), Color = "silver" },
	["StageAward_OneW2"]			= { File = THEME:GetPathG("_award","models/flag"), Color = "orange" },
	["StageAward_FullComboW2"]		= { File = THEME:GetPathG("_award","models/plaque"), Color = "bronze" },
	["StageAward_FullComboW1"]		= { File = THEME:GetPathG("_award","models/trophy"), Color = "bronze" },
};

local t = Def.ActorFrame{};

if award then
	t[#t+1] = LoadActor(awardRef[award].File,awardRef[award].Color)..{
		Name="Trophy";
		InitCommand=function(self) self:zoom(0.7):x(-60):y(-80):rotationy(-15) end;
	};
	t[#t+1] = LoadFont("_eurostile normal")..{
		Name="Text";
		InitCommand=function(self) self:halign(1):shadowlength(2):maxwidth(220):settext(THEME:GetString( "StageAward", ToEnumShortString(award) )) end;
	};
end

return t