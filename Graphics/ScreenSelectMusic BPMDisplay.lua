local BPMtype = ThemePrefs.Get("ShowBPMDisplayType")
local course = GAMESTATE:IsCourseMode()

local function getBPMs(step)
	local bpms = BPMtype == 0 and step:GetDisplayBpms() or step:GetTimingData():GetActualBPM()
	bpms[1]=math.round(bpms[1])
	bpms[2]=math.round(bpms[2])

	return bpms
end

local function getBPMRange(self,step)
	local bpms = getBPMs(step)
	if BPMtype == 0 and (step:IsDisplayBpmRandom() or step:IsDisplayBpmSecret()) then
		self:diffuse(color("#ffffff"))
		return "..."
	elseif bpms[1] == bpms[2] then
		self:diffuse(color("#ffffff"))
		return bpms[1]
	else
		self:diffuse(color("#d8f6ff"))
		return table.concat(bpms,"-")
	end
end

local function getTrueBPMs(song,step)
	local bpms = {}
	if isOutFox() then
		local truebpms = step:GetTimingData():GetActualBPM()
		bpms[1]=math.round(truebpms[1])
		bpms[2]=math.round(truebpms[2])
		bpms[3]=math.round(tonumber(LoadFromCache(song,step,"TrueMaxBPM")))
	else
		bpms = getTrueBPMsCalculated(song,step)
		bpms[1]=math.round(bpms[1])
		bpms[2]=math.round(bpms[2])
	end

	return bpms
end

local function getTrueBPMRange(self,song,step)
	local bpms = getTrueBPMs(song,step)

	if bpms[1] == bpms[2] and bpms[2] == bpms[3] then
		self:diffuse(color("#ffffff"))
		return bpms[1]
	elseif bpms[3] == bpms[1] or bpms[3] == 0 then
		if bpms[1] ~= bpms[2] then
			self:diffuse(color("#d8f6ff"))
			return bpms[1] .. " (" .. bpms[2] .. ")"
		else
			self:diffuse(color("#ffffff"))
			return bpms[1]
		end
	elseif bpms[3] < bpms[2] then
		self:diffuse(color("#d8f6ff"))
		return bpms[1] .. "-" .. bpms[3] .. " (" .. bpms[2] .. ")"
	else
		self:diffuse(color("#d8f6ff"))
		return bpms[1] .. "-" .. bpms[2]
	end
end

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		Text="BPM:",
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()):halign(1) end
	},
	Def.BPMDisplay{
		Name="BPMDisplay",
		Font="BPMDisplay bpm",
		InitCommand=function(self) self:halign(1):zoom(0.66*WideScreenDiff()):maxwidth(120):maxheight(32):vertspacing(-10) end,
		SetCommand=function(self)
			if GAMESTATE:IsCourseMode() then self:SetFromGameState() else
				local output = ""
				self:settext(output)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					local temp = {}
					for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
						local step = GAMESTATE:GetCurrentSteps(pn)
						if step then temp[pn] = BPMtype == 2 and getTrueBPMRange(self,song,step) or getBPMRange(self,step) end
					end
					if temp[PLAYER_1] and temp[PLAYER_2] then
						if temp[PLAYER_1] == temp[PLAYER_2] then
							self:settext(temp[PLAYER_1])
						else
							output = temp[PLAYER_1].."\n"..temp[PLAYER_2]
							self:settext(output):diffuse(PlayerColor(PLAYER_2)):AddAttribute(0, {
								Length = string.len(temp[PLAYER_1]),
								Diffuse = PlayerColor(PLAYER_1),
							})
						end
					elseif temp[PLAYER_1] or temp[PLAYER_2] then
						self:settext(temp[GAMESTATE:GetMasterPlayerNumber()])
					end
				end
			end
		end,
		CurrentSongChangedMessageCommand=function(self) if not course then self:playcommand("Set") end end,
		CurrentCourseChangedMessageCommand=function(self) if course then self:playcommand("Set") end end,
		CurrentStepsP1ChangedMessageCommand=function(self) if not course then self:playcommand("Set") end end,
		CurrentStepsP2ChangedMessageCommand=function(self) if not course then self:playcommand("Set") end end,
		CurrentTrailP1ChangedMessageCommand=function(self) if course then self:playcommand("Set") end end,
		CurrentTrailP2ChangedMessageCommand=function(self) if course then self:playcommand("Set") end end
	}
}