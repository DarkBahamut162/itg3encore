local cacheVersion = "0.44"
local stepCache = {}
local typeList = {"avi","f4v","flv","mkv","mp4","mpeg","mpg","mov","ogv","webm","wmv"}
Master,P1,P2={},{},{}
AllowLateJoin = true
bannerForced = false
KeysChecked = false
ThemeVersion = "????????"
CheckVersion = "????????"
TimeZone = "+0100"
local full = isOutFoxV() and "FullRes" or "Full"

function GetThemeVersion()
	if not FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory().."/version.txt") then return "????????" end

	local configfile = RageFileUtil.CreateRageFile()
	configfile:Open(THEME:GetCurrentThemeDirectory().."/version.txt", 1)

	ThemeVersion = configfile:Read():gsub('[-:]+','')

	configfile:Close()
	configfile:destroy()

	return split(" ",ThemeVersion)[1]
end

function SetAllowLateJoin(change) AllowLateJoin = change end

if not isOutFoxV() then
	if isOutFox(20201000) then
		bannerForced = PREFSMAN:GetPreference("ImageCache") ~= "ImageCacheMode_"..full
	else
		if isOldStepMania() or isEtterna() then
			bannerForced = PREFSMAN:GetPreference("BannerCache") == "BannerCacheMode_Off"
		else
			bannerForced = PREFSMAN:GetPreference("ImageCache") == "ImageCacheMode_Off"
		end
	end
	if PREFSMAN:PreferenceExists("ShowBanners") and not tobool(PREFSMAN:GetPreference("ShowBanners")) then
		local check = false
		if isOldStepMania() or isEtterna() then
			check = PREFSMAN:GetPreference("BannerCache") == "BannerCacheMode_"..full
		else
			check = PREFSMAN:GetPreference("ImageCache") == "ImageCacheMode_"..full
		end
		if check then bannerForced = true end
	end
end

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

	if not IsNetSMOnline() then
		ret = addToOutput(ret,THEME:GetString("ScreenSelectMusic","SelectButtonAvailableHelpTextAppend"),"::")
		if ThemePrefs.Get("KeyboardEnabled") then ret = addToOutput(ret,THEME:GetString("ScreenSelectMusic","CtrlButtonAvailableHelpTextAppend"),"::") end
		if DifficultyChangingAvailable() then ret = addToOutput(ret,THEME:GetString("ScreenSelectMusic","DifficultyChangingAvailableHelpTextAppend"),"::") end
	end
	if ModeMenuAvailable() then ret = addToOutput(ret,THEME:GetString("ScreenSelectMusic","SortMenuAvailableHelpTextAppend"),"::") end
	if getenv("Workout") and IsHome() then ret = addToOutput(ret,THEME:GetString("ScreenSelectMusic","WorkoutHelpTextAppend"),"::") end

	return ret
end

function GetScreenEvaluationHelpText()
	local ret = ThemePrefs.Get("KeyboardEnabled") and THEME:GetString("ScreenEvaluation", "HelpTextKeyboard") or THEME:GetString("ScreenEvaluation", "HelpText")
	if ThemePrefs.Get("ShowOffset") and not isVS() then
		ret = addToOutput(ret,ThemePrefs.Get("KeyboardEnabled") and THEME:GetString("ScreenEvaluation", "HelpTextViewKeyboard") or THEME:GetString("ScreenEvaluation","HelpTextView"),"::")
	end
	return ret
end

function GetSMParameter(song,parameter)
	local filePath = song:GetSongFilePath():lower()
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

function GetBMSParameter(steps,parameter)
	local filePath = steps:GetFilename():lower()
	if filePath:sub(-3):sub(2,2) ~= 'm' then return "" end
	local file = RageFileUtil.CreateRageFile()
	file:Open(filePath,1)
	file:Seek(0)
	local gLine = ""
	local line
	while true do
		if file then
			line = file:GetLine()
			if file:AtEOF() then break
			elseif string.find(line,"#"..parameter.." ") then
				gLine = line:sub(string.len("#"..parameter.." "))
				break
			end
		end
	end
	file:Close()
	file:destroy()
	return gLine
end

function checkBMS()
	if IsGame("beat") or IsGame("be-mu") or IsGame("popn") or IsGame("po-mu") then
		if GAMESTATE:GetNumPlayersEnabled() == 1 then
			return true
		else
			return GAMESTATE:GetCurrentSteps(PLAYER_1) == GAMESTATE:GetCurrentSteps(PLAYER_2)
		end
	end
	return false
end

