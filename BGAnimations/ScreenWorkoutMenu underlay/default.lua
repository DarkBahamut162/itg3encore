return Def.ActorFrame{
	OnCommand=function(self) if isOutFox() then GAMESTATE:UpdateDiscordScreenInfo("Selecting Workout","",1) end end,
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay")),
	LoadActor(THEME:GetPathG("_name","badge"),PLAYER_1)..{
		Condition=not GAMESTATE:IsHumanPlayer(PLAYER_1),
		InitCommand=function(self) self:x(SCREEN_CENTER_X+54):addx(SCREEN_WIDTH*3/4):player(PLAYER_1) end,
		OnCommand=function(self) self:sleep(0.1):decelerate(0.3):addx(-SCREEN_WIDTH*3/4) end,
		OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end
	},
	LoadActor(THEME:GetPathG("_name","badge"),PLAYER_2)..{
		Condition=not GAMESTATE:IsHumanPlayer(PLAYER_2),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-54*1.25+SCREEN_WIDTH/2):addx(SCREEN_WIDTH*3/4):player(PLAYER_2) end,
		OnCommand=function(self) self:sleep(0.2):decelerate(0.3):addx(-SCREEN_WIDTH*3/4) end,
		OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end
	},
	Def.ActorFrame{
		OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.3):addx(SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end,
		LoadActor("player-frame")..{
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
			OnCommand=function(self) self:x(SCREEN_CENTER_X-146):y(SCREEN_CENTER_Y-60) end
		},
		LoadActor("2player-frame")..{
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
			OnCommand=function(self) self:x(SCREEN_CENTER_X+146):y(SCREEN_CENTER_Y-60) end
		},
		LoadFont("_v credit")..{
			Condition=not GAMESTATE:IsHumanPlayer(PLAYER_1),
			InitCommand=function(self)
				self:xy(SCREEN_CENTER_X-146,SCREEN_CENTER_Y-70):diffuseshift():effectcolor1(0.8,0.8,0.8,1):effectcolor2(0.4,0.4,0.4,1):effectperiod(2):settext("Not Present"):diffusealpha(0)
			end
		},
		LoadFont("_v credit")..{
			Condition=not GAMESTATE:IsHumanPlayer(PLAYER_2),
			InitCommand=function(self)
				self:xy(SCREEN_CENTER_X+146,SCREEN_CENTER_Y-70):diffuseshift():effectcolor1(0.8,0.8,0.8,1):effectcolor2(0.4,0.4,0.4,1):effectperiod(2):settext("Not Present"):diffusealpha(0)
			end
		},
		LoadActor("shared-frame")..{
			OnCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+36) end
		},
		LoadActor("explanation-frame")..{
			OnCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+118) end
		}
	}
}