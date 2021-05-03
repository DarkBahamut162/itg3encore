return Def.ActorFrame{
	InitCommand=cmd(zoom,0.85;wag;effectmagnitude,0,0,10);
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/d.txt"),
		Meshes=THEME:GetPathG("_grade","models/d.txt"),
		Bones=THEME:GetPathG("_grade","models/d.txt"),
	};
};