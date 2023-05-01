local c
local player = ...
local pNum = (player == PLAYER_1) and 1 or 2
local style = GAMESTATE:GetCurrentStyle()

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(pNum-1) * currentMini or 64 * 4 * currentMini

if string.find(style:GetName(),"double") then
	if IsGame("be-mu") then
		filterWidth = filterWidth * 1.8
	elseif IsGame("pump") then
		filterWidth = filterWidth * 1.35
	elseif IsGame("smx") then
		filterWidth = filterWidth * 1.45
	elseif IsGame("po-mu") then
		filterWidth = filterWidth * 1.65
	else
		filterWidth = filterWidth * 1.4
	end
end
if getenv("EffectVibrateP"..pNum) then
	filterWidth = filterWidth + (30 * currentMini)
end

local Stops = {}
local Si = 1
local timingData = GAMESTATE:GetCurrentSteps(player):GetTimingData()
local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")

for k,v in pairs(timingData:GetStops()) do
	local data = split('=', v)
	Stops[#Stops+1] = { Time = timingData:GetElapsedTimeFromBeat(tonumber(data[1])), Length = tonumber(data[2]), BPM = timingData:GetBPMAtBeat(tonumber(data[1])) }
end

local totalDelta = 0
local tmpDelta = 0
local speedMod = 1

local curStep = GAMESTATE:GetCurrentSteps(player)
local timingdata = curStep:GetTimingData()
local truebpms = timingdata:GetActualBPM()
local bpm1 = math.floor(timingdata:GetActualBPM()[1])
local bpm2 = math.floor(timingdata:GetActualBPM()[2])

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

return Def.ActorFrame{
	InitCommand=function(self)
		c = self:GetChildren()
		--c.Stop:diffusealpha(0)
	end,
	OnCommand = function(self) self:SetUpdateFunction(Update) end,
	Def.Quad{
		Name="Stop",
		OnCommand=function(self)
			self:y(PY):valign(0):zoomtowidth(filterWidth-8):zoomtoheight(0):diffusecolor(Color.White):blend(Blend.Add)
		end
	}
}