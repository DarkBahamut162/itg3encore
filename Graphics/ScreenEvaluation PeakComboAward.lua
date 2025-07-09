local player = ...
assert(player,"[ScreenEvaluation PeakComboAward] requires player")

local t = Def.ActorFrame{}

if getenv("EvalCombo"..pname(player)) then
	local award = not isEtterna() and STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPeakComboAward() or nil
	if isEtterna() then
		local MaxCombo = math.min(math.floor(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):MaxCombo()/1000)*1000,10000)
		if MaxCombo > 0 then award = "PeakComboAward_"..MaxCombo end
	end
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

	if award then
		t[#t+1] = loadfile(awardRef[award].File)(awardRef[award].Color)..{
			Name="Trophy",
			InitCommand=function(self) self:zoom(0.7):x(60):y(-80):rotationy(-15) end
		}
		t[#t+1] = Def.BitmapText {
			File = "_eurostile normal",
			Name="Combo",
			InitCommand=function(self) self:halign(0):shadowlength(2*WideScreenDiff()):maxwidth(220):settext(THEME:GetString( "PeakComboAward", ToEnumShortString(award) ) ) end
		}
	end
end

return t