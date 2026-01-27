if not isOutFox() then
	function LoadModule(ModuleName,...)
		local Path = THEME:GetCurrentThemeDirectory().."Modules/"..ModuleName

		if ... then
			return loadfile(Path)(...)
		end
		return loadfile(Path)()
	end
end

if isEtterna() and type(VersionDate) ~= "function" then
	function VersionDate() return "20191216" end
end

if isOutFox() and not VersionDateCheck(20200400) then
	function math.log10(x) return math.log(x,10) end
end

if isStepMania() and not VersionDateCheck(20150500) then
	function Actor:effect_hold_at_full(fEffectPeriod) return self:effectperiod(1) end
end

function GetPreviewMusicPath(song)
	local output = GetSMParameter(song,"PREVIEW")
	if output == "" then
		output = GetSMParameter(song,"MUSIC")
	end
	return output
end

local function GetSimfileString(steps)
	local filename = steps:GetFilename()
	if not filename or filename == "" then return end

	local filetype = filename:match("[^.]+$"):lower()
	if not (filetype=="ssc" or filetype=="sm") then return end

	local f = RageFileUtil.CreateRageFile()
	local contents

	if f:Open(filename, 1) then contents = f:Read() end

	f:destroy()

	return contents, filetype
end

local function MinimizeChart(chartString)
	local function MinimizeMeasure(measure)
		local minimal = false

		while not minimal and #measure % 2 == 0 do
			local allZeroes = true
			for i=2, #measure, 2 do
				if measure[i] ~= string.rep('0', measure[i]:len()) then
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
	end

	local finalChartData = {}
	local curMeasure = {}

	for line in chartString:gmatch('[^\n]+') do
		if line == ',' then
			MinimizeMeasure(curMeasure)
			for row in ivalues(curMeasure) do
				table.insert(finalChartData, row)
			end
			table.insert(finalChartData, ',')
			for i=1, #curMeasure do
				table.remove(curMeasure, 1)
			end
		else
			table.insert(curMeasure, line)
		end
	end

	if #curMeasure > 0 then
		MinimizeMeasure(curMeasure)
		for row in ivalues(curMeasure) do
			table.insert(finalChartData, row)
		end
	end

	return table.concat(finalChartData, '\n')
end

