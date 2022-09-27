return Def.ActorFrame{
	LoadFont("_z bold gray 36px")..{
		Text="FITNESS OPTIONS",
		InitCommand=function(self) self:x(SCREEN_RIGHT-20):y(SCREEN_TOP+28):shadowlength(2):horizalign(right):zoom(0.5):cropright(1.3):faderight(0.1) end,
		OnCommand=function(self) self:sleep(0.2):linear(0.8):cropright(-0.3) end,
		OffCommand=function(self) self:accelerate(0.2):zoomx(1.5):zoomy(0):diffusealpha(0) end
	}
}