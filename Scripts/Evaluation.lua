function EvalTweenDistance()
	local Distance = SCREEN_WIDTH/2
	return Distance
end

function isRegular()
	return isPlayMode("PlayMode_Regular")
end

function isNonstop()
	return isPlayMode("PlayMode_Nonstop")
end

function isOni()
	return isPlayMode("PlayMode_Oni")
end

function isRave()
	return isPlayMode("PlayMode_Rave")
end

function isLifeline(player)
	return isOni() and GAMESTATE:GetCurrentCourse(player):GetCourseEntry(0):GetGainSeconds() == 0
end