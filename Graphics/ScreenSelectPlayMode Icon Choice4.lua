return Def.ActorFrame{
	OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
	LoadFont("_r bold glow 30px")..{
		Text="Beat the clock by stepping\naccurately with modifiers",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-55-34):y(SCREEN_CENTER_Y+125):zoomx(0.8):zoomy(0.7):maxwidth(300):shadowlength(0) end,
		GainFocusCommand=function(self) self:visible(true):finishtweening():cropright(1):linear(0.5):cropright(0) end,
		LoseFocusCommand=function(self) self:visible(false) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y+155):horizalign(right) end,
		LoadActor(THEME:GetPathG("_join","icons/title4"))..{
			OnCommand=function(self) self:x(SCREEN_RIGHT-116):y(-3):zoomto(155,80) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(SCREEN_RIGHT-136) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(SCREEN_RIGHT-116) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		LoadActor(THEME:GetPathG("_join","icons/survival_icon"))..{
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(SCREEN_RIGHT-130) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(SCREEN_RIGHT-110) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		LoadActor(THEME:GetPathG("_join","icons/gameglow"))..{
			InitCommand=function(self) self:blend(Blend.Add) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffusealpha(1):x(SCREEN_RIGHT-130):sleep(0.07):linear(0.2):diffusealpha(0) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):x(SCREEN_RIGHT-110):diffusealpha(0) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		}
	}
}