local function MixedCaseRegex(str)
	local t = {}
	for c in str:gmatch(".") do
		t[#t+1] = "[" .. c:upper() .. c:lower() .. "]"
	end
	return table.concat(t, "")
end

local function GetSimfileChartString(SimfileString, StepsType, Difficulty, StepsDescription, Meter, Filetype)
	local NoteDataString = nil

	StepsType = StepsType:lower()
	Difficulty = Difficulty:lower()
	Filetype = Filetype:lower()

	local NOTEDATA = MixedCaseRegex("NOTEDATA")
	local NOTES = MixedCaseRegex("NOTES")
	local STEPSTYPE = MixedCaseRegex("STEPSTYPE")
	local DIFFICULTY = MixedCaseRegex("DIFFICULTY")
	local DESCRIPTION = MixedCaseRegex("DESCRIPTION")
	local METER = MixedCaseRegex("METER")

	local dupCheck = {}

	if Filetype == "ssc" then
		for noteData in SimfileString:gmatch("#"..NOTEDATA..".-#"..NOTES.."2?:[^;]*") do
			local normalizedNoteData = noteData:gsub('\r\n?', '\n')

			local stepsType = ''
			for st in normalizedNoteData:gmatch("#"..STEPSTYPE..":(.-);") do
				if stepsType == '' and st ~= '' then
					stepsType = st
					break
				end
			end
			stepsType = stepsType:gsub("%s+", ""):lower()

			local difficulty = ''
			for diff in normalizedNoteData:gmatch("#"..DIFFICULTY..":(.-);") do
				if difficulty == '' and diff ~= '' then
					difficulty = diff
					break
				end
			end
			difficulty = difficulty:gsub("%s+", ""):lower()

			if not isOutFox() then
				local found = FindInTable(difficulty, dupCheck)
				if not found then
					table.insert(dupCheck,difficulty)
				else
					difficulty = Difficulty
				end
			end

			local description = ''
			for desc in normalizedNoteData:gmatch("#"..DESCRIPTION..":(.-);") do
				if description == '' and desc ~= '' then
					description = desc
					break
				end
			end

			local meter = 0
			for met in normalizedNoteData:gmatch("#"..METER..":(.-);") do
				if meter == 0 and met ~= '' then
					meter = tonumber(met)
					break
				end
			end

			if (stepsType == StepsType and difficulty == Difficulty and meter == Meter) then
				if (difficulty ~= "edit" or description == StepsDescription) then

                    NoteDataString = normalizedNoteData:match("#"..NOTES.."2?:[\n]*([^;]*)\n?$"):gsub("//[^\n]*", ""):gsub('[\r\t\f\v ]+', ''):gsub('{(.-)}', ''):gsub('[{}]', '')
					NoteDataString = MinimizeChart(NoteDataString)
					break
				end
			end
		end
	elseif Filetype == "sm" then
		for noteData in SimfileString:gmatch("#"..NOTES.."2?[^;]*") do
			local normalizedNoteData = noteData:gsub('\r\n?', '\n')
			local parts = {}
			for part in (normalizedNoteData..":"):gmatch("([^:]*):") do
				parts[#parts+1] = part
			end

			if #parts >= 7 then
				local stepsType = parts[2]:gsub("[^%w-]", ""):lower()
				local difficulty = parts[4]:gsub("[^%w]", "")
				difficulty = ToEnumShortString(OldStyleStringToDifficulty(difficulty)):lower()
				local description = parts[3]:gsub("^%s*(.-)", "")
				local meter = parts[5]:gsub("[^%w]", "")

				if not isOutFox() then
					local found = FindInTable(difficulty, dupCheck)
					if not found then
						table.insert(dupCheck,difficulty)
					else
						difficulty = Difficulty
					end
				end

				if (stepsType == StepsType and difficulty == Difficulty and tonumber(meter) == Meter) then
					if (difficulty ~= "edit" or description == StepsDescription) then
						NoteDataString = parts[7]:gsub("//[^\n]*", ""):gsub('[\r\t\f\v ]+', '')
						NoteDataString = MinimizeChart(NoteDataString)
						break
					end
				end
			end
		end
	end

	return NoteDataString
end

function SMParser(steps)
	local stepsType = ToEnumShortString( steps:GetStepsType() ):gsub("_", "-"):lower()
	local difficulty = ToEnumShortString( steps:GetDifficulty() )
	local description = steps:GetDescription()
	local meter = steps:GetMeter()
    local simfileString, fileType = GetSimfileString( steps )

    if simfileString then
        local chartString = GetSimfileChartString(simfileString, stepsType, difficulty, description, meter, fileType)
        if chartString ~= nil then
            return chartString
        end
    end
end

function GetTechniques(chartString)
	local RegexStep = "[124]"
	local RegexAny = "."

	local RegexL = "^" .. RegexStep .. RegexAny .. RegexAny .. RegexAny
	local RegexD = "^" .. RegexAny .. RegexStep .. RegexAny .. RegexAny
	local RegexU = "^" .. RegexAny .. RegexAny .. RegexStep .. RegexAny
	local RegexR = "^" .. RegexAny .. RegexAny .. RegexAny .. RegexStep

	local NumCrossovers = 0
	local NumFootswitches = 0
	local NumSideswitches = 0
	local NumJacks = 0
	local NumBrackets = 0

	local LastFoot = false
	local WasLastStreamFlipped = false
	local LastStep
	local LastRepeatedFoot
	local StepsLR = {}
	local AnyStepsSinceLastCommitStream = false

	local LastArrowL = "X"
	local LastArrowR = "X"
	local TrueLastArrowL = "X"
	local TrueLastArrowR = "X"
	local TrueLastFoot = nil
	local JustBracketed = false

	function CommitStream(tieBreakFoot)
		local ns = #StepsLR
		local nx = 0
		for step in ivalues(StepsLR) do
			if not step then nx = nx + 1 end
		end

		local needFlip = false
		if nx * 2 > ns then
			needFlip = true
		elseif nx * 2 == ns then
			if tieBreakFoot then
				if JustBracketed then
					needFlip = false
				elseif LastFoot then
					needFlip = (tieBreakFoot == "R")
				else
					needFlip = (tieBreakFoot == "L")
				end
			elseif NumFootswitches > NumJacks then
				needFlip = LastFlip -- Match flipness of last chunk -> footswitch
			else
				needFlip = not LastFlip -- Don't match -> jack
			end
		end

		local splitIndex
		local splitFirstUncrossedStepIndex
		local numConsecutiveCrossed = 0
		for i, step in ipairs(StepsLR) do
			local stepIsCrossed = step == needFlip
			if not splitIndex then
				if stepIsCrossed then
					numConsecutiveCrossed = numConsecutiveCrossed + 1
					if numConsecutiveCrossed == 9 then
						splitIndex = i - 8
					end
				else
					numConsecutiveCrossed = 0
				end
			elseif not splitFirstUncrossedStepIndex then
				if not stepIsCrossed then
					splitFirstUncrossedStepIndex = i
				end
			end
		end

		if splitIndex then
			if splitIndex == 1 then
				splitIndex = splitFirstUncrossedStepIndex
			end

			local StepsLR1 = {}
			local StepsLR2 = {}
			for i, step in ipairs(StepsLR) do
				if i < splitIndex then
					StepsLR1[#StepsLR1+1] = step
				else
					StepsLR2[#StepsLR2+1] = step
				end
			end
			StepsLR = StepsLR1
			CommitStream(nil)
			LastRepeatedFoot = nil
			StepsLR = StepsLR2
			CommitStream(tieBreakFoot)
		else
			if needFlip then
				NumCrossovers = NumCrossovers + ns - nx
			else
				NumCrossovers = NumCrossovers + nx
			end

			if LastRepeatedFoot then
				if needFlip == LastFlip then
					NumFootswitches = NumFootswitches + 1
					if LastRepeatedFoot == "L" or LastRepeatedFoot == "R" then
						NumSideswitches = NumSideswitches + 1
					end
				else
					NumJacks = NumJacks + 1
				end
			end

			StepsLR = {}
			LastFlip = needFlip

			if AnyStepsSinceLastCommitStream then
				if needFlip then
					if LastFoot then TrueLastFoot = "L" else TrueLastFoot = "R" end
					TrueLastArrowL = LastArrowR
					TrueLastArrowR = LastArrowL
				else
					if LastFoot then TrueLastFoot = "R" else TrueLastFoot = "L" end
					TrueLastArrowL = LastArrowL
					TrueLastArrowR = LastArrowR
				end
			end
			AnyStepsSinceLastCommitStream = false
			LastArrowL = ""
			LastArrowR = ""
			JustBracketed = false
		end
	end

	for line in chartString:gmatch("[^%s*\r\n]+") do
		if line:match(RegexStep) then
			local step = ""
			if line:match(RegexL) then step = step .. "L" end
			if line:match(RegexD) then step = step .. "D" end
			if line:match(RegexU) then step = step .. "U" end
			if line:match(RegexR) then step = step .. "R" end

			if step:len() == 1 then
				if LastStep and step == LastStep then
					CommitStream(nil)
					LastRepeatedFoot = step
				end

				LastStep = step
				LastFoot = not LastFoot
				if step == "L" then
					StepsLR[#StepsLR+1] = not LastFoot
				elseif step == "R" then
					StepsLR[#StepsLR+1] = LastFoot
				end
				AnyStepsSinceLastCommitStream = true
				if LastFoot then
					LastArrowR = step
				else
					LastArrowL = step
				end
			elseif step:len() > 1 then
				if step:len() == 2 then
					local isBracketLeft  = step:match("L[^R]")
					local isBracketRight = step:match("[^L]R")

					local tieBreakFoot = nil
					if isBracketLeft then
						tieBreakFoot = "L"
					elseif isBracketRight then
						tieBreakFoot = "R"
					end
					CommitStream(tieBreakFoot)
					LastStep = nil
					LastRepeatedFoot = nil

					if isBracketLeft or isBracketRight then
						if isBracketLeft and (not TrueLastFoot or TrueLastFoot == "R") then
							if not step:match(TrueLastArrowR) then
								NumBrackets = NumBrackets + 1
								TrueLastFoot = "L"
								LastFoot = false
								TrueLastArrowL = step:sub(2)
								JustBracketed = true
							else
								TrueLastFoot = nil
								TrueLastArrowL = "L"
								TrueLastArrowR = step:sub(2)
								LastArrowR = TrueLastArrowR
							end
							LastArrowL = TrueLastArrowL
						elseif isBracketRight and (not TrueLastFoot or TrueLastFoot == "L") then
							if not step:match(TrueLastArrowL) then
								NumBrackets = NumBrackets + 1
								TrueLastFoot = "R"
								LastFoot = true
								TrueLastArrowR = step:sub(1,1)
								JustBracketed = true
							else
								TrueLastFoot = nil
								TrueLastArrowL = step:sub(1,1)
								TrueLastArrowR = "R"
								LastArrowL = TrueLastArrowL
							end
							LastArrowR = TrueLastArrowR
						end
					else
						if step == "DU" then
							local leftD  = TrueLastArrowL:match("D")
							local leftU  = TrueLastArrowL:match("U")
							local rightD = TrueLastArrowR:match("D")
							local rightU = TrueLastArrowR:match("U")
							if (leftD and not rightD) or (rightU and not leftU) then
								TrueLastArrowL = "D"
								TrueLastArrowR = "U"
							elseif (leftU and not rightU) or (rightD and not leftD) then
								TrueLastArrowL = "U"
								TrueLastArrowR = "D"
							else
								TrueLastArrowL = "X"
								TrueLastArrowR = "X"
							end
						else
							TrueLastArrowL = "X"
							TrueLastArrowR = "X"
						end
						TrueLastFoot = nil
					end
				else
					CommitStream()
					LastStep = nil
					LastRepeatedFoot = nil
					NumBrackets = NumBrackets + 1
					TrueLastFoot = nil
				end
			end
		end
	end
	CommitStream(nil)

	return NumCrossovers, NumFootswitches, NumSideswitches, NumJacks, NumBrackets
end