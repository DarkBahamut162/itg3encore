return Def.ActorFrame{
	Def.ActorFrame{
		Name="CardPaneP1";
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155):visible(EnabledAndProfile(PLAYER_1)) end;
			OnCommand=function(self) self:sleep(1):accelerate(0.3):addx(-300) end;
		};
	};
	Def.ActorFrame{
		Name="CardPaneP2";
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+155):visible(EnabledAndProfile(PLAYER_2)) end;
			OnCommand=function(self) self:sleep(1):accelerate(0.3):addx(300) end;
		};
	};
	Def.ActorFrame{
		Name="NameP1";
	};
	Def.ActorFrame{
		Name="NameP2";
	};
	LoadActor(THEME:GetPathB("","_overlay/profileload"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155):blend(Blend.Add) end;
		BeginCommand=function(self) self:visible(EnabledAndProfile(PLAYER_1)) end;
		OnCommand=function(self) self:linear(0.5):diffusealpha(0) end;
	};
	LoadActor(THEME:GetPathB("","_overlay/profileload"))..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+155):blend(Blend.Add) end;
		BeginCommand=function(self) self:visible(EnabledAndProfile(PLAYER_2)) end;
		OnCommand=function(self) self:linear(0.5):diffusealpha(0) end;
	};
};