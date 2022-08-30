return Def.ActorFrame{
	LoadFont("_z bold gray 36px")..{
		Text="SINGLE SCORE SUMMARY",
		InitCommand=function(self) self:x(SCREEN_RIGHT-20):y(SCREEN_TOP+28):shadowlength(2):horizalign(right):zoom(0.5):cropright(1.3):faderight(0.1) end,
		OnCommand=function(self) self:sleep(0.2):linear(0.8):cropright(-0.3) end
	}
}