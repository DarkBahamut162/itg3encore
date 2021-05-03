return Def.ActorFrame{
	InitCommand=cmd(ztest,true;zoom,0.5);
	LoadActor("base")..{ InitCommand=cmd(ztest,true;); };
	LoadActor("SPAECESHIPLOL")..{
		InitCommand=cmd(ztest,true;addx,-76;addy,-25;);
		OnCommand=cmd(spin,1;effectmagnitude,0,0,50;effectperiod,1);
	};
};
