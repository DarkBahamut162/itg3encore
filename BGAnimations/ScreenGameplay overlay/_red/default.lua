local function UpdateSingleBPM(self)
	if isGamePlay() then
		local bpmDisplay = self:GetChild("BPMDisplay")
		local bpm0 = string.format("%03.0f",SCREENMAN:GetTopScreen():GetTrueBPS(GAMESTATE:GetMasterPlayerNumber()) * 60)
		bpmDisplay:settext( bpm0 )
	end
end

return Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(UpdateSingleBPM) end,
	Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_ONLY_P1"))()..{
			InitCommand=function(self) self:x(0):y(0) end,
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2)
		},
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_ONLY_P2"))()..{
			InitCommand=function(self) self:x(0):y(0) end,
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1)
		},
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_VERSUS"))()..{
			InitCommand=function(self) self:x(0):y(0) end,
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1) == GAMESTATE:IsPlayerEnabled(PLAYER_2)
		},
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_BANNER"))()..{
			InitCommand=function(self) self:CenterX():y(SCREEN_HEIGHT-44):zoom(WideScreenDiff()) end
		}
	},
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_LIFE_P1"))()..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-181*WideScreenDiff()):y(22*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_LIFE_P2"))()..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+181*WideScreenDiff()):y(22*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenGameplay","overlay/_red/BPM"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X+1*WideScreenDiff()):y(31*WideScreenDiff()):zoom(WideScreenDiff()) end
	},
	Def.BitmapText {
		File=THEME:GetPathF("_iidx/Gameplay", "BPM Blue"),
		Name="BPMDisplay",
		InitCommand=function(self)  self:x(SCREEN_CENTER_X+2*WideScreenDiff()):y(88*WideScreenDiff()):diffusealpha(1):maxwidth(15*3):zoom(WideScreenDiff()) end
	},
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/DIFFICULTY"))(GAMESTATE:GetMasterPlayerNumber())..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-336*WideScreenDiff()):y(-20) end
	},
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/STAGE"))()..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-302*WideScreenDiff()):y(-17) end
	},
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/TIME_DISPLAY"))()..{
		InitCommand=function(self) self:CenterX():y(18*WideScreenDiff()):zoom(WideScreenDiff()) end
	}
}
