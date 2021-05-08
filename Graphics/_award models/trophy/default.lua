local itemColor = ... -- "gold", "silver", "bronze", "green"
assert(itemcolor,"[_award models/trophy/] requires item color")

return Def.ActorFrame{
	Def.Model{
		Meshes=THEME:GetPathG("_award","models/trophy/meshes.txt"),
		Materials=THEME:GetPathG("_award","models/trophy/materials "..itemColor..".txt"),
		Bones=THEME:GetPathG("_award","models/bones.txt"),
		InitCommand=function(self) self:zoom(4.6):spin():effectmagnitude(0,40,0) end;
	};
};