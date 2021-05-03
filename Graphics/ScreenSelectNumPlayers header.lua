local t = Def.ActorFrame{
	LoadActor( THEME:GetPathG("_dynamic","headers"), Var "LoadingScreen" )..{
		InitCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_TOP+30) end,
		OnCommand=function(self) self:zoom(1.3) end
	};
	LoadFont("_z bold gray 36px")..{
		Text="PLAYER SELECTION";
		InitCommand=cmd(x,SCREEN_RIGHT-20;y,SCREEN_TOP+28;shadowlength,2;halign,1;zoom,.5;cropright,1.3;faderight,0.1;);
		OnCommand=cmd(sleep,.2;linear,0.8;cropright,-0.3);
	};
};

return t;