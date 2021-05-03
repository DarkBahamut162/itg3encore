return Def.ActorFrame{
	LoadFont("_eurostile normal")..{
		Text="Hard";
		InitCommand=cmd(x,4;zoom,.5;shadowlength,2;diffuse,ContrastingDifficultyColor("Hard");diffusealpha,0);
		OnCommand=cmd(sleep,0.1;linear,0.3;diffusealpha,1);
		OffCommand=cmd(linear,0.3;diffusealpha,0);
	};
};