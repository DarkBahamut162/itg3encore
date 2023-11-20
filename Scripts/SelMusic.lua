local cacheVersion = "0.32"

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
	["TapNoteSubType_Roll"] = true
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

function cacheStep(Song,Step)
    local chartint = 1
	local currentBeat = 0
	local currentNotes = 0
	local currentMines = 0
	local noteCounter = {}
	local firstBeat = 999
	local lastBeat = 0
	local shockArrows = ""

	for k,v in pairs( Song:GetAllSteps() ) do
		if v == Step then
			chartint = k
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

	for k,v in pairs( Song:GetNoteData(chartint) ) do
		if currentBeat < v[1] then
			currentBeat = v[1]
			if currentNotes ~= 0 then
				noteCounter[currentNotes] = noteCounter[currentNotes] + 1
			end
			currentNotes, currentMines = 0, 0
		end

		if timingData:IsJudgableAtBeat(v[1]) then
			if allowednotes[v[3]] then
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
					if shockArrows ~= "" then
						shockArrows = shockArrows .. "_"
					end
					shockArrows = shockArrows .. Step:GetTimingData():GetElapsedTimeFromBeat(v[1])
				end
			end
		end
	end
	if currentNotes ~= 0 then noteCounter[currentNotes] = noteCounter[currentNotes] + 1 end
	local total, times = 0, 0
	for _sps, _times in pairs(stepsPerSec) do
		total = total + (_sps * _times)
		times = times + _times
	end

	if total > 0 and times > 0 then total = total / times * 2 end

	local total2, times2 = 0, 0
	for _sps2, _times2 in pairs(stepsPerSec) do
		if _sps2 > total / 6 and _sps2 < total * 2 then
			total2 = total2 + (_sps2 * _times2)
			times2 = times2 + _times2
		end
	end

	if total2 > 0 and times2 > 0 then total2 = total2 / times2 * 2 end

	local hasLua = HasLua(Song,"BGCHANGES") or HasLua(Song,"FGCHANGES")

	LoadModule("Config.Save.lua")("Version",cacheVersion,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("HasLua",hasLua and "true" or "false",getStepCacheFile(Step))
	if shockArrows ~= "" then LoadModule("Config.Save.lua")("ShockArrows",shockArrows,getStepCacheFile(Step)) end
	LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("StepsPerSecond",total2,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,getStepCacheFile(Step))
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

local tapsp2lv100={
	00.5,0.55,00.6,0.65,00.7,0.75,00.8,0.85,00.9,0.95,
	01.0,01.2,01.4,01.6,01.7,01.8,01.9,02.0,02.2,02.3,
	02.5,02.6,03.0,03.3,03.6,04.0,04.3,04.6,05.0,05.2,
	05.5,05.7,06.0,06.2,06.5,06.7,07.0,07.2,07.4,07.6,
	07.8,08.0,08.3,08.6,09.0,09.2,09.4,09.6,09.8,10.0,
	10.2,10.5,10.7,11.0,11.3,11.6,12.0,12.0,12.2,12.4,
	12.6,12.8,13.0,13.0,13.3,13.5,13.7,14.0,14.2,14.4,
	14.5,14.5,14.6,14.8,15.0,15.2,15.4,15.6,15.8,16.0,
	16.2,16.4,16.6,16.8,17.0,17.2,17.4,17.6,17.8,18.0,
	18.2,18.4,18.6,18.8,19.0,19.2,19.4,19.6,19.8,20.0,
	20.2,20.4,20.6,20.8,21.0,21.2,21.4,21.6,21.8,22.0,
	22.2,22.4,22.6,22.8,23.0,23.2,23.4,23.6,23.8,24.0,
	24.2,24.4,24.6,24.8,25.0,25.2,25.4,25.6,25.8,26.0,
	26.2,26.4,26.6,26.8,27.0,27.2,27.4,27.6,27.8,28.0,
	28.2,28.4,28.6,28.8,29.0,29.2,29.4,29.6,29.8,30.0,
	30.2,30.4,30.6,30.8,31.0,31.2,31.4,31.6,31.8,32.0,
	32.2,32.4,32.6,32.8,33.0,33.2,33.4,33.6,33.8,34.0,
	34.2,34.4,34.6,34.8,35.0,35.2,35.4,35.6,35.8,36.0,
	36.4,36.8,37.2,37.6,38.0,38.4,38.8,39.2,39.6,40.0,
	40.5,41.0,41.5,42.0,42.5,43.0,43.5,44.0,44.5,45.0,
	45.5,46.0,46.5,47.0,47.5,48.0,48.5,49.0,49.5,50.0
}

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
	if tapspoint>=#tapsp2lv100*1.98 then
		tapspoint=#tapsp2lv100
	else
		if tapspoint>=#tapsp2lv100 then
			local max=#tapsp2lv100*1.98-#tapsp2lv100
			tapspoint=#tapsp2lv100*0.85+(#tapsp2lv100*0.15*math.sin((math.pi*0.5)*(tapspoint-#tapsp2lv100)/max))
		elseif tapspoint>=#tapsp2lv100*0.5 then
			local max=#tapsp2lv100-#tapsp2lv100*0.5
			tapspoint=#tapsp2lv100*0.5+(#tapsp2lv100*0.35*math.sin((math.pi*0.5)*(tapspoint-#tapsp2lv100*0.5)/max))
		end
	end
	tapspoint=math.round(tapspoint)
	tapspoint=math.max(tapspoint+1,1)
	tapspoint=math.min(tapspoint,#tapsp2lv100)

	local meter
	if tapsp2lv100[tapspoint]<25 then
		meter=12*math.sin(tapsp2lv100[tapspoint]*math.pi*0.5/25)
	elseif tapsp2lv100[tapspoint]<35 then
		meter=(tapsp2lv100[tapspoint]-25)*3/10+12
	else
		meter=(tapsp2lv100[tapspoint]-35)*5/15+15
	end
	return meter
end