function GetBMSTitle(steps,solo)
	local title = GetBMSParameter(steps,"TITLE")
	if solo == 1 then return title end
	local subtitle = GetBMSParameter(steps,"SUBTITLE")
	if solo == 2 then return subtitle end
	if subtitle ~= "" then
		return title .. " " .. subtitle
	else
		return title
	end
end

function GetBMSArtist(steps)
	local artist = GetBMSParameter(steps,"ARTIST")
	local subartist = GetBMSParameter(steps,"SUBARTIST")
	if subartist ~= "" then
		return artist .. " " .. subartist
	else
		return artist
	end
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
						local songFolder = isOutFox(20221200) and song:GetSongFolder() or GetSongFolderName(song)
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
	if not song then song = GAMESTATE:GetCurrentSong() end
	if not changes then changes = "BGCHANGES" end
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

function HasVideoBMS(steps,changes)
	local parameter = GetBMSParameter(steps,changes)
	if parameter ~= "" then
		parameter = split(",",parameter)
		for i=1,#parameter do
			for typ in ivalues(typeList) do
				if string.find(parameter[i],typ,0,true) then
					return true
				end
			end
		end
	end
	return false
end

function HasLuaCheck()
	local song = GAMESTATE:GetCurrentSong()
	return HasLua(song,"BGCHANGES") or HasLua(song,"BGCHANGES2") or HasLua(song,"FGCHANGES")
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

function IsCourseFixed()
	if GAMESTATE:IsCourseMode() then
		for i=1,#GAMESTATE:GetCurrentCourse():GetCourseEntries() do
			if not GAMESTATE:GetCurrentCourse():GetCourseEntry(i-1):IsFixedSong() then
				return false
			end
		end
	end

	return true
end

function RadarCategory_Notes(SongOrCourse,StepsOrTrail)
	local total = 0
	if SongOrCourse and StepsOrTrail then
		if GAMESTATE:IsCourseMode() then
			if SongOrCourse and StepsOrTrail then
				local entries = StepsOrTrail:GetTrailEntries()
				for i=1, #entries do
					local song = entries[i]:GetSong()
					local steps = entries[i]:GetSteps()
					local StepCounter = LoadFromCache(song,steps,"StepCounter")
					if StepCounter and StepCounter ~= "" then
						StepCounter = split("_",StepCounter)
						for i=1,#StepCounter do total = total + (tonumber(StepCounter[i])*i) end
					end
				end
			end
		else
			local StepCounter = LoadFromCache(SongOrCourse,StepsOrTrail,"StepCounter")
			if StepCounter and StepCounter ~= "" then
				StepCounter = split("_",StepCounter)
				for i=1,#StepCounter do total = total + (tonumber(StepCounter[i])*i) end
			end
		end
	end
	return total
end

