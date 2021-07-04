local player = ...
assert(player,"[ScreenEvaluation PeakComboAward] requires player")
local failed = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed()

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

local combo = PlayerMaxCombo(player)
local combo_ = math.floor(combo/1000)*1000;
if combo_ > 10000 then combo_ = 10000 end;
local award = "PeakComboAward_"..combo_;

local t = Def.ActorFrame{};

if combo_ > 0 and not failed then
	t[#t+1] = LoadActor(awardRef[award].File,awardRef[award].Color)..{
		Name="Trophy";
		InitCommand=function(self) self:zoom(0.7):x(60):y(-80):rotationy(-15) end;
	};
	t[#t+1] = LoadFont("_eurostile normal")..{
		Name="Combo";
		InitCommand=function(self) self:halign(0):shadowlength(2):maxwidth(250):settext(THEME:GetString( "PeakComboAward", combo_ ) ) end;
	};
end

return t