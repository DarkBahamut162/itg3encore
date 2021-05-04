return Def.ActorFrame{
	LoadActor(THEME:GetPathB("_fade in","normal"));
	Def.Actor{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75):diffusealpha(1) end;
		OnCommand=function(self) self:sleep(4):linear(.3):diffuse(color("0,0,0,0")):addy(-30) end;
	};
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX() end;
		BeginCommand=function(self)
			-- onepassed
			local stageStats = STATSMAN:GetCurStageStats()
			self:visible( stageStats:OnePassed() )
		end;
		LoadActor(THEME:GetPathB("ScreenGameplay","out/_round"))..{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y-75):zoom(.6):diffusealpha(1) end;
			OnCommand=function(self) self:sleep(.1):linear(.4):diffuse(color("0,0,0,0")):addy(-30) end;
		};
		LoadActor(THEME:GetPathB("ScreenGameplay","out/_cleared bottom"))..{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+15):zoom(.9):diffusealpha(1) end;
			OnCommand=function(self) self:sleep(.1):accelerate(.4):diffuse(color("0,0,0,0")):addx(-100) end;
		};
		LoadActor(THEME:GetPathB("ScreenGameplay","out/_cleared top"))..{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+10):zoom(.9):diffusealpha(1) end;
			OnCommand=function(self) self:sleep(.1):accelerate(.4):diffuse(color("0,0,0,0")):addx(100) end;
		};
	};

	-- cleared/failed text
	Def.ActorFrame{
		Name="Cleared";
		BeginCommand=function(self)
			local stageStats = STATSMAN:GetCurStageStats()
			self:visible( stageStats:OnePassed() )
		end;
		LoadActor("cleared glow")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-240+340):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1) end;
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropleft(1):cropright(-0.3) end;
		};
		LoadActor("cleared text")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-240+340):cropright(1.3):faderight(0.1) end;
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffuse(color("0,0,0,0")) end;
		};
	};
	Def.ActorFrame{
		Name="Failed";
		BeginCommand=function(self)
			local stageStats = STATSMAN:GetCurStageStats()
			self:visible( not stageStats:OnePassed() )
		end;
		LoadActor("failed glow")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-240+340):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1) end;
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropleft(1):cropright(-0.3) end;
		};
		LoadActor("failed text")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-240+340):cropright(1.3):faderight(0.1) end;
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffuse(color("0,0,0,0")) end;
		};
	};
};