function RadarCategory_Trail(StepsOrTrail,player,RadarCategory)
	local total = 0
	if StepsOrTrail and player and RadarCategory then
		for entry in ivalues(StepsOrTrail:GetTrailEntries()) do
			total = total + entry:GetSteps():GetRadarValues(player):GetValue(RadarCategory)
		end
	end
	return total
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
	elseif typ == "popn" then
		if style == "Five" then
			return 5
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
	local Song = nil
	if not isEtterna("0.55") then
		if Step:IsAutogen() then Song = SONGMAN:GetSongFromSteps(Step) end
	end
	if #filename == 1 and Song then filename = split("/",Song:GetSongDir()) end
	if #filename == 1 and Song then filename = split("/",Song:GetSongFilePath()) end
	local groupName = filename[#filename-2] or Song:GetGroupName() or ""
	local songName = filename[#filename-1] or (isOutFox(20221200) and Song:GetSongFolder() or "") or ""
	if string.find(groupName,"@") then
		if not Song then Song = SONGMAN:GetSongFromSteps(Step) end
		groupName = Song:GetGroupName()
	end

	local identifier = Step:GetHash()
	if identifier == 0 then identifier = Step:GetMeter() end

	return "Cache/Steps/Steps_"..groupName.."_"..songName.."_"..ToEnumShortString(Step:GetStepsType()).."_"..ToEnumShortString(Step:GetDifficulty()).."_"..identifier..".db9"
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

function HasKeysounds(Step)
	local filePath = Step:GetFilename():lower()
	local check = filePath:sub(-3):sub(2,2) == "m" and filePath:sub(-3):sub(1,1) ~= "s"
	if check then else return false end
    local file = RageFileUtil:CreateRageFile()
	local ret = false
	local count = 0
	if file:Open(filePath,1) then
		file:Seek(0)
		while true do
			if file then
				if count >= 2 then
					ret = true
					break
				elseif string.find(file:GetLine(),"#WAV[0-9A-Z]+") then
					count = count + 1
				elseif file:AtEOF() then
					break
				end
			end
		end
	end
	file:Close()
	file:destroy()
	return ret
end

function CheckNullMeasure(Step)
	if not Step then return false end
	local filePath = Step:GetFilename():lower()
	local check = filePath:sub(-3):sub(2,2) == "m" and filePath:sub(-3):sub(1,1) ~= "s"
	if check then else return false end
    local file = RageFileUtil:CreateRageFile()
	file:Open(filePath,1)
	file:Seek(0)
	local line
	local ret = false
	local checkMeasure = {}
	local checkMeasurelength = {}
	local checkNotes = {}
	local maxMeasure = 0
	local minMeasure = nil
	while file and not file:AtEOF() do
		line = file:GetLine()
		if line and string.find(line,":") then
			local currentMeasure = tonumber(line:sub(2,4))
			if currentMeasure then
				if not checkMeasure[currentMeasure] and string.find(line,"02:") then
					checkMeasure[currentMeasure] = true
					checkMeasurelength[currentMeasure] = tonumber(line:sub(8))
				elseif not checkNotes[currentMeasure] then
					if currentMeasure > maxMeasure then maxMeasure = currentMeasure end
					if not minMeasure then minMeasure = currentMeasure end
					checkNotes[currentMeasure] = true
				end
			end
		end
	end
	file:Close()
	file:destroy()
	local output = {}
	if minMeasure then
		for measure,length in pairs( checkMeasurelength ) do
			if length ~= 1 then
				if not checkNotes[measure] then
					if measure >= minMeasure and measure <= maxMeasure then
						ret = true
						output[#output+1] = measure
					end
				end
			end
		end
	end
	return ret, output
end

function condenseNullMeasures(nulls)
	table.sort(nulls)
	local temp,low,high = {},0,0
	for i=1,#nulls+1 do
		if low == 0 then
			low,high = nulls[i],nulls[i]
		elseif nulls[i] == high+1 then
			high = nulls[i]
		elseif nulls[i] ~= high+1 or i == #nulls+1 then
			if low == high then
				temp[#temp+1] = low
			else
				temp[#temp+1] = low.."-"..high
			end
			low,high = nulls[i],nulls[i]
		end
	end
	return table.concat(temp,"|")
end

function cacheStep(Song,Step)
	if Song == nil and not isOutFoxV043() then Song = SONGMAN:GetSongFromSteps(Step) end

    local chartint = 1
	local currentBeat = 0
	local currentNotes = 0
	local noteCounter = {}
	local firstBeat = nil
	local lastBeat = 0

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
	local check = not isOutFox() or isOutFox(20210666)
	local stops = timingData:GetStops()
	local delays = timingData:GetDelays()
	local warps = timingData:GetWarps()
	local IsJudgableAtBeat = false
	local firstArrow = 0
	local firstArrowCheck = false
	local buffered_notes = 0
	local buffered_sec = 0

	local noteData = isOutFoxV043() and Step:GetNoteData() or Song:GetNoteData(chartint)
	for _,v in pairs( noteData ) do
		local isStop, isDelay, isWarp = false, false, false
		if currentBeat < v[1] then
			if currentBeat ~= 0 and not firstArrowCheck then firstArrowCheck = true end
			currentBeat = v[1]
			currentNotes = 0
			lastSec = currentSec
		end
		if stops and #stops > 0 then isStop,stops = HasStopAtBeat(v[1],stops) end
		if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(v[1],delays) end
		if check then
			isJudgableAtBeat = timingData:IsJudgableAtBeat(v[1])
		else
			if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(v[1],warps) end
			isJudgableAtBeat = not isWarp or (isWarp and (isStop or isDelay))
		end
		if isJudgableAtBeat then
			if allowednotes[v[3]] then
				currentNotes = currentNotes + 1
				if v["length"] then
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
						local buffered_diff = currentSec - buffered_sec
						if buffered_diff >= 1/32 then
							if buffered_notes == 0 then buffered_notes = currentNotes end
							local currentSPS = (1 / buffered_diff) * buffered_notes
							if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
							buffered_notes = 0
						else
							buffered_notes = buffered_notes + currentNotes
						end
						buffered_sec = currentSec
					end
				end
			end
		end
	end

	noteData = nil

	local total = calcSPS(stepsPerSec) 
	local total2 = calcSPS(stepsPerSec,total)
	local file = getStepCacheFile(Step)

	if firstBeat then
		local list = {
			["Version"] = cacheVersion,
			["StepCounter"] = table.concat(noteCounter,"_"),
			["StepsPerSecond"] = total2,
			["TrueFirstBeat"] = firstBeat,
			["TrueLastBeat"] = lastBeat,
			["TrueBeats"] = lastBeat-firstBeat,
			["TrueMaxBPM"] = maxBPM,
			["TrueFirstSecond"] = Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat),
			["TrueLastSecond"] = Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat),
			["TrueSeconds"] = Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat)-Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat)
		}

		if stepType[2] == "Bm" then
			if #noteCounter == 7 or #noteCounter == 14 then
				list["Foots"] = foots
			end
			list["Scratches"] = scratches
		end

		if getenv("cacheing") then
			LoadModule("Config.SaveAll.lua")(list,file)
		else
			LoadModule("Config.Save.lua")("Version",cacheVersion,file)
			LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),file)
			LoadModule("Config.Save.lua")("StepsPerSecond",total2,file)
			LoadModule("Config.Save.lua")("TrueFirstBeat",firstBeat,file)
			LoadModule("Config.Save.lua")("TrueLastBeat",lastBeat,file)
			LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,file)
			LoadModule("Config.Save.lua")("TrueMaxBPM",maxBPM,file)
			LoadModule("Config.Save.lua")("TrueFirstSecond",Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat),file)
			LoadModule("Config.Save.lua")("TrueLastSecond",Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat),file)
			LoadModule("Config.Save.lua")("TrueSeconds",Step:GetTimingData():GetElapsedTimeFromBeat(lastBeat)-Step:GetTimingData():GetElapsedTimeFromBeat(firstBeat),file)
			if stepType[2] == "Bm" then
				if #noteCounter == 7 or #noteCounter == 14 then
					LoadModule("Config.Save.lua")("Foots",foots,file)
				end
				LoadModule("Config.Save.lua")("Scratches",scratches,file)
			end
		end
		return list
	else
		LoadModule("Config.Save.lua")("Version","0",file)
		return {["Version"]="0"}
	end
