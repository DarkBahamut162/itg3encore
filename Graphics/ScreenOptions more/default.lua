return Def.ActorFrame{
	LoadActor("_triangle "..(isFinal() and "final" or "normal"))..{
		InitCommand=function(self) self:zoom(0.5*WideScreenDiff()):blend(Blend.Add):x(-38*WideScreenDiff()):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(0.4):effect_hold_at_full(0.6):effectoffset(0.2):effectclock("beat") end,
		ExitSelectedP1Command=function(self) self:stoptweening():linear(0.15):rotationz(-90) end,
		ExitUnselectedP1Command=function(self) self:stoptweening():linear(0.15):rotationz(0) end,
		OffCommand=function(self) self:diffusealpha(1):accelerate(0.6):diffusealpha(0) end
	},
	LoadActor("_triangle "..(isFinal() and "final" or "normal"))..{
		InitCommand=function(self) self:zoom(0.5*WideScreenDiff()):blend(Blend.Add):x(38*WideScreenDiff()):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(0.4):effect_hold_at_full(0.6):effectoffset(0.2):effectclock("beat") end,
		ExitSelectedP2Command=function(self) self:stoptweening():linear(0.15):rotationz(90) end,
		ExitUnselectedP2Command=function(self) self:stoptweening():linear(0.15):rotationz(0) end,
		OffCommand=function(self) self:diffusealpha(1):accelerate(0.6):diffusealpha(0) end
	},
	LoadActor("moreexit")..{
		Condition=not isTopScreen("ScreenSMOnlineLogin"),
		InitCommand=function(self) self:zoom(WideScreenDiff()):y(-19*WideScreenDiff()):croptop(0.57):cropbottom(0.1) end,
		GainFocusCommand=function(self) self:stoptweening():linear(0.15):y(-16*WideScreenDiff()):croptop(0.57):cropbottom(0.1) end,
		LoseFocusCommand=function(self) self:stoptweening():linear(0.15):y(16*WideScreenDiff()):croptop(0.07):cropbottom(0.6) end
	},
	LoadFont("_v 26px bold shadow")..{
		Condition=isTopScreen("ScreenSMOnlineLogin"),
		Text="Login",
		InitCommand=function(self) self:zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(1):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		GainFocusCommand=function(self) self:diffuse(color("#808080")):diffuseshift():effectcolor2(color("#808080")):effectcolor1(color("#FFFFFF")) end,
		LoseFocusCommand=function(self) self:diffuse(color("#808080")):stopeffect() end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:zoom(WideScreenDiff()):x(-188*WideScreenDiff()):y(isTopScreen("ScreenWorkoutMenu") and 22*WideScreenDiff() or (SCREEN_CENTER_Y+112*WideScreenDiff() - THEME:GetMetric(Var "LoadingScreen","MoreY"))) end,
		BeginCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end,
		LoadActor("1 "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(42):diffusealpha(0) end,
			ExitSelectedP1Command=function(self) self:stoptweening():decelerate(0.2):y(52):diffusealpha(1) end,
			ExitUnselectedP1Command=function(self) self:stoptweening():accelerate(0.2):y(42):diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():accelerate(0.1):y(42):diffusealpha(0) end
		},
		LoadActor("_ready "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(51):zoom(0) end,
			ExitSelectedP1Command=function(self) self:stoptweening():zoom(0):bounceend(0.2):zoom(1) end,
			ExitUnselectedP1Command=function(self) self:stoptweening():bouncebegin(0.2):zoom(0) end,
			OffCommand=function(self) self:stoptweening():bouncebegin(0.1):zoom(0) end
		},
		LoadActor("_textglow "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(51):diffusealpha(0) end,
			ExitSelectedP1Command=function(self) self:stoptweening():sleep(0.1):diffusealpha(1):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.3):linear(1):cropleft(1):cropright(-0.3) end,
			ExitUnselectedP1Command=function(self) self:finishtweening():diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():linear(0.1):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathG("","blueflare"))..{
			InitCommand=function(self) self:y(52):diffusealpha(0):zoomx(5):blend(Blend.Add) end,
			ExitSelectedP1Command=function(self) self:stoptweening():zoomy(3):linear(0.1):diffusealpha(1):decelerate(0.3):zoomy(0):diffusealpha(0) end,
			ExitUnselectedP1Command=function(self) self:stoptweening():diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():linear(0.3):diffusealpha(0) end
		},
		LoadActor("2 "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(62):diffusealpha(0) end,
			ExitSelectedP1Command=function(self) self:stoptweening():decelerate(0.2):y(52):diffusealpha(1) end,
			ExitUnselectedP1Command=function(self) self:stoptweening():accelerate(0.2):y(62):diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():accelerate(0.1):y(62):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:zoom(WideScreenDiff()):x(188*WideScreenDiff()):y(isTopScreen("ScreenWorkoutMenu") and 22*WideScreenDiff() or (SCREEN_CENTER_Y+112*WideScreenDiff() - THEME:GetMetric(Var "LoadingScreen","MoreY"))) end,
		BeginCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end,
		LoadActor("3 "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(42):diffusealpha(0) end,
			ExitSelectedP2Command=function(self) self:stoptweening():decelerate(0.2):y(52):diffusealpha(1) end,
			ExitUnselectedP2Command=function(self) self:stoptweening():accelerate(0.2):y(42):diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():accelerate(0.1):y(42):diffusealpha(0) end
		},
		LoadActor("_ready "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(51):zoom(0) end,
			ExitSelectedP2Command=function(self) self:stoptweening():zoom(0):bounceend(0.2):zoom(1) end,
			ExitUnselectedP2Command=function(self) self:stoptweening():bouncebegin(0.2):zoom(0) end,
			OffCommand=function(self) self:stoptweening():bouncebegin(0.1):zoom(0) end
		},
		LoadActor("_textglow "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(51):diffusealpha(0) end,
			ExitSelectedP2Command=function(self) self:stoptweening():sleep(0.1):diffusealpha(1):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.3):linear(1):cropleft(1):cropright(-0.3) end,
			ExitUnselectedP2Command=function(self) self:finishtweening():diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():linear(0.1):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathG("","blueflare"))..{
			InitCommand=function(self) self:y(52):diffusealpha(0):zoomx(5):blend(Blend.Add) end,
			ExitSelectedP2Command=function(self) self:stoptweening():zoomy(3):linear(0.1):diffusealpha(1):decelerate(0.3):zoomy(0):diffusealpha(0) end,
			ExitUnselectedP2Command=function(self) self:stoptweening():diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():linear(0.3):diffusealpha(0) end
		},
		LoadActor("4 "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:y(62):diffusealpha(0) end,
			ExitSelectedP2Command=function(self) self:stoptweening():decelerate(0.2):y(52):diffusealpha(1) end,
			ExitUnselectedP2Command=function(self) self:stoptweening():accelerate(0.2):y(62):diffusealpha(0) end,
			OffCommand=function(self) self:stoptweening():accelerate(0.1):y(62):diffusealpha(0) end
		}
	}
}