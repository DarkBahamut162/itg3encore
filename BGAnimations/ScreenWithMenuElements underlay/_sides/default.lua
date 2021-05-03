return Def.ActorFrame{
	LoadActor("left")..{
		InitCommand=cmd(x,SCREEN_LEFT-50;CenterY;halign,0);
		OnCommand=cmd(sleep,0.2;decelerate,0.6;x,SCREEN_LEFT);
		OffCommand=cmd(accelerate,0.4;addx,-100);
	};
	LoadActor("right")..{
		InitCommand=cmd(x,SCREEN_RIGHT+50;CenterY;halign,1);
		OnCommand=cmd(sleep,0.2;decelerate,0.6;x,SCREEN_RIGHT);
		OffCommand=cmd(accelerate,0.4;addx,100);
	};
};