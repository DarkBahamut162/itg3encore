return Def.ActorFrame{
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(-25):y(20):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(0):y(-20):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(25):y(20):zoom(0.5):wag():effectmagnitude(0,4,10) end
	}
}