return Def.ActorFrame{
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=cmd(x,-19;y,20;zoom,0.6;wag;effectmagnitude,0,4,10);
	};
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=cmd(x,19;y,-20;zoom,0.6;wag;effectmagnitude,0,4,10);
	};
};