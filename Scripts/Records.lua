function GetGradeFromPercent(percent)
	local total = THEME:GetMetric("PlayerStageStats","NumGradeTiersUsed")
	local grades = {}
	for i=1,total do
		grades[#grades+1] = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", i))
	end
	grades[#grades] = 0.5
	for g=1,total-1 do
		if percent <= grades[g] and percent > grades[g+1] then return "Tier"..string.format("%02d", g) end
	end
	return "Tier17"
end

function GetTotalActual( profile, stepsType )
	return
		profile:GetSongsActual(stepsType,'Difficulty_Easy')+
		profile:GetSongsActual(stepsType,'Difficulty_Medium')+
		profile:GetSongsActual(stepsType,'Difficulty_Hard')+
		profile:GetSongsActual(stepsType,'Difficulty_Challenge')+
		profile:GetCoursesActual(stepsType,'Difficulty_Medium')+
		profile:GetCoursesActual(stepsType,'Difficulty_Hard')
end

function GetTotalPossible( profile, stepsType )
	return
		profile:GetSongsPossible(stepsType,'Difficulty_Easy')+
		profile:GetSongsPossible(stepsType,'Difficulty_Medium')+
		profile:GetSongsPossible(stepsType,'Difficulty_Hard')+
		profile:GetSongsPossible(stepsType,'Difficulty_Challenge')+
		profile:GetCoursesPossible(stepsType,'Difficulty_Medium')+
		profile:GetCoursesPossible(stepsType,'Difficulty_Hard')
end

function GetTotalPercentComplete( profile, stepsType )
	return GetTotalActual(profile,stepsType) / GetTotalPossible(profile,stepsType)
end

function GetSongsActual( profile, stepsType )
	return
		profile:GetSongsActual(stepsType,'Difficulty_Easy')+
		profile:GetSongsActual(stepsType,'Difficulty_Medium')+
		profile:GetSongsActual(stepsType,'Difficulty_Hard')+
		profile:GetSongsActual(stepsType,'Difficulty_Challenge')
end

function GetSongsPossible( profile, stepsType )
	return
		profile:GetSongsPossible(stepsType,'Difficulty_Easy')+
		profile:GetSongsPossible(stepsType,'Difficulty_Medium')+
		profile:GetSongsPossible(stepsType,'Difficulty_Hard')+
		profile:GetSongsPossible(stepsType,'Difficulty_Challenge')
end

function GetSongsPercentComplete( profile, stepsType )
	return GetSongsActual(profile,stepsType) / GetSongsPossible(profile,stepsType)
end

function GetCoursesActual( profile, stepsType )
	return
		profile:GetCoursesActual(stepsType,'Difficulty_Medium')+
		profile:GetCoursesActual(stepsType,'Difficulty_Hard')
end

function GetCoursesPossible( profile, stepsType )
	return
		profile:GetCoursesPossible(stepsType,'Difficulty_Medium')+
		profile:GetCoursesPossible(stepsType,'Difficulty_Hard')
end

function GetCoursesPercentComplete( profile, stepsType )
	return GetCoursesActual(profile,stepsType) / GetCoursesPossible(profile,stepsType)
end
