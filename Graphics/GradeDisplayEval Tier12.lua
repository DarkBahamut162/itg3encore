return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.85):rotationy(-90):spin():effectmagnitude(0,40,0) end;
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/b.txt"),
		Meshes=THEME:GetPathG("_grade","models/b.txt"),
		Bones=THEME:GetPathG("_grade","models/b.txt"),
	};
};