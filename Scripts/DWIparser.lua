local function GetSimfileString(steps)
	local filename = steps:GetFilename()
	if not filename or filename == "" then return end

	local filetype = filename:match("[^.]+$"):lower()
	if not filetype=="dwi" then return end

	local f = RageFileUtil.CreateRageFile()
	local contents

	if f:Open(filename, 1) then contents = f:Read() end

	f:destroy()

	return contents:gsub('[\r\t\f\v ]+', '')
end

local function MinimizeChart(chartString,solo,check)
	local function MinimizeMeasure(measure)
		local minimal = false
		local check = solo and "000000" or "0000"
		if double then check = check..check end

		while not minimal and #measure % 2 == 0 do
			local allZeroes = true
			for i=2, #measure, 2 do
				if measure[i] ~= check then
					allZeroes = false
					break
				end
			end

			if allZeroes then
				for i=2, #measure/2+1 do
					table.remove(measure, i)
				end
			else
				minimal = true
			end
		end
		return measure
	end

	local new = {}

	table.remove(chartString, 1)
	for measure in ivalues(chartString) do
		new[#new+1] = MinimizeMeasure(measure)
	end

	return new
end

local function GetSimfileChartString(SimfileString, StepsType, Difficulty, Meter)
	local NoteDataString = {}
	Difficulty = Difficulty:lower()

	local STEPSTYPE = StepsType:upper()
	local index = nil
	if Difficulty == "beginner" then
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("beginner")..":") end
	elseif Difficulty == "easy" then
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("easy")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("basic")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("light")..":") end
	elseif Difficulty == "medium" then
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("medium")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("another")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("trick")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("standard")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("difficult")..":") end
	elseif Difficulty == "hard" then
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("hard")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("ssr")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("maniac")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("heavy")..":") end
	elseif Difficulty == "challenge" then
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("smaniac")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("challenge")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("expert")..":") end
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("oni")..":") end
	else
		if not index then index = string.find(SimfileString,"#"..STEPSTYPE..":"..string.upper("edit")..":") end
	end

	if index then
		SimfileString = SimfileString:sub(index,-1)
		local index3 = string.find(SimfileString,";")
		SimfileString = SimfileString:sub(1,index3)
	end
	local counter = 0
	local solo = STEPSTYPE == "SOLO"
	local double = false
	for measure,line in ipairs(split("\n",SimfileString)) do
		local currentMeasure = {}
		if string.find(";",line) then break elseif measure == 1 then elseif string.find(":",line) then double = true else
			counter = counter + 1
			local jump = false
			local hold = false
			local jumpCounter = 0
			local temp
			for i = 1, #line do
				local c = line:sub(i,i)
				if c == "(" or c == ")" or c == "[" or c == "]" or c == "{" or c == "}" or c == "`" or c == "\'" then else
					if c == "0" then
						temp=solo and "000000" or "0000"
					elseif c == "1" then
						temp=solo and "101000" or "1100"
					elseif c == "2" then
						temp=solo and "001000" or "0100"
					elseif c == "3" then
						temp=solo and "001001" or "0101"
					elseif c == "4" then
						temp=solo and "100000" or "1000"
					elseif c == "5" then
						temp=solo and "000000" or "0000"
					elseif c == "6" then
						temp=solo and "000001" or "0001"
					elseif c == "7" then
						temp=solo and "100100" or "1010"
					elseif c == "8" then
						temp=solo and "000100" or "0010"
					elseif c == "9" then
						temp=solo and "000101" or "0011"
					elseif c == "A" then
						temp=solo and "001100" or "0110"
					elseif c == "B" then
						temp=solo and "100001" or "1001"
					elseif c == "C" then
						temp=solo and "010000" or "0000"
					elseif c == "D" then
						temp=solo and "000010" or "0000"
					elseif c == "E" then
						temp=solo and "110000" or "0000"
					elseif c == "F" then
						temp=solo and "010100" or "0000"
					elseif c == "G" then
						temp=solo and "011000" or "0000"
					elseif c == "H" then
						temp=solo and "010001" or "0000"
					elseif c == "I" then
						temp=solo and "100010" or "0000"
					elseif c == "J" then
						temp=solo and "001010" or "0000"
					elseif c == "K" then
						temp=solo and "000110" or "0000"
					elseif c == "L" then
						temp=solo and "000011" or "0000"
					elseif c == "M" then
						temp=solo and "010010" or "0000"
					end
					if c == "<" then
						jump = true
					elseif c == ">" and jump then
						jump = false
					elseif c == "!" then
						hold = true
					else
						if jump then jumpCounter = jumpCounter + 1 end
						if jumpCounter == 2 and not hold then
							local t = currentMeasure[#currentMeasure]
							local total = ""
							for i = 1, #t do
								if t:sub(i,i) == "1" or temp:sub(i,i) == "1" then
									total=total.."1"
								else
									total=total.."0"
								end
							end
							currentMeasure[#currentMeasure] = total
							jumpCounter = 0
						elseif hold then
							local t = currentMeasure[#currentMeasure]
							local total = ""
							for i = 1, #t do
								if t:sub(i,i) == "1" and temp:sub(i,i) == "1" then
									total=total.."2"
								elseif t:sub(i,i) == "2" and temp:sub(i,i) == "0" then
									total=total.."2"
								elseif t:sub(i,i) == "1" and temp:sub(i,i) == "0" then
									total=total.."1"
								else
									total=total.."0"
								end
							end
							currentMeasure[#currentMeasure] = total
							if jumpCounter == 0 or jumpCounter == 2 then hold = false end
							hold = false
						else
							currentMeasure[#currentMeasure+1] = temp
						end
					end
				end
			end
			NoteDataString[#NoteDataString+1]=currentMeasure
		end
	end

	if double then
		local tempNDS = {}
		for a=1,#NoteDataString/2 do
			tempNDS[a] = {}
			for b=1,#NoteDataString[a] do
				tempNDS[a][b] = NoteDataString[a][b]..NoteDataString[#NoteDataString/2+a][b]
			end
		end
		NoteDataString = tempNDS
	end
	NoteDataString = MinimizeChart(NoteDataString,solo,double)

	local holdCheck = {}
	local newNoteDataString = {}
	for a,measure in ipairs(NoteDataString) do
		newNoteDataString[a] = {}
		for b,beat in ipairs(measure) do
			local new = ""
			for i = 1, #beat do
				if beat:sub(i,i) == "2" then
					holdCheck[i] = true
					new = new.."2"
				elseif beat:sub(i,i) == "1" then
					if holdCheck[i] then
						holdCheck[i] = false
						new = new.."3"
					else
						new = new.."1"
					end
				else
					new = new.."0"
				end
			end
			newNoteDataString[a][b]=new
		end
	end

	return newNoteDataString
end

function DWIParser(steps)
	if not steps then return end
	local stepsType = split("_",steps:GetStepsType())
	stepsType = stepsType[#stepsType]:lower()

	local difficulty = split("_",steps:GetDifficulty())
	difficulty = difficulty[#difficulty]:lower()

	local meter = steps:GetMeter()
    local simfileString = GetSimfileString( steps )

    if simfileString then
        local chartString = GetSimfileChartString(simfileString, stepsType, difficulty, meter)
        if chartString ~= nil then return chartString end
    end
end