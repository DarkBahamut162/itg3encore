local itemColor = ... -- "blue", "green", "orange", "pink", "purple", "red"
assert(itemColor,"[_award models/ribbon/] requires itemColor")

return Def.ActorFrame{
	Def.Model{
		Meshes=THEME:GetPathG("_award","models/ribbon/meshes.txt"),
		Materials=THEME:GetPathG("_award","models/ribbon/materials "..itemColor..".txt"),
		Bones=THEME:GetPathG("_award","models/bones.txt"),
		InitCommand=function(self) self:zoom(0.6):wag():effectmagnitude(0,15,0):effectperiod(8) end;
	};
};