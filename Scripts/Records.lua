function GetActual( stepsType )
	return 
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,'Difficulty_Easy')+
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,'Difficulty_Medium')+
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,'Difficulty_Hard')+
		PROFILEMAN:GetMachineProfile():GetSongsActual(stepsType,'Difficulty_Challenge')+
		PROFILEMAN:GetMachineProfile():GetCoursesActual(stepsType,'Difficulty_Medium')+
		PROFILEMAN:GetMachineProfile():GetCoursesActual(stepsType,'Difficulty_Hard')
end

function GetPossible( stepsType )
	return 
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,'Difficulty_Easy')+
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,'Difficulty_Medium')+
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,'Difficulty_Hard')+
		PROFILEMAN:GetMachineProfile():GetSongsPossible(stepsType,'Difficulty_Challenge')+
		PROFILEMAN:GetMachineProfile():GetCoursesPossible(stepsType,'Difficulty_Medium')+
		PROFILEMAN:GetMachineProfile():GetCoursesPossible(stepsType,'Difficulty_Hard')
end

function GetTotalPercentComplete( stepsType )
	-- why 0.96? wtf
	return GetActual(stepsType) / (0.96*GetPossible(stepsType))
end

function GetSongsPercentComplete( stepsType, difficulty )
	return PROFILEMAN:GetMachineProfile():GetSongsPercentComplete(stepsType,difficulty)/0.96
end

function GetCoursesPercentComplete( stepsType, difficulty )
	return PROFILEMAN:GetMachineProfile():GetCoursesPercentComplete(stepsType,difficulty)/0.96
end
