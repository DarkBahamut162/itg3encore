return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.8):wag():effectmagnitude(0,0,10) end,
	Def.ActorFrame{
		InitCommand=function(self) self:x(-32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/d.txt"),
			Meshes=THEME:GetPathG("_grade","models/d.txt"),
			Bones=THEME:GetPathG("_grade","models/d.txt")
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/orange.txt"),
			Meshes=THEME:GetPathG("_grade","models/minus.txt"),
			Bones=THEME:GetPathG("_grade","models/minus.txt")
		}
	}
}