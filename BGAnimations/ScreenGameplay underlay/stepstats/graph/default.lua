local pn = ...
local graphW  = SCREEN_HEIGHT-126.5
local graphH  = 92
local height  = (SCREEN_HEIGHT / graphH)
local bgColor = color('0, 0, 0, 0.66')
local normalizeAlpha = (1.0 - bgColor[4]) * 0.8
local showNoteGraph = getenv("ShowNoteGraph"..pname(pn))
local showNoteGraphType = getenv("ShowNoteGraphType"..pname(pn))
local ShowNoteGraphRange = getenv("ShowNoteGraphRange"..pname(pn))
local ShowStatsSize = getenv("ShowStatsSize"..pname(pn))
local adjust = ShowNoteGraphRange == 2
local rowLimit = showNoteGraphType == 1
local ShowNoteGraphData = getenv("ShowNoteGraphData"..pname(pn))
local lastSec = nil
local lastBeat = nil
local courseMode = GAMESTATE:IsCourseMode()
local screenMusicCheck = isTopScreen("ScreenSelectMusic") or isTopScreen("ScreenSelectMusicFinal")
local screenNetMusicCheck = isTopScreen("ScreenNetSelectMusic") or isTopScreen("ScreenNetSelectMusicFinal")
local screenCheck = screenMusicCheck or screenNetMusicCheck
local cropValue = screenNetMusicCheck and 0.64 or screenMusicCheck and 0.6 or 0.5
local max = 0
local average = 0
local counter = 0

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

local function UpdateGraph()
    lastSec = 0
    lastBeat = 0
    local SongOrCourse = GAMESTATE:GetCurrentSong()
    local StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
	local stepsPerSecList = {0}
    local chartint = 1
    local absoluteSec = 0
    local previousSec = -999

    if SongOrCourse and StepsOrTrail then
        if not isOutFoxV043() then
            for k,v in pairs( SongOrCourse:GetAllSteps() ) do
                if v == StepsOrTrail then
                    chartint = k
                    break
                end
            end
        end

        local timingData = StepsOrTrail:GetTimingData()
        local check = VersionDateCheck(20210666)
        local stops = check and {} or timingData:GetStops()
        local delays = check and {} or timingData:GetDelays()
        local warps = check and {} or timingData:GetWarps()
        local IsJudgableAtBeat = false

        for v in ivalues(isOutFoxV043() and StepsOrTrail:GetNoteData() or SongOrCourse:GetNoteData(chartint)) do
            if check then
                isJudgableAtBeat = timingData:IsJudgableAtBeat(v[1])
            else
                local isStop, isDelay, isWarp = false, false, false
                if stops and #stops > 0 then isStop,stops = HasStopAtBeat(v[1],stops) end
                if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(v[1],delays) end
                if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(v[1],warps) end
                isJudgableAtBeat = not isWarp or (isWarp and (isStop or isDelay))
            end
            if isJudgableAtBeat then
                if allowednotes[v[3]] then
                    if rowLimit then absoluteSec = timingData:GetElapsedTimeFromBeat(v[1]) end
                    if previousSec ~= absoluteSec then
                        local currentSec = math.ceil(timingData:GetElapsedTimeFromBeat(v[1]))
                        stepsPerSecList[currentSec] = stepsPerSecList[currentSec] and stepsPerSecList[currentSec] + 1 or 1
                    end
                    if v["length"] then
                        if not lastBeat or (v[1] + v["length"] > lastBeat) then lastBeat = v[1] + v["length"] end
                    else
                        if not lastBeat or (v[1] > lastBeat) then lastBeat = v[1] end
                    end
                    if rowLimit then previousSec = absoluteSec end
                end
            end
        end

        for i=1,math.ceil(timingData:GetElapsedTimeFromBeat(lastBeat)) do
            if not stepsPerSecList[i] then stepsPerSecList[i] = 0 end
        end

        lastSec = timingData:GetElapsedTimeFromBeat(lastBeat)
    end

    return stepsPerSecList
