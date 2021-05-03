return Def.ActorFrame{
	InitCommand=cmd(zoom,0.7;rotationy,-90;spin;effectmagnitude,0,40,0);
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/aplus.txt"),
		Meshes=THEME:GetPathG("_grade","models/aplus.txt"),
		Bones=THEME:GetPathG("_grade","models/aplus.txt"),
	};
};