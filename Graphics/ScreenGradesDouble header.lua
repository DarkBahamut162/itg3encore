return Def.ActorFrame{
	LoadFont("_z bold gray 36px")..{
		Text="DOUBLE GRADES";
		InitCommand=cmd(x,SCREEN_RIGHT-20;y,SCREEN_TOP+28;shadowlength,2;horizalign,right;zoom,.5;cropright,1.3;faderight,0.1;);
		OnCommand=cmd(sleep,.2;linear,0.8;cropright,-0.3);
	};
};