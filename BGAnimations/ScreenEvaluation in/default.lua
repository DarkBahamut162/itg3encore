return Def.ActorFrame{
	LoadActor(THEME:GetPathB("_fade in","normal")),
	Def.Actor{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75):diffusealpha(1) end,
		OnCommand=function(self) self:sleep(4):linear(0.3):diffuse(color("0,0,0,0")):addy(-30) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX() end,
		BeginCommand=function(self) self:visible( STATSMAN:GetCurStageStats():OnePassed() ) end,
		LoadActor(THEME:GetPathB("ScreenGameplay out/_round",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(1) end,
			OnCommand=function(self) self:sleep(0.1):linear(0.4):diffusealpha(0):addy(-30) end
		},
		LoadActor(THEME:GetPathB("ScreenGameplay out/_cleared bottom",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+15*WideScreenDiff()):zoom(0.9*WideScreenDiff()):diffusealpha(1) end,
			OnCommand=function(self) self:sleep(0.1):accelerate(0.4):diffusealpha(0):addx(-100) end
		},
		LoadActor(THEME:GetPathB("ScreenGameplay out/_cleared top",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+10*WideScreenDiff()):zoom(0.9*WideScreenDiff()):diffusealpha(1) end,
			OnCommand=function(self) self:sleep(0.1):accelerate(0.4):diffusealpha(0):addx(100) end
		}
	},
	Def.ActorFrame{
		Name="Cleared",
		BeginCommand=function(self) self:visible( STATSMAN:GetCurStageStats():OnePassed() ) end,
		LoadActor("cleared glow "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropleft(1):cropright(-0.3) end
		},
		LoadActor("cleared text "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Name="Failed",
		BeginCommand=function(self) self:visible( not STATSMAN:GetCurStageStats():OnePassed() ) end,
		LoadActor("failed glow "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropleft(1):cropright(-0.3) end
		},
		LoadActor("failed text "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(WideScreenDiff()):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.35):linear(0.7):cropright(-0.3):sleep(1.95):linear(0.3):diffusealpha(0) end
		}
	}
}