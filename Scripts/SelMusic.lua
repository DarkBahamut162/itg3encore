local cacheVersion = "0.33"

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
	local ret = IsNetSMOnline() and THEME:GetString("ScreenNetSelectMusic", "HelpText") or THEME:GetString("ScreenSelectMusic", "HelpTextNormal")

	if SelectButtonAvailable() then
		if DifficultyChangingAvailable() or ModeMenuAvailable() then
			ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "SelectButtonAvailableHelpTextAppend" )
		end
	else
		if DifficultyChangingAvailable() then
			ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "DifficultyChangingAvailableHelpTextAppend" )
		end

		if ModeMenuAvailable() then
			ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "SortMenuAvailableHelpTextAppend" )
		end
	end

	if getenv("Workout") and IsHome() then
		ret = ret .. "::" .. THEME:GetString( "ScreenSelectMusic", "WorkoutHelpTextAppend" )
	end

	return ret
end

function GetSMParameter(song,parameter)
	local filePath = song:GetSongFilePath()
	local suffix = string.match(filePath, '.+%.([^.]+)')
	if suffix ~= 'sm' and suffix ~= 'ssc' then return "" end
	local file = RageFileUtil.CreateRageFile()
	file:Open(filePath,1)
	file:Seek(0)
	local gLine = ""
	local line
	while true do
		if file then
			line = file:GetLine()
			if string.find(line,"#NOTES:.*") or string.find(line,"#NOTEDATA:.*") or file:AtEOF() then break
			elseif (string.find(line,"^.*#"..parameter..":.*") and (not string.find(line,"^%/%/.*"))) or gLine ~= "" then
				gLine = gLine..""..split("//",line)[1]
				if string.find(line,".*;") then break end
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
	local var = GetSMParameter(song,changes)
	local parameter, current
	if var ~= "" then
		parameter = split(",",var)
		if parameter ~= "" then
			for i=1,#parameter do
				parameter[i] = split("=",parameter[i])
				if #parameter[i] >= 2 then
					current = parameter[i][2]
					if current ~= "" then
						if string.find(current,".lua",0,true) then
							return true
						elseif string.find(current,".",0,true) then else
							local groupName = song:GetGroupName()
							local songFolder = isOutFox() and song:GetSongFolder() or GetSongFolderName(song)
							local checkFolder = FILEMAN:GetDirListing("/Songs/"..groupName.."/"..songFolder.."/"..current.."/")
							for insideFiles in ivalues( checkFolder ) do
								if string.find(insideFiles,".lua",0,true) then return true end
							end
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
	["TapNoteSubType_TapNoteSubType_Roll"] = true
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
	local Song = SONGMAN:GetSongFromSteps(Step)
	local groupName = #filename >= 4 and filename[3] or Song:GetGroupName()
	local songName = #filename >= 4 and filename[4] or Song:GetSongFolder()
	return "Cache/Steps/Steps_"..groupName.."_"..songName.."_"..ToEnumShortString(Step:GetStepsType()).."_"..ToEnumShortString(Step:GetDifficulty()).."_"..Step:GetHash()
end

function HasStopAtBeat(beat,timing)
	for _,v in pairs(timing:GetStops()) do
		if tonumber(split('=', v)[1]) == beat then
			return true
		end
	end
	return false
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

local function calcSPS(SPS,max)
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

