function DifficultyChangingAvailable()
	local pm = GAMESTATE:GetPlayMode()
	local so = GAMESTATE:GetSortOrder()
	return pm ~= 'PlayMode_Endless' and pm ~= 'PlayMode_Oni' and so ~= 'SortOrder_ModeMenu'
end

function SelectMenuAvailable()
	local pm = GAMESTATE:GetPlayMode()
	local so = GAMESTATE:GetSortOrder()
	return pm ~= 'PlayMode_Endless' and so ~= 'SortOrder_ModeMenu'
end

function ModeMenuAvailable()
	local courseMode = GAMESTATE:IsCourseMode()
	local sortOrder = GAMESTATE:GetSortOrder()
	return (not courseMode) and (sortOrder ~= 'SortOrder_ModeMenu')
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
	local text = {}
	local ret = THEME:GetString("ScreenSelectMusic", "HelpTextNormal")

	if  SelectButtonAvailable() then
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

	if GAMESTATE:GetEnv("Workout") and IsHomeMode() then
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
							if string.find(current,"-nosongbg-",0,true) or string.find(current,"-random-",0,true)
								or string.find(current,"songbackground",0,true) or current == "" then else
								return true
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

function getStepCacheFile(Step)
	local hashOld = false
	local cache = ""
	if hashOld then
		cache = "Cache/Steps/"..Step:GetHash()
	else
		local filename = split("/",Step:GetFilename())
		cache = "Cache/Steps/Steps_"..filename[3].."_"..filename[4].."_"..ToEnumShortString(Step:GetStepsType()).."_"..ToEnumShortString(Step:GetDifficulty())
	end
	return cache
end

function cacheStep(Step)
    local chartint = 1
	local currentBeat = 0
	local currentNotes = 0
	local currentMines = 0
	local noteCounter
	local firstBeat = 999
	local lastBeat = 0
	local shockArrows = ""
	local arrows = GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
	local temp = ""
	local lastSecondHint = GetSMParameter(GAMESTATE:GetCurrentSong(),"LASTSECONDHINT")

	for k,v in pairs( GAMESTATE:GetCurrentSong():GetAllSteps() ) do
		if v == Step then
			chartint = k
			break
		end
	end

	for i=1,arrows do
		temp = temp .. "0"
		if i < arrows then temp = temp .. "," end
	end

	noteCounter = split(",",temp)

	if lastSecondHint ~= "" then
		lastBeat = Step:GetTimingData():GetBeatFromElapsedTime(lastSecondHint)
	end

	local timingData = Step:GetTimingData()
	local warps = timingData:GetWarps()
	local ignore = false

	if #warps > 0 then
		for i=1, #warps do
			warps[i] = split("=",warps[i])
			warps[i][1] = tonumber(warps[i][1])
			warps[i][2] = tonumber(warps[i][2])
		end
	end

	for k,v in pairs( GAMESTATE:GetCurrentSong():GetNoteData(chartint) ) do
		ignore = false
		if currentBeat < v[1] then
			currentBeat = v[1]
			if currentNotes ~= 0 then
				noteCounter[currentNotes] = noteCounter[currentNotes] + 1
			end
			currentNotes, currentMines = 0, 0
		end

		if #warps > 0 then
			for i=1, #warps do
				if warps[i][1] < currentBeat and (warps[i][1] + warps[i][2]) > currentBeat then
					ignore = true
					break
				end
			end
		end

		if not ignore then
			if allowednotes[ v[3] ] then
				if v["length"] then
					if currentBeat + v["length"] > lastBeat and lastSecondHint == "" then lastBeat = currentBeat + v["length"] end
				else
					if currentBeat > lastBeat and lastSecondHint == "" then lastBeat = currentBeat end
				end
				if currentBeat < firstBeat then firstBeat = currentBeat end
				currentNotes = currentNotes + 1
			elseif v[3] == "TapNoteType_Mine" then
				currentMines = currentMines + 1
				if currentMines == arrows then
					if shockArrows ~= "" then
						shockArrows = shockArrows .. "_"
					end
					shockArrows = shockArrows .. Step:GetTimingData():GetElapsedTimeFromBeat(v[1])
				end
			end
		end
	end
	if currentNotes ~= 0 then
		noteCounter[currentNotes] = noteCounter[currentNotes] + 1
	end

	LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueFirstBeat",firstBeat,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueFirstSecond",Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat),getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueLastBeat",lastBeat,getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("TrueLastSecond",Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat),getStepCacheFile(Step))
	LoadModule("Config.Save.lua")("HasLua",HasLuaCheck() and "true" or "false",getStepCacheFile(Step))
	if shockArrows ~= "" then LoadModule("Config.Save.lua")("ShockArrows",shockArrows,getStepCacheFile(Step)) end
