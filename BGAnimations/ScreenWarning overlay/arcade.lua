return Def.ActorFrame{
	loadfile(THEME:GetPathG("_platform","double"))()..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100):zoom(1.4*WideScreenDiff()):fov(90) end,
		OnCommand=function(self) self:spin():effectmagnitude(0,60,0) end
	}
}