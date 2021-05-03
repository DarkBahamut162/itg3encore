local mask = GAMESTATE:IsCourseMode() and "_course banner mask" or "_banner mask"

local t = Def.ActorFrame{
	
	LoadActor(mask)..{
		InitCommand=cmd(x,SCREEN_CENTER_X+140;y,SCREEN_CENTER_Y-16;z,2;zwrite,true;blend,'BlendMode_NoEffect';);
		OnCommand=cmd(addx,SCREEN_WIDTH;decelerate,0.75;addx,-SCREEN_WIDTH);
		OffCommand=cmd(accelerate,0.75;addx,SCREEN_WIDTH);
	};
};

return t;