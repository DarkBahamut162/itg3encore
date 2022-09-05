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

function getStepCacheFile(Steps)
	local hashOld = false
	local cache = ""
	if hashOld then
		cache = "Cache/Steps/"..Steps:GetHash()
	else
		local filename = split("/",Steps:GetFilename())
		cache = "Cache/Steps/Steps_"..filename[3].."_"..filename[4].."_"..ToEnumShortString(Steps:GetStepsType()).."_"..ToEnumShortString(Steps:GetDifficulty())
	end
	return cache
end

function cacheStep(Steps)
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
		if v == Steps then
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
		lastBeat = Steps:GetTimingData():GetBeatFromElapsedTime(lastSecondHint)
	end

	local timingData = Steps:GetTimingData()
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
					shockArrows = shockArrows .. "_" .. Steps:GetTimingData():GetElapsedTimeFromBeat(v[1])
				end
			end
		end
	end
	if currentNotes ~= 0 then
		noteCounter[currentNotes] = noteCounter[currentNotes] + 1
	end

	LoadModule("Config.Save.lua")("StepCounter",table.concat(noteCounter,"_"),getStepCacheFile(Steps))
	LoadModule("Config.Save.lua")("TrueFirstBeat",firstBeat,getStepCacheFile(Steps))
	LoadModule("Config.Save.lua")("TrueFirstSecond",Steps:GetTimingData():GetElapsedTimeFromBeat(firstBeat),getStepCacheFile(Steps))
	LoadModule("Config.Save.lua")("TrueLastBeat",lastBeat,getStepCacheFile(Steps))
	LoadModule("Config.Save.lua")("TrueLastSecond",Steps:GetTimingData():GetElapsedTimeFromBeat(lastBeat),getStepCacheFile(Steps))
	LoadModule("Config.Save.lua")("HasLua",HasLuaCheck() and "true" or "false",getStepCacheFile(Steps))
	if shockArrows ~= "" then LoadModule("Config.Save.lua")("ShockArrows",shockArrows,getStepCacheFile(Steps)) end
end

function getStepCounter(Steps)
	if not LoadModule("Config.Exists.lua")("StepCounter",getStepCacheFile(Steps)) then cacheStep(Steps) end
	return split("_",LoadModule("Config.Load.lua")("StepCounter",getStepCacheFile(Steps)))
end

function GetMinSecondsToStep()
	local song = GAMESTATE:GetCurrentSong()
	local firstSec, firstBeat = 1.55, 999
	local firstBpm, offset = 60, 0
	local BGCHANGES = GetSMParameter(song,"BGCHANGES")
	local FGCHANGES = GetSMParameter(song,"FGCHANGES")
	local firstOffset = 0
	if #BGCHANGES > 0 then
		firstOffset = tonumber(split('=', split(',', BGCHANGES)[1])[1])
		if firstOffset < firstBeat then firstBeat = firstOffset end
	end
	if #FGCHANGES > 0 then
		firstOffset = tonumber(split('=', split(',', FGCHANGES)[1])[1])
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