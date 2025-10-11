local player = ...
assert(player,"[_name/default.lua] requires a player to be passed in.")
local iconName = "_icon "..pname(player)

local pX = 0.0
local pXmod = ""

local StepsOrTrain = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
local timingdata
local bpm = {}
local currentBPM = {}
local absoluteBPM = {}
local BPMtype = IsGame("pump") and 0 or ThemePrefs.Get("ShowBPMDisplayType")

local function checkInitBPMs()
	if GAMESTATE:IsCourseMode() then
		if StepsOrTrain then
			local entries = StepsOrTrain:GetTrailEntries()
			for i=1, #entries do
				local song = entries[i]:GetSong()
				StepsOrTrain = entries[i]:GetSteps()
				timingdata = StepsOrTrain:GetTimingData()
				bpm = getAllTheBPMs(song,StepsOrTrain,BPMtype)
				absoluteBPM = timingdata:GetActualBPM()
				if i == 1 then
					currentBPM[1] = bpm[1]
					currentBPM[2] = bpm[2]
					currentBPM[3] = bpm[3]
				else
					if bpm[1] < currentBPM[1] then currentBPM[1] = bpm[1] end
					if bpm[2] > currentBPM[2] then currentBPM[2] = bpm[2] end
					if bpm[3] > currentBPM[3] then currentBPM[3] = bpm[3] end
				end
			end
		end
	else
		if StepsOrTrain then
			local song = GAMESTATE:GetCurrentSong()
			timingdata = StepsOrTrain:GetTimingData()
			bpm = getAllTheBPMs(song,StepsOrTrain,BPMtype)
			absoluteBPM = StepsOrTrain:GetTimingData():GetActualBPM()
			currentBPM[1] = bpm[1]
			currentBPM[2] = bpm[2]
			currentBPM[3] = bpm[3]
		end
	end
end

local function checkInitSpeedMods()
	local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	if playeroptions:XMod()						then pX = playeroptions:XMod()*100 pXmod = "x" end
	if playeroptions:CMod()						then pX = playeroptions:CMod() pXmod = "C" end
	if playeroptions:MMod()						then pX = playeroptions:MMod() pXmod = "m" end
	if isOutFox(20210200) and playeroptions:AMod()		then pX = playeroptions:AMod() pXmod = "a" end
	if isOutFox(20220300) and playeroptions:CAMod()		then pX = playeroptions:CAMod() pXmod = "ca" end
	if isOutFox(20220900) and playeroptions:AVMod()		then pX = playeroptions:AVMod() pXmod = "av" end
end

local function modifiedBPM(speed,mode)
	local modifiedBPM = {0,0,0}

	if mode == "x" then
		modifiedBPM[1] = currentBPM[1] * speed / 100
		modifiedBPM[2] = currentBPM[2] * speed / 100
		modifiedBPM[3] = currentBPM[3] * speed / 100
	elseif mode == "C" then
		modifiedBPM[1] = speed
		modifiedBPM[2] = speed
		modifiedBPM[3] = speed
	elseif mode == "m" then
        local max = tonumber(THEME:GetMetric('Player', 'MModHighCap'))
        if max > 0 and absoluteBPM[2] > max then
            speed = speed / max
        else
            speed = speed / absoluteBPM[2]
        end
		modifiedBPM[1] = currentBPM[1] * speed
		modifiedBPM[2] = currentBPM[2] * speed
		modifiedBPM[3] = currentBPM[3] * speed
	elseif mode == "a" or mode == "ca" or mode == "av" then
		local baseAvg = (absoluteBPM[1] + absoluteBPM[2]) * 0.5
		local mult = speed / baseAvg
		modifiedBPM[1] = currentBPM[1] * mult
		modifiedBPM[2] = currentBPM[2] * mult
		modifiedBPM[3] = currentBPM[3] * mult
	end

	modifiedBPM[1] = math.round(modifiedBPM[1],3)
	modifiedBPM[2] = math.round(modifiedBPM[2],3)
	modifiedBPM[3] = math.round(modifiedBPM[3],3)

	if modifiedBPM[3] == 0.0 then
		if modifiedBPM[2] and modifiedBPM[1] ~= modifiedBPM[2] then
			return modifiedBPM[1].."-"..modifiedBPM[2]
		else
			return modifiedBPM[1]
		end
	else
		if modifiedBPM[1] == modifiedBPM[2] and modifiedBPM[2] == modifiedBPM[3] then
			return modifiedBPM[1]
		elseif modifiedBPM[3] == modifiedBPM[1] or modifiedBPM[3] == 0 then
			if modifiedBPM[1] ~= modifiedBPM[2] then
				return modifiedBPM[1] .. " (" .. modifiedBPM[2] .. ")"
			else
				return modifiedBPM[1]
			end
		elseif modifiedBPM[3] < modifiedBPM[2] then
			return modifiedBPM[1] .. "-" .. modifiedBPM[3] .. " (" .. modifiedBPM[2] .. ")"
		else
			return modifiedBPM[1] .. "-" .. modifiedBPM[2]
		end
	end
end

if not isTopScreen("ScreenJukeboxMenu") and GAMESTATE:IsHumanPlayer(player) then
	return Def.ActorFrame{
		Def.Sprite {
			Texture = "_name frame "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:zoomx(1.75):xy(-205.5,5) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:xy(-280,4):maxwidth(160):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player)) end,
			BeginCommand=function(self) self:settext( GetDisplayNameFromProfileOrMemoryCard(player) ) end
		},
		Def.Sprite {
			Texture = iconName,
			InitCommand=function(self) self:xy(-232,4):shadowlength(2) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:xy(-226,4):maxwidth(260):halign(0):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player))  end,
			BeginCommand=function(self) checkInitBPMs() checkInitSpeedMods() end,
			OnCommand=function(self)
				bpmtext = modifiedBPM(pX,pXmod)
				self:settextf("MOD: %s%s  BPM: %s",pXmod == "x" and pX/100 or pX,pXmod,bpmtext)
			end,
			SpeedChoiceChangedMessageCommand=function(self,param)
				if player == param.pn then
					pX = param.speed
					pXmod = param.mode
					self:playcommand("On")
				end
			end,
			RateChangedMessageCommand=function(self)
				checkInitBPMs()
				self:playcommand("On")
			end
		}
	}
else
	return Def.ActorFrame{}
end