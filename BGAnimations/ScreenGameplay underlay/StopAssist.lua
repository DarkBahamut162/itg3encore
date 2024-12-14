local c
local player = ...
local pNum = (player == PLAYER_1) and 1 or 2
local style = GAMESTATE:GetCurrentStyle()

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny
local filterWidth = style:GetWidth(player) * currentMini
local widthZoom = Center1Player() and 1 or WideScreenDiff()

if not isOutFox() then filterWidth = filterWidth * math.min(1,NotefieldZoom()) end
if isOutFox() then filterWidth = filterWidth * WideScreenDiff() end
if getenv("EffectVibrateP"..pNum) then filterWidth = filterWidth + (30 * currentMini) end

local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
local Stops,timingData,truebpms,bpm1,bpm2
local totalDelta = 0
local tmpDelta = 0
local speedMod = 1
local Si = 1

local function setStops(steps)
	Si = 1
	Stops = {}
	timingData = steps:GetTimingData()
	truebpms = timingData:GetActualBPM()
	bpm1 = math.floor(timingData:GetActualBPM()[1])
	bpm2 = math.floor(timingData:GetActualBPM()[2])

	for v in ivalues(timingData:GetStops()) do
		local data = split('=', v)
		Stops[#Stops+1] = { Time = timingData:GetElapsedTimeFromBeat(tonumber(data[1])), Length = tonumber(data[2]), BPM = timingData:GetBPMAtBeat(tonumber(data[1])) }
	end
end

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1.0/60 and timingData then
		tmpDelta = totalDelta

		local ms = GAMESTATE:GetCurMusicSeconds()
		if getenv("ShowStopAssistP"..pNum) then
			if Stops[Si] and Stops[Si]["Time"] < ms then
				if playeroptions:XMod() then speedMod = playeroptions:XMod()*Stops[Si]["BPM"] end
				if playeroptions:CMod() then speedMod = playeroptions:CMod() end
				if playeroptions:MMod() then speedMod = playeroptions:MMod() end
				if isOutFox() and playeroptions:AMod() then speedMod = ((bpm1+bpm2)*0.5)/playeroptions:AMod()*Stops[Si]["BPM"] end
				if isOutFox() and playeroptions:CAMod() then speedMod = ((bpm1+bpm2)*0.5)/playeroptions:CAMod()*Stops[Si]["BPM"] end
				if isOutFox() and playeroptions:AVMod() then speedMod = ((bpm1+bpm2)*0.5)/playeroptions:AVMod()*Stops[Si]["BPM"] end
				c.Stop:stoptweening():diffusealpha(1):zoomtoheight(Stops[Si]["Length"]*speedMod*currentMini):linear(Stops[Si]["Length"]):zoomtoheight(0):linear(0.1):diffusealpha(0)
				Si = Si + 1
			end
		end
	end
end

local PY = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Preferred'):UsingReverse() and THEME:GetMetric("Player","ReceptorArrowsYReverse") or THEME:GetMetric("Player","ReceptorArrowsYStandard")
local adjust = isOutFox() and 47-(47 * WideScreenDiff()) or 0

if GAMESTATE:GetNumPlayersEnabled() == 1 then
	if getenv("RotationRight"..pname(player)) and player == PLAYER_1 then
		PY = PY - SCREEN_CENTER_X
	elseif getenv("RotationLeft"..pname(player)) and player == PLAYER_2 then
		PY = PY - SCREEN_CENTER_X
	end
end

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	OnCommand = function(self)
		if GAMESTATE:IsCourseMode() then
			setStops(GAMESTATE:GetCurrentTrail(player):GetTrailEntry(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetSongsPassed()):GetSteps())
		else
			setStops(GAMESTATE:GetCurrentSteps(player))
		end
		self:SetUpdateFunction(Update)
	end,
	DoneLoadingNextSongMessageCommand=function(self) self:playcommand("On") end,
	Def.Quad{
		Name="Stop",
		OnCommand=function(self)
			self:y(PY-adjust):valign(0):zoomtowidth(filterWidth-8*widthZoom):zoomtoheight(0):diffusecolor(Color.White):blend(Blend.Add)
		end
	}
}