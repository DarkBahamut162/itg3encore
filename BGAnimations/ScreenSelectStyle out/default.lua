return Def.ActorFrame{
	-- sound

	Def.Quad{
		InitCommand=cmd(Center;diffuse,color("0,0,0,1");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffusealpha,0;);
		OnCommand=cmd(sleep,0.5;linear,0.31;diffusealpha,1;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+120;diffuse,color("0,0,0,1");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;diffusealpha,0;);
		OnCommand=cmd(sleep,0;linear,0.5;diffusealpha,1;y,SCREEN_CENTER_Y+158;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120;diffuse,color("0,0,0,1");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;diffusealpha,0;);
		OnCommand=cmd(sleep,0;linear,0.5;diffusealpha,1;y,SCREEN_CENTER_Y-158;);
	};

	-- lolhi (no card) vs. profile (card)
	Def.Sprite{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0) end;
		BeginCommand=function(self)
			self:Load(THEME:GetPathB("","lolhi"))
		end;
		OnCommand=cmd(linear,.5;zoomy,.68);
	};

	LoadFont("_z 36px black")..{
		Text="Loading Profiles...";
		InitCommand=cmd(Center;zoom,.7;cropright,1.3;faderight,0.1;visible,false);
		OnCommand=cmd(sleep,0.25;linear,0.7;cropright,-0.3);
	};
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=cmd(Center;zoom,.7;cropright,1.3;faderight,0.1;visible,true);
		OnCommand=cmd(sleep,0.25;linear,0.7;cropright,-0.3);
	};
	-- disk (no card)

	LoadActor("stats");
};