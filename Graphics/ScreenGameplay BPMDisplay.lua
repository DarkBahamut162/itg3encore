local ani

local scrolls = {[PLAYER_1]=nil,[PLAYER_2]=nil}
local scroll = {[PLAYER_1]=1,[PLAYER_2]=1}
local speeds = {[PLAYER_1]=nil,[PLAYER_2]=nil}
local speed = {[PLAYER_1]=1,[PLAYER_2]=1}

function repopulate()
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		local StepsOrTrail
		if GAMESTATE:IsCourseMode() then
			local trail = GAMESTATE:GetCurrentTrail(pn):GetTrailEntries()[GAMESTATE:GetCourseSongIndex()+1]
			StepsOrTrail = trail:GetSteps()
		else
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
		end
		local timingData = StepsOrTrail:GetTimingData()
		scrolls[pn] = timingData:GetScrolls()
		speeds[pn] = timingData:GetSpeeds()
		scroll[pn] = 1
		speed[pn] = 1
	end
end

local function UpdateSingleBPM(self)
	if isGamePlay() then
		local p0,p1,p2 = GAMESTATE:GetMasterPlayerNumber(),PLAYER_1,PLAYER_2
		local currentBeat = GAMESTATE:GetPlayerState(p0):GetSongPosition():GetSongBeat()
		local Single = self:GetChild("Single")
		local bpmDisplaySingle = Single:GetChild("BPMDisplay")
		if ThemePrefs.Get("AddScrollSpeed") then
			local update = false
			if scrolls[p0] and #scrolls[p0] > 0 then
				update,temp,scrolls[p0] = GetScrollAtBeat(currentBeat,scrolls[p0])
				if update then scroll[p0] = temp end
			end
			if speeds[p0] and #speeds[p0] > 0 then
				update,temp,speeds[p0] = GetSpeedAtBeat(p0,currentBeat,speeds[p0])
				if update then speed[p0] = temp end
			end
		end
		local bpm0 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(p0)*60*scroll[p0]*speed[p0])
		bpmDisplaySingle:settext(bpm0)
		if GAMESTATE:GetNumPlayersEnabled() > 1 then
			local Versus = self:GetChild("Versus")
			local bpmDisplayVersusP1 = Versus:GetChild("BPMDisplayP1")
			local bpmDisplayVersusP2 = Versus:GetChild("BPMDisplayP2")
			if ThemePrefs.Get("AddScrollSpeed") then
				local update = {[PLAYER_1]=false,[PLAYER_2]=false}
				local currentBeatP1 = GAMESTATE:GetPlayerState(p1):GetSongPosition():GetSongBeat()
				if scrolls[p1] and #scrolls[p1] > 0 then
					update[p1],temp,scrolls[p1] = GetScrollAtBeat(currentBeatP1,scrolls[p1])
					if update[p1] then scroll[p1] = temp end
				end
				if speeds[p1] and #speeds[p1] > 0 then
					update[p1],temp,speeds[p1] = GetSpeedAtBeat(p1,currentBeatP1,speeds[p1])
					if update[p1] then speed[p1] = temp end
				end
				local currentBeatP2 = GAMESTATE:GetPlayerState(p2):GetSongPosition():GetSongBeat()
				if scrolls[p2] and #scrolls[p2] > 0 then
					update[p2],temp,scrolls[p2] = GetScrollAtBeat(currentBeatP2,scrolls[p2])
					if update[p2] then scroll[p2] = temp end
				end
				if speeds[p2] and #speeds[p2] > 0 then
					update[p2],temp,speeds[p2] = GetSpeedAtBeat(p2,currentBeatP2,speeds[p2])
					if update[p2] then speed[p2] = temp end
				end
			end
			local bpm1 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(p1)*60*scroll[p1]*speed[p1])
			local bpm2 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(p2)*60*scroll[p2]*speed[p2])
			bpmDisplayVersusP1:settext(bpm1)
			bpmDisplayVersusP2:settext(bpm2)
			if bpm1 ~= bpm2 and not ani then
				ani = true
				Single:stoptweening():sleep(0):linear(0.0625):zoomx(0)
				Versus:stoptweening():sleep(0.0625):linear(0.0625):zoomx(1)
			elseif bpm1 == bpm2 and ani then
				ani = false
				Single:stoptweening():sleep(0.0625):linear(0.0625):zoomx(1)
				Versus:stoptweening():sleep(0):linear(0.0625):zoomx(0)
			end
		end
	end
end

return Def.ActorFrame{
	DoneLoadingNextSongMessageCommand=function() if ThemePrefs.Get("AddScrollSpeed") then repopulate() end end,
	InitCommand=function(self) self:SetUpdateFunction(UpdateSingleBPM) end,
	Def.BitmapText {
		File = "_eurostile normal",
		Text="BPM",
		InitCommand=function(self) self:shadowlength(1):zoomx(0):zoomy(0.6):sleep(1):accelerate(0.25):zoomx(0.6):sleep(1):decelerate(0.25):zoomx(0) end
	},
	Def.ActorFrame{
		Name="Single",
		Def.BitmapText {
			File = "_eurostile normal",
			Name="BPMDisplay",
			InitCommand=function(self) self:maxwidth(60):shadowlength(1):zoom(0.6):diffusealpha(0):sleep(2.5):accelerate(0.25):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Name="Versus",
		InitCommand=function(self) self:zoomx(0) end,
		Def.BitmapText {
			File = "_eurostile normal",
			Name="BPMDisplayP1",
			InitCommand=function(self) self:x(-22.5):maxwidth(60):shadowlength(1):zoom(0.6):diffusealpha(0):sleep(2.5):accelerate(0.25):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="|",
			InitCommand=function(self) self:x(0):shadowlength(1):zoom(0.6):diffusealpha(0):sleep(2.5):accelerate(0.25):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Name="BPMDisplayP2",
			InitCommand=function(self) self:x(22.5):maxwidth(60):shadowlength(1):zoom(0.6):diffusealpha(0):sleep(2.5):accelerate(0.25):diffusealpha(1) end
		}
	}
}