end

local function UpdateGraphSM(Step)
    lastSec = 0
    lastBeat = 0
	local stepsPerSecList = {}
    if Step then
        local timingData = Step:GetTimingData()

        local stops = timingData:GetStops()
        local delays = timingData:GetDelays()
        local warps = timingData:GetWarps()
        local chart = SMParser(Step)
        
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
                        if rowLimit then count = 1 end
                        local isStop, isDelay, isWarp = false, false, false
                        if stops and #stops > 0 then isStop,stops = HasStopAtBeat(beat,stops) end
                        if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(beat,delays) end
                        if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(beat,warps) end
                        local isJudgableAtBeat = not isWarp or (isWarp and (isStop or isDelay))
                        if isJudgableAtBeat then
                            local currentSec = math.ceil(timingData:GetElapsedTimeFromBeat(beat))
                            stepsPerSecList[currentSec] = stepsPerSecList[currentSec] and stepsPerSecList[currentSec] + count or count
                        end
                    end
                    if lastBeat ~= beat and string.find(row,"[L1234]") then
                        lastBeat = beat
                    end
                end
            end
            for i=1,math.ceil(timingData:GetElapsedTimeFromBeat(lastBeat)) do
                if not stepsPerSecList[i] then stepsPerSecList[i] = 0 end
            end
            lastSec = timingData:GetElapsedTimeFromBeat(lastBeat)
        end
    end
    return stepsPerSecList
end

local function UpdateGraphBMS(Step)
    lastSec = 0
    lastBeat = 0
	local stepsPerSecList = {}
    if Step then
        local timingData = Step:GetTimingData()

        local stops = timingData:GetStops()
        local delays = timingData:GetDelays()
        local warps = timingData:GetWarps()

        local chart,lastHold = BMSParser(Step)

        local actualBeat = 0
        if chart then
            for beat,count in pairs( chart ) do
                if rowLimit then count = 1 end
                local isStop, isDelay, isWarp = false, false, false
                if stops and #stops > 0 then isStop,stops = HasStopAtBeat(beat,stops) end
                if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(beat,delays) end
                if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(beat,warps) end
                if not isWarp or (isWarp and (isStop or isDelay)) then
                    local currentSec = math.ceil(timingData:GetElapsedTimeFromBeat(beat))
                    stepsPerSecList[currentSec] = stepsPerSecList[currentSec] and stepsPerSecList[currentSec] + count or count
                end
                lastBeat = math.max(lastBeat,beat)
            end
            lastBeat = math.max(lastBeat,lastHold)
            for i=1,math.ceil(timingData:GetElapsedTimeFromBeat(lastBeat)) do
                if not stepsPerSecList[i] then stepsPerSecList[i] = 0 end
            end
            lastSec = timingData:GetElapsedTimeFromBeat(lastBeat)
        end
    end
    return stepsPerSecList
end

local function UpdateGraphOld()
    if GAMESTATE:GetCurrentSong() then
        local Step = GAMESTATE:GetCurrentSteps(pn)
        if Step then
            local filePath = Step:GetFilename()
            local checkSM = filePath:sub(-2):sub(1,1) == 's'	-- [S]M & S[S]C
            if checkSM then
                return UpdateGraphSM(Step)
            else
                return UpdateGraphBMS(Step)
            end
        end
    end
    return {}
end