end

function getNoteType(beat)
    if beat % (4/4) == 0 then return 4
    elseif beat % (4/8) == 0 then return 8
    elseif beat % (4/12) <= 0.001 then return 12
    elseif beat % (4/16) == 0 then return 16
    elseif beat % (4/24) <= 0.001 then return 24
    elseif beat % (4/32) == 0 then return 32
    elseif beat % (4/48) <= 0.001 then return 48
    elseif beat % (4/64) == 0 then return 64
    elseif beat % (4/96) <= 0.001 then return 96
    elseif beat % (4/128) == 0 then return 128 end
    return 192
end

function cacheStepSM(Song,Step)
	local stepType = split("_",Step:GetStepsType())
	local timingData = Step:GetTimingData()
	local stepsPerSec = {}
	local noteCounter = {}
	local firstBeat = nil
	local lastBeat = 0
	local lastSec = 0
	local currentBPM,checkBPM,checkCount,maxBPM = 0,0,0,0
	local buffered_notes = 0
	local buffered_sec = 0

	local stops = timingData:GetStops()
	local delays = timingData:GetDelays()
	local warps = timingData:GetWarps()

	for i=1,getColumnsPerPlayer(stepType[2],stepType[3]) do
		noteCounter[i] = 0
	end

	local chart = SMParser(Step)
	local beat = 0

	local beats = {}
	local chaosCount = 0
	local maxVoltage = 0
	local firstRow

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
					if not firstRow then firstRow = row end
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
							local buffered_diff = currentSec - buffered_sec
							if buffered_diff >= 1/32 then
								if buffered_notes == 0 then buffered_notes = currentNotes end
								local currentSPS = (1 / buffered_diff) * buffered_notes
								if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
								buffered_notes = 0
							else
								buffered_notes = buffered_notes + currentNotes
							end
							buffered_sec = currentSec
						end
						lastSec = currentSec

						if isEtterna("0.55") then
							if getNoteType(beat) >= 12 then chaosCount = chaosCount + 1 end
							for _=1,count do table.insert(beats,beat) end
							for i=1,#beats do
								if beats[i] and beats[i] < beat - 8 then
									table.remove(beats,i)
									i=i-1
								else
									break
								end
							end
							maxVoltage = math.max(maxVoltage,#beats)
						end
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
			local file = getStepCacheFile(Step)
			local list = {
				["Version"] = cacheVersion,
				["FirstRow"] = firstRow,
				["StepCounter"] = table.concat(noteCounter,"_"),
				["StepsPerSecond"] = total2,
				["TrueFirstBeat"] = firstBeat,
				["TrueLastBeat"] = lastBeat,
				["TrueBeats"] = lastBeat-firstBeat,
				["TrueMaxBPM"] = maxBPM,
				["TrueFirstSecond"] = firstSecond,
				["TrueLastSecond"] = lastSecond,
				["TrueSeconds"] = lastSecond-firstSecond
			}

			if isEtterna("0.55") then
				list["chaosCount"] = chaosCount
				list["maxVoltage"] = maxVoltage
			end

			if getenv("cacheing") then
				LoadModule("Config.SaveAll.lua")(list,file)
			else
				LoadModule("Config.Save.lua")("Version",cacheVersion,file)
				LoadModule("Config.Save.lua")("FirstRow",firstRow,file)
				LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),file)
				LoadModule("Config.Save.lua")("StepsPerSecond",total2,file)
				LoadModule("Config.Save.lua")("TrueFirstBeat",firstBeat,file)
				LoadModule("Config.Save.lua")("TrueLastBeat",lastBeat,file)
				LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,file)
				LoadModule("Config.Save.lua")("TrueMaxBPM",maxBPM,file)
				LoadModule("Config.Save.lua")("TrueFirstSecond",firstSecond,file)
				LoadModule("Config.Save.lua")("TrueLastSecond",lastSecond,file)
				LoadModule("Config.Save.lua")("TrueSeconds",lastSecond-firstSecond,file)
				if isEtterna("0.55") then
					LoadModule("Config.Save.lua")("chaosCount",chaosCount,file)
					LoadModule("Config.Save.lua")("maxVoltage",maxVoltage,file)
				end
			end

			return list
		else
			local file = getStepCacheFile(Step)
			LoadModule("Config.Save.lua")("Version","0",file)
			return {["Version"]="0"}
		end
	else
		if isOutFox(20200400) then
			return cacheStep(Song,Step)
		else
			local file = getStepCacheFile(Step)
			LoadModule("Config.Save.lua")("Version","0",file)
			return {["Version"]="0"}
		end
	end
