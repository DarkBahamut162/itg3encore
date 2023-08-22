function GetGradeFromPercent(percent)
	local grades = {
		1.00,	-- ☆☆☆☆
		0.99,	-- ☆☆☆
		0.98,	-- ☆☆
		0.96,	-- ☆
		0.94,	-- S+
		0.92,	-- S
		0.89,	-- S-
		0.86,	-- A+
		0.83,	-- A
		0.80,	-- A-
		0.76,	-- B+
		0.72,	-- B
		0.68,	-- B-
		0.64,	-- C+
		0.60,	-- C
		0.55,	-- C-
		0.50,	-- D+
		0.45,	-- D
		0.40,	-- D-
		0.35,	-- E+
		0.30,	-- E
		0.25,	-- E-
		0.20	-- F+
	}

	if percent >= grades[1] then return "Tier01" end

	for g=1,#grades-1 do
		if percent < grades[g] and percent >= grades[g+1] then return "Tier"..string.format("%02d", g+1) end
	end

	return "Failed"
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
