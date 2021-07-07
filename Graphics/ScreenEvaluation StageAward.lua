local player = ...
assert(player,"[ScreenEvaluation StageAward] requires player")
local award;
local checkFC = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):FullCombo()

local awardRef = {
	["80PercentW3"]       = { File = THEME:GetPathG("_award","models/ribbon"), Color = "green" },
	["90PercentW3"]       = { File = THEME:GetPathG("_award","models/plaque"), Color = "green" },
	["100PercentW3"]      = { File = THEME:GetPathG("_award","models/trophy"), Color = "green" },
	["SingleDigitW3"]     = { File = THEME:GetPathG("_award","models/ribbon"), Color = "pink" },
	["OneW3"]             = { File = THEME:GetPathG("_award","models/flag"), Color = "green" },
	["FullComboW3"]       = { File = THEME:GetPathG("_award","models/ribbon"), Color = "blue" },
	["SingleDigitW2"]     = { File = THEME:GetPathG("_award","models/plaque"), Color = "silver" },
	["OneW2"]             = { File = THEME:GetPathG("_award","models/flag"), Color = "orange" },
	["FullComboW2"]       = { File = THEME:GetPathG("_award","models/plaque"), Color = "bronze" },
	["FullComboW1"]       = { File = THEME:GetPathG("_award","models/trophy"), Color = "bronze" },
};

local steps = GetRadarData(player,"RadarCategory_TapsAndHolds");
local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local W1FC = pss:FullComboOfScore('TapNoteScore_W1');
local W1 = pss:GetTapNoteScores('TapNoteScore_W1');
local W2FC = pss:FullComboOfScore('TapNoteScore_W2');
local W2 = pss:GetTapNoteScores('TapNoteScore_W2');
local W3FC = pss:FullComboOfScore('TapNoteScore_W3');
local W3 = pss:GetTapNoteScores('TapNoteScore_W3');
local percent = W3 / steps;

if percent >= 0.8 then
	if percent >= 0.8 and percent < 0.9 then
		award = "80PercentW3";
	elseif percent >= 0.9 and percent < 1 then
		award = "90PercentW3";
	elseif percent == 1 then
		award = "100PercentW3";
	end
elseif W3FC then
	if W3 > 1 and W3 < 10 then
		award = "SingleDigitW3";
	elseif W3 == 1 then
		award = "OneW3";
	elseif W3 == 0 then
		award = "FullComboW3";
	end 
elseif W2FC then
	if W2 > 1 and W2 < 10 then
		award = "SingleDigitW2";
	elseif W2 == 1 then
		award = "OneW2";
	elseif W2 == 0 then
		award = "FullComboW2";
	end 
elseif W1FC then
	award = "FullComboW1";
end

local t = Def.ActorFrame{};

if award ~= nil and checkFC then
	t[#t+1] = LoadActor(awardRef[award].File,awardRef[award].Color)..{
		Name="Trophy";
		InitCommand=function(self) self:zoom(0.7):x(-60):y(-80):rotationy(-15) end;
	};
	t[#t+1] = LoadFont("_eurostile normal")..{
		Name="Text";
		InitCommand=function(self) self:halign(1):shadowlength(2):maxwidth(250):settext(THEME:GetString( "StageAward", award )) end;
	};
end

return t