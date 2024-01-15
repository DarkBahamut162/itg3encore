local player = ...
assert(player,"[_name/default.lua] requires a player to be passed in.")
local iconName = "_icon p"..(player == PLAYER_1 and 1 or 2)

local pX = 0.0
local pXmod = ""

local step = GAMESTATE:GetCurrentSteps(player)
local trail = GAMESTATE:GetCurrentTrail(player)
local timingdata
local bpm = {}

if GAMESTATE:IsCourseMode() then
	if trail then
		local entries = trail:GetTrailEntries()
		for i=1, #entries do
			step = entries[i]:GetSteps()
			timingdata = step:GetTimingData()
			if i == 1 then
				bpm[1] = timingdata:GetActualBPM()[1]
				bpm[2] = timingdata:GetActualBPM()[2]
			else
				if timingdata:GetActualBPM()[1] < bpm[1] then bpm[1] = timingdata:GetActualBPM()[1] end
				if timingdata:GetActualBPM()[2] > bpm[2] then bpm[2] = timingdata:GetActualBPM()[2] end
			end
		end
	end
else
	if step then
		timingdata = step:GetTimingData()
		bpm[1] = timingdata:GetActualBPM()[1]
		bpm[2] = timingdata:GetActualBPM()[2]
	end
end

local function checkInitSpeedMods()
	local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	if playeroptions:XMod()						then pX = playeroptions:XMod()*100 pXmod = "x" end
	if playeroptions:CMod()						then pX = playeroptions:CMod() pXmod = "C" end
	if playeroptions:MMod()						then pX = playeroptions:MMod() pXmod = "m" end
	if isOutFox() and playeroptions:AMod()		then pX = playeroptions:AMod() pXmod = "a" end
	if isOutFox() and playeroptions:CAMod()		then pX = playeroptions:CAMod() pXmod = "ca" end
	if isOutFox() and playeroptions:AVMod()		then pX = playeroptions:AVMod() pXmod = "av" end
end

local function modifiedBPM(speed,mode)
	local modifiedBPM1 = bpm[1]
	local modifiedBPM2 = bpm[2]

	if mode == "x" then
		modifiedBPM1 = bpm[1] * speed / 100
		modifiedBPM2 = bpm[2] * speed / 100
	elseif mode == "C" then
		modifiedBPM1 = speed
		modifiedBPM2 = speed
	elseif mode == "m" then
        local max = tonumber(THEME:GetMetric('Player', 'MModHighCap'))
        if bpm[2] > max then
            speed = speed / max
        else
            speed = (bpm[2] ~= 0) and speed / bpm[2] or 0
        end
		modifiedBPM1 = bpm[1] * speed
		modifiedBPM2 = bpm[2] * speed
	elseif mode == "a" or mode == "ca" or mode == "av" then
		local baseAvg = (bpm[1] + bpm[2]) * 0.5
		local mult = speed / baseAvg
		modifiedBPM1 = bpm[1] * mult
		modifiedBPM2 = bpm[2] * mult
	end

	modifiedBPM1 = math.round(modifiedBPM1,3)
	modifiedBPM2 = math.round(modifiedBPM2,3)

	if modifiedBPM2 and modifiedBPM1 ~= modifiedBPM2 then
		return modifiedBPM1..' - '..modifiedBPM2
	else
		return modifiedBPM1
	end
end

if not isTopScreen("ScreenJukeboxMenu") and GAMESTATE:IsHumanPlayer(player) then
	return Def.ActorFrame{
		LoadActor("_name frame "..(isFinal() and "final" or "normal"))..{ InitCommand=function(self) self:zoomx(1.75):xy(-205.5,5) end },
		LoadFont("_v 26px bold white")..{
			InitCommand=function(self) self:xy(-280,4):maxwidth(160):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player)) end,
			BeginCommand=function(self) self:settext( GetDisplayNameFromProfileOrMemoryCard(player) ) end
		},
		LoadActor(iconName)..{ InitCommand=function(self) self:xy(-232,4):shadowlength(2) end },
		LoadFont("_v 26px bold white")..{
			InitCommand=function(self) self:xy(-226,4):maxwidth(260):halign(0):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player)) end,
			BeginCommand=function(self)
				checkInitSpeedMods()
				bpmtext = modifiedBPM(pX,pXmod)
				self:settextf("MOD: %s%s  BPM: %s",pXmod == "x" and pX/100 or pX,pXmod,bpmtext)
			end,
			SpeedChoiceChangedMessageCommand=function(self,param)
				bpmtext = modifiedBPM(param.speed,param.mode)
				self:settextf("MOD: %s%s  BPM: %s",param.mode == "x" and param.speed/100 or param.speed,param.mode,bpmtext)
			end
		}
	}
else
	return Def.ActorFrame{}
end