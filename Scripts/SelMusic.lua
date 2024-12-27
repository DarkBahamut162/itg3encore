local cacheVersion = "0.38"
--local stepCache = {}
local typeList = {"avi","f4v","flv","mkv","mp4","mpeg","mpg","mov","ogv","webm","wmv"}

function getCacheVersion()
	return cacheVersion
end

function DifficultyChangingAvailable()
	return not isPlayMode('PlayMode_Endless') and not isOni() and GAMESTATE:GetSortOrder() ~= 'SortOrder_ModeMenu'
end

function SelectMenuAvailable()
	return not isPlayMode('PlayMode_Endless') and GAMESTATE:GetSortOrder() ~= 'SortOrder_ModeMenu'
end

function ModeMenuAvailable()
	return (not GAMESTATE:IsCourseMode()) and (GAMESTATE:GetSortOrder() ~= 'SortOrder_ModeMenu')
end

function TextBannerAfterSet(self,param)
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")

	if Subtitle:GetText() == "" then
		Title:y(0)
		Subtitle:visible(false)
	else
		Title:y(-5)
		Subtitle:visible(true)
		Subtitle:y(8)
	end
end

function CourseTextBannerAfterSet(self,param)
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")

	if Subtitle:GetText() == "" then
		Title:y(0)
		Title:zoom(0.773)
		Subtitle:visible(false)
	else
		Title:y(-6)
		Title:zoom(0.6)
		Subtitle:visible(true)
		Subtitle:y(8)
	end
end

function GetScreenSelectMusicHelpText()
	local ret = IsNetSMOnline() and THEME:GetString("ScreenNetSelectMusic", "HelpText") or THEME:GetString("ScreenSelectMusic", "HelpText")

	if true or SelectButtonAvailable() then
		ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "SelectButtonAvailableHelpTextAppend" )
	end
	if DifficultyChangingAvailable() then
		ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "DifficultyChangingAvailableHelpTextAppend" )
	end
	if ModeMenuAvailable() then
		ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "SortMenuAvailableHelpTextAppend" )
	end
	if getenv("Workout") and IsHome() then
		ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "WorkoutHelpTextAppend" )
	end

	return ret
end

function GetSMParameter(song,parameter)
	local filePath = song:GetSongFilePath()
	if filePath:sub(-2) ~= 'sm' and filePath:sub(-3) ~= 'ssc' then return "" end
	local file = RageFileUtil.CreateRageFile()
	file:Open(filePath,1)
	file:Seek(0)
	local gLine = ""
	local line
	while true do
		if file then
			line = file:GetLine()
			if string.find(line,"#NOTES:") or string.find(line,"#NOTEDATA:") or file:AtEOF() then break
			elseif string.find(line,"#"..parameter..":") or gLine ~= "" then
				gLine = gLine..""..split("//",line)[1]
				if string.find(line,";") then break end
			end
		end
	end
	local tmp = {}
	if gLine == "" then
		tmp = {""}
	else
		tmp = split(":",gLine)
		if tmp[2] == ";" then
			tmp[1] = ""
		else
			if #tmp > 2 then
				tmp[1] = tmp[2]
				for i = 3, #tmp do
					tmp[1] = tmp[1]..":"..split(";",tmp[i])[1]
				end
			else
				tmp[1] = split(";",tmp[2])[1]
			end
		end
	end
	file:Close()
	file:destroy()
	return tmp[1]
end

