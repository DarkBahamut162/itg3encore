return Def.ActorFrame{
	OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
	LoadFont("_r bold glow 30px")..{
		Text="Beat the clock by stepping\naccurately with modifiers",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-102*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+125*WideScreenSemiDiff()):zoomx(0.8*WideScreenDiff()):zoomy(0.7*WideScreenDiff()):maxwidth(369):shadowlength(0) end,
		GainFocusCommand=function(self) self:visible(true):finishtweening():cropright(1):linear(0.5):cropright(0) end,
		LoseFocusCommand=function(self) self:visible(false) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_RIGHT-110*WideScreenDiff()):y(SCREEN_CENTER_Y+155):horizalign(right) end,
		LoadActor(THEME:GetPathG("_join","icons/title4"))..{
			OnCommand=function(self) self:y(-3):zoomto(155*WideScreenDiff(),80*WideScreenDiff()) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(-26*WideScreenDiff()) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(-6*WideScreenDiff()) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		LoadActor(THEME:GetPathG("_join","icons/survival_icon"))..{
			InitCommand=function(self) self:zoom(WideScreenDiff()) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(-20*WideScreenDiff()) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(0) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		LoadActor(THEME:GetPathG("_join","icons/gameglow"))..{
			InitCommand=function(self) self:zoom(WideScreenDiff()):blend(Blend.Add) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffusealpha(1):x(-20*WideScreenDiff()):sleep(0.07):linear(0.2):diffusealpha(0) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):x(0):diffusealpha(0) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		}
	}
}