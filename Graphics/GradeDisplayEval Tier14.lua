return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.8):wag():effectmagnitude(0,10,10) end,
	Def.ActorFrame{
		InitCommand=function(self) self:x(-32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/c.txt"),
			Meshes=THEME:GetPathG("_grade","models/c.txt"),
			Bones=THEME:GetPathG("_grade","models/c.txt")
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/green.txt"),
			Meshes=THEME:GetPathG("_grade","models/plus.txt"),
			Bones=THEME:GetPathG("_grade","models/plus.txt")
		}
	}
}