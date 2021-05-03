local function EnabledAndProfile(player)
	return GAMESTATE:IsPlayerEnabled(player) and PROFILEMAN:IsPersistentProfile(player)
end

local t = Def.ActorFrame{
	Def.ActorFrame{
		Name="CardPaneP1";
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+155;visible,EnabledAndProfile(PLAYER_1));
			OnCommand=cmd(sleep,1;accelerate,.3;addx,-300;);
		};
	};
	Def.ActorFrame{
		Name="CardPaneP2";
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=cmd(x,SCREEN_RIGHT-120;y,SCREEN_CENTER_Y+155;visible,EnabledAndProfile(PLAYER_2));
			OnCommand=cmd(sleep,1;accelerate,.3;addx,300;);
		};
	};
	Def.ActorFrame{
		Name="NameP1";
	};
	Def.ActorFrame{
		Name="NameP2";
	};
	LoadActor(THEME:GetPathB("","_overlay/profileload"))..{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+155;blend,Blend.Add);
		BeginCommand=cmd(visible,EnabledAndProfile(PLAYER_1));
		OnCommand=cmd(linear,0.5;diffusealpha,0;);
	};
	LoadActor(THEME:GetPathB("","_overlay/profileload"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-120;y,SCREEN_CENTER_Y+155;blend,Blend.Add);
		BeginCommand=cmd(visible,EnabledAndProfile(PLAYER_2));
		OnCommand=cmd(linear,0.5;diffusealpha,0;);
	};
};

return t;