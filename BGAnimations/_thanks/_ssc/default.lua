return Def.ActorFrame{
	Def.Model{
		Materials="logo.txt";
		Meshes="logo.txt";
		Bones="logo.txt";
		InitCommand=function(self) self:y(5):zoom(2.5):rotationx(90) end;
		OnCommand=function(self) self:spin():effectmagnitude(0,0,90) end;
	};
	LoadActor("ssc text")..{
		InitCommand=function(self) self:x(16):y(5):halign(0):zoom(0.45) end;
	};
};