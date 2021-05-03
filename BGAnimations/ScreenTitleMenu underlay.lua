-- trickery!
InitOptions()

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenEndingNormal","overlay/p1gradient"))..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_TOP+63;halign,1;valign,0;zoomtoheight,420;addx,150;);
		OnCommand=cmd(sleep,.8;decelerate,.2;addx,-150);
	};
	LoadActor(THEME:GetPathB("ScreenEndingNormal","overlay/p1gradient"))..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_TOP+63;halign,1;valign,0;zoomtoheight,420;addx,150;);
		OnCommand=cmd(sleep,.8;decelerate,.2;addx,-150);
	};
};

return t;