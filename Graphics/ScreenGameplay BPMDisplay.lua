local ani

local function UpdateSingleBPM(self)
	if isGamePlay() then
		local p0,p1,p2 = GAMESTATE:GetMasterPlayerNumber(),PLAYER_1,PLAYER_2
		local Single = self:GetChild("Single")
		local bpmDisplaySingle = Single:GetChild("BPMDisplay")
		local bpm0 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(p0) * 60)
		bpmDisplaySingle:settext( bpm0 )
		if GAMESTATE:GetNumPlayersEnabled() > 1 then
			local Versus = self:GetChild("Versus")
			local bpmDisplayVersusP1 = Versus:GetChild("BPMDisplayP1")
			local bpmDisplayVersusP2 = Versus:GetChild("BPMDisplayP2")
			local bpm1 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(p1) * 60)
			local bpm2 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(p2) * 60)
			bpmDisplayVersusP1:settext( bpm1 )
			bpmDisplayVersusP2:settext( bpm2 )
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