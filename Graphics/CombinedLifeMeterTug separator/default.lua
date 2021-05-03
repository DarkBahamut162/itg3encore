return Def.ActorFrame{
	Def.Quad{ InitCommand=cmd(zoomto,2,14;diffuse,color("#000000")); };
	LoadActor("back");
	LoadActor("back")..{
		OnCommand=cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#000000");effectperiod,0.3);
	};
};