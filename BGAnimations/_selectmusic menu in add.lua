-- holdover from loading profiles
return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(linear,0.2;diffusealpha,0);
	};
	LoadActor("lolhi")..{
		InitCommand=cmd(Center;zoomx,SCREEN_WIDTH;zoomy,.68;);
		OnCommand=cmd(linear,0.2;zoomy,.0);
	};
	-- profile

	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=cmd(x,SCREEN_CENTER_X+42;CenterY;zoom,.7);
		OnCommand=cmd(linear,0.2;diffuse,color("0,0,0,0"));
	};
	--[[
	LoadFont("_z 36px shadowx")..{
		Text="LOADING PROFILES...";
		InitCommand=cmd(x,SCREEN_CENTER_X+42;CenterY;zoom,.7);
		OnCommand=cmd(linear,0.2;diffuse,color("0,0,0,0"));
	};
	--]]
};