function cacheStep(Song,Step)
    local chartint = 1
	local currentBeat = 0
	local currentNotes = 0
	local currentMines = 0
	local noteCounter = {}
	local firstBeat = 999
	local lastBeat = 0
	local shockArrows = ""

	for i,current in pairs( Song:GetAllSteps() ) do
		if current == Step then
			chartint = i
			break
		end
	end

	local stepType = split("_",Step:GetStepsType())

	for i=1,getColumnsPerPlayer(stepType[2],stepType[3]) do
		noteCounter[i] = 0
	end

	local timingData = Step:GetTimingData()
	local lastSec = 0
	local stepsPerSec = {}
	local currentSPS = 0
	local scratches = 0
	local foots = 0
	local currentBPM,checkBPM,checking,checkCount,maxBPM,isStop = 0,0,false,0,0,false

	for _,v in pairs( Song:GetNoteData(chartint) ) do
		if currentBeat < v[1] then
			currentBeat = v[1]
			if currentNotes ~= 0 then
				noteCounter[currentNotes] = noteCounter[currentNotes] + 1
			end
			currentNotes, currentMines = 0, 0
		end

		if timingData:IsJudgableAtBeat(v[1]) then
			if allowednotes[v[3]] then
				currentBPM = math.round(timingData:GetBPMAtBeat(v[1]),3)
				isStop = HasStopAtBeat(v[1],timingData)
				if currentBPM > maxBPM and not checking and not isStop then
					checking = true
					if currentBPM > checkBPM then checkBPM = currentBPM end
					checkCount = 0
				elseif math.abs(1-checkBPM/currentBPM) <= 0.02 and checking and not isStop then
					checkCount = checkCount + 1
					if checkCount > 4 then
						if currentBPM > checkBPM then checkBPM = currentBPM end
						if currentBPM > maxBPM then maxBPM = checkBPM end
					end
				else
					checkBPM = 0
					checking = false
				end

				local currentSec = timingData:GetElapsedTimeFromBeat(v[1])
				currentNotes = currentNotes + 1
				if lastSec > 0 then
					if lastSec < currentSec then
						currentSPS = 1 / (currentSec - lastSec)
						if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
						lastSec = currentSec
					elseif lastSec == currentSec then
						local currentSPS_ = currentSPS * currentNotes
						if stepsPerSec[currentSPS_] then stepsPerSec[currentSPS_] = stepsPerSec[currentSPS_] + 1 else stepsPerSec[currentSPS_] = 1 end
					end
				else
					lastSec = currentSec
				end
				if v["length"] then
					if currentBeat + v["length"] > lastBeat then lastBeat = currentBeat + v["length"] end
				else
					if currentBeat > lastBeat then lastBeat = currentBeat end
				end
				if currentBeat < firstBeat then firstBeat = currentBeat end
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
			elseif v[3] == "TapNoteType_Mine" then
				currentMines = currentMines + 1
				if currentMines == getColumnsPerPlayer(stepType[2],stepType[3]) then
					shockArrows = addToOutput(shockArrows,Step:GetTimingData():GetElapsedTimeFromBeat(v[1]),"_")
				end
			end
		end
	end
	if currentNotes ~= 0 then noteCounter[currentNotes] = noteCounter[currentNotes] + 1 end

	local total = calcSPS(stepsPerSec)
	local total2 = calcSPS(stepsPerSec,total)

	local hasLua = HasLua(Song,"BGCHANGES") or HasLua(Song,"FGCHANGES")

	LoadModule("Config.Save.lua")("Version",cacheVersion,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("HasLua",hasLua and "true" or "false",getStepCacheFile(Step))
	if shockArrows ~= "" then LoadModule("Config.Save.lua")("ShockArrows",shockArrows,getStepCacheFile(Step)) end
	LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("StepsPerSecond",total2,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueMaxBPM",maxBPM,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueSeconds",Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat)-Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat),getStepCacheFile(Step))
	if stepType[2] == "Bm" then
		if #noteCounter == 7 or #noteCounter == 14 then
			LoadModule("Config.Save.lua")("Foots",foots,getStepCacheFile(Step))
		end
		LoadModule("Config.Save.lua")("Scratches",scratches,getStepCacheFile(Step))
	end
end

function LoadFromCache(Song,Step,value)
	local version = LoadModule("Config.Load.lua")("Version",getStepCacheFile(Step))
	if not LoadModule("Config.Exists.lua")(value,getStepCacheFile(Step)) then
		cacheStep(Song,Step)
	elseif not version or version ~= cacheVersion then
		cacheStep(Song,Step)
	end
	return LoadModule("Config.Load.lua")(value,getStepCacheFile(Step))
end

