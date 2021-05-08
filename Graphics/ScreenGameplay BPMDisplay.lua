local function UpdateSingleBPM(self)
	local bpmDisplay = self:GetChild("BPMDisplay")
	local pn = GAMESTATE:GetMasterPlayerNumber()
	local pState = GAMESTATE:GetPlayerState(pn)
	local songPosition = pState:GetSongPosition()
	local mods = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
	local rate = mods:MusicRate()
	local bpm = songPosition:GetCurBPS() * 60 * rate
	bpmDisplay:settext( string.format("%03.0f",bpm) )
end

return Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(UpdateSingleBPM) end,
	-- manual bpm display
	LoadFont("_eurostile normal")..{
		Text="BPM",
		InitCommand=function(self) self:shadowlength(1):zoomx(0):zoomy(0):sleep(1.2):accelerate(0.3):zoomx(0.6):zoomy(0.6):sleep(1):decelerate(0.3):zoomx(0):zoomy(3) end;
	};
	LoadFont("_eurostile normal")..{
		Name="BPMDisplay",
		InitCommand=function(self) self:maxwidth(60):shadowlength(1):zoom(0.6):diffusealpha(0):sleep(3):accelerate(0.3):diffusealpha(1) end;
	};
}