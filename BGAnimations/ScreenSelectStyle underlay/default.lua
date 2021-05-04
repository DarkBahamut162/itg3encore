return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"));
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"));

	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+13;z,-100;zoom,1.3);
		LoadActor("char")..{
			InitCommand=cmd(zoom,0.5;glow,color("1,1,1,0");diffusealpha,0;linear,0.3;glow,color("1,1,1,1");sleep,0.001;diffusealpha,1;linear,0.3;glow,color("1,1,1,0"));
			MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end;
			MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end;
			GoOffCommand=cmd(sleep,.2;linear,0.3;diffusealpha,0;);
		};
	};

	LoadActor("explanation frame")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+138-8;horizalign,center;diffusealpha,0;);
		OnCommand=function(self) self:linear(0.5):diffusealpha(1.0) end;
		MadeChoiceP1MessageCommand=function(self) self:playcommand("GoOff") end;
		MadeChoiceP2MessageCommand=function(self) self:playcommand("GoOff") end;
		GoOffCommand=cmd(sleep,.2;linear,0.3;diffusealpha,0;);
	};
	LoadActor(THEME:GetPathB("_shared","underlay arrows"))..{
		InitCommand=cmd(x,184);
	};
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop"));
};
