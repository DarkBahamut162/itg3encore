local function GetSimfileString(steps)
	local filename = steps:GetFilename()
	if not filename or filename == "" then return end

	local filetype = filename:match("[^.]+$"):sub(2,2):lower()
	if not filetype == "m" then return end

	local f = RageFileUtil.CreateRageFile()
	local contents

	if f:Open(filename, 1) then contents = f:Read() end

	f:destroy()

	return contents, filetype
end

function BMSParser(steps)
	local simfileString,filetype = GetSimfileString( steps )
	local function splitByChunk(text, chunkSize)
		local s = {}
		for i=1, #text, chunkSize do
			s[#s+1] = text:sub(i,i+chunkSize - 1)
		end
		return s
	end
	if simfileString then
		simfileString = simfileString:gsub('[\r\t\f\v ]+', '')
		local currentMeasure = -1
		local currentRow = -1
		local beatData = {}
		local holds = {}
		local lastHold = 0
		local scratch = 0
		local foot = 0
		local timing = {}
		local allRows = simfileString:gmatch("#(%w+):([%w]+)\n")
		local _allRows = simfileString:gmatch("#(%w+):([%w.]+)\n")
		for measure,rows in _allRows do
			if tonumber(measure) then
				currentMeasure = math.floor(measure/100)
				if timing[currentMeasure] then else timing[currentMeasure] = 1 end
				if tonumber(measure) % 100 == 2 then
					timing[currentMeasure] = tonumber(rows)
				end
			end
		end
		local actualBeat = 0
		local previousMeasure = 0
		for measure,rows in allRows do
			if tonumber(measure) then
				currentMeasure = math.floor(measure/100)
				if previousMeasure < currentMeasure then
					actualBeat = actualBeat + 4*(timing[currentMeasure-1] or 1)
					previousMeasure = currentMeasure
				end
				if tonumber(measure) % 100 > 10 and tonumber(measure) % 100 < 30 then
					local currentRow = -1
					rows = splitByChunk(rows,2)
					for row in ivalues(rows) do
						currentRow = currentRow + 1
						if row ~= "00" then
							beat = actualBeat+(currentRow/#rows*4)*(timing[currentMeasure-1] or 1)
							beatData[beat] = beatData[beat] and beatData[beat] + 1 or 1
							if filetype ~= "pms" then
								if tonumber(measure) % 10 == 6 then
									scratch = scratch + 1
								elseif tonumber(measure) % 10 == 7 then
									foot = foot + 1
								end
							end
						end
					end
				end
				if tonumber(measure) % 100 > 50 and tonumber(measure) % 100 < 70 then
					local currentRow = -1
					rows = splitByChunk(rows,2)
					for row in ivalues(rows) do
						currentRow = currentRow + 1
						if row ~= "00" then
							beat = actualBeat+(currentRow/#rows*4)*timing[currentMeasure]
							local index = FindInTable(row, holds)
							if index then
								table.remove(holds, index)
								lastHold = beat
							else
								table.insert(holds, row)
								beatData[beat] = beatData[beat] and beatData[beat] + 1 or 1
								if filetype ~= "pms" then
									if tonumber(measure) % 10 == 6 then
										scratch = scratch + 1
									elseif tonumber(measure) % 10 == 7 then
										foot = foot + 1
									end
								end
							end
						end
					end
				end
			end
		end
		return beatData, lastHold, scratch, foot
	end
end