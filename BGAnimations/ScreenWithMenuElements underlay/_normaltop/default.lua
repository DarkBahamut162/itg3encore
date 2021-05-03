local t = Def.ActorFrame{
	LoadActor("_width")..{
		InitCommand=cmd(x,SCREEN_LEFT+180;valign,0;halign,0;zoomtowidth,SCREEN_WIDTH-630;);
		OnCommand=cmd(y,SCREEN_TOP-100;decelerate,0.8;y,SCREEN_TOP);
		OffCommand=cmd(accelerate,0.5;addy,-100);
	};
	LoadActor("_lside")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;valign,0);
		OnCommand=cmd(y,SCREEN_TOP-100;decelerate,0.8;y,SCREEN_TOP);
		OffCommand=cmd(accelerate,0.5;addy,-100);
	};
	LoadActor("_rside")..{
		InitCommand=cmd(x,SCREEN_RIGHT;halign,1;valign,0);
		OnCommand=cmd(y,SCREEN_TOP-100;decelerate,0.8;y,SCREEN_TOP);
		OffCommand=cmd(accelerate,0.5;addy,-100);
	};
	LoadActor("_lmask")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;valign,0;blend,'BlendMode_NoEffect';zwrite,true;draworder,110;);
		OnCommand=cmd(y,SCREEN_TOP-100;decelerate,0.8;y,SCREEN_TOP);
		OffCommand=cmd(accelerate,0.5;addy,-100);
	};
};

return t;