return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.8):wag():effectmagnitude(0,0,10) end,
	Def.ActorFrame{
		InitCommand=function(self) self:x(-32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/f.txt"),
			Meshes=THEME:GetPathG("_grade","models/f.txt"),
			Bones=THEME:GetPathG("_grade","models/f.txt")
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/purple.txt"),
			Meshes=THEME:GetPathG("_grade","models/plus.txt"),
			Bones=THEME:GetPathG("_grade","models/plus.txt")
		}
	}
}