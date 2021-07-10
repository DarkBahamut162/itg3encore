return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:Center() end;
		Def.Sprite{
			Name="SongBackground";
			InitCommand=function(self)
				self:LoadFromSongBackground(GAMESTATE:GetCurrentSong())
				self:FullScreen()
			end;
		};
		LoadActor(THEME:GetPathB("ScreenStageInformation","in/rear"))..{
			InitCommand=function(self) self:diffusealpha(0.98):FullScreen() end;
		};
		LoadActor(THEME:GetPathB("ScreenStageInformation","in/bottom/lines"))..{
			InitCommand=function(self) self:FullScreen():diffusealpha(0) end;
			OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end;
		};
	};

	LoadActor("bar")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+60):zoomtowidth(SCREEN_WIDTH) end;
	};
	LoadActor("sides")..{
		InitCommand=function(self) self:x(SCREEN_LEFT):CenterY():horizalign(left):zoomtoheight(SCREEN_HEIGHT) end;
	};
	LoadActor("infopane")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y-5):horizalign(right) end;
	};
	-- icons (unused for now)

	LoadFont("_r 26px bold glow")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+76):y(SCREEN_TOP+40):shadowlength(1):settext("EDITOR") end;
	};
	LoadActor("difficultyframe")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+76):y(SCREEN_CENTER_Y-20):pause():playcommand("Update"):zoom(0.8):diffusealpha(0) end;
		OnCommand=function(self) self:linear(0.3):diffusealpha(1) end;
		UpdateCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			local state = DifficultyToState(steps:GetDifficulty())
			self:setstate(state)
		end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Update") end;
	};
	LoadFont("_r bold glow 30px")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+76):y(SCREEN_CENTER_Y-20):shadowlength(0):diffusealpha(0.8):zoom(0.6):maxwidth(184):playcommand("Update") end;
		UpdateCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			self:settext( GetCustomDifficulty(steps:GetStepsType(),steps:GetDifficulty(),nil) );
			self:sleep(0.5)
		end;
		CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Update") end;
	};
	Def.Banner{
		InitCommand=function(self) self:x(SCREEN_LEFT+76):y(SCREEN_CENTER_Y-70):diffusealpha(0):ztest(true) end;
		BeginCommand=function(self)
			self:LoadFromSong(GAMESTATE:GetCurrentSong())
			self:scaletoclipped(136,52)
		end;
		OnCommand=function(self) self:decelerate(1):y(SCREEN_CENTER_Y-74):diffusealpha(1) end;
	};

	-- abridged help
};