end

function cacheStepDWI(Song,Step)
	local stepType = split("_",Step:GetStepsType())
	local timingData = Step:GetTimingData()
	local stepsPerSec = {}
	local noteCounter = {}
	local firstBeat = nil
	local lastBeat = 0
	local lastSec = 0
	local currentBPM,checkBPM,checkCount,maxBPM = 0,0,0,0
	local buffered_notes = 0
	local buffered_sec = 0

	local stops = timingData:GetStops()
	local delays = timingData:GetDelays()
	local warps = timingData:GetWarps()

	for i=1,getColumnsPerPlayer(stepType[2],stepType[3]) do
		noteCounter[i] = 0
	end

	local chart = DWIParser(Step)
	local beat = 0

	local beats = {}
	local chaosCount = 0
	local maxVoltage = 0
	local firstRow

	if chart then
		local currentMeasure = -1
		for measure in ivalues(chart) do
			currentMeasure = currentMeasure + 1
			local currentRow = -1
			for row in ivalues(measure) do
				currentRow = currentRow + 1
				beat = (currentMeasure*4)+(currentRow/#measure*4)
				local _, count = string.gsub(row, "[L124]", "")
				if count > 0 then
					if not firstRow then firstRow = row end
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
							local buffered_diff = currentSec - buffered_sec
							if buffered_diff >= 1/32 then
								if buffered_notes == 0 then buffered_notes = count end
								local currentSPS = (1 / buffered_diff) * buffered_notes
								if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
								buffered_notes = 0
							else
								buffered_notes = buffered_notes + count
							end
							buffered_sec = currentSec
							local currentSPS = 1 / (currentSec - lastSec) * count
							if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
						end
						lastSec = currentSec

						if isEtterna("0.55") then
							if getNoteType(beat) >= 12 then chaosCount = chaosCount + 1 end
							for _=1,count do table.insert(beats,beat) end
							for i=1,#beats do
								if beats[i] and beats[i] < beat - 8 then
									table.remove(beats,i)
									i=i-1
								else
									break
								end
							end
							maxVoltage = math.max(maxVoltage,#beats)
						end
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
			local file = getStepCacheFile(Step)
			local list = {
				["Version"] = cacheVersion,
				["FirstRow"] = firstRow,
				["StepCounter"] = table.concat(noteCounter,"_"),
				["StepsPerSecond"] = total2,
				["TrueFirstBeat"] = firstBeat,
				["TrueLastBeat"] = lastBeat,
				["TrueBeats"] = lastBeat-firstBeat,
				["TrueMaxBPM"] = maxBPM,
				["TrueFirstSecond"] = firstSecond,
				["TrueLastSecond"] = lastSecond,
				["TrueSeconds"] = lastSecond-firstSecond
			}

			if isEtterna("0.55") then
				list["chaosCount"] = chaosCount
				list["maxVoltage"] = maxVoltage
			end

			if getenv("cacheing") then
				LoadModule("Config.SaveAll.lua")(list,file)
			else
				LoadModule("Config.Save.lua")("Version",cacheVersion,file)
				LoadModule("Config.Save.lua")("FirstRow",firstRow,file)
				LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),file)
				LoadModule("Config.Save.lua")("StepsPerSecond",total2,file)
				LoadModule("Config.Save.lua")("TrueFirstBeat",firstBeat,file)
				LoadModule("Config.Save.lua")("TrueLastBeat",lastBeat,file)
				LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,file)
				LoadModule("Config.Save.lua")("TrueMaxBPM",maxBPM,file)
				LoadModule("Config.Save.lua")("TrueFirstSecond",firstSecond,file)
				LoadModule("Config.Save.lua")("TrueLastSecond",lastSecond,file)
				LoadModule("Config.Save.lua")("TrueSeconds",lastSecond-firstSecond,file)
				if isEtterna("0.55") then
					LoadModule("Config.Save.lua")("chaosCount",chaosCount,file)
					LoadModule("Config.Save.lua")("maxVoltage",maxVoltage,file)
				end
			end

			return list
		else
			local file = getStepCacheFile(Step)
			LoadModule("Config.Save.lua")("Version","0",file)
			return {["Version"]="0"}
		end
	else
		if isOutFox(20200400) then
			return cacheStep(Song,Step)
		else
			local file = getStepCacheFile(Step)
			LoadModule("Config.Save.lua")("Version","0",file)
			return {["Version"]="0"}
		end
	end
