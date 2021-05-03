return Def.ActorFrame{
	InitCommand=cmd(spin;effectmagnitude,0,90,0);
	LoadActor(THEME:GetPathG("_platform","single"))..{
		InitCommand=cmd(x,80;cullmode,'CullMode_Back');
	};
	LoadActor(THEME:GetPathG("_platform","single/flipped"))..{
		InitCommand=cmd(x,-80;zoomx,-1;cullmode,'CullMode_Front');
	};
};