function GetSongFolderName(song)
    local folderPath = split('/', song:GetSongDir())
    return folderPath[#folderPath-1]
end

function HasLua(song,changes)
	local parameter = GetSMParameter(song,changes)
	if parameter ~= "" then
		parameter = split(",",parameter)
		for i=1,#parameter do
			parameter[i] = split("=",parameter[i])
			for current in ivalues({2,7}) do
				if parameter[i][current] then
					if string.find(parameter[i][current],".lua",0,true) then
						return true
					elseif string.find(parameter[i][current],".",0,true) then else
						local groupName = song:GetGroupName()
						local songFolder = isOutFox() and song:GetSongFolder() or GetSongFolderName(song)
						local checkFolder = FILEMAN:GetDirListing("/Songs/"..groupName.."/"..songFolder.."/"..parameter[i][current].."/")
						for insideFiles in ivalues( checkFolder ) do
							if string.find(insideFiles,".lua",0,true) then return true end
						end
					end
				end
			end
		end
	end
	return false
end

function HasVideo(song,changes)
	local parameter = GetSMParameter(song,changes)
	if parameter ~= "" then
		parameter = split(",",parameter)
		for i=1,#parameter do
			parameter[i] = split("=",parameter[i])
			for current in ivalues({2,7}) do
				if parameter[i][current] then
					for typ in ivalues(typeList) do
						if string.find(parameter[i][current],typ,0,true) then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

function HasLuaCheck()
	local song = GAMESTATE:GetCurrentSong()
	return HasLua(song,"BGCHANGES") or HasLua(song,"FGCHANGES")
end

function IsCourseSecret()
	if GAMESTATE:IsCourseMode() then
		for i=1,#GAMESTATE:GetCurrentCourse():GetCourseEntries() do
			if GAMESTATE:GetCurrentCourse():GetCourseEntry(i-1):IsSecret() then
				return true
			end
		end
	end

	return false
end

local allowednotes = {
	["TapNoteType_Tap"] = true,
	["TapNoteType_Lift"] = true,
	["TapNoteSubType_Hold"] = true,
	["TapNoteSubType_Roll"] = true,
	--What the hell happened here, OF0.5-pre042?
	["TapNoteType_TapNoteType_Tap"] = true,
	["TapNoteType_TapNoteType_Lift"] = true,
	["TapNoteSubType_TapNoteSubType_Hold"] = true,
	["TapNoteSubType_TapNoteSubType_Roll"] = true,
	--I give up...
	["Hold"] = true,
	["Roll"] = true
}

function getColumnsPerPlayer(typ,style,calc)
	local dif = calc and 2 or 1

	if typ == "Dance" then
		if style == "Single" then
			return 4
		elseif style == "Double" then
			return 8/dif
		elseif style == "Couple" then
			return 8/dif
		elseif style == "Solo" then
			return 6
		elseif style == "Solodouble" then
			return 12/dif
		elseif style == "Routine" then
			return 8/dif
		elseif style == "Threepanel" then
			return 3
		elseif style == "Threedouble" then
			return 6/dif
		end
	elseif typ == "Pump" then
		if style == "Single" then
			return 5
		elseif style == "Double" then
			return 10/dif
		elseif style == "Halfdouble" then
			return 6
		elseif style == "Couple" then
			return 10/dif
		elseif style == "Routine" then
			return 10/dif
		end
	elseif typ == "Smx" then
		if style == "Single" then
			return 5
		elseif style == "Double6" then
			return 6
		elseif style == "Double10" then
			return 10/dif
		elseif style == "Couple" then
			return 10/dif
		elseif style == "Routine" then
			return 10/dif
		end
	elseif typ == "Bm" then
		if style == "Single5" then
			return 5+1
		elseif style == "Single6" then
			return 6+1
		elseif style == "Single7" then
			return 7+1
		elseif style == "Double5" then
			return (10+2)/dif
		elseif style == "Double6" then
			return (12+2)/dif
		elseif style == "Double7" then
			return (14+2)/dif
		end
	elseif typ == "Pnm" then
		if style == "Three" then
			return 3
		elseif style == "Four" then
			return 4
		elseif style == "Five" then
			return 5
		elseif style == "Seven" then
			return 7
		elseif style == "Nine" then
			return 9
		end
	elseif typ == "Techno" then
		if style == "Single4" then
			return 4
		elseif style == "Single5" then
			return 5
		elseif style == "Single8" then
			return 8/dif
		elseif style == "Single9" then
			return 9/dif
		elseif style == "Double4" then
			return 8/dif
		elseif style == "Double5" then
			return 10/dif
		elseif style == "Double8" then
			return 16/dif/dif
		elseif style == "Double9" then
			return 18/dif/dif
		end
	end
	return 0
end

function getStepCacheFile(Step)
	local filename = split("/",Step:GetFilename())
	local groupName = filename[#filename-2]
	local songName = filename[#filename-1]
	if string.find(groupName,"@") then
		local Song = SONGMAN:GetSongFromSteps(Step)
		groupName = Song:GetGroupName()
	end
	return "Cache/Steps/Steps_"..groupName.."_"..songName.."_"..ToEnumShortString(Step:GetStepsType()).."_"..ToEnumShortString(Step:GetDifficulty()).."_"..Step:GetHash()..".db9"
end

function HasStopAtBeat(beat,stops)
	while stops and stops[1] do
		local stop = tonumber(split('=', stops[1])[1])
		if beat < stop then
			return false, stops
		elseif beat == stop then
			table.remove(stops,1)
			return true, stops
		elseif beat > stop then
			table.remove(stops,1)
		end
	end
	return false, stop
end

function HasDelayAtBeat(beat,delays)
	while delays and delays[1] do
		local delay = tonumber(split('=', delays[1])[1])
		if beat < delay then
			return false, delays
		elseif beat == delay then
			table.remove(delays,1)
			return true, delays
		elseif beat > delay then
			table.remove(delays,1)
		end
	end
	return false, delays
end

function HasWarpAtBeat(beat,warps)
	while warps and warps[1] do
		local warp = split('=', warps[1])
		warp[1] = tonumber(warp[1])
		warp[2] = tonumber(warp[2])
		if beat < warp[1] then
			return false, warps
		elseif warp[1] <= beat and beat < warp[1] + warp[2] then
			table.remove(warps,1)
			return true, warps
		elseif beat >= warp[1] + warp[2] then
			table.remove(warps,1)
		end
	end
	return false, warps
end

function checkStopAtBeat(beat,timing)
	for _,v in pairs(timing:GetStops()) do
		local data = split('=', v)
		if tonumber(data[1]) == beat then
			return timing:GetElapsedTimeFromBeat(beat)+tonumber(data[2])
		end
	end
	return timing:GetElapsedTimeFromBeat(beat)
end

function calcSPS(SPS,max)
	local total, times = 0, 0
	for _sps, _times in pairs(SPS) do
		if (max and _sps > max / 6 and _sps < max * 2) or not max then
			total = total + (_sps * _times)
			times = times + _times
		end
	end

	if total > 0 and times > 0 then total = total / times * 2 end

	return total
end

function GetParameter(Step,minAmount)
	local filePath = Step:GetFilename()
	local extBME = filePath:sub(-3) == "bme" and true or false
	local extBML = filePath:sub(-3) == "bml" and true or false
	local extBMS = filePath:sub(-3) == "bms" and true or false
	local extPMS = filePath:sub(-3) == "pms" and true or false
	if extBME or extBML or extBMS or extPMS then else return {} end
    local file = RageFileUtil:CreateRageFile()
	local count = 0
	file:Open(filePath,1)
	file:Seek(0)
	local gLine = {}
	local line
	while true do
		if file then
			line = file:GetLine()
			if file:AtEOF() or (minAmount and count >= minAmount) then break elseif string.find(line,"#WAV[0-9A-Z]+") then
				gLine[#gLine+1] = split(" ",line)[2]
				if minAmount then count = count + 1 end
			end
		end
	end
	file:Close()
	file:destroy()
	return gLine
end

function CheckNullMeasure(Step)
	local filePath = Step:GetFilename()
	local extBME = filePath:sub(-3) == "bme" and true or false
	local extBML = filePath:sub(-3) == "bml" and true or false
	local extBMS = filePath:sub(-3) == "bms" and true or false
	local extPMS = filePath:sub(-3) == "pms" and true or false
	if extBME or extBML or extBMS or extPMS then else return false end
    local file = RageFileUtil:CreateRageFile()
	file:Open(filePath,1)
	file:Seek(0)
	local line
	local ret = false
	local checkMeasure = {}
	local checkMeasurelength = {}
	local checkNotes = {}
	local maxMeasure = 0
	while file and not file:AtEOF() do
		if file then
			line = file:GetLine()
			if string.find(line,":") then
				local tmp = split(":",line)
				local currentMeasure = tonumber(string.sub(tmp[1],2,4))
				if currentMeasure then
					if currentMeasure > maxMeasure then maxMeasure = currentMeasure end
					if string.find(line,"02:") then
						checkMeasure[currentMeasure] = true
						checkMeasurelength[currentMeasure] = tonumber(tmp[2])
					else
						if not checkMeasurelength[currentMeasure] then checkMeasurelength[currentMeasure] = 1 end
						checkNotes[currentMeasure] = true
					end
				end
			end
		end
	end
	file:Close()
	file:destroy()
	local nullCheck = {}
	local earliestNull = 999
	local latestNull = 0
    for measure,length in pairs( checkMeasurelength ) do
		if measure then
			if measure > maxMeasure then maxMeasure = measure end
		end
		if length ~= 1 then
			if not checkNotes[measure] then
				nullCheck[measure] = true
				if measure < earliestNull then earliestNull = measure end
				if measure > latestNull then latestNull = measure end
			end
		end
	end
	if earliestNull ~= 999 and latestNull ~= 0 then
		for measure=maxMeasure-(latestNull-earliestNull), maxMeasure do
			if checkNotes[string.format("%03d",measure)] then ret = true end
		end
	end
	return ret
end

function cacheStep(Song,Step)
	if Song == nil then Song = SONGMAN:GetSongFromSteps(Step) end

    local chartint = 1
	local currentBeat = 0
	local currentNotes = 0
	--local currentMines = 0
	local noteCounter = {}
	local firstBeat = nil
	local lastBeat = 0
	--local shockArrows = ""
	--local NoteDensity = 0

	if not isOutFoxV043() then
		for i,current in pairs( Song:GetAllSteps() ) do
			if current == Step then
				chartint = i
				break
			end
		end
	end

	local stepType = split("_",Step:GetStepsType())

	for i=1,getColumnsPerPlayer(stepType[2],stepType[3]) do
		noteCounter[i] = 0
	end

	local timingData = Step:GetTimingData()
	local currentSec,lastSec = 0,0
	local stepsPerSec = {}
	local scratches,foots = 0,0
	local currentBPM,checkBPM,checkCount,maxBPM = 0,0,0,0
	local checking = false
	--local ChaosValue = 0
	--local previousBeat = 0
	--local FreezeLength = 0
	local stops = timingData:GetStops()
	local delays = timingData:GetDelays()

	local noteData = isOutFoxV043() and Step:GetNoteData() or Song:GetNoteData(chartint)
	for _,v in pairs( noteData ) do
		if currentBeat < v[1] then
			currentBeat = v[1]
			currentNotes = 0
			--currentMines = 0
			lastSec = currentSec
		end

		--local fourBeatCounter = tablelength(Song:GetNoteData(chartint,v[1],v[1]+4))
		--if NoteDensity < fourBeatCounter then NoteDensity = fourBeatCounter end

		if timingData:IsJudgableAtBeat(v[1]) then
			if allowednotes[v[3]] then
				currentNotes = currentNotes + 1
				if v["length"] then
					--FreezeLength = FreezeLength + v["length"]
					if currentBeat + v["length"] > lastBeat then lastBeat = currentBeat + v["length"] end
				else
					if currentBeat > lastBeat then lastBeat = currentBeat end
				end
				if not firstBeat then firstBeat = currentBeat end
				if stepType[2] == "Bm" then
					if #noteCounter == 6 or #noteCounter == 12 then
						if v[2] == #noteCounter or (#noteCounter > 10 and v[2] == #noteCounter/2) then
							scratches = scratches + 1
						end
					elseif #noteCounter == 7 or #noteCounter == 14 then
						if v[2] == #noteCounter or (#noteCounter > 10 and v[2] == #noteCounter/2) then
							foots = foots + 1
						elseif v[2] == #noteCounter-1 or (#noteCounter > 10 and v[2] == #noteCounter/2-1) then
							scratches = scratches + 1
						end
					elseif #noteCounter == 8 or #noteCounter == 16 then
						if v[2] == 1 or (#noteCounter > 10 and v[2] == #noteCounter) then
							scratches = scratches + 1
						end
					end
				end
				--elseif v[3] == "TapNoteType_Mine" then
				--	currentMines = currentMines + 1
				--	if currentMines == getColumnsPerPlayer(stepType[2],stepType[3]) then
				--		shockArrows = addToOutput(shockArrows,Step:GetTimingData():GetElapsedTimeFromBeat(v[1]),"_")
				--	end
			end

			local checkBeat = false

			if _ < #noteData then
				if currentBeat < noteData[_+1][1] then
					checkBeat = true
				end
			else
				checkBeat = true
			end

			if checkBeat then
				if currentNotes ~= 0 then
					currentBPM = math.round(timingData:GetBPMAtBeat(v[1]),3)
					if stops and #stops > 0 then isStop, stops = HasStopAtBeat(v[1],stops) end
					if delays and #delays > 0 then isDelay, delays = HasDelayAtBeat(v[1],delays) end
					if currentBPM > maxBPM and not checking and not (isStop or isDelay) then
						checking = true
						if currentBPM > checkBPM then checkBPM = currentBPM end
						checkCount = 0
					elseif math.abs(1-checkBPM/currentBPM) <= 0.02 and checking and not (isStop or isDelay) then
						checkCount = checkCount + 1
						if checkCount > 4 then
							if currentBPM > checkBPM then checkBPM = currentBPM end
							if currentBPM > maxBPM then maxBPM = checkBPM end
						end
					else
						checkBPM = 0
						checking = false
					end

					noteCounter[currentNotes] = noteCounter[currentNotes] + 1
					currentSec = timingData:GetElapsedTimeFromBeat(v[1])
					if lastSec > 0 then
						local currentSPS = 1 / (currentSec - lastSec) * currentNotes
						if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
					end
				end
				--[[
				ChaosValue = ChaosValue + ChaosCalc(currentBeat,previousBeat,currentNotes)
				previousBeat = currentBeat
				]]--
			end
		end
	end

	noteData = nil

	local total = calcSPS(stepsPerSec)
	local total2 = calcSPS(stepsPerSec,total)

	local hasLua = HasLua(Song,"BGCHANGES") or HasLua(Song,"FGCHANGES")
	local hasKeys = false
	local hasNullMeasure = false

	if stepType[2] == "Bm" or stepType[2] == "Pnm" then
		local keySounds = GetParameter(Step,3)
		hasNullMeasure = CheckNullMeasure(Step)
		if keySounds and #keySounds > 2 then hasKeys = true end
	end

	local file = getStepCacheFile(Step)

	if firstBeat then
		if getenv("cacheing") then
			local list = {
				["Version"] = cacheVersion,
				["HasLua"] = hasLua and "true" or "false",
				["HasKeys"] = hasKeys and "true" or "false",
				["HasNullMeasure"] = hasNullMeasure and "true" or "false",
				["StepCounter"] = table.concat(noteCounter,"_"),
				["StepsPerSecond"] = total2,
				["TrueBeats"] = lastBeat-firstBeat,
				["TrueMaxBPM"] = maxBPM,
				["TrueSeconds"] = Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat)-Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat)
			}

			--if shockArrows ~= "" then list["ShockArrows"] = shockArrows end
			if stepType[2] == "Bm" then
				if #noteCounter == 7 or #noteCounter == 14 then
					list["Foots"] = foots
				end
				list["Scratches"] = scratches
			end

			LoadModule("Config.SaveAll.lua")(list,file)
		else
			LoadModule("Config.Save.lua")("Version",cacheVersion,file)
			LoadModule("Config.Save.lua")("HasLua",hasLua and "true" or "false",file)
			LoadModule("Config.Save.lua")("HasKeys",hasKeys and "true" or "false",file)
			LoadModule("Config.Save.lua")("HasNullMeasure",hasNullMeasure and "true" or "false",file)
			--if shockArrows ~= "" then LoadModule("Config.Save.lua")("ShockArrows",shockArrows,file) end
			LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),file)
			LoadModule("Config.Save.lua")("StepsPerSecond",total2,file)
			LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,file)
			LoadModule("Config.Save.lua")("TrueMaxBPM",maxBPM,file)
			LoadModule("Config.Save.lua")("TrueSeconds",Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat)-Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat),file)
			if stepType[2] == "Bm" then
				if #noteCounter == 7 or #noteCounter == 14 then
					LoadModule("Config.Save.lua")("Foots",foots,file)
				end
				LoadModule("Config.Save.lua")("Scratches",scratches,file)
			end
			--LoadModule("Config.Save.lua")("ChaosValue",ChaosValue,file)
			--LoadModule("Config.Save.lua")("FreezeLength",FreezeLength,file)
			--LoadModule("Config.Save.lua")("NoteDensity",NoteDensity,file)
		end
	else
		local file = getStepCacheFile(Step)
		LoadModule("Config.Save.lua")("Version","0",file)
	end
