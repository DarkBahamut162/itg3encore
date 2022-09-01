local player = ...
assert(player,"[_name/default.lua] requires a player to be passed in.")
local iconName = "_icon p"..(player == PLAYER_1 and 1 or 2)

local pX = 0.0
local pXmod = ""

local song = GAMESTATE:GetCurrentSong()
local course = GAMESTATE:GetCurrentCourse()
local selection = song or course
local bpm1, bpm2

if selection then
	bpm1 = math.floor(selection:GetDisplayBpms()[1])
	bpm2 = math.floor(selection:GetDisplayBpms()[2])
end

local function checkInitSpeedMods()
	local playeroptions = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
	if playeroptions:MMod()			then pX = playeroptions:MMod() pXmod = "m"
	elseif playeroptions:AMod()		then pX = playeroptions:AMod() pXmod = "a"
	elseif playeroptions:CAMod()	then pX = playeroptions:CAMod() pXmod = "ca"
	elseif playeroptions:XMod()		then pX = playeroptions:XMod() * 100 pXmod = "x"
	elseif playeroptions:CMod()		then pX = playeroptions:CMod() pXmod = "C" end
end

local function modifiedBPM(speed,mode)
	local modifiedBPM1 = bpm1
	local modifiedBPM2 = bpm2

	if mode == "x" then
		modifiedBPM1 = bpm1 * speed / 100
		modifiedBPM2 = bpm2 * speed / 100
	elseif mode == "C" then
		modifiedBPM1 = speed
		modifiedBPM2 = speed
	elseif mode == "m" then
		modifiedBPM1 = (bpm1 * speed) / bpm2
		modifiedBPM2 = speed
	elseif mode == "a" then
		local baseAvg = (bpm1 + bpm2) * 0.5
		local mult = speed / baseAvg
		modifiedBPM1 = bpm1 * mult
		modifiedBPM2 = bpm2 * mult
	end

	modifiedBPM1 = math.floor(modifiedBPM1*1000)/1000
	modifiedBPM2 = math.floor(modifiedBPM2*1000)/1000

	if modifiedBPM2 and modifiedBPM1 ~= modifiedBPM2 then
		return modifiedBPM1..' - '..modifiedBPM2
	else
		return modifiedBPM1
	end
end

return Def.ActorFrame{
	LoadActor(THEME:GetPathG("_name","frame"))..{ InitCommand=function(self) self:zoomx(1.75):xy(-205.5,5) end },
	LoadFont("_v 26px bold diffuse")..{
		InitCommand=function(self) self:xy(-280,4):maxwidth(160):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player)) end,
		BeginCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(player) then
				self:settext( GetDisplayNameFromProfileOrMemoryCard(player) )
			end
		end
	},
	LoadActor(iconName)..{ InitCommand=function(self) self:xy(-232,4):shadowlength(2) end },
	LoadFont("_v 26px bold diffuse")..{
		InitCommand=function(self) self:xy(-226,4):maxwidth(260):halign(0):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player)) end,
		BeginCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(player) then
				checkInitSpeedMods()
				bpmtext = modifiedBPM(pX,pXmod)
				self:settextf("MOD: %s%s  BPM: %s",pXmod == "x" and pX/100 or pX,pXmod,bpmtext)
			end
		end,
		SpeedChoiceChangedMessageCommand=function(self,param)
			if GAMESTATE:IsPlayerEnabled(player) and param.pn == player then
				bpmtext = modifiedBPM(param.speed,param.mode)
				self:settextf("MOD: %s%s  BPM: %s",param.mode == "x" and param.speed/100 or param.speed,param.mode,bpmtext)
			end
		end
	}
}