end

local function orderedIndex(t)
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert(orderedIndex,key)
    end
    table.sort(orderedIndex)
    return orderedIndex
end

function cacheStepBMS(Song,Step)
	local stepType = split("_",Step:GetStepsType())
	local timingData = Step:GetTimingData()
	local stepsPerSec = {}
	local noteCounter = {}
	local rows,lastHold,scratch,foot,data = BMSParser(Step)
	local firstBeat = nil
	local lastBeat = lastHold or 0
	local currentBPM,checkBPM,checkCount,maxBPM = 0,0,0,0
	local lastSec = 0
	local buffered_notes = 0
	local buffered_sec = 0

	local stops = timingData:GetStops()
	local delays = timingData:GetDelays()
	local warps = timingData:GetWarps()

	for i=1,getColumnsPerPlayer(stepType[2],stepType[3]) do
		noteCounter[i] = 0
	end

	local beats = {}
	local chaosCount = 0
	local maxVoltage = 0

	if rows then
		local orderedBeats = orderedIndex(rows)
		for beat in ivalues(orderedBeats) do
			local row = rows[beat]
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
				noteCounter[row] = noteCounter[row] + 1
				if not firstBeat then firstBeat = beat end
				if beat > lastBeat then lastBeat = beat end

				if lastSec > 0 then
					local buffered_diff = currentSec - buffered_sec
					if buffered_diff >= 1/32 then
						if buffered_notes == 0 then buffered_notes = row end
						local currentSPS = (1 / buffered_diff) * buffered_notes
						if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
						buffered_notes = 0
					else
						buffered_notes = buffered_notes + row
					end
					buffered_sec = currentSec
					local currentSPS = 1 / (currentSec - lastSec) * row
					if stepsPerSec[currentSPS] then stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1 else stepsPerSec[currentSPS] = 1 end
				end
				lastSec = currentSec

				if isEtterna("0.55") then
					if getNoteType(beat) >= 12 then chaosCount = chaosCount + 1 end
					for _=1,row do table.insert(beats,beat) end
					for i=1,#beats do
						if beats[i] and beats[i] < beat - 8 then
							table.remove(beats,i)
							i=i-1
						else
							break
						end
					end
					maxVoltage = math.max(maxVoltage,#beats)
				end
			end
		end

		local firstSecond = timingData:GetElapsedTimeFromBeat(firstBeat)
		local lastSecond = timingData:GetElapsedTimeFromBeat(lastBeat)
		local total = calcSPS(stepsPerSec)
		local total2 = calcSPS(stepsPerSec,total)
		local file = getStepCacheFile(Step)
		local data_ = orderedIndex(data)
		local firstRow = table.concat(data[data_[1]],"_")
		local list = {
			["Version"] = cacheVersion,
			["FirstRow"] = firstRow,
			["StepCounter"] = table.concat(noteCounter,"_"),
			["StepsPerSecond"] = total2,
			["TrueFirstBeat"] = firstBeat,
			["TrueLastBeat"] = lastBeat,
			["TrueBeats"] = lastBeat-firstBeat,
			["TrueMaxBPM"] = maxBPM,
			["TrueFirstSecond"] = firstSecond,
			["TrueLastSecond"] = lastSecond,
			["TrueSeconds"] = lastSecond-firstSecond,
			["Scratches"] = scratch,
			["Foots"] = foot
		}

		if isEtterna("0.55") then
			list["chaosCount"] = chaosCount
			list["maxVoltage"] = maxVoltage
		end

		if getenv("cacheing") then
			LoadModule("Config.SaveAll.lua")(list,file)
		else
			LoadModule("Config.Save.lua")("Version",cacheVersion,file)
			LoadModule("Config.Save.lua")("FirstRow",firstRow,file)
			LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),file)
			LoadModule("Config.Save.lua")("StepsPerSecond",total2,file)
			LoadModule("Config.Save.lua")("TrueFirstBeat",firstBeat,file)
			LoadModule("Config.Save.lua")("TrueLastBeat",lastBeat,file)
			LoadModule("Config.Save.lua")("TrueBeats",lastBeat-firstBeat,file)
			LoadModule("Config.Save.lua")("TrueMaxBPM",maxBPM,file)
			LoadModule("Config.Save.lua")("TrueFirstSecond",firstSecond,file)
			LoadModule("Config.Save.lua")("TrueLastSecond",lastSecond,file)
			LoadModule("Config.Save.lua")("TrueSeconds",lastSecond-firstSecond,file)
			LoadModule("Config.Save.lua")("Scratches",scratch,file)
			LoadModule("Config.Save.lua")("Foots",foot,file)
			if isEtterna("0.55") then
				LoadModule("Config.Save.lua")("chaosCount",chaosCount,file)
				LoadModule("Config.Save.lua")("maxVoltage",maxVoltage,file)
			end
		end

		return list
	else
		if isOutFox(20200400) then
			return cacheStep(Song,Step)
		else
			local file = getStepCacheFile(Step)
			LoadModule("Config.Save.lua")("Version","0",file)
			return {["Version"]="0"}
		end
	end
