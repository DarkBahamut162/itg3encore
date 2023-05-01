return Def.ActorFrame{
	OnCommand=function(self) if isOutFox() then GAMESTATE:UpdateDiscordScreenInfo("Selecting Workout","",1) end end,
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay")),
	Def.ActorFrame{
		OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end,
		LoadActor("player-frame")..{
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
			OnCommand=function(self) self:x(SCREEN_CENTER_X-146*WideScreenDiff()):y(SCREEN_CENTER_Y-60*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		LoadActor("2player-frame")..{
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
			OnCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_CENTER_Y-60*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		LoadFont("_v credit")..{
			Condition=not GAMESTATE:IsHumanPlayer(PLAYER_1),
			InitCommand=function(self)
				self:xy(SCREEN_CENTER_X-146*WideScreenDiff(),SCREEN_CENTER_Y-70*WideScreenDiff()):zoom(WideScreenDiff()):diffuseshift():effectcolor1(0.8,0.8,0.8,1):effectcolor2(0.4,0.4,0.4,1):effectperiod(2):settext("Not Present"):diffusealpha(0)
			end
		},
		LoadFont("_v credit")..{
			Condition=not GAMESTATE:IsHumanPlayer(PLAYER_2),
			InitCommand=function(self)
				self:xy(SCREEN_CENTER_X+146*WideScreenDiff(),SCREEN_CENTER_Y-70*WideScreenDiff()):zoom(WideScreenDiff()):diffuseshift():effectcolor1(0.8,0.8,0.8,1):effectcolor2(0.4,0.4,0.4,1):effectperiod(2):settext("Not Present"):diffusealpha(0)
			end
		},
		LoadActor("shared-frame")..{
			OnCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+36*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		LoadActor("explanation-frame")..{
			OnCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+118*WideScreenDiff()):zoom(WideScreenDiff()) end
		}
	}
}