return Def.ActorFrame{
	InitCommand=cmd(zoom,0.85;wag;effectmagnitude,0,10,10);
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/f.txt"),
		Meshes=THEME:GetPathG("_grade","models/f.txt"),
		Bones=THEME:GetPathG("_grade","models/f.txt"),
	};
};