return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_lower"))..{
		InitCommand=cmd(Center;zoomtowidth,SCREEN_WIDTH;diffusealpha,.4;blend,Blend.Add);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;linear,3;croptop,1;cropbottom,-0.8;sleep,1;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_upper"))..{
		InitCommand=cmd(Center;zoomtowidth,SCREEN_WIDTH;diffusealpha,.4;blend,Blend.Add);
		OnCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(croptop,-0.8;cropbottom,1;fadebottom,.45;fadetop,.45;linear,3;croptop,1;cropbottom,-0.8;sleep,1;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_lside"))..{
		InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_BOTTOM+100;halign,0;valign,1;);
		OnCommand=cmd(decelerate,0.4;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_lside"))..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM+100;halign,0;valign,1;zoomx,-1;);
		OnCommand=cmd(decelerate,0.4;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/width"))..{
		InitCommand=cmd(x,SCREEN_LEFT+48;y,SCREEN_BOTTOM+100;horizalign,left;vertalign,bottom;zoomtowidth,SCREEN_WIDTH-96);
		OnCommand=cmd(decelerate,0.4;y,SCREEN_BOTTOM);
		OffCommand=cmd(accelerate,0.5;addy,100);
	};

	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop"));

	LoadFont("_z bold gray 36px")..{
		Text="LOADING...";
		InitCommand=cmd(x,SCREEN_RIGHT-30;y,SCREEN_BOTTOM-50;horizalign,right;shadowlength,0.5;zoom,.5;diffusebottomedge,color("#df0000");diffusetopedge,color("#ff2828"););
		OnCommand=cmd(sleep,.3;linear,.8;diffusealpha,0;);
	};
};