end

function cacheStepSM(Song,Step)
	if Song == nil then Song = SONGMAN:GetSongFromSteps(Step) end

	local stepType = split("_",Step:GetStepsType())
	local timingData = Step:GetTimingData()
	local stepsPerSec = {}
	local noteCounter = {}
	local firstBeat = nil
	local lastBeat = 0
	local lastSec = 0
	local currentBPM,checkBPM,checkCount,maxBPM = 0,0,0,0

	local stops = timingData:GetStops()
	local delays = timingData:GetDelays()
	local warps = timingData:GetWarps()

	for i=1,getColumnsPerPlayer(stepType[2],stepType[3]) do
		noteCounter[i] = 0
	end

	local chart = ParseChartInfo(Step)
	local beat = 0
	if chart then
		chart = split("\n,\n",chart)
		local currentMeasure = -1
		for measure in ivalues(chart) do
			currentMeasure = currentMeasure + 1
			local rows = split("\n",measure)
			local currentRow = -1
			for row in ivalues(rows) do
				currentRow = currentRow + 1
				beat = (currentMeasure*4)+(currentRow/#rows*4)
				local _, count = string.gsub(row, "[L124]", "")
				if count > 0 then
					local isStop, isDelay, isWarp = false, false, false
					currentBPM = math.round(timingData:GetBPMAtBeat(beat),3)
					if stops and #stops > 0 then isStop,stops = HasStopAtBeat(beat,stops) end
					if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(beat,delays) end
					if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(beat,warps) end
					local isJudgableAtBeat = not isWarp or (isWarp and (isStop or isDelay))
					if isJudgableAtBeat then
						if currentBPM > maxBPM and not checking and not (isStop or isDelay) then
							checking = true
							if currentBPM > checkBPM then checkBPM = currentBPM end
							checkCount = 0
						elseif math.abs(1-checkBPM/currentBPM) <= 0.02 and checking and not (isStop or isDelay) then
							checkCount = checkCount + 1
							if checkCount > 4 then
								if currentBPM > checkBPM then checkBPM = currentBPM end
								if currentBPM > maxBPM then maxBPM = checkBPM end
							end
						else
							checkBPM = 0
							checking = false
						end

						local currentSec = timingData:GetElapsedTimeFromBeat(beat)
						noteCounter[count] = noteCounter[count] + 1
						if not firstBeat then firstBeat = beat end
						lastBeat = beat

						if lastSec > 0 then
							local currentSPS = 1 / (currentSec - lastSec) * count
							if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
						end
						lastSec = currentSec
					end
				end
				if string.find(row,"[L1234]") then
					lastBeat = beat
				end
			end
		end
		if firstBeat then
			local firstSecond = timingData:GetElapsedTimeFromBeat(firstBeat)
			local lastSecond = timingData:GetElapsedTimeFromBeat(lastBeat)
			local total = calcSPS(stepsPerSec)
			local total2 = calcSPS(stepsPerSec,total)
			local hasLua = HasLua(Song,"BGCHANGES") or HasLua(Song,"FGCHANGES")
			local file = getStepCacheFile(Step)
	
			if getenv("cacheing") then
				local list = {
					["Version"] = cacheVersion,
					["HasLua"] = hasLua and "true" or "false",
					["StepCounter"] = table.concat(noteCounter,"_"),
					["StepsPerSecond"] = total2,
					["TrueBeats"] = lastBeat-firstBeat,
					["TrueMaxBPM"] = maxBPM,
					["TrueSeconds"] = lastSecond-firstSecond
				}
	
				LoadModuleSM("Config.SaveAll.lua")(list,file)
			else
				LoadModuleSM("Config.Save.lua")("Version",cacheVersion,file)
				LoadModuleSM("Config.Save.lua")("HasLua",hasLua and "true" or "false",file)
				LoadModuleSM("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),file)
				LoadModuleSM("Config.Save.lua")("StepsPerSecond",total2,file)
				LoadModuleSM("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,file)
				LoadModuleSM("Config.Save.lua")("TrueMaxBPM",maxBPM,file)
				LoadModuleSM("Config.Save.lua")("TrueSeconds",lastSecond-firstSecond,file)
			end
		else
			local file = getStepCacheFile(Step)
			LoadModuleSM("Config.Save.lua")("Version","0",file)
		end
	else
		if isOutFox() then
			cacheStep(Song,Step)
		else
			local file = getStepCacheFile(Step)
			LoadModuleSM("Config.Save.lua")("Version","0",file)
		end
	end
end

function LoadFromCache(Song,Step,key)
	local version = isOutFox() and LoadModule("Config.Load.lua")("Version",getStepCacheFile(Step)) or LoadModuleSM("Config.Load.lua")("Version",getStepCacheFile(Step))

	if version == "0" then
		return nil
	elseif not version or version ~= cacheVersion then
		if isOutFox() then cacheStep(Song,Step) else cacheStepSM(Song,Step) end
	end

	if isOutFox() then
		return LoadModule("Config.Load.lua")(key,getStepCacheFile(Step))
	else
		return LoadModuleSM("Config.Load.lua")(key,getStepCacheFile(Step))
	end
end

--[[
function LoadFromCache(Song,Step,key)
	local file = getStepCacheFile(Step)
	if not FILEMAN:DoesFileExist(file) then
		stepCache[file] = cacheStep(Song,Step)
	else
		local version = LoadModule("Config.Load.lua")("Version",file)

		if not version or version ~= cacheVersion then
			stepCache[file] = cacheStep(Song,Step)
		elseif not LoadModule("Config.Exist.lua")(key,file) then
			stepCache[file] = cacheStep(Song,Step)
		end
	end

	if stepCache[file] ~= nil and stepCache[file][key] ~= nil then
		return stepCache[file][key]
	else
		if stepCache[file] == nil then stepCache[file] = {} end
		if stepCache[file][key] == nil then stepCache[file][key] = LoadModule("Config.Load.lua")(key,file) end
	end

	return stepCache[file][key] or LoadModule("Config.Load.lua")(key,file)
end
]]--

function GetMinSecondsToStep()
	local song = GAMESTATE:GetCurrentSong()
	local firstSec, firstBeat = 1, 0
	local firstBpm, smOffset = 60, 0

	local BPMS = GetSMParameter(song,"BPMS")
	if BPMS ~= "" then firstBpm = split('=', split(',', BPMS)[1])[2] end

	local OFFSET = GetSMParameter(song,"OFFSET")
	if OFFSET ~= "" then smOffset = OFFSET end

	local BGCHANGES = GetSMParameter(song,"BGCHANGES")
	if BGCHANGES ~= "" then
		BGCHANGES = split(',',BGCHANGES)
		for BGC in ivalues(BGCHANGES) do
			line = split('=',BGC)
			line[1] = tonumber(line[1])
			firstFile = line[2]
			if line[1] >= 0 then break elseif line[1] < 0 and line[1] > -20 * firstBpm / 60 then
				for typ in ivalues(typeList) do
					if string.find(line[2], typ) then firstBeat = line[1] break end
				end
			end
		end
	end

	if firstBeat < 0 then firstSec = firstBeat * 60 / firstBpm end
	firstSec = song:GetFirstSecond() - firstSec + smOffset

	return math.max(firstSec, 1)
end

function LV100(input)
	return math.pow(input*(1/15000),2)+(input*0.09)+0.5
end

function GetConvertDifficulty(Song,Step,songLength)
	local voltage=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Voltage')*Song:MusicLengthSeconds()/songLength
	local stream=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Stream')*Song:MusicLengthSeconds()/songLength
	local radar_voltage=voltage-0.5
	local radar_stream=stream-0.5
	local bpms=Step:GetTimingData():GetActualBPM()
	local tapspoint=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds')
	tapspoint=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Jumps')/1.05+tapspoint
	tapspoint=((radar_stream>=0) and radar_stream*66 or radar_stream*50)+tapspoint
	tapspoint=((radar_voltage>=0) and radar_voltage*80 or radar_voltage*50)+tapspoint
	tapspoint=math.max(tapspoint-666,0)*1.05+tapspoint
	tapspoint=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Mines')/8+tapspoint
	tapspoint=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Holds')/8+tapspoint
	tapspoint=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Rolls')+tapspoint
	tapspoint=Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Chaos')*10+tapspoint
	tapspoint=25+tapspoint
	tapspoint=math.max(130-bpms[1],0)+tapspoint
	tapspoint=math.max(math.min(bpms[2],400)-160,0)/5+tapspoint
	tapspoint=math.round(tapspoint*52/songLength/5)
	tapspoint=tapspoint*1.2
	if songLength>300 then
		tapspoint=tapspoint*1.14
	elseif songLength>150 then
		tapspoint=tapspoint*1.09
	elseif songLength>120 then
		tapspoint=tapspoint*1.05
	elseif songLength>100 then
		tapspoint=tapspoint*1.02
	end
	--if songLength>60 then tapspoint=tapspoint*(1+((songLength-60)/30)*0.025) end
	return LV100(tapspoint)
end

function getTrueBPMsCalculated(song,step)
	local timingdata = step:GetTimingData()
	local bpms = step:GetDisplayBpms()
	local truebpms = timingdata:GetActualBPM()

	bpms[1] = math.round(bpms[1],3)
	bpms[2] = math.round(bpms[2],3)
	truebpms[1] = math.round(truebpms[1],3)
	truebpms[2] = math.round(truebpms[2],3)

	for i=1,2 do
		if bpms[i] then if math.abs(1-bpms[i]/math.round(bpms[i])) < 0.005 then bpms[i] = math.round(bpms[i]) end end
		if truebpms[i] then if math.abs(1-truebpms[i]/math.round(truebpms[i])) < 0.005 then truebpms[i] = math.round(truebpms[i]) end end
	end

	if bpms[1] == truebpms[1] and bpms[2] == truebpms[2] and bpms[1] == bpms[2] then
		return {truebpms[1],truebpms[1],truebpms[1]}
	else
		local sets = timingdata:GetBPMsAndTimes()
		local currentSet, lastSet
		local BPMs, duration, lastDuration = {}, 0, 0
		local fastestBPM = 0

		for i, set in ipairs(sets) do
			currentSet = split("=",set)
			currentSet[1]=math.round(tonumber(currentSet[1]),3)
			currentSet[2]=math.round(tonumber(currentSet[2]),3)

			if lastSet then
				duration = (currentSet[1]-lastSet[1]) / lastSet[2] * 60
				if BPMs[lastSet[2]] then
					BPMs[lastSet[2]] = BPMs[lastSet[2]] + duration
				else
					BPMs[lastSet[2]] = duration
				end
				if math.abs(1-lastSet[2]/currentSet[2]) <= 0.02 then
					duration = duration + lastDuration
					if truebpms[1] <= currentSet[2] and truebpms[2] >= currentSet[2] then
						if fastestBPM < currentSet[2] then fastestBPM = currentSet[2] end
					end
				end
				if duration >= 6 then
					if truebpms[1] <= lastSet[2] and truebpms[2] >= lastSet[2] then
						if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
					end
					if truebpms[1] <= currentSet[2] and truebpms[2] >= currentSet[2] then
						if math.abs(1-lastSet[2]/currentSet[2]) <= 0.02 then
							if fastestBPM < currentSet[2] then fastestBPM = currentSet[2] end
						end
					end
				end
			end
			lastSet, lastDuration = currentSet, duration
		end

		duration = (song:GetLastBeat()-lastSet[1]) / lastSet[2] * 60
		if BPMs[lastSet[2]] then
			BPMs[lastSet[2]] = BPMs[lastSet[2]] + duration
		else
			BPMs[lastSet[2]] = duration
		end
		if duration >= 4 then
			if truebpms[1] <= lastSet[2] and truebpms[2] >= lastSet[2] then
				if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
			end
		end
		if math.abs(1-fastestBPM/truebpms[2]) <= 0.04 then fastestBPM = truebpms[2] end

		return {truebpms[1],truebpms[2],fastestBPM}
	end
end

function getAllTheBPMs(song,step,BPMtype)
	local bpms = {0,0,0}
	if BPMtype == 0 then
		if song:IsDisplayBpmSecret() or song:IsDisplayBpmRandom() then
			bpms = {"???","???","???"}
		else
			bpms = step:GetDisplayBpms()
			bpms[3] = 0
		end
	elseif BPMtype == 1 then
		bpms = step:GetTimingData():GetActualBPM()
		bpms[3] = 0
	elseif BPMtype == 2 then
		local usesStepCache = ThemePrefs.Get("UseStepCache")
		local trueBPM = usesStepCache and tonumber(LoadFromCache(song,step,"TrueMaxBPM")) or -1
		--local trueBPM = isOutFox() and getTrueMaxBPM(song,step) or 0
		if usesStepCache and trueBPM >= 0 then
			bpms = step:GetTimingData():GetActualBPM()
			bpms[3]=trueBPM
		else
			bpms = getTrueBPMsCalculated(song,step)
		end
	end

	local MusicRate = math.round(GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate(),1)

	if tonumber(bpms[1]) then bpms[1]=math.round(bpms[1]*MusicRate) end
	if tonumber(bpms[2]) then bpms[2]=math.round(bpms[2]*MusicRate) end
	if tonumber(bpms[3]) then bpms[3]=math.round(bpms[3]*MusicRate) end

	return bpms
end

local repeatCheck = {}

function resetRepeatCheck()
	if IsGame("dance") or IsGame("groove") then
		repeatCheck = {}
	end
end

--[[
	This function gets called intentionally through MeterSetCommand inside Metrics.ini for [StepsDisplayListRow]
	But for whatever reason, it gets called on ALL Changed*MessageCommands FOR ALL ENABLED PLAYERS.
	Because of this, if ShowCalcDiff is enabled, I'm forcing a check so that the function only gets executed once and loaded every other time. 
]]--
function getCalculatedDifficulty(Step)
	if not Step then return "" end
	local value = split("/",getStepCacheFile(Step))[3]
	if repeatCheck[value] then return repeatCheck[value] end

	local OG = Step:GetMeter()
	local Song = SONGMAN:GetSongFromSteps(Step)
	--local totalSeconds = isOutFox() and getTrueSeconds(Song,Step)["TrueSeconds"] or (Song:GetLastSecond() - Song:GetFirstSecond())
	--local stepCounter = isOutFox() and getStepCounter(Song,Step)["StepCounter"] or {}
	local usesStepCache = ThemePrefs.Get("UseStepCache")
	local skip = usesStepCache and LoadFromCache(Song,Step,"Version") == nil or false
	if skip then
		repeatCheck[value] = OG
		return OG
	end
	local totalSeconds = usesStepCache and tonumber(LoadFromCache(Song,Step,"TrueSeconds")) or (Song:GetLastSecond() - Song:GetFirstSecond())
	local stepCounter = usesStepCache and split("_",LoadFromCache(Song,Step,"StepCounter") or "") or {}
	local stepType = split("_",Step:GetStepsType())
	local stepSum = isOutFox() and 0 or math.round(Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)

	if totalSeconds < 0 then
		totalSeconds = Song:GetLastSecond() - Song:GetFirstSecond()
		stepCounter = {}
		stepSum = math.round(Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)
	end

	if usesStepCache then
		for i=1,#stepCounter do if stepCounter[i] then stepSum = stepSum + (stepCounter[i] * i) end end
		if IsGame("be-mu") or IsGame("beat") then
			stepSum = stepSum / totalSeconds
		else
			stepSum = ( stepSum / totalSeconds ) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)
		end
	end

	local ddrtype = 1

	if (IsGame("dance") or IsGame("groove")) then
		if ThemePrefs.Get("DanceDifficultyType") == false then
			ddrtype = 2/3
		end
	end

	local DB9 = stepSum * ddrtype
	local YA  = 0
	local SPS = 0

	if IsGame("be-mu") or IsGame("beat") then
		YA = GetConvertDifficulty(Song,Step,totalSeconds) / 2
		if usesStepCache then SPS = tonumber(LoadFromCache(Song,Step,"StepsPerSecond")) / 2 end
		--if usesStepCache then SPS = getSPS(Song,Step) / 2 end
	else
		if not IsGame("pump") then YA = GetConvertDifficulty(Song,Step,totalSeconds) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4) * ddrtype end
		if usesStepCache then SPS = tonumber(LoadFromCache(Song,Step,"StepsPerSecond")) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4) * ddrtype end
		--if usesStepCache then SPS = getSPS(Song,Step) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4) * ddrtype end
	end

	local output = {}
	if DB9 > YA and DB9 > SPS then
		output = {math.round(DB9),"DB9"}
	elseif YA > DB9 and YA > SPS then
		output = {math.round(YA),"Y&A"}
	elseif SPS > DB9 and SPS > YA then
		output = {math.round(SPS),"SPS"}
	end
	if output[1] and output[1] ~= OG then
		repeatCheck[value] = output[1].." "..output[2].."\n"..OG.." OG"
		return output[1].." "..output[2].."\n"..OG.." OG"
	else
		repeatCheck[value] = OG
		return OG
	end
