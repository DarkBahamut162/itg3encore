return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.8):rotationy(-90):spin():effectmagnitude(0,40,0) end;
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/splus.txt"),
		Meshes=THEME:GetPathG("_grade","models/splus.txt"),
		Bones=THEME:GetPathG("_grade","models/splus.txt"),
	};
};