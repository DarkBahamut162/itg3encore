local player = ...
assert(player,"[ScreenEvaluation StageAward] requires player")

local t = Def.ActorFrame{}

if getenv("EvalCombo"..pname(player)) then
	local award = not isEtterna() and STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetStageAward() or nil
	if isEtterna() then
		local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
		if pss:FullCombo() then
			if pss:FullComboOfScore('TapNoteScore_W3') then
				local greats = pss:GetTapNoteScores('TapNoteScore_W3')
				if greats == 1 then
					award = "StageAward_OneW3"
				elseif greats < 10 then
					award = "StageAward_SingleDigitW3"
				else
					award = "StageAward_FullComboW3"
				end
			elseif pss:FullComboOfScore('TapNoteScore_W2') then
				local perfects = pss:GetTapNoteScores('TapNoteScore_W2')
				if perfects == 1 then
					award = "StageAward_OneW2"
				elseif perfects < 10 then
					award = "StageAward_SingleDigitW2"
				else
					award = "StageAward_FullComboW2"
				end
			elseif pss:FullComboOfScore('TapNoteScore_W1') then
				award = "StageAward_FullComboW1"
			end
		else
			local percent = pss:GetPercentageOfTaps('TapNoteScore_W3')
			if percent >= 100 then
				award = "StageAward_100PercentW3"
			elseif percent >= 90 then
				award = "StageAward_90PercentW3"
			elseif percent >= 80 then
				award = "StageAward_80PercentW3"
			end
		end
	end
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
		["StageAward_FullComboW1"]		= { File = THEME:GetPathG("_award","models/trophy"), Color = "bronze" }
	}

	if award and not STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed() then
		t[#t+1] = loadfile(awardRef[award].File)(awardRef[award].Color)..{
			Name="Trophy",
			InitCommand=function(self) self:zoom(0.7):x(-60):y(-80):rotationy(-15) end
		}
		t[#t+1] = Def.BitmapText {
			File = "_eurostile normal",
			Name="Text",
			InitCommand=function(self) self:halign(1):shadowlength(2*WideScreenDiff()):maxwidth(220):settext(THEME:GetString( "StageAward", ToEnumShortString(award) )) end
		}
	end
end

return t