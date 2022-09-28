function EvalTweenDistance()
	local Distance = SCREEN_WIDTH/2
	return Distance
end

function isOni()
	return GAMESTATE:GetPlayMode() == "PlayMode_Oni"
end

function isRave()
	return GAMESTATE:GetPlayMode() == "PlayMode_Rave"
end

function isLifeline(player)
	return isOni() and GAMESTATE:GetCurrentCourse(player):GetCourseEntry(0):GetGainSeconds() == 0
end