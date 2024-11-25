return Def.ActorFrame{
	OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
	Def.BitmapText {
		File = "_r bold glow 30px",
		Text="One Player uses 8 Panels",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+125+12*WideScreenSemiDiff()):zoom(0.68*WideScreenDiff()):maxwidth(840):shadowlength(0) end,
		GainFocusCommand=function(self) self:visible(true):finishtweening():cropright(1):linear(0.5):cropright(0) end,
		LoseFocusCommand=function(self) self:visible(false) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_LEFT+111*WideScreenDiff()):y(SCREEN_CENTER_Y-95+240):horizalign(left) end,
		Def.Sprite {
			Texture = THEME:GetPathG("_join","icons/choice3"),
			OnCommand=function(self) self:y(-2):zoomto(150*WideScreenDiff(),110*WideScreenDiff()) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(26*WideScreenDiff()) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(6*WideScreenDiff()) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_join","icons/double_icon"),
			InitCommand=function(self) self:zoom(WideScreenDiff()) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffuse(color("#FFFFFF")):x(20*WideScreenDiff()) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(0) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_join","icons/styleglow"),
			InitCommand=function(self) self:zoom(WideScreenDiff()):blend(Blend.Add) end,
			GainFocusCommand=function(self) self:accelerate(0.1):diffusealpha(1):x(20*WideScreenDiff()):sleep(0.07):linear(0.2):diffusealpha(0) end,
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):x(0):diffusealpha(0) end,
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end
		}
	}
}