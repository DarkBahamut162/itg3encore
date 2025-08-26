return Def.ActorFrame{
	Def.ActorFrame{
		Def.Sprite{
			Name="SongBackground",
			InitCommand=function(self)
				self:LoadFromSongBackground(GAMESTATE:GetCurrentSong())
				self:FullScreen()
			end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenStageInformation","in/rear"),
			InitCommand=function(self) self:diffusealpha(0.98):FullScreen() end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenStageInformation","in/bottom/lines"),
			InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
			OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
		}
	},
	Def.Sprite {
		Texture = "bar",
		InitCommand=function(self) self:CenterX():y((IsGame("be-mu") or IsGame("po-mu")) and SCREEN_BOTTOM-60*WideScreenDiff() or SCREEN_TOP+60*WideScreenDiff()):zoom(WideScreenDiff()):zoomtowidth(SCREEN_WIDTH) end
	},
	Def.Sprite {
		Texture = "sides",
		InitCommand=function(self) self:x(SCREEN_LEFT):CenterY():horizalign(left):zoom(WideScreenDiff()):zoomtoheight(SCREEN_HEIGHT) end
	},
	Def.Sprite {
		Texture = "infopane",
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y-5*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right) end
	},
	Def.BitmapText {
		File = "_r bold glow 30px",
		InitCommand=function(self) self:x(SCREEN_LEFT+76*WideScreenDiff()):y(SCREEN_TOP+40*WideScreenDiff()):zoom(WideScreenDiff()):shadowlength(1):settext("EDITOR") end
	},
	Def.Sprite {
		Texture = "difficultyframe",
		InitCommand=function(self) self:x(SCREEN_LEFT+76*WideScreenDiff()):y(SCREEN_CENTER_Y-20*WideScreenDiff()):pause():playcommand("Update"):zoom(0.8*WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.3):diffusealpha(1) end,
		UpdateCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			if steps then
				local state = DifficultyToState(steps:GetDifficulty())
				self:setstate(state)
			end
		end,
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Update") end
	},
	Def.BitmapText {
		File = "_r bold glow 30px",
		InitCommand=function(self) self:x(SCREEN_LEFT+76*WideScreenDiff()):y(SCREEN_CENTER_Y-20*WideScreenDiff()):shadowlength(0):diffusealpha(0.8):zoom(0.6*WideScreenDiff()):maxwidth(184):playcommand("Update") end,
		UpdateCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			if steps then
				self:settext( GetCustomDifficulty(steps:GetStepsType(),steps:GetDifficulty(),nil) )
				self:sleep(0.5)
			end
		end,
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Update") end
	},
	Def.Banner{
		InitCommand=function(self) self:x(SCREEN_LEFT+76*WideScreenDiff()):y(SCREEN_CENTER_Y-70*WideScreenDiff()):diffusealpha(0):ztest(true) end,
		BeginCommand=function(self)
			self:LoadFromSong(GAMESTATE:GetCurrentSong())
			self:scaletoclipped(136*WideScreenDiff(),52*WideScreenDiff())
		end,
		OnCommand=function(self) self:decelerate(1):y(SCREEN_CENTER_Y-74*WideScreenDiff()):diffusealpha(1) end
	},
	Def.BitmapText {
		File = "_r bold 30px",
		Text="Press F1\nfor commands.\n\nPress Start\nfor the Edit Menu",
		InitCommand=function(self) self:shadowlength(2):zoom(0.6*WideScreenDiff()):x(SCREEN_LEFT+74*WideScreenDiff()):y(SCREEN_BOTTOM-90*WideScreenDiff()) end
	}
}