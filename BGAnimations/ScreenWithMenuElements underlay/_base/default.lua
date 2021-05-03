local t = Def.ActorFrame{
	LoadActor("_lside")..{
		InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_BOTTOM+97;horizalign,left;vertalign,bottom);
		OnCommand=cmd(decelerate,0.6;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
	LoadActor("_rside")..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM+97;horizalign,right;vertalign,bottom);
		OnCommand=cmd(decelerate,0.6;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
	LoadActor("width")..{
		InitCommand=cmd(x,SCREEN_LEFT+48;y,SCREEN_BOTTOM+97;horizalign,left;vertalign,bottom;zoomtowidth,SCREEN_WIDTH/2);
		OnCommand=cmd(decelerate,0.6;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
	LoadActor("width")..{
		InitCommand=cmd(x,SCREEN_RIGHT-48;y,SCREEN_BOTTOM+97;horizalign,right;vertalign,bottom;zoomtowidth,SCREEN_WIDTH/2);
		OnCommand=cmd(decelerate,0.6;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
	LoadActor("base")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM+97;valign,1;);
		OnCommand=cmd(decelerate,0.6;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
};

return t;