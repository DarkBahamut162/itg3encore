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

function GetGradeFromPercentWife(percent)
	local grades = {
		--1.000000,	-- AAAAA
		0.999935,	-- AAAA:
		0.9998,		-- AAAA.
		0.9997,		-- AAAA
		0.99955,	-- AAA:
		0.999,		-- AAA.
		0.998,		-- AAA
		0.997,		-- AA:
		0.99,		-- AA.
		0.965,		-- AA
		0.93,		-- A:
		0.9,		-- A.
		0.85,		-- A
		0.8,		-- B
		0.7,		-- C
		0.6,		-- D
	}

	for g=1,#grades do
		if percent >= grades[g] then return "Tier"..string.format("%02d", g) end
	end

	return "Tier16"
end

function GetPercentFromGradeWife(grade)
	local percent = {
		["Grade_Tier00"] = 1.000000,	-- AAAAA
		["Grade_Tier01"] = 0.999935,	-- AAAA:
		["Grade_Tier02"] = 0.9998,		-- AAAA.
		["Grade_Tier03"] = 0.9997,		-- AAAA
		["Grade_Tier04"] = 0.99955,		-- AAA:
		["Grade_Tier05"] = 0.999,		-- AAA.
		["Grade_Tier06"] = 0.998,		-- AAA
		["Grade_Tier07"] = 0.997,		-- AA:
		["Grade_Tier08"] = 0.99,		-- AA.
		["Grade_Tier09"] = 0.965,		-- AA
		["Grade_Tier10"] = 0.93,		-- A:
		["Grade_Tier11"] = 0.9,			-- A.
		["Grade_Tier12"] = 0.85,		-- A
		["Grade_Tier13"] = 0.8,			-- B
		["Grade_Tier14"] = 0.7,			-- C
		["Grade_Tier15"] = 0.6,			-- D
	}

	return percent[grade] and percent[grade] or 0
end

XMLdata = {}

function LoadXML(file)
	if not FILEMAN:DoesFileExist(file) then return {} end

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open(file, 1)

	local configcontent = configfile:Read()

	configfile:Close()
	configfile:destroy()

	return configcontent:gsub('[\r\t\f\v]+', '')
end

function XML()
	local files = FILEMAN:GetDirListing("/Save/LocalProfiles/")
	for dir in ivalues(files) do
		local file = "/Save/LocalProfiles/"..dir.."/Etterna.xml"
		local read = false
		local deepRead = false
		local key
		local PBkey
		local PBgrade
		if FILEMAN:DoesFileExist(file) then
			local xml = LoadXML(file)
			xml = split("\n",xml)
			for i=1,#xml do
				if string.find(xml[i],"PlayerScores") then read = not read end
				if read then
					if string.find(xml[i],"<Chart") then
						key = nil
						PBkey = nil
						PBgrade = nil
						local string = xml[i]:gsub("[<'>]+", '')
						string = split(" ",string)
						key = split("=",string[2])[2]
						XMLdata[key] = {["WIFE"]=0}
					end
					if string.find(xml[i],"<ScoresAt") then
						local string = xml[i]:gsub("[<'>]+", '')
						string = split(" ",string)
						PBkey = split("=",string[3])[2]
						PBgrade = split("=",string[2])[2]
						XMLdata[key]["GRADE"] = PBgrade
					end
					if string.find(xml[i],"<Score ") and PBkey and string.find(xml[i],PBkey) then deepRead = true end
					if deepRead then
						if string.find(xml[i],"WifeScore") then
							local score = xml[i]:gsub("<WifeScore>", ''):gsub("</WifeScore>", '')
							score = tonumber(score)
							if XMLdata[key]["WIFE"] and XMLdata[key]["WIFE"] < score or true then XMLdata[key]["WIFE"] = score end
							deepRead = false
						end
					end
				end
			end
		end
	end
end

function GetSongsActualEtterna(StepsType,Difficulty)
	local total = 0
	local songs = SONGMAN:GetAllSongs()
	local total = 0
	for curSong=1,#songs do
		local step = songs[curSong]:GetOneSteps(StepsType,Difficulty)
		if step then
			local key = step:GetChartKey()
			local score = XMLdata[key] and XMLdata[key]["WIFE"] or 0
			if step then total = total+score end
		end
	end
	return total
end

function GetSongsPossibleEtterna(StepsType,Difficulty)
	local songs = SONGMAN:GetAllSongs()
	local total = 0
	for curSong=1,#songs do
		local step = songs[curSong]:GetOneSteps(StepsType,Difficulty)
		if step then total = total+1 end
	end
	return total
end

function GetSongsPercentCompleteEtterna(StepsType,Difficulty)
	return GetSongsActualEtterna(StepsType,Difficulty) / GetSongsPossibleEtterna(StepsType,Difficulty)
end

function GetTotalActualEtterna(stepsType)
	return
		GetSongsActualEtterna(stepsType,'Difficulty_Easy')+
		GetSongsActualEtterna(stepsType,'Difficulty_Medium')+
		GetSongsActualEtterna(stepsType,'Difficulty_Hard')+
		GetSongsActualEtterna(stepsType,'Difficulty_Challenge')
end

function GetTotalPossibleEtterna(stepsType)
	return
		GetSongsPossibleEtterna(stepsType,'Difficulty_Easy')+
		GetSongsPossibleEtterna(stepsType,'Difficulty_Medium')+
		GetSongsPossibleEtterna(stepsType,'Difficulty_Hard')+
		GetSongsPossibleEtterna(stepsType,'Difficulty_Challenge')
end

function GetTotalPercentCompleteEtterna(stepsType)
	return GetTotalActualEtterna(stepsType) / GetTotalPossibleEtterna(stepsType)
end

function GetTotalStepsWithTopGradeEtterna(StepsType,Difficulty,Tier)
	local songs = SONGMAN:GetAllSongs()
	local total = 0
	for curSong=1,#songs do
		local step = songs[curSong]:GetOneSteps(StepsType,Difficulty)
		if step then
			local key = step:GetChartKey()
			local grade = XMLdata[key] and XMLdata[key]["GRADE"] or "Failed"
			if grade == ToEnumShortString(Tier) then total = total+1 end
		end
	end
	return total
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
