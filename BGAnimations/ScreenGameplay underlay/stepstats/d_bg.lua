return Def.ActorFrame{
	LoadActor("base")..{ InitCommand=cmd(addy,35); };
	LoadActor("streak")..{
		InitCommand=cmd(addy,185;addy,100;);
		OnCommand=cmd(sleep,0.8;decelerate,0.6;addy,-100);
	};
	LoadActor("streak")..{
		InitCommand=cmd(addy,204;addy,100;);
		OnCommand=cmd(sleep,1;decelerate,0.6;addy,-100);
	};
};