local function UpdateGraphAlt()
    lastSec = 0
    lastBeat = 0
    local SongOrCourse = GAMESTATE:GetCurrentSong()
    local StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
	local stepsPerSecList = {}
    local chartint = 1
    local previousSec = -999
    local combo = 1
    local lastBeat = 0

    if SongOrCourse and StepsOrTrail then
        if not isOutFoxV043() then
            for k,v in pairs( SongOrCourse:GetAllSteps() ) do
                if v == StepsOrTrail then
                    chartint = k
                    break
                end
            end
        end

        local timingData = StepsOrTrail:GetTimingData()
        local check = VersionDateCheck(20210666)
        local stops = check and {} or timingData:GetStops()
        local delays = check and {} or timingData:GetDelays()
        local warps = check and {} or timingData:GetWarps()
        local IsJudgableAtBeat = false

        for v in ivalues(isOutFoxV043() and StepsOrTrail:GetNoteData() or SongOrCourse:GetNoteData(chartint)) do
            if check then
                isJudgableAtBeat = timingData:IsJudgableAtBeat(v[1])
            else
                local isStop, isDelay, isWarp = false, false, false
                if stops and #stops > 0 then isStop,stops = HasStopAtBeat(v[1],stops) end
                if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(v[1],delays) end
                if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(v[1],warps) end
                isJudgableAtBeat = not isWarp or (isWarp and (isStop or isDelay))
            end
            if isJudgableAtBeat then
                if allowednotes[v[3]] then
                    local currentSec = math.round(timingData:GetElapsedTimeFromBeat(v[1]),3)
                    if previousSec ~= currentSec then
                        combo = 1
                        stepsPerSecList[currentSec] = math.max(combo,1/(currentSec-previousSec))
                    else
                        if not rowLimit then
                            combo = combo + 1
                            stepsPerSecList[currentSec] = math.max(combo,stepsPerSecList[currentSec] / (combo-1) * combo)
                        end
                    end
                    if v["length"] then
                        if not lastBeat or (v[1] + v["length"] > lastBeat) then lastBeat = v[1] + v["length"] end
                    else
                        if not lastBeat or (v[1] > lastBeat) then lastBeat = v[1] end
                    end
                    previousSec = currentSec
                end
            end
        end

        for i=1,math.ceil(timingData:GetElapsedTimeFromBeat(lastBeat)) do
            if not stepsPerSecList[i] then stepsPerSecList[i] = 0 end
        end

        lastSec = timingData:GetElapsedTimeFromBeat(lastBeat)
    end

    return stepsPerSecList
end

local function UpdateGraphAltSM(Step)
    lastSec = 0
    lastBeat = 0
	local stepsPerSecList = {}
    if Step then
        local timingData = Step:GetTimingData()

        local stops = timingData:GetStops()
        local delays = timingData:GetDelays()
        local warps = timingData:GetWarps()
        local chart = SMParser(Step)
        local previousSec = nil
        
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
                        if rowLimit then count = 1 end
                        local isStop, isDelay, isWarp = false, false, false
                        if stops and #stops > 0 then isStop,stops = HasStopAtBeat(beat,stops) end
                        if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(beat,delays) end
                        if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(beat,warps) end
                        local isJudgableAtBeat = not isWarp or (isWarp and (isStop or isDelay))
                        if isJudgableAtBeat then
                            local currentSec = math.round(timingData:GetElapsedTimeFromBeat(beat),3)
                            if previousSec then
                                stepsPerSecList[currentSec] = math.max(count,1/(currentSec-previousSec) * count)
                            end
                            previousSec = currentSec
                        end
                    end
                    if lastBeat ~= beat and string.find(row,"[L1234]") then
                        lastBeat = beat
                    end
                end
            end
            for i=1,math.ceil(timingData:GetElapsedTimeFromBeat(lastBeat)) do
                if not stepsPerSecList[i] then stepsPerSecList[i] = 0 end
            end
            lastSec = timingData:GetElapsedTimeFromBeat(lastBeat)
        end
    end
    return stepsPerSecList
end

