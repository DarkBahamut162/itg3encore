return Def.ActorFrame{
	LoadActor("arrow")..{
		InitCommand=cmd(zoom,.8;y,6;diffuseshift;effectoffset,.5;diffusealpha,0;);
		OnCommand=cmd(sleep,3.5;addy,-20;accelerate,.3;diffusealpha,1;addy,25;decelerate,.3;addy,-10;accelerate,.3;addy,10);
	};
	LoadFont("_r bold shadow 30px")..{
		Text="Barely!";
		InitCommand=cmd(draworder,9999;zoom,0.5;shadowlength,2;y,-8;diffusealpha,0;addy,-20;);
		OnCommand=cmd(sleep,4.25;accelerate,.2;diffusealpha,1;addy,20;);
	};
};