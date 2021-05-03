return Def.ActorFrame{
	LoadActor("back frame")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-1;CenterY;diffusealpha,0;zoomtowidth,228;);
		OnCommand=cmd(decelerate,0.30;zoomx,1;diffusealpha,1);
	};
	LoadActor("horiz-line")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-34;diffusealpha,0;zoomtowidth,0;);
		OnCommand=cmd(sleep,.2;decelerate,0.30;zoomx,.99;diffusealpha,1);
	};
	LoadActor("mask")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+2;zwrite,true;blend,'BlendMode_NoEffect';vertalign,bottom;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_TOP;valign,0;zoomto,SCREEN_WIDTH,78;zwrite,true;blend,'BlendMode_NoEffect';);
	};
	LoadActor("center")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120;y,SCREEN_TOP+4;vertalign,top;);
	};
	LoadActor("left")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120-17;y,SCREEN_TOP+4;vertalign,top;horizalign,right;zoomtowidth,SCREEN_WIDTH);
		OnCommand=cmd();
	};
	LoadActor("right")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120+14;y,SCREEN_TOP+4;vertalign,top;horizalign,left;zoomtowidth,SCREEN_WIDTH);
	};

	Def.ActorFrame{
		Name="Icons";
		LoadActor("dgrades")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_TOP+56;);
		};
		LoadFont("_eurostile normal")..{
			Text="Easy";
			InitCommand=cmd(x,SCREEN_CENTER_X-48;y,SCREEN_TOP+54;shadowlength,2;zoom,0.5;diffuse,ContrastingDifficultyColor("Easy"));
		};
		LoadFont("_eurostile normal")..{
			Text="Medium";
			InitCommand=cmd(x,SCREEN_CENTER_X+48;y,SCREEN_TOP+54;shadowlength,2;zoom,0.5;diffuse,ContrastingDifficultyColor("Medium"));
		};
		LoadFont("_eurostile normal")..{
			Text="Hard";
			InitCommand=cmd(x,SCREEN_CENTER_X+144;y,SCREEN_TOP+54;shadowlength,2;zoom,0.5;diffuse,ContrastingDifficultyColor("Hard"));
		};
		LoadFont("_eurostile normal")..{
			Text="Expert";
			InitCommand=cmd(x,SCREEN_CENTER_X+240;y,SCREEN_TOP+54;shadowlength,2;zoom,0.5;diffuse,ContrastingDifficultyColor("Challenge"));
		};
	};
};