end

function grooveRadar(song,step,RadarValues)
	local stream,voltage,air,freeze,chaos = 0,0,0,0,0

	stream = RadarValues:GetValue('RadarCategory_Stream')
	voltage = RadarValues:GetValue('RadarCategory_Voltage')
	air = RadarValues:GetValue('RadarCategory_Air')
	freeze = RadarValues:GetValue('RadarCategory_Freeze')
	chaos = RadarValues:GetValue('RadarCategory_Chaos')

	if not IsGame("pump") then
		--local trueValues = isOutFox() and getTrueSeconds(song,step) or {}
		--local totalSeconds = isOutFox() and trueValues["TrueSeconds"] or (song:GetLastSecond() - song:GetFirstSecond())
		--local totalBeats = isOutFox() and trueValues["TrueBeats"] or (song:GetLastBeat() - song:GetFirstBeat())
		local usesStepCache = ThemePrefs.Get("UseStepCache")
		local totalSeconds = usesStepCache and tonumber(LoadFromCache(song,step,"TrueSeconds")) or song:GetLastSecond() - song:GetFirstSecond()
		local totalBeats = usesStepCache and tonumber(LoadFromCache(song,step,"TrueBeats")) or song:GetLastBeat() - song:GetFirstBeat()
		local avg_bps_OLD = song:GetLastBeat() / song:MusicLengthSeconds()
		local avg_bps_NEW = totalBeats / totalSeconds

		if totalSeconds < 0 and totalBeats < 0 then
			totalSeconds = song:GetLastSecond() - song:GetFirstSecond()
			totalBeats = song:GetLastBeat() - song:GetFirstBeat()
			avg_bps_NEW = totalBeats / totalSeconds
		end

		stream = stream * song:MusicLengthSeconds() / totalSeconds
		voltage = voltage / avg_bps_OLD * avg_bps_NEW
		air = air * song:MusicLengthSeconds() / totalSeconds
		freeze = freeze * song:MusicLengthSeconds() / totalSeconds
		chaos = chaos * song:MusicLengthSeconds() / totalSeconds
	end

	return math.max(0,stream),math.max(0,voltage),math.max(0,air),math.max(0,freeze),math.max(0,chaos)
end