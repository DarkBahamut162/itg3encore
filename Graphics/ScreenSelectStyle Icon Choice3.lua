return Def.ActorFrame{
	LoadFont("_r bold glow 30px")..{
		Text="One Player uses 8 Panels",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100):y(SCREEN_CENTER_Y+138):zoom(0.68):maxwidth(840):horizalign(center):shadowlength(0) end,
		GainFocusCommand=function(self) self:visible(true):finishtweening():cropright(1):linear(0.5):cropright(0) end,
		LoseFocusCommand=function(self) self:visible(false) end,
		OffCommand=function(self) self:linear(0.3):diffusealpha(0) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_LEFT+65):y(SCREEN_CENTER_Y-95+240):horizalign(left) end,
		LoadActor(THEME:GetPathG("_join","icons/choice3"))..{
			OnCommand=function(self) self:y(-2):zoomto(150,110) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(52+19) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(52) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		LoadActor(THEME:GetPathG("_join","icons/double_icon"))..{
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(SCREEN_LEFT+65) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(SCREEN_LEFT+46) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		LoadActor(THEME:GetPathG("_join","icons/styleglow"))..{
			InitCommand=function(self) self:blend(Blend.Add) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffusealpha(1):x(SCREEN_LEFT+65):sleep(0.07):linear(0.2):diffusealpha(0) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):x(SCREEN_LEFT+46):diffusealpha(0) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		}
	}
}