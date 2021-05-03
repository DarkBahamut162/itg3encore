return Def.Model{
	Meshes=THEME:GetPathG("_platform","home single/platform meshes.txt"),
	Materials=THEME:GetPathG("_platform","home single/platform materials.txt"),
	Bones=THEME:GetPathG("_platform","home single/platform bones.txt"),
	InitCommand=cmd(rotationy,180),
};