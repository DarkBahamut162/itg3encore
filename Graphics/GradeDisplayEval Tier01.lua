return Def.ActorFrame{
	BeginCommand=function(self)
		local name = self:GetParent():GetName():sub(-2)
		if name ~= "" then
			local faCheck = getenv("SetScoreFA"..name)
			if faCheck then
				local W0Count = getenv("W0"..name) or 0
				local WXCount = getenv("WX"..name) or 0
				if W0Count > 0 and WXCount == 0 then else
					self:GetChild("Quint"):diffusealpha(0)
				end
			else
				self:GetChild("Quint"):diffusealpha(0)
			end
		else
			self:GetChild("Quint"):diffusealpha(0)
		end
	end,
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(-25):y(-22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("_grade","models/goldflare"),
		InitCommand=function(self) self:blend(Blend.Add):x(-25):y(-21):zoom(0.45):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(25):y(-22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("_grade","models/goldflare"),
		InitCommand=function(self) self:blend(Blend.Add):x(25):y(-21):zoom(0.45):wag():effectmagnitude(0,4,10) end
	},
	Def.ActorFrame{
		Name="Quint",
		Def.Model{
			Materials=THEME:GetPathG("_grade","models/star.txt"),
			Meshes=THEME:GetPathG("_grade","models/star.txt"),
			Bones=THEME:GetPathG("_grade","models/star.txt"),
			InitCommand=function(self) self:zoom(0.5):wag():effectmagnitude(0,4,10) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_grade","models/goldflare"),
			InitCommand=function(self) self:blend(Blend.Add):zoom(0.45):wag():effectmagnitude(0,4,10) end
		}
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(-25):y(22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("_grade","models/goldflare"),
		InitCommand=function(self) self:blend(Blend.Add):x(-25):y(23.5):zoom(0.45):wag():effectmagnitude(0,4,10) end
	},
	Def.Model{
		Materials=THEME:GetPathG("_grade","models/star.txt"),
		Meshes=THEME:GetPathG("_grade","models/star.txt"),
		Bones=THEME:GetPathG("_grade","models/star.txt"),
		InitCommand=function(self) self:x(25):y(22):zoom(0.5):wag():effectmagnitude(0,4,10) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("_grade","models/goldflare"),
		InitCommand=function(self) self:blend(Blend.Add):x(25):y(23.5):zoom(0.45):wag():effectmagnitude(0,4,10) end
	}
}