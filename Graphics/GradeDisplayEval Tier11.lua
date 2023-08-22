return Def.ActorFrame{
	InitCommand=function(self) self:zoom(0.8):rotationy(-90):spin():effectmagnitude(0,40,0) end,
	Def.ActorFrame{
		InitCommand=function(self) self:x(-32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/b.txt"),
			Meshes=THEME:GetPathG("_grade","models/b.txt"),
			Bones=THEME:GetPathG("_grade","models/b.txt")
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:x(32) end,
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/yellow.txt"),
			Meshes=THEME:GetPathG("_grade","models/plus.txt"),
			Bones=THEME:GetPathG("_grade","models/plus.txt")
		}
	}
}