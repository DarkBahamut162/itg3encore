return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.7):wag():effectmagnitude(0,10,10) end,
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/cplus.txt"),
		Meshes=THEME:GetPathG("_grade","models/cplus.txt"),
		Bones=THEME:GetPathG("_grade","models/cplus.txt")
	}
}