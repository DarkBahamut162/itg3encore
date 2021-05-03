local itemColor = ... -- "gold", "silver", "bronze", "green"
assert(itemcolor,"[_award models/plaque/] requires item color")

return Def.ActorFrame{
	Def.Model{
		Meshes=THEME:GetPathG("_award","models/plaque/meshes.txt"),
		Materials=THEME:GetPathG("_award","models/plaque/materials "..itemColor..".txt"),
		Bones=THEME:GetPathG("_award","models/bones.txt"),
		InitCommand=cmd(zoom,1.6;wag;effectmagnitude,0,20,0;effectperiod,8),
	};
};