return Def.ActorFrame{
	InitCommand=function(self) self:spin():effectmagnitude(0,90,0) end;
	LoadActor(THEME:GetPathG("_platform","single"))..{
		InitCommand=function(self) self:x(80):cullmode('CullMode_Back') end;
	};
	LoadActor(THEME:GetPathG("_platform","single/flipped"))..{
		InitCommand=function(self) self:x(-80):zoomx(-1):cullmode('CullMode_Front') end;
	};
};