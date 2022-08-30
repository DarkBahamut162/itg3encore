return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.85):wag():effectmagnitude(0,10,0) end,
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/c.txt"),
		Meshes=THEME:GetPathG("_grade","models/c.txt"),
		Bones=THEME:GetPathG("_grade","models/c.txt")
	}
}