return Def.ActorFrame{
	InitCommand=cmd(zoom,0.8;wag;effectmagnitude,0,4,10);
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
	};
};