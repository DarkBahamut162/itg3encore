return Def.ActorFrame{
	LoadFont("_r bold shadow 30px")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-100;shadowlength,0;zoomx,.8;zoomy,.7;settext,"PRESS");
	};
	Def.ActorFrame{
		Name="StartButton";
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-75);
		LoadActor(THEME:GetPathG("_common","base start button"))..{
			InitCommand=cmd(shadowlength,0;zoom,.7);
		};
		LoadActor(THEME:GetPathG("_common","start button"))..{
			InitCommand=cmd(shadowlength,0;diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#858585");zoom,.7;effectclock,"beat");
		};
		LoadActor(THEME:GetPathG("_common","glow start button"))..{
			InitCommand=cmd(blend,Blend.Add;shadowlength,0;diffuseshift;effectcolor1,color("#6BFF75");effectcolor2,color("#FFFFFF00");zoom,.7;effectclock,"beat");
		};
	};

	Def.ActorFrame{
		Name="UnlockFrame";
	};

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,0"));
		-- unlock command
	};
};