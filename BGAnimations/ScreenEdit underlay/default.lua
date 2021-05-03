return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(Center);
		Def.Sprite{
			Name="SongBackground";
			InitCommand=function(self)
				self:LoadFromSongBackground(GAMESTATE:GetCurrentSong())
				self:FullScreen()
			end;
		};
		LoadActor(THEME:GetPathB("ScreenStageInformation","background/rear"))..{
			InitCommand=cmd(diffusealpha,.98;FullScreen);
		};
		LoadActor(THEME:GetPathB("ScreenStageInformation","background/bottom/lines"))..{
			InitCommand=cmd(FullScreen;diffusealpha,0;);
			OnCommand=cmd(accelerate,0.3;diffusealpha,1);
		};
	};

	LoadActor("bar")..{
		InitCommand=cmd(CenterX;y,SCREEN_TOP+60;zoomtowidth,SCREEN_WIDTH);
	};
	LoadActor("sides")..{
		InitCommand=cmd(x,SCREEN_LEFT;CenterY;horizalign,left;zoomtoheight,SCREEN_HEIGHT);
	};
	LoadActor("infopane")..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y-5;horizalign,right;);
	};
	-- icons (unused for now)

	LoadFont("_r 26px bold glow")..{
		InitCommand=cmd(x,SCREEN_LEFT+76;y,SCREEN_TOP+40;shadowlength,1;settext,"EDITOR");
	};
	LoadActor("difficultyframe")..{
		InitCommand=cmd(x,SCREEN_LEFT+76;y,SCREEN_CENTER_Y-20;pause;playcommand,"Update";zoom,.8;diffusealpha,0;);
		OnCommand=cmd(linear,.3;diffusealpha,1);
		UpdateCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			local state = DifficultyToState(steps:GetDifficulty())
			self:setstate(state)
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Update");
	};
	LoadFont("_r bold glow 30px")..{
		InitCommand=cmd(x,SCREEN_LEFT+76;y,SCREEN_CENTER_Y-20;shadowlength,0;diffusealpha,0.8;zoom,.6;maxwidth,184;playcommand,"Update";);
		UpdateCommand=function(self)
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			self:settext( GetCustomDifficulty(steps:GetStepsType(),steps:GetDifficulty(),nil) );
			self:sleep(0.5)
		end;
		CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Update");
	};
	Def.Banner{
		InitCommand=cmd(x,SCREEN_LEFT+76;y,SCREEN_CENTER_Y-70;diffusealpha,0;ztest,true);
		BeginCommand=function(self)
			self:LoadFromSong(GAMESTATE:GetCurrentSong())
			self:scaletoclipped(136,52)
		end;
		OnCommand=cmd(decelerate,1;y,SCREEN_CENTER_Y-74;diffusealpha,1;);
	};

	-- abridged help
};