local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop")),

	LoadActor("name entry banner mask")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+138;zbuffer,true;blend,'BlendMode_NoEffect';addy,-200),
		OnCommand=cmd(decelerate,0.3;addy,200)
	},

	-- todo: don't show player crap if they didn't rank in

	Def.ActorFrame{
		Name="P1Side",
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1)),

		LoadActor("name frame")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-157;y,SCREEN_CENTER_Y+72),
			OnCommand=cmd(addx,-SCREEN_WIDTH/2;decelerate,0.3;addx,SCREEN_WIDTH/2)
		},
		LoadActor("p1")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y+145;addx,-SCREEN_WIDTH/2;),
			OnCommand=cmd(decelerate,0.3;addx,SCREEN_WIDTH/2)
		},
		LoadActor("name entry BGA list frame")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-157;y,SCREEN_CENTER_Y-70;addx,-SCREEN_WIDTH/2;),
			OnCommand=cmd(decelerate,0.3;addx,SCREEN_WIDTH/2)
		}
	},

	Def.ActorFrame{
		Name="P2Side",
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2)),

		LoadActor("name frame")..{
			InitCommand=cmd(zoomx,-1;x,SCREEN_CENTER_X+156;y,SCREEN_CENTER_Y+72),
			OnCommand=cmd(addx,SCREEN_WIDTH/2;decelerate,0.3;addx,-SCREEN_WIDTH/2)
		},

		LoadActor("p1")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+200;y,SCREEN_CENTER_Y+145;zoomx,-1;addx,-SCREEN_WIDTH/2;),
			OnCommand=cmd(decelerate,0.3;addx,SCREEN_WIDTH/2)
		},

		LoadActor("name entry BGA list frame")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+156;y,SCREEN_CENTER_Y-70;zoomx,-1;addx,SCREEN_WIDTH/2;),
			OnCommand=cmd(decelerate,0.3;addx,-SCREEN_WIDTH/2)
		}
	},

	LoadActor("light")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+4.5;zoomy,0.815;diffusealpha,0;),
		OnCommand=cmd(sleep,1;linear,0.4;diffusealpha,1;diffuseramp;effectperiod,1;effectoffset,0.20;effectclock,"beat";diffuseramp;effectcolor1,color("#FFFFFF00");effectcolor2,color("#FFFFFFFF");effectperiod,2;),
		OffCommand=cmd(linear,0.2;diffusealpha,0)
	}
}

return t