local player, NullMeasures = ...
if not GAMESTATE:IsHumanPlayer(player) or NullMeasures == nil then return Def.ActorFrame{} end
assert( player )

local totalDelta = 0
local tmpDelta = 0
local c
local steps = GAMESTATE:GetCurrentSteps(player)
local timingData = steps:GetTimingData()
NullMeasures = condenseNullMeasures(NullMeasures)
NullMeasures = split("|",NullMeasures)
local timeSignatures = timingData:GetTimeSignatures()
local currentMeasure = -1
local currentBeat = 0
local totalBeats = 0
local add = 0

local function GetTimeSignatureAtBeat(beat,TS)
	while TS and TS[1] do
		local time1 = split('=', TS[1])
		if TS[2] then
			local time2 = split('=', TS[2])
			if beat >= tonumber(time1[1]) and beat < tonumber(time2[1]) then
				return tonumber(time1[2])/tonumber(time1[3])*4, TS
			elseif beat >= tonumber(time1[1]) and beat >= tonumber(time2[1]) then
				table.remove(TS,1)
			end
		else
			if beat >= tonumber(time1[1]) then
				return tonumber(time1[2])/tonumber(time1[3])*4, TS
			end
		end
	end
	return 0, TS
end

local function CheckMeasure(check,measures)
	while measures and measures[1] do
		local measure = measures[1]
		if string.find(measure,"-") then
			measure = tonumber(split('-',measure)[2])+1
			if check < measure then
				return false, measures
			elseif check >= measure then
				table.remove(measures,1)
				return true, measures
			end
		else
			measure = tonumber(measure)+1
			if check < measure then
				return false, measures
			elseif check >= measure then
				table.remove(measures,1)
				return true, measures
			end
		end
	end
	return false, measures
end

local measures = ""
local coloring = {}

local function SetMeasures(M)
	measures = ""
	coloring = {}
	for measure = 0, #M do
		local begin = string.len(measures)+1
		measures = addToOutput(measures,"\n",M[#M-measure+1])
		coloring[#coloring+1] = {FIRST = begin-1, LAST = string.len(measures)-begin, COLOR = color("1,1,1,"..math.min(1,math.max(0.1,math.pow(measure/#M,4))))}
	end
end

SetMeasures(NullMeasures)
local resetDisplay

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1.0/60 and #NullMeasures > 0 then
		tmpDelta = totalDelta
		currentBeat = timingData:GetBeatFromElapsedTime(GAMESTATE:GetSongPosition():GetMusicSecondsVisible())
		if currentBeat > totalBeats then
			add, timeSignatures = GetTimeSignatureAtBeat(totalBeats,timeSignatures)
			currentMeasure = currentMeasure + 1
			totalBeats = totalBeats + add
			resetDisplay,NullMeasures = CheckMeasure(currentMeasure,NullMeasures)
			if resetDisplay then SetMeasures(NullMeasures) end
			if #NullMeasures == 0 then c.NullMeasure:linear(1):diffusealpha(0) end
			c.NullMeasure:settext(measures.."Measure "..currentMeasure)
			for i,pair in pairs(coloring) do
				c.NullMeasure:AddAttribute(pair.FIRST, {
					Length = pair.LAST,
					Diffuse = pair.COLOR
				})
			end
		end
	end
end

local iidx = IsGame("beat") or IsGame("be-mu")

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	OnCommand=function(self) self:SetUpdateFunction(Update) end,
	Def.BitmapText {
		File = "_r bold 30px",
		Name="NullMeasure",
		InitCommand=function(self)
			c = self
			local NoteFieldMiddle = (THEME:GetMetric("Player","ReceptorArrowsYStandard")+THEME:GetMetric("Player","ReceptorArrowsYReverse"))/2
			local mods = string.find(GAMESTATE:GetPlayerState(player):GetPlayerOptionsString("ModsLevel_Song"),"FlipUpsideDown")
			local reverse = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Song'):UsingReverse()
			if mods then reverse = not reverse end
			local posY = reverse and THEME:GetMetric("Player","ReceptorArrowsYReverse") or THEME:GetMetric("Player","ReceptorArrowsYStandard")
			self:y(SCREEN_CENTER_Y+posY-NoteFieldMiddle):addy(reverse and -30 or 30):valign(reverse and 1 or 0):zoom(iidx and 1 or 0.5):draworder(999)
		end
	}
}