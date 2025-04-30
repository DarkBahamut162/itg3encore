local pX = {}
local pXmod = {}
local timingdata = {}
local bpm = {}
local currentBPM = {}
local absoluteBPM = {}
local BPMtype = IsGame("pump") and 0 or ThemePrefs.Get("ShowBPMDisplayType")
local courseMode = GAMESTATE:IsCourseMode()

local function checkInitBPMs(pn)
	if GAMESTATE:IsCourseMode() then
		local trail = GAMESTATE:GetCurrentTrail(pn)
		if trail then
			local entries = trail:GetTrailEntries()
			for i=1, #entries do
				local song = entries[i]:GetSong()
				local step = entries[i]:GetSteps()
				timingdata[pn] = step:GetTimingData()
				bpm[pn] = getAllTheBPMs(song,step,BPMtype)
				absoluteBPM[pn] = timingdata:GetActualBPM()
				if i == 1 then
					currentBPM[pn] = {bpm[pn][1],bpm[pn][2],bpm[pn][3]}
				else
					if bpm[pn][1] < currentBPM[pn][1] then currentBPM[pn][1] = bpm[pn][1] end
					if bpm[pn][2] > currentBPM[pn][2] then currentBPM[pn][2] = bpm[pn][2] end
					if bpm[pn][3] > currentBPM[pn][3] then currentBPM[pn][3] = bpm[pn][3] end
				end
			end
		end
	else
		local step = GAMESTATE:GetCurrentSteps(pn)
		if step then
			local song = GAMESTATE:GetCurrentSong()
			timingdata[pn] = step:GetTimingData()
			bpm[pn] = getAllTheBPMs(song,step,BPMtype)
			absoluteBPM[pn] = step:GetTimingData():GetActualBPM()
			currentBPM[pn] = {bpm[pn][1],bpm[pn][2],bpm[pn][3]}
		end
	end
end

local function checkInitSpeedMods(pn)
	local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
	if playeroptions:XMod()						then pX[pn] = playeroptions:XMod()*100 pXmod[pn] = "x" end
	if playeroptions:CMod()						then pX[pn] = playeroptions:CMod() pXmod[pn] = "C" end
	if playeroptions:MMod()						then pX[pn] = playeroptions:MMod() pXmod[pn] = "m" end
	if isOutFox() and playeroptions:AMod()		then pX[pn] = playeroptions:AMod() pXmod[pn] = "a" end
	if isOutFox() and playeroptions:CAMod()		then pX[pn] = playeroptions:CAMod() pXmod[pn] = "ca" end
	if isOutFox() and playeroptions:AVMod()		then pX[pn] = playeroptions:AVMod() pXmod[pn] = "av" end
end

local function modifiedBPM(pn,speed,mode)
	local modifiedBPM = {0,0,0}
	if not currentBPM[pn] then return "" end
	if mode == "x" then
		modifiedBPM[1] = currentBPM[pn][1] * speed / 100
		modifiedBPM[2] = currentBPM[pn][2] * speed / 100
		modifiedBPM[3] = currentBPM[pn][3] * speed / 100
	elseif mode == "C" then
		modifiedBPM[1] = speed
		modifiedBPM[2] = speed
		modifiedBPM[3] = speed
	elseif mode == "m" then
        local max = tonumber(THEME:GetMetric('Player', 'MModHighCap'))
        if absoluteBPM[pn][2] > max then
            speed = speed / max
        else
            speed = speed / absoluteBPM[pn][2]
        end
		modifiedBPM[1] = currentBPM[pn][1] * speed
		modifiedBPM[2] = currentBPM[pn][2] * speed
		modifiedBPM[3] = currentBPM[pn][3] * speed
	elseif mode == "a" or mode == "ca" or mode == "av" then
		local baseAvg = (absoluteBPM[pn][1] + absoluteBPM[pn][2]) * 0.5
		local mult = speed / baseAvg
		modifiedBPM[1] = currentBPM[pn][1] * mult
		modifiedBPM[2] = currentBPM[pn][2] * mult
		modifiedBPM[3] = currentBPM[pn][3] * mult
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

return Def.ActorFrame{
	Def.BitmapText {
		File = "_v 26px bold white",
		Text="MOD:",
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()):halign(1) end
	},
	Def.BitmapText {
		Font="BPMDisplay bpm",
		InitCommand=function(self) self:halign(1):zoom(0.66*WideScreenDiff()):maxwidth(120):maxheight(32):vertspacing(-10):playcommand("Set") end,
		SetCommand=function(self)
			local output = ""
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				checkInitBPMs(pn)
				checkInitSpeedMods(pn)
				output = addToOutput(output,pXmod[pn]..(pXmod[pn] == "x" and pX[pn]/100 or pXmod[pn] == "C" and "" or pX[pn]).."|"..modifiedBPM(pn,pX[pn],pXmod[pn]),"\n")
			end
			self:settext(output)
		end,
		RateChangedMessageCommand=function(self) self:playcommand("Set") end,
		SpeedChoiceChangedMessageCommand=function(self,param)
			pXmod[param.pn] = param.mode
			pX[param.pn] = param.speed
			if pXmod[param.pn] == "x" then
				setX(pX[param.pn],param.pn)
			elseif pXmod[param.pn] == "c" then
				setC(pX[param.pn],param.pn)
			elseif pXmod[param.pn] == "m" then
				setM(pX[param.pn],param.pn)
			elseif pXmod[param.pn] == "a" then
				setA(pX[param.pn],param.pn)
			elseif pXmod[param.pn] == "ca" then
				setCA(pX[param.pn],param.pn)
			elseif pXmod[param.pn] == "av" then
				setAV(pX[param.pn],param.pn)
			end
			local output = ""
			for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
				output = addToOutput(output,pXmod[pn]..(pXmod[pn] == "x" and pX[pn]/100 or pXmod[pn] == "C" and "" or pX[pn]).."|"..modifiedBPM(pn,pX[pn],pXmod[pn]),"\n")
			end
			self:settext(output)
		end,
		EmptyCommand=function(self) self:settext("") end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if not GAMESTATE:GetCurrentSong() then self:playcommand("Empty") end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if not GAMESTATE:GetCurrentCourse() then self:playcommand("Empty") end end end,
		CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentTrailP1ChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
		CurrentTrailP2ChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end
	}
}