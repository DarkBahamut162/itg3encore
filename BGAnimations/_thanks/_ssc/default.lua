return Def.ActorFrame{
	Def.Model{
		Materials="logo.txt";
		Meshes="logo.txt";
		Bones="logo.txt";
		InitCommand=cmd(y,5;zoom,2.5;rotationx,90;);
		OnCommand=cmd(spin;effectmagnitude,0,0,90;);
	};
	LoadActor("ssc text")..{
		InitCommand=cmd(x,16;y,5;halign,0;zoom,0.45;);
	};
};