local typeList = {'avi','mkv','mp4','mpeg','mpg','wmv'}

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
				for i=1, #typeList do
					if string.find(line[2], typeList[i]) then firstBeat = line[1] break end
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
		local fastestBPM, fastestBPM_backup = 0, 0

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
		bpms = step:GetDisplayBpms()
		bpms[1]=math.round(bpms[1])
		bpms[2]=math.round(bpms[2])
		bpms[3] = 0
	elseif BPMtype == 1 then
		bpms = step:GetTimingData():GetActualBPM()
		bpms[1]=math.round(bpms[1])
		bpms[2]=math.round(bpms[2])
		bpms[3] = 0
	elseif BPMtype == 2 then
		local trueBPM = isOutFox() and tonumber(LoadFromCache(song,step,"TrueMaxBPM")) or 0
		if isOutFox() and trueBPM > 0 then
			bpms = step:GetTimingData():GetActualBPM()
			bpms[1]=math.round(bpms[1])
			bpms[2]=math.round(bpms[2])
			bpms[3]=math.round(trueBPM)
		else
			bpms = getTrueBPMsCalculated(song,step)
			bpms[1]=math.round(bpms[1])
			bpms[2]=math.round(bpms[2])
			bpms[3]=math.round(bpms[3])
		end
	end
	return bpms
end

local repeatCheck = {}

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
	local totalSeconds = isOutFox() and tonumber(LoadFromCache(Song,Step,"TrueSeconds")) or (Song:GetLastSecond() - Song:GetFirstSecond())
	local stepCounter = isOutFox() and split("_",LoadFromCache(Song,Step,"StepCounter")) or {}
	local stepType = split("_",Step:GetStepsType())
	local stepSum = isOutFox() and 0 or math.round(Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)

	if totalSeconds < 0 then
		totalSeconds = Song:GetLastSecond() - Song:GetFirstSecond()
		stepCounter = {}
		stepSum = math.round(Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)
	end

	if isOutFox() then
		for i=1,#stepCounter do if stepCounter[i] then stepSum = stepSum + (stepCounter[i] * i) end end
		if IsGame("be-mu") then
			stepSum = stepSum / totalSeconds
		else
			stepSum = ( stepSum / totalSeconds ) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)
		end
	end

	local DB9 = stepSum
	local YA  = 0
	local SPS = 0

	if IsGame("be-mu") then
		YA = GetConvertDifficulty(Song,Step,totalSeconds) / 2
		if isOutFox() then SPS = tonumber(LoadFromCache(Song,Step,"StepsPerSecond")) / 2 end
	else
		YA = GetConvertDifficulty(Song,Step,totalSeconds) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4)
		if isOutFox() then SPS = tonumber(LoadFromCache(Song,Step,"StepsPerSecond")) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4) end
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

function grooveRadar(song,step,timingData,RadarValues)
	local stream,voltage,air,freeze,chaos = 0,0,0,0,0
	local totalSeconds = isOutFox() and tonumber(LoadFromCache(song,step,"TrueSeconds")) or (song:GetLastSecond() - song:GetFirstSecond())
	local totalBeats = (isOutFox() and tonumber(LoadFromCache(song,step,"TrueBeats")) or (song:GetLastBeat() - song:GetFirstBeat()))
	local avg_bps_OLD = song:GetLastBeat() / song:MusicLengthSeconds()
	local avg_bps_NEW = totalBeats / totalSeconds

	if totalSeconds < 0 and totalBeats < 0 then
		totalSeconds = song:GetLastSecond() - song:GetFirstSecond()
		totalBeats = song:GetLastBeat() - song:GetFirstBeat()
		avg_bps_NEW = totalBeats / totalSeconds
	end

	stream = RadarValues:GetValue('RadarCategory_Stream')
	voltage = RadarValues:GetValue('RadarCategory_Voltage')
	air = RadarValues:GetValue('RadarCategory_Air')
	freeze = RadarValues:GetValue('RadarCategory_Freeze')
	chaos = RadarValues:GetValue('RadarCategory_Chaos')

	stream = stream * song:MusicLengthSeconds() / totalSeconds
	voltage = voltage / avg_bps_OLD * avg_bps_NEW
	air = air * song:MusicLengthSeconds() / totalSeconds
	freeze = freeze * song:MusicLengthSeconds() / totalSeconds
	chaos = chaos * song:MusicLengthSeconds() / totalSeconds

	return math.max(0,stream),math.max(0,voltage),math.max(0,air),math.max(0,freeze),math.max(0,chaos)
end