end

function LoadFromCache(Step,value)
	if not LoadModule("Config.Exists.lua")(value,getStepCacheFile(Step)) then cacheStep(Step) end
	return LoadModule("Config.Load.lua")(value,getStepCacheFile(Step))
end

function getStepCounter(Step)
	return split("_",LoadFromCache(Step,"StepCounter"))
end

function GetMinSecondsToStep()
	local song
	if GAMESTATE:IsCourseMode() then
		song = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber()):GetTrailEntry(GAMESTATE:GetCourseSongIndex()+1):GetSong()
	else
		song = GAMESTATE:GetCurrentSong()
	end
	local firstSec, firstBeat = 1.55, 999
	local firstBpm, offset = 60, 0
	local BGCHANGES = GetSMParameter(song,"BGCHANGES")
	local firstOffset = 0
	if #BGCHANGES > 0 then
		firstOffset = tonumber(split('=', split(',', BGCHANGES)[1])[1])
		if firstOffset < firstBeat then firstBeat = firstOffset end
	end
	local BPMS = GetSMParameter(song,"BPMS")
	if #BPMS > 0 then firstBpm = tonumber(split('=', split(',', BPMS)[1])[2]) end
	local OFFSET = GetSMParameter(song,"OFFSET")
	if #OFFSET > 0 then offset = tonumber(OFFSET) end
	if firstBeat < 999 then firstSec = math.max(firstBeat * 60 / firstBpm, -1) end
	firstSec = song:GetFirstSecond() - firstSec + offset + 0.05
	return math.max(firstSec, 1.55)
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

function GetConvertDifficulty(Step)
	local songLength = LoadFromCache(Step,"TrueLastSecond") - LoadFromCache(Step,"TrueFirstSecond")
	local voltage=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Voltage')*GAMESTATE:GetCurrentSong():MusicLengthSeconds()/songLength
	local stream=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Stream')*GAMESTATE:GetCurrentSong():MusicLengthSeconds()/songLength
	local radar_voltage=voltage-0.5
	local radar_stream=stream-0.5
	local bpms=Step:GetTimingData():GetActualBPM()
	local tapspoint=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
	tapspoint=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Jumps')/1.05+tapspoint
	tapspoint=((radar_stream>=0) and radar_stream*66 or radar_stream*50)+tapspoint
	tapspoint=((radar_voltage>=0) and radar_voltage*80 or radar_voltage*50)+tapspoint
	tapspoint=math.max(tapspoint-666,0)*1.05+tapspoint
	tapspoint=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Mines')/8+tapspoint
	tapspoint=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Holds')/8+tapspoint
	tapspoint=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Rolls')+tapspoint
	tapspoint=Step:GetRadarValues(PLAYER_1):GetValue('RadarCategory_Chaos')*10+tapspoint
	tapspoint=25+tapspoint
	tapspoint=math.max(130-bpms[1],0)+tapspoint
	tapspoint=math.max(math.min(bpms[2],400)-160,0)/5+tapspoint
	tapspoint=math.round(tapspoint*52/songLength/5)
	tapspoint=tapspoint*1.2
	if songLength>300 then
		tapspoint=tapspoint*1.14;
	elseif songLength>150 then
		tapspoint=tapspoint*1.09;
	elseif songLength>120 then
		tapspoint=tapspoint*1.05;
	elseif songLength>100 then
		tapspoint=tapspoint*1.02;
	end;
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
		meter=math.round(12*math.sin(tapsp2lv100[tapspoint]*math.pi*0.5/25))
	elseif tapsp2lv100[tapspoint]<35 then
		meter=math.round((tapsp2lv100[tapspoint]-25)*3/10+12)
	else
		meter=math.round((tapsp2lv100[tapspoint]-35)*5/15+15)
	end
	return meter
end