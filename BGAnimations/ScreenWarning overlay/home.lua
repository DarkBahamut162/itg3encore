return Def.ActorFrame{
	InitCommand=cmd(fov,90;CenterX;y,SCREEN_CENTER_Y-20;addx,800;zoom,3.4;rotationx,90;);
	OnCommand=cmd(linear,4;addx,-1600;decelerate,1.5;CenterX;y,SCREEN_CENTER_Y+180;z,-200;rotationx,30;queuecommand,"PlayWag");
	PlayWagCommand=cmd(wag;effectmagnitude,0,7,0;effectperiod,3);
	OffCommand=cmd(stoptweening;accelerate,0.5;addx,-SCREEN_WIDTH*1.5;addz,-100);
	LoadActor(THEME:GetPathG("_platform","home single"))..{ InitCommand=cmd(addx,-56); };
	LoadActor(THEME:GetPathG("_platform","home single"))..{ InitCommand=cmd(addx,56); };
};