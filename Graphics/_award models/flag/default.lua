local itemColor = ... -- "green", "orange"
assert(itemcolor,"[_award models/flag/] requires item color")

return Def.ActorFrame{
	Def.Model{
		Meshes=THEME:GetPathG("_award","models/flag/meshes.txt"),
		Materials=THEME:GetPathG("_award","models/flag/materials "..itemColor..".txt"),
		Bones=THEME:GetPathG("_award","models/bones.txt"),
		InitCommand=function(self) self:zoom(0.8):wag():effectmagnitude(0,20,0):effectperiod(8):y(-20) end;
	};
};