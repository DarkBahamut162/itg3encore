function PlayerUsingBothSides()
	local style = GAMESTATE:GetCurrentStyle()
	return style:GetStyleType() == 'StyleType_OnePlayerTwoSides'
end

function EvalX()
	return 0;
end

function EvalTweenDistance()
	local Distance = SCREEN_WIDTH/2
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

function GetRadarData( pnPlayer, rcRadarCategory )
	local tRadarValues
	local StepsOrTrail
	local fDesiredValue = 0
	if GAMESTATE:GetCurrentTrail( pnPlayer ) then
		StepsOrTrail = GAMESTATE:GetCurrentTrail( pnPlayer )
		fDesiredValue = StepsOrTrail:GetRadarValues( pnPlayer ):GetValue( rcRadarCategory )
	elseif GAMESTATE:GetCurrentSteps( pnPlayer ) then
		StepsOrTrail = GAMESTATE:GetCurrentSteps( pnPlayer )
		fDesiredValue = StepsOrTrail:GetRadarValues( pnPlayer ):GetValue( rcRadarCategory )
	else
		StepsOrTrail = nil
	end
	return fDesiredValue
end

function isOni()
	return GAMESTATE:GetPlayMode() == "PlayMode_Oni"
end

function isRave()
	return GAMESTATE:GetPlayMode() == "PlayMode_Rave"
end

function isLifeline(player)
	return isOni() and GAMESTATE:GetCurrentCourse(player):GetCourseEntry(1):GetGainSeconds() == 0
end