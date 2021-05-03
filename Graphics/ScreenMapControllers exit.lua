return Def.ActorFrame{
	LoadActor(THEME:GetPathG("ScreenOptions","more/moreexit")) .. {
		Text="Exit";
		InitCommand=cmd(CenterX;y,-10;croptop,.57;cropbottom,.1;diffuse,color("0.5,0.5,0.5,1"));
		OnCommand=cmd(diffusealpha,0;decelerate,0.5;diffusealpha,1);
		OffCommand=cmd(stoptweening;accelerate,0.3;diffusealpha,0;queuecommand,"Hide");
		HideCommand=cmd(visible,false);

		GainFocusCommand=cmd(linear,0.2;diffuse,color("1,1,1,1"));
		LoseFocusCommand=cmd(stoptweening;linear,0.2;diffuse,color("0.5,0.5,0.5,1"));
	};

	Def.ActorFrame{
		Name="Triangles";
		InitCommand=cmd(CenterX;y,6;);
		LoadActor(THEME:GetPathG("ScreenOptions","more/_triangle"))..{
			InitCommand=cmd(blend,Blend.Add;x,-38;diffuseblink;effectcolor1,color("0.6,0.6,0.6,1");effectperiod,0.4;effectoffset,0.2;effectclock,"beat");
			GainFocusCommand=cmd(stoptweening;linear,.15;rotationz,-90);
			LoseFocusCommand=cmd(stoptweening;linear,.15;rotationz,0);
		};
		LoadActor(THEME:GetPathG("ScreenOptions","more/_triangle"))..{
			InitCommand=cmd(blend,Blend.Add;x,38;diffuseblink;effectcolor1,color("0.6,0.6,0.6,1");effectperiod,0.4;effectoffset,0.2;effectclock,"beat");
			GainFocusCommand=cmd(stoptweening;linear,.15;rotationz,90);
			LoseFocusCommand=cmd(stoptweening;linear,.15;rotationz,0);
		};
	};
};