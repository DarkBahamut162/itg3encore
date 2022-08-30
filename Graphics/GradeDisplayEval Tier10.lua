return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.7):rotationy(-90):spin():effectmagnitude(0,40,0) end,
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/aminus.txt"),
		Meshes=THEME:GetPathG("_grade","models/aminus.txt"),
		Bones=THEME:GetPathG("_grade","models/aminus.txt")
	}
}