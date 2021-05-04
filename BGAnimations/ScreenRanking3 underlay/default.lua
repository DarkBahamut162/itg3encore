return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/back frame"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-1;CenterY;diffusealpha,0;zoomtowidth,228;);
		OnCommand=cmd(decelerate,0.30;zoomx,1;diffusealpha,1);
	};
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/horiz-line"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-34;diffusealpha,0;zoomtowidth,0;);
		OnCommand=cmd(sleep,.2;decelerate,0.30;zoomx,.99;diffusealpha,1);
	};
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/mask"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+2;zwrite,true;blend,'BlendMode_NoEffect';vertalign,bottom;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_TOP;valign,0;zoomto,SCREEN_WIDTH,78;zwrite,true;blend,'BlendMode_NoEffect';);
	};
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/center"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120;y,SCREEN_TOP+4;vertalign,top;);
	};
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/left"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120-17;y,SCREEN_TOP+4;vertalign,top;horizalign,right;zoomtowidth,SCREEN_WIDTH);
		OnCommand=function(self) end;
	};
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/right"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120+14;y,SCREEN_TOP+4;vertalign,top;horizalign,left;zoomtowidth,SCREEN_WIDTH);
	};
	Def.ActorFrame{
		Name="Icons";
		LoadActor("dgrades")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_TOP+56;);
		};
		LoadFont("_eurostile normal")..{
			Text="Normal";
			InitCommand=cmd(x,SCREEN_CENTER_X+144;y,SCREEN_TOP+54;shadowlength,2;zoom,0.5;diffuse,ContrastingDifficultyColor("Medium"));
		};
	};
};