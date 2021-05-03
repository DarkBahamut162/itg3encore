local coinMode = GAMESTATE:GetCoinMode()

local platformType
if coinMode == 'CoinMode_Home' then platformType = "home"
else platformType = "arcade"
end

return Def.ActorFrame{
	LoadActor(platformType)..{
		InitCommand=cmd(rotationx,5);
	};
	LoadActor(THEME:GetPathB("","lolhi"))..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-130;fadeleft,0.3;faderight,0.3;cropleft,1.3;cropright,-0.3;zoom,0.5);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(linear,1;cropleft,-0.3;zoom,1.6;linear,7;zoom,1.2;);
		OffCommand=cmd(stoptweening;linear,0.5;cropright,1.3;zoom,0.5);
	};
	LoadActor(THEME:GetPathB("_red2","streak"))..{
		InitCommand=cmd(diffusealpha,0;zoom,0.5;CenterX;y,SCREEN_CENTER_Y-132;zoom,2.25;sleep,.8;accelerate,.8;diffusealpha,1;sleep,.7;decelerate,.8;diffusealpha,0;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(linear,1;cropleft,-0.3;zoom,1.6;linear,7;zoom,1.2;);
		OffCommand=cmd(stoptweening;linear,0.5;cropright,1.3;zoom,0.5);
	};
	LoadActor("extreme motions")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+40;y,SCREEN_CENTER_Y-130;zoom,0.91;diffusealpha,0;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(sleep,.50;linear,0.25;diffusealpha,1;zoom,.9;linear,3.5;zoom,0.83;sleep,0;accelerate,0.3;diffusealpha,0;zoom,.8;);
		OffCommand=cmd(stoptweening;accelerate,0.5;addx,SCREEN_WIDTH*1.5);
	};
	LoadActor("be careful")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+40;y,SCREEN_CENTER_Y-130;zoom,.905;diffusealpha,0;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(sleep,4.3;linear,0.25;diffusealpha,1;zoom,.9;linear,4.5;zoom,0.8;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(stoptweening;accelerate,0.5;addx,SCREEN_WIDTH*1.5);
	};
	LoadActor("exclamation normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-240;y,SCREEN_CENTER_Y-130;glow,color("1,1,1,1");addx,-SCREEN_WIDTH*.5;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(sleep,.5;decelerate,0.5;addx,SCREEN_WIDTH*.5;glowshift;effectclock,"beat";effectoffset,1;effectperiod,2;sleep,8.2;accelerate,0.5;addx,-SCREEN_WIDTH);
		OffCommand=cmd(stoptweening;accelerate,0.5;addx,-SCREEN_WIDTH*1.5);
	};

	LoadActor("cyan_arrow")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+450;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(sleep,0.5;decelerate,0.4;addy,-350;decelerate,8.5;addy,-30);
		OffCommand=cmd(stoptweening;accelerate,0.2;y,SCREEN_TOP-100);
	};
	LoadActor("caution_txt")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+45;y,SCREEN_CENTER_Y+110;addx,SCREEN_WIDTH/1.2;);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(sleep,0.5;decelerate,0.4;addx,-SCREEN_WIDTH/1.2;decelerate,9;addx,-40);
		OffCommand=cmd(stoptweening;accelerate,0.2;x,-SCREEN_LEFT-150);
	};

	LoadActor(THEME:GetPathB("_join","overlay"));
};