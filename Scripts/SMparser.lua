function LoadModuleSM(ModuleName,...)
	local Path = THEME:GetCurrentThemeDirectory().."Modules/"..ModuleName

	if ... then
		return loadfile(Path)(...)
	end
	return loadfile(Path)()
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

local function NormalizeFloatDigits(param)
	local function NormalizeDecimal(decimal)
		decimal = decimal:gsub("%c", "")
		local rounded = tonumber(decimal)
		local mult = 10^3
		rounded = (rounded * mult + 0.5 - (rounded * mult + 0.5) % 1) / mult
		return string.format("%.3f", rounded)
	end

	local paramParts = {}
	for beat_bpm in param:gmatch('[^,]+') do
		local beat, bpm = beat_bpm:match('(.+)=(.+)')
		table.insert(paramParts, NormalizeDecimal(beat) .. '=' .. NormalizeDecimal(bpm))
	end
	return table.concat(paramParts, ',')
end

local function MixedCaseRegex(str)
	local t = {}
	for c in str:gmatch(".") do
		t[#t+1] = "[" .. c:upper() .. c:lower() .. "]"
	end
	return table.concat(t, "")
end

local function GetSimfileChartString(SimfileString, StepsType, Difficulty, StepsDescription, Filetype)
	local NoteDataString = nil

	StepsType = StepsType:lower()
	Difficulty = Difficulty:lower()

	local NOTEDATA = MixedCaseRegex("NOTEDATA")
	local NOTES = MixedCaseRegex("NOTES")
	local STEPSTYPE = MixedCaseRegex("STEPSTYPE")
	local DIFFICULTY = MixedCaseRegex("DIFFICULTY")
	local DESCRIPTION = MixedCaseRegex("DESCRIPTION")

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

			local description = ''
			for desc in normalizedNoteData:gmatch("#"..DESCRIPTION..":(.-);") do
				if description == '' and desc ~= '' then
					description = desc
					break
				end
			end

			if (stepsType == StepsType and difficulty == Difficulty) then
				if (difficulty ~= "edit" or description == StepsDescription) then

                    NoteDataString = normalizedNoteData:match("#"..NOTES.."2?:[\n]*([^;]*)\n?$"):gsub("//[^\n]*", ""):gsub('[\r\t\f\v ]+', '')
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

				if (stepsType == StepsType and difficulty == Difficulty) then
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

function ParseChartInfo(steps)
	local stepsType = ToEnumShortString( steps:GetStepsType() ):gsub("_", "-"):lower()
	local difficulty = ToEnumShortString( steps:GetDifficulty() )
	local description = steps:GetDescription()
    local simfileString, fileType = GetSimfileString( steps )

    if simfileString then
        local chartString = GetSimfileChartString(simfileString, stepsType, difficulty, description, fileType)
        if chartString ~= nil then
            return chartString
        end
    end
end