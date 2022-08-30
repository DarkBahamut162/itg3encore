return Def.ActorFrame{
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(-25):y(-22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	LoadActor(THEME:GetPathG("_grade","models/goldflare"))..{
		InitCommand=function(self) self:blend(Blend.Add):x(-25):y(-21):zoom(0.45):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(25):y(-22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	LoadActor(THEME:GetPathG("_grade","models/goldflare"))..{
		InitCommand=function(self) self:blend(Blend.Add):x(25):y(-21):zoom(0.45):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(-25):y(22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	LoadActor(THEME:GetPathG("_grade","models/goldflare"))..{
		InitCommand=function(self) self:blend(Blend.Add):x(-25):y(23.5):zoom(0.45):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(25):y(22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	LoadActor(THEME:GetPathG("_grade","models/goldflare"))..{
		InitCommand=function(self) self:blend(Blend.Add):x(25):y(23.5):zoom(0.45):wag():effectmagnitude(0,4,10) end
	}
}