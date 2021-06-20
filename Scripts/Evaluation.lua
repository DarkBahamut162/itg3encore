function PlayerUsingBothSides()
	local style = GAMESTATE:GetCurrentStyle()
	return style:GetStyleType() == 'StyleType_OnePlayerTwoSides'
end

function EvalX()
	if not PlayerUsingBothSides() then return 0 end

	local Offset = 147
	if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then Offset = Offset * -1 end
	return Offset;
end

function EvalTweenDistance()
	local Distance = SCREEN_WIDTH/2
	if PlayerUsingBothSides() then Distance = Distance * 2 end
	return Distance
end

function ActorFrame:difficultyoffset()
	local XOffset = 85
	if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then XOffset = XOffset * -1 end
	self:addx( XOffset )
	self:addy( 0 )
end

function PlayerMaxCombo(pn)
	if GAMESTATE:IsPlayerEnabled(pn) then
		return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):MaxCombo()
	end	
	return -1
end