local function UpdateGraphAltBMS(Step)
    lastSec = 0
    lastBeat = 0
	local stepsPerSecList = {}
    if Step then
        local timingData = Step:GetTimingData()

        local stops = timingData:GetStops()
        local delays = timingData:GetDelays()
        local warps = timingData:GetWarps()
        local chart,lastHold = BMSParser(Step)
        local previousSec = nil

        local beats = {}
        for beat in pairs(chart) do beats[#beats+1] = beat end
        table.sort(beats)

        local beat = 0
        if chart then
            for beat in ivalues( beats ) do
                if rowLimit then chart[beat] = 1 end
                local isStop, isDelay, isWarp = false, false, false
                if stops and #stops > 0 then isStop,stops = HasStopAtBeat(beat,stops) end
                if delays and #delays > 0 then isDelay,delays = HasDelayAtBeat(beat,delays) end
                if warps and #warps > 0 then isWarp,warps = HasWarpAtBeat(beat,warps) end
                if not isWarp or (isWarp and (isStop or isDelay)) then
                    local currentSec = math.round(timingData:GetElapsedTimeFromBeat(beat),3)
                    if previousSec then
                        stepsPerSecList[currentSec] = math.max(chart[beat],(1/(currentSec-previousSec)) * chart[beat])
                    end
                    previousSec = currentSec
                end
                lastBeat = math.max(lastBeat,beat)
            end
            lastBeat = math.max(lastBeat,lastHold)
            for i=1,math.ceil(timingData:GetElapsedTimeFromBeat(lastBeat)) do
                if not stepsPerSecList[i] then stepsPerSecList[i] = 0 end
            end
            lastSec = timingData:GetElapsedTimeFromBeat(lastBeat)
        end
    end
    return stepsPerSecList
end

local function UpdateGraphAltOld()
    if GAMESTATE:GetCurrentSong() then
        local Step = GAMESTATE:GetCurrentSteps(pn)
        if Step then
            local filePath = Step:GetFilename()
            local checkSM = filePath:sub(-2):sub(1,1) == 's'	-- [S]M & S[S]C
            if checkSM then
                return UpdateGraphAltSM(Step)
            else
                return UpdateGraphAltBMS(Step)
            end
        end
    end
    return {}
end

local function UpdateGraphAssist()
    local SongOrCourse = GAMESTATE:GetCurrentSong()
    local StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
	local assist = {}
    local temp = nil

    if SongOrCourse and StepsOrTrail then
        local timingData = StepsOrTrail:GetTimingData()
        if getenv("ShowSpeedAssist"..pname(pn)) then
            for v in ivalues(timingData:GetBPMsAndTimes()) do
                local data = split('=', v)
                local numData = {tonumber(data[1]), tonumber(data[2])}
                numData[2] = math.round(numData[2],3)
                if temp then
                    if numData[2] - temp < 0 then
                        assist[checkStopAtBeat(numData[1],timingData)] = -1
                    elseif numData[2] - temp > 0 then
                        assist[checkStopAtBeat(numData[1],timingData)] = 1
                    end
                end
                temp = numData[2]
            end
        end

        if getenv("ShowStopAssist"..pname(pn)) then
            for v in ivalues(timingData:GetStops()) do
                local data = split('=', v)
                local numData = {tonumber(data[1]), tonumber(data[2])}
                assist[timingData:GetElapsedTimeFromBeat(numData[1])] = 0
            end
        end
    end

    return assist
end

local function GetVertices(stepsPerSecList)
    local stepsList = stepsPerSecList or {1}
    local addx = graphW / #stepsList
    local vertices = {}

    average,counter,max = 0,0,0

    for _=1, #stepsList do
        average = average + (stepsList[_] or 0)
        counter = counter + 1
        max = math.max(max,stepsList[_] or 0)
    end

    for i=1, #stepsList + 1 do
        local curX = (i > 1) and ((i-1) * graphW / #stepsList+1 - addx) or 0
        local nextX = (i <= #stepsList) and ((i * graphW / #stepsList+1) - addx) or graphW
        local curY = stepsList[(i > 1) and (i-1) or i] or 0
        local nextY = (i <= #stepsList) and (stepsList[i] or 0) or (#stepsList > 0 and stepsList[#stepsList]/2 or 0)
        if adjust then
            curY = scale(curY,0,max,0,20)
            nextY = scale(nextY,0,max,0,20)
        end

        local alpha = 0.65 + 0.3 * normalizeAlpha
        local col = color('1, 0, 0, '..alpha)
        vertices[#vertices+1] = { {curX, 0, 0}, {col[1], col[2], col[3], col[4]*0.5} }
        local colGB = math.min((math.max(curY, 0) -12) * 0.0833, 1.0)
        col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
        vertices[#vertices+1] = { {curX, math.min(curY * height, graphH), 0}, col }
        local colGB = math.min((math.max(nextY, 0) -12) * 0.0833, 1.0)
        col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
        vertices[#vertices+1] = { {nextX,math.min(nextY * height, graphH), 0}, col }
        col = color('1, 0, 0, '..alpha)
        vertices[#vertices+1] = { {nextX, 0, 0}, {col[1], col[2], col[3], col[4]*0.5} }

        if curY > 20 or nextY > 20 then
            col = color('0, 0, 0, 1')
            vertices[#vertices+1] = { {curX, 0, 0}, col }
            vertices[#vertices+1] = { {curX, math.min(math.max(0,(curY-20)/4) * height, graphH), 0}, col }
            vertices[#vertices+1] = { {nextX,math.min(math.max(0,(nextY-20)/4) * height, graphH), 0}, col }
            vertices[#vertices+1] = { {nextX, 0, 0}, col }
        end
    end
    return vertices
end

local function GetVerticesAlt(stepsPerSecList)
    local stepsList = stepsPerSecList or {1}
    local vertices = {}
    local last = 0

    average,counter,max = 0,0,0

    for _i,_ in pairs( stepsList ) do
        max = math.max(max,_)
        average = average + _
        counter = counter + 1
        if _i > last then last = _i end
    end

    for i,value in pairs( stepsList ) do
        local curX = (i-1) * graphW / last - 0
        local nextX = (i * graphW / last) - 0
        local curY = value/2
        local nextY = value
        if adjust then
            curY = scale(curY,0,max,0,20)
            nextY = scale(nextY,0,max,0,20)
        end
        local alpha = 0.65 + 0.3 * normalizeAlpha
        local col = color('1, 0, 0, '..alpha)
        vertices[#vertices+1] = { {curX, 0, 0}, {col[1], col[2], col[3], col[4]*0.5} }

        if showNoteGraph == 3 then
            local colGB = math.min((math.max(nextY, 0) -12) * 0.0833, 1.0)
            col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
            vertices[#vertices+1] = { {(curX+nextX)/2,math.min(nextY * height, graphH), 0}, col }
        else
            local colGB = math.min((math.max(curY, 0) -12) * 0.0833, 1.0)
            col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
            vertices[#vertices+1] = { {curX, math.min(curY * height, graphH), 0}, col }
            local colGB = math.min((math.max(nextY, 0) -12) * 0.0833, 1.0)
            col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
            vertices[#vertices+1] = { {nextX,math.min(nextY * height, graphH), 0}, col }
        end

        col = color('1, 0, 0, '..alpha)
        vertices[#vertices+1] = { {nextX, 0, 0}, {col[1], col[2], col[3], col[4]*0.5} }

        if curY > 20 or nextY > 20 then
            col = color('0, 0, 0, 1')
            vertices[#vertices+1] = { {curX, 0, 0}, col }
            
            if showNoteGraph == 3 then
                vertices[#vertices+1] = { {(curX+nextX)/2,math.min(math.max(0,(nextY-20)/4) * height, graphH), 0}, col }
            else
                vertices[#vertices+1] = { {curX, math.min(math.max(0,(curY-20)/4) * height, graphH), 0}, col }
                vertices[#vertices+1] = { {nextX,math.min(math.max(0,(nextY-20)/4) * height, graphH), 0}, col }
            end
            vertices[#vertices+1] = { {nextX, 0, 0}, col }
        end
    end
    return vertices
end

local function GetVerticesAssist(insert)
    local graphW = SCREEN_HEIGHT-130
    local assistList = insert
    local vertices = {}
    local col = color('1, 1, 1, 1')
    local length = lastSec/352/2
    local lines = isOutFox() and VersionDateCheck(20201100)

    for sec,typ in pairs(assistList) do
        if typ < 0 then
            col = color('0, 0, 1, 0.5')
        elseif typ > 0 then
            col = color('1, 0, 0, 0.5')
        else
            col = color('1, 1, 1, 0.25')
        end

        if lines then
            vertices[#vertices+1] = { {sec*graphW/lastSec, 0, 0},col }
            vertices[#vertices+1] = { {sec*graphW/lastSec, graphH, 0},col }
        else
            vertices[#vertices+1] = { {(sec-length)*graphW/lastSec, 0, 0},col }
            vertices[#vertices+1] = { {(sec-length)*graphW/lastSec, graphH, 0},col }
            vertices[#vertices+1] = { {(sec+length)*graphW/lastSec, graphH, 0},col }
            vertices[#vertices+1] = { {(sec+length)*graphW/lastSec, 0, 0},col }
        end
    end
    return vertices
end

return Def.ActorFrame{
    Def.Sprite {
        Texture = "notegraph",
        InitCommand=function(self)
            if screenCheck then self:diffuse(PlayerColor(pn)) end
            self:cropleft(pn == PLAYER_1 and 0 or 1):cropright(pn == PLAYER_1 and 1 or 0):zoomy(2/3):sleep(0.5):linear(0.5):x(pn == PLAYER_1 and -100 or 100):cropleft(pn == PLAYER_1 and 0 or cropValue):cropright(pn == PLAYER_1 and cropValue or 0)
        end
    },
    Def.Sprite {
        Texture = "notegraph",
        InitCommand=function(self)
            if screenCheck then self:diffuse(PlayerColor(pn)) end
            self:cropleft(pn == PLAYER_1 and 0 or 1):cropright(pn == PLAYER_1 and 1 or 0):zoomy(2/3):sleep(0.5):linear(0.5):x(pn == PLAYER_1 and -100 or 100):cropleft(pn == PLAYER_1 and 0 or cropValue):cropright(pn == PLAYER_1 and cropValue or 0)
        end,
        OnCommand=function(self) self:blend(Blend.Add):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
    },
    Def.ActorFrame{
        DoneLoadingNextSongMessageCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end,
        Def.ActorMultiVertex{
            DoneLoadingNextSongMessageCommand=function(self) self:playcommand("Init") end,
            CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_1 then self:playcommand("Init") end end,
            CurrentStepsChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_1 then self:playcommand("Init") end end,
            CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_2 then self:playcommand("Init") end end,
            CurrentTrailP1ChangedMessageCommand=function(self) if courseMode and pn == PLAYER_1 then self:playcommand("Init") end end,
            CurrentTrailP2ChangedMessageCommand=function(self) if courseMode and pn == PLAYER_2 then self:playcommand("Init") end end,
            InitCommand=function(self)
                local vertices = showNoteGraph == 3 and GetVerticesAlt((isOutFox() and VersionDateCheck(20200400)) and UpdateGraphAlt() or UpdateGraphAltOld()) or GetVertices((isOutFox() and VersionDateCheck(20200400)) and UpdateGraph() or UpdateGraphOld())
                self:SetDrawState(showNoteGraph == 3 and {Mode = 'DrawMode_Triangles'} or {Mode = 'DrawMode_Quads'})
                self:SetVertices(1, vertices)
                self:SetNumVertices(#vertices)
                self:rotationz(pn == PLAYER_1 and 90 or -90)
                self:rotationx(pn == PLAYER_1 and 180 or 0)
                self:x(pn == PLAYER_1 and -graphH*1.5 or graphH*1.5):y(175)
            end
        },
        Def.ActorMultiVertex{
            Condition=(getenv("ShowSpeedAssist"..pname(pn)) or getenv("ShowStopAssist"..pname(pn))) and not screenCheck,
            DoneLoadingNextSongMessageCommand=function(self) self:sleep(1/30):queuecommand("Draw") end,
            CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_1 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentStepsChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_1 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_2 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentTrailP1ChangedMessageCommand=function(self) if courseMode and pn == PLAYER_1 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentTrailP2ChangedMessageCommand=function(self) if courseMode and pn == PLAYER_2 then self:sleep(1/30):queuecommand("Draw") end end,
            InitCommand=function(self) self:sleep(1/30):queuecommand("Draw") end,
            DrawCommand=function(self)
                local vertices = GetVerticesAssist(UpdateGraphAssist())
                self:SetDrawState((isOutFox() and VersionDateCheck(20201100)) and {Mode = 'DrawMode_Lines'} or {Mode = 'DrawMode_Quads'})
                self:SetVertices(1, vertices)
                self:SetNumVertices(#vertices)
                self:rotationz(pn == PLAYER_1 and 90 or -90)
                self:rotationx(pn == PLAYER_1 and 180 or 0)
                self:x(pn == PLAYER_1 and -graphH*1.5 or graphH*1.5):y(175)
            end
        },
        Def.BitmapText{
            Condition=ShowNoteGraphData,
            File = "_r bold shadow 30px",
            InitCommand=function(self)
                self:diffuseramp():effectcolor1(PlayerColor(pn)):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat'):vertspacing(-10)
                if screenCheck then
                    self:x(pn == PLAYER_1 and -graphH*1.525 or graphH*1.525):y(graphH*2.1):zoomx(pn == PLAYER_1 and -1 or 1):maxwidth(graphH):halign(0):valign(0)
                else
                    self:x(pn == PLAYER_1 and -graphH*2.55 or graphH*2.55):rotationz(pn == PLAYER_2 and 90 or -90):zoom(WideScreenDiff()):maxwidth(ShowStatsSize == 1 and graphW*0.9 or graphW):valign(1)
                end
                self:queuecommand("Draw")
            end,
            DoneLoadingNextSongMessageCommand=function(self) self:sleep(1/30):queuecommand("Draw") end,
            CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_1 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentStepsChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_1 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode and pn == PLAYER_2 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentTrailP1ChangedMessageCommand=function(self) if courseMode and pn == PLAYER_1 then self:sleep(1/30):queuecommand("Draw") end end,
            CurrentTrailP2ChangedMessageCommand=function(self) if courseMode and pn == PLAYER_2 then self:sleep(1/30):queuecommand("Draw") end end,
            DrawCommand=function(self)
                if screenCheck then
                    self:settext("AVG: "..math.round(average/counter).."\nMAX: "..math.round(max))
                else
                    self:settext("Average NPS: "..math.round(average/counter,1).." | Max NPS: "..math.round(max,1))
                end
            end
        }
    },
    Def.Sprite {
        Condition=not screenCheck,
        Texture = THEME:GetPathG("horiz-line","short"),
        DoneLoadingNextSongMessageCommand=function(self) self:queuecommand("RePos") end,
        InitCommand=function(self) self:x(pn == PLAYER_1 and -140 or 140):blend(Blend.Add):fadeleft(0.25):faderight(0.25):zoomy(0.5):cropleft(pn == PLAYER_1 and 0 or 0.25):cropright(pn == PLAYER_1 and 0.25 or 0):queuecommand("RePos") end,
        OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
        RePosCommand=function(self)
            if lastSec == 0 then lastSec = GAMESTATE:GetCurrentSong():GetLastSecond() end
            self:y(176-352*(math.min(1,GAMESTATE:GetSongPosition():GetMusicSecondsVisible()/lastSec))):sleep(1/60):queuecommand("RePos")
        end
    }
}