end

function cacheStepX(Song,Step)
	local filePath = Step:GetFilename():lower()
	local checkSM = filePath:sub(-2):sub(1,1) == 's'	-- [S]M & S[S]C
	local checkDWI = filePath:sub(-3):sub(1,1) == 'd'	-- [D]WI
	--local checkBMS = filePath:sub(-3):sub(2,2) == 'm'	-- B[M]S & B[M]E & B[M]L & P[M]S
	local checkPMS = filePath:sub(-3) == 'pms'

	if not isOutFox(20200400) or ((checkSM or checkPMS) and isOutFoxV()) then
		if checkSM then
			return cacheStepSM(Song,Step)
		elseif checkDWI then
			return cacheStepDWI(Song,Step)
		else
			return cacheStepBMS(Song,Step)
		end
	else
		return cacheStep(Song,Step)
	end
end

function LoadFromCache(Song,Step,key)
	local file = getStepCacheFile(Step)
	if not FILEMAN:DoesFileExist(file) then
		stepCache[file] = cacheStepX(Song,Step)
	else
		if stepCache[file] and stepCache[file]["Version"] == "0" then
			return nil
		elseif stepCache[file] and stepCache[file][key] then
			return stepCache[file][key]
		else
			if not stepCache[file] then stepCache[file] = LoadModule("Config.LoadAll.lua")(file) end
		end
		local version = LoadModule("Config.Load.lua")("Version",file)

		if version == "0" then
			stepCache[file] = {{"Version"} == "0"}
			return nil
		elseif not version or version ~= cacheVersion then
			stepCache[file] = cacheStepX(Song,Step)
		end
	end

	return stepCache[file][key] or LoadModule("Config.Load.lua")("Version",file)
end

function GetMinSecondsToStep()
	local song = GAMESTATE:GetCurrentSong()
	local firstSec, firstBeat = 1, 0
	local firstBpm, smOffset = 60, 0
	if not song then return 1 end
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

	return math.max(firstSec, isEtterna() and 2 or 1)
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

function getTrueBPMsCalculated(song,steps)
	local timingdata = steps:GetTimingData()
	local bpms = steps:GetDisplayBpms()
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

