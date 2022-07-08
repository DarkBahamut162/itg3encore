local function UpdateSingleBPM(self)
	if SCREENMAN:GetTopScreen():GetName() == 'ScreenGameplay' or SCREENMAN:GetTopScreen():GetName() == 'ScreenDemonstration' then
		local bpmDisplay = self:GetChild("BPMDisplay")
		local pn = GAMESTATE:GetMasterPlayerNumber()
		local truebpm = SCREENMAN:GetTopScreen():GetTrueBPS(pn) * 60
		bpmDisplay:settext( string.format("%03.0f",truebpm) )
	end
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