local pn = ...
local graphW  = SCREEN_HEIGHT-130
local max     = 92
local height  = SCREEN_HEIGHT / max
local bgColor = color('0, 0, 0, 0.66')
local normalizeAlpha = (1.0 - bgColor[4]) * 0.8
local graphH = -max

local allowednotes = {
	["TapNoteType_Tap"] = true,
	["TapNoteType_Lift"] = true,
	["TapNoteSubType_Hold"] = true,
	["TapNoteSubType_Roll"] = true
}

local function UpdateGraph()
    local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSong() or GAMESTATE:GetCurrentSong()
    local StepOrTrails = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSteps() or GAMESTATE:GetCurrentSteps(pn)
	local stepsPerSecList = {0}
    local chartint = 1

    if SongOrCourse then
        for k,v in pairs( SongOrCourse:GetAllSteps() ) do
            if v == StepOrTrails then
                chartint = k
                break
            end
        end

        local timingData = StepOrTrails:GetTimingData()

        for i=1,math.ceil(SongOrCourse:GetLastSecond()) do
            stepsPerSecList[i] = 0
        end


        for k,v in pairs( SongOrCourse:GetNoteData(chartint) ) do
            if timingData:IsJudgableAtBeat(v[1]) then
                if allowednotes[v[3]] then
                    local currentSec = math.ceil(timingData:GetElapsedTimeFromBeat(v[1]))
                    stepsPerSecList[currentSec] = stepsPerSecList[currentSec] and stepsPerSecList[currentSec] + 1 or 0
                end
            end
        end
    end

    return stepsPerSecList
end

local function GetVertices(stepsPerSecList)
    local stepsList = stepsPerSecList or {1}
    local lenCorrection = 1.0
    local addx = graphW / #stepsList
    local vertices = {}
    for i=1, #stepsList + 1 do
        local curX = (i > 1) and ((i-1) * graphW / #stepsList+1 - addx) or 0
        local nextX = (i <= #stepsList) and ((i * graphW / #stepsList+1) - addx) or graphW
        local curY = stepsList[(i > 1) and (i-1) or i] or 0
        local nextY = (i <= #stepsList) and (stepsList[i] or 0) or (stepsList[#stepsList]/2)
        local alpha = 0.65 + 0.3 * normalizeAlpha
        local col = color('1, 0, 0, '..alpha)
        vertices[#vertices+1] = {
            {curX, graphH, 0},
            {col[1], col[2], col[3], col[4]*0.5}
        }
        local colGB = math.min((math.max(curY, 0) * lenCorrection -12) * 0.0833, 1.0)
        col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
        vertices[#vertices+1] = {
            {curX, graphH - math.min(curY * lenCorrection * height, max), 0},
            col
        }
        local colGB = math.min((math.max(nextY, 0) * lenCorrection -12) * 0.0833, 1.0)
        col = color(string.format('%.2f, %.2f, %.2f, %.2f', (1-colGB), colGB, colGB, alpha))
        vertices[#vertices+1] = {
            {nextX, graphH - math.min(nextY * lenCorrection * height, max), 0},
            col
        }
        col = color('1, 0, 0, '..alpha)
        vertices[#vertices+1] = {
            {nextX, graphH, 0},
            {col[1], col[2], col[3], col[4]*0.5}
        }
    end
    return vertices
end

return Def.ActorFrame{
    LoadActor("notegraph")..{
        InitCommand=function(self) self:cropleft(pn == PLAYER_1 and 0 or 1):cropright(pn == PLAYER_1 and 1 or 0):zoomy(2/3):sleep(0.5):linear(0.5):x(pn == PLAYER_1 and -100 or 100):cropleft(pn == PLAYER_1 and 0 or 0.5):cropright(pn == PLAYER_1 and 0.5 or 0) end
    },
    LoadActor("notegraph")..{
        InitCommand=function(self) self:cropleft(pn == PLAYER_1 and 0 or 1):cropright(pn == PLAYER_1 and 1 or 0):zoomy(2/3):sleep(0.5):linear(0.5):x(pn == PLAYER_1 and -100 or 100):cropleft(pn == PLAYER_1 and 0 or 0.5):cropright(pn == PLAYER_1 and 0.5 or 0) end,
        OnCommand=function(self) self:blend(Blend.Add):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
    },
    Def.ActorFrame{
        Def.ActorMultiVertex{
            DoneLoadingNextSongMessageCommand=function(self) self:playcommand("Init") end,
            InitCommand=function(self)
                local vertices = GetVertices(UpdateGraph())
                self:SetDrawState({Mode = 'DrawMode_Quads'})
                self:SetVertices(1, vertices)
                self:SetNumVertices(#vertices)
                self:rotationz(pn == PLAYER_1 and -90 or 90)
                self:rotationx(pn == PLAYER_1 and 0 or 180)
                self:x(pn == PLAYER_1 and-46 or 46):y(175)
                self:diffusealpha(0):zoomy(0):linear(0.5):zoomy(1.0-0.4*math.max(854-SCREEN_WIDTH, 0)/214):diffusealpha(1)
            end
        },
        Def.ActorMultiVertex{
            DoneLoadingNextSongMessageCommand=function(self) self:playcommand("Init") end,
            InitCommand=function(self)
                local update = UpdateGraph()
                for i=1,#update do update[i] = math.max(0,(update[i]-20)/4) end
                local vertices = GetVertices(update)
                self:SetDrawState({Mode = 'DrawMode_Quads'})
                self:SetVertices(1, vertices)
                self:SetNumVertices(#vertices)
                self:rotationz(pn == PLAYER_1 and -90 or 90)
                self:rotationx(pn == PLAYER_1 and 0 or 180)
                self:x(pn == PLAYER_1 and-46 or 46):y(175)
                self:blend(Blend.Subtract)
                self:diffusealpha(0):zoomy(0):linear(0.5):zoomy(1.0-0.4*math.max(854-SCREEN_WIDTH, 0)/214):diffusealpha(1)
            end
        }
    },
    LoadActor(THEME:GetPathG("horiz-line","short"))..{
        DoneLoadingNextSongMessageCommand=function(self) self:queuecommand("RePos") end,
        InitCommand=function(self) self:x(pn == PLAYER_1 and -140 or 140):blend(Blend.Add):fadeleft(0.25):faderight(0.25):zoomy(0.5):cropleft(pn == PLAYER_1 and 0 or 0.25):cropright(pn == PLAYER_1 and 0.25 or 0):queuecommand("RePos") end,
        OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1) end,
        RePosCommand=function(self) self:y(176-352*(math.min(1,GAMESTATE:GetSongPosition():GetMusicSecondsVisible()/GAMESTATE:GetCurrentSong():GetLastSecond()))):sleep(1/60):queuecommand("RePos") end
    }
}