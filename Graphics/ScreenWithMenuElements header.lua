return Def.ActorFrame{
	loadfile( THEME:GetPathG("_dynamic","headers"))( Var "LoadingScreen" )..{
		Condition=not isFinal(),
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,30*WideScreenDiff()) end,
		OnCommand=function(self) self:zoom(1.3*WideScreenDiff()) end
	},
	Def.BitmapText {
		File = "_z bold gray 36px",
		InitCommand=function(self)
			self:x(isFinal() and SCREEN_CENTER_X or SCREEN_RIGHT-20*WideScreenDiff_(16/10)):y(isFinal() and 32*WideScreenDiff_(16/10) or 28*WideScreenDiff()):shadowlength(2):halign(isFinal() and 0.5 or 1)
			:zoom(isFinal() and 0.5*WideScreenDiff_(16/10) or 0.5*WideScreenDiff()):cropright(1.3):faderight(0.1):settext(THEME:GetString(Var "LoadingScreen","HeaderText"))
			if isFinal() then self:wrapwidthpixels(600) end
		end,
		OnCommand=function(self) self:sleep(0.2):linear(0.8):cropright(-0.3) end
	}
}