function getAllTheBPMs(song,steps,BPMtype)
	local bpms = {0,0,0}
	if BPMtype == 0 then
		if song:IsDisplayBpmSecret() or song:IsDisplayBpmRandom() then
			bpms = {"???","???","???"}
		else
			bpms = steps:GetDisplayBpms()
			bpms[3] = 0
		end
	elseif BPMtype == 1 or (not isEtterna("0.55") and steps:IsAutogen()) then
		bpms = steps:GetTimingData():GetActualBPM()
		bpms[3] = 0
	elseif BPMtype == 2 then
		local usesStepCache = ThemePrefs.Get("UseStepCache")
		local trueBPM = usesStepCache and tonumber(LoadFromCache(song,steps,"TrueMaxBPM")) or -1
		if usesStepCache and trueBPM >= 0 then
			bpms = steps:GetTimingData():GetActualBPM()
			bpms[3]=trueBPM
		else
			bpms = getTrueBPMsCalculated(song,steps)
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
	local usesStepCache = ThemePrefs.Get("UseStepCache")
	local version = usesStepCache and LoadFromCache(Song,Step,"Version") or false
	if not version or version == "0" then
		repeatCheck[value] = OG
		return OG
	end
	local totalSeconds = usesStepCache and tonumber(LoadFromCache(Song,Step,"TrueSeconds")) or (Song:GetLastSecond() - Song:GetFirstSecond())
	local stepCounter = usesStepCache and split("_",LoadFromCache(Song,Step,"StepCounter") or "") or {}
	local stepType = split("_",Step:GetStepsType())
	local stepSum = usesStepCache and 0 or math.round(Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)

	if totalSeconds < 0 then
		totalSeconds = Song:GetLastSecond() - Song:GetFirstSecond()
		stepCounter = {}
		stepSum = math.round(Step:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)
	end

	if usesStepCache then
		if #stepCounter > 0 then for i=1,#stepCounter do stepSum = stepSum + (stepCounter[i] * i) end end
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
		if not isEtterna("0.55") then YA = GetConvertDifficulty(Song,Step,totalSeconds) / 2 end
		if usesStepCache then SPS = tonumber(LoadFromCache(Song,Step,"StepsPerSecond")) / 2 end
	else
		if not IsGame("pump") and not isEtterna("0.55") then YA = GetConvertDifficulty(Song,Step,totalSeconds) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4) * ddrtype end
		if usesStepCache then SPS = tonumber(LoadFromCache(Song,Step,"StepsPerSecond")) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4) * ddrtype end
	end

	local output = {}
	local decimals = ThemePrefs.Get("ShowCalcDiffDecimals")
	if DB9 > YA and DB9 > SPS then
		output = {math.round(DB9,decimals),"DB9"}
	elseif YA > DB9 and YA > SPS then
		output = {math.round(YA,decimals),"Y&A"}
	elseif SPS > DB9 and SPS > YA then
		output = {math.round(SPS,decimals),"SPS"}
	end
	if output[1] and output[1] ~= OG then
		repeatCheck[value] = output[1].." "..output[2].."\n"..OG.." OG"
		return output[1].." "..output[2].."\n"..OG.." OG"
	else
		repeatCheck[value] = OG
		return OG
	end
end

function grooveRadar(song,steps,RadarValues)
	local stream,voltage,air,freeze,chaos = 0,0,0,0,0

	if not isEtterna(20160826) then
		stream = RadarValues:GetValue('RadarCategory_Stream')
		voltage = RadarValues:GetValue('RadarCategory_Voltage')
		air = RadarValues:GetValue('RadarCategory_Air')
		freeze = RadarValues:GetValue('RadarCategory_Freeze')
		chaos = RadarValues:GetValue('RadarCategory_Chaos')
	else
		local maxVoltage = tonumber(LoadFromCache(song,steps,"maxVoltage"))
		local chaosCount = tonumber(LoadFromCache(song,steps,"chaosCount"))

		local total = 0
		if not VersionDateCheck(20150500) then
			total = RadarCategory_Notes(song,steps)
		else
			total = RadarValues:GetValue('RadarCategory_Notes') or 0
		end
		stream = (total/song:MusicLengthSeconds())/7
		voltage = ((maxVoltage/8)*(song:GetLastBeat()/song:MusicLengthSeconds()))/10
		air = RadarValues:GetValue('RadarCategory_Jumps')/song:MusicLengthSeconds()
		freeze = RadarValues:GetValue('RadarCategory_Holds')/song:MusicLengthSeconds()
		chaos = chaosCount/song:MusicLengthSeconds()*0.5
	end

	if not IsGame("pump") then
		local usesStepCache = ThemePrefs.Get("UseStepCache")
		local totalSeconds = usesStepCache and tonumber(LoadFromCache(song,steps,"TrueSeconds")) or song:GetLastSecond() - song:GetFirstSecond()
		local totalBeats = usesStepCache and tonumber(LoadFromCache(song,steps,"TrueBeats")) or song:GetLastBeat() - song:GetFirstBeat()
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