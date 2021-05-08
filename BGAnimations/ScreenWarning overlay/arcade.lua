return Def.ActorFrame{
	LoadActor(THEME:GetPathG("_platform","double"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+100):zoom(1.4):fov(90) end;
		OnCommand=function(self) self:spin():effectmagnitude(0,60,0) end;
	};
};