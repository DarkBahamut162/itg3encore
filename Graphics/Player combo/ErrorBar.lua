if isTopScreen("ScreenDemonstration2") or isTopScreen("ScreenDemonstration") then return Def.ActorFrame{} end
local player = ...
local t = Def.ActorFrame{}

local tilt = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions():Tilt()
local tilt_degrees = scale(tilt,-1,1,30,30) % 360
if tilt_degrees > 180 then tilt_degrees = tilt_degrees - (tilt_degrees-180) end
local stretch = 1-(tilt_degrees/180)
local add = math.abs(SCREEN_HEIGHT-SCREEN_HEIGHT/stretch)*2

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny * WideScreenDiff()

local style = GAMESTATE:GetCurrentStyle()

if tilt > 0 then
	currentMini = currentMini * scale(tilt,0,1,1,0.9)
	add = add + math.abs(scale(tilt,0,1,0,-45)/stretch)
else
	currentMini = currentMini * scale(tilt,0,-1,1,0.9)
	add = add + math.abs(scale(tilt,0,-1,0,-20)/stretch)
end

local filterAlpha = tonumber(getenv("ScreenFilter"..pname(player)) or 0)
local filterWidth = style:GetWidth(player)
local currentTick = 1

local faplus = getenv("SetScoreFA"..pname(player)) or false

local timing = GetTimingDifficulty()
local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
local W0 = 0.0135*timingChange[timing]*JudgeScale
local W1 = (isOpenDDR() and 0.0167 or PREFSMAN:GetPreference("TimingWindowSecondsW1"))*timingChange[timing]*JudgeScale
local W2 = (isOpenDDR() and 0.0333 or PREFSMAN:GetPreference("TimingWindowSecondsW2"))*timingChange[timing]*JudgeScale
local W3 = (isOpenDDR() and 0.0920 or PREFSMAN:GetPreference("TimingWindowSecondsW3"))*timingChange[timing]*JudgeScale
local W4 = (isOpenDDR() and 0.1420 or PREFSMAN:GetPreference("TimingWindowSecondsW4"))*timingChange[timing]*JudgeScale
local W5 = (isOpenDDR() and 0.1420 or PREFSMAN:GetPreference("TimingWindowSecondsW5"))*timingChange[timing]*JudgeScale
local Wadd = isOpenDDR() and 0.0000 or PREFSMAN:GetPreference("TimingWindowAdd")

if not isEtterna() then
	W0 = W0 + Wadd
	W1 = W1 + Wadd
	W2 = W2 + Wadd
	W3 = W3 + Wadd
	W4 = W4 + Wadd
	W5 = W5 + Wadd
end

local judg = {}
if faplus then judg[#judg+1] = W0 end
judg[#judg+1] = W1
judg[#judg+1] = W2
judg[#judg+1] = W3
if not isOpenDDR() then judg[#judg+1] = W4 end
local Wmax = (isOpenDDR() and W4 or W5)
local width = isFinal() and 125 or 125/2

local errorBar = getenv("ShowErrorBar"..pname(player)) or 0
if errorBar == 1 then
	Wmax = W1
elseif errorBar == 2 then
	Wmax = W2
elseif errorBar == 3 then
	Wmax = W3
elseif errorBar == 4 and not isOpenDDR() then
	Wmax = W4
end

local jugdE = {
	["TapNoteScore_W0"] = 0,
	["TapNoteScore_W1"] = 1,
	["TapNoteScore_W2"] = 2,
	["TapNoteScore_W3"] = 3,
	["TapNoteScore_W4"] = 4,
	["TapNoteScore_W5"] = 5,
	["TapNoteScore_Miss"] = isOpenDDR() and 5 or 6
}

local function DisplayTick(self,params)
    if params.TapNoteOffset then
		--if math.abs(params.TapNoteOffset) > Wmax then return end
        local tick = self:GetChild("Tick"..currentTick)
        currentTick = currentTick % 15 + 1

        tick:finishtweening()

		local WX = params.TapNoteScore
		local posX = -params.TapNoteOffset/Wmax
		local zoomX = isFinal() and 2 or 1
		local length = 0.75

		if WX == "TapNoteScore_W1" and faplus then
			if math.abs(params.TapNoteOffset) <= W0 then else WX = "TapNoteScore_W0" end
		elseif errorBar < jugdE[WX] then
			posX = 0
			zoomX = isFinal() and 250 or 125
			length = 0.25
		end
        local color = TapNoteScoreToColor(WX) 

        tick:zoomx(zoomX):diffusealpha(1):diffuse(color):x(125*posX):sleep(0.03):linear(length - 0.03):diffusealpha(0)
    end
end

local judgments = Def.ActorFrame{
    JudgmentMessageCommand = function(self,params)
        if params.Player ~= player then return end
        if params.HoldNoteScore then return end
        DisplayTick(self,params)
    end
}

for WX in ivalues(judg) do
	if WX < Wmax then
		judgments[#judgments+1] = Def.Sprite{
			Texture = THEME:GetPathG("horiz-line","short"),
			InitCommand=function(self)
				self:zoomto(1,30):diffusealpha(0.25):x(125*(WX/Wmax)):blend(Blend.Add)
			end
		}
		judgments[#judgments+1] = Def.Sprite{
			Texture = THEME:GetPathG("horiz-line","short"),
			InitCommand=function(self)
				self:zoomto(1,30):diffusealpha(0.25):x(125*(-WX/Wmax)):blend(Blend.Add)
			end
		}
	end
end

for i = 1, 15 do
    judgments[#judgments+1] = Def.Quad{
        Name = "Tick"..i, InitCommand=function(self) self:zoomto(2,30):diffusealpha(0) end
    }
end

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		local NoteFieldMiddle = (THEME:GetMetric("Player","ReceptorArrowsYStandard")+THEME:GetMetric("Player","ReceptorArrowsYReverse"))/2
		local mods = string.find(GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
		local reverse = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):UsingReverse()
		if mods then reverse = not reverse end
		self:addy(reverse and -NoteFieldMiddle*3 or NoteFieldMiddle*3):addy(-64):zoomy(0.5)
	end,
	Def.Sprite {
		Texture = "bar "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:zoomtowidth(filterWidth+14) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("horiz-line","short"),
		InitCommand=function(self) self:zoomto(1,30):diffusealpha(0.25) end
	},
	judgments
}

return t