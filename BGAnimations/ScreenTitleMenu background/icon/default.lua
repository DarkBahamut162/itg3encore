return Def.ActorFrame{
	Def.ActorFrame{
		Name="Stages";
		LoadActor("_icon")..{
			InitCommand=cmd(x,SCREEN_RIGHT-200;y,SCREEN_TOP-2+34;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		LoadFont("_v 26px bold black")..{
			Text=PREFSMAN:GetPreference('SongsPerPlay');
			InitCommand=cmd(x,SCREEN_RIGHT-200+1;y,SCREEN_TOP-2+29;horizalign,center;zoom,.8;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		LoadFont("_v 26px bold black")..{
			Text="ROUNDS";
			InitCommand=cmd(x,SCREEN_RIGHT-200;y,SCREEN_TOP-2+46;zoom,0.4;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
	};
	Def.ActorFrame{
		Name="Difficulty";
		InitCommand=cmd(x,SCREEN_RIGHT-200+53*1;);
		LoadActor("_icon")..{
			InitCommand=cmd(y,SCREEN_TOP-2+34;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		Def.ActorFrame{
			Name="DiffBars";
			InitCommand=cmd(y,SCREEN_TOP-2+40);

			Def.ActorFrame{
				Name="BG";
				Def.Quad{
					InitCommand=cmd(x,-5*3;vertalign,bottom;zoomtowidth,4;zoomtoheight,3;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
				Def.Quad{
					InitCommand=cmd(x,-5*2;vertalign,bottom;zoomtowidth,4;zoomtoheight,6;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
				Def.Quad{
					InitCommand=cmd(x,-5*1;vertalign,bottom;zoomtowidth,4;zoomtoheight,9;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
				Def.Quad{
					InitCommand=cmd(x,0;vertalign,bottom;zoomtowidth,4;zoomtoheight,12;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
				Def.Quad{
					InitCommand=cmd(x,5*1;vertalign,bottom;zoomtowidth,4;zoomtoheight,15;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
				Def.Quad{
					InitCommand=cmd(x,5*2;vertalign,bottom;zoomtowidth,4;zoomtoheight,18;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
				Def.Quad{
					InitCommand=cmd(x,5*3;vertalign,bottom;zoomtowidth,4;zoomtoheight,21;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#77777777"));
				};
			};
			Def.ActorFrame{
				Name="Real";
				OnCommand=function(self)
					local c = self:GetChildren()
					local diffScale = PREFSMAN:GetPreference("LifeDifficultyScale")
					local thresholds = { 1.7, 1.5, 1.3, 1, 0.9, 0.7, 0.5 }
					for i = 1,7 do
						-- stuff
						c["Diff"..i]:visible( diffScale <= thresholds[i] )
					end
				end;
				Def.Quad{
					Name="Diff1";
					InitCommand=cmd(x,-5*3;vertalign,bottom;zoomtowidth,4;zoomtoheight,3;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
				Def.Quad{
					Name="Diff2";
					InitCommand=cmd(x,-5*2;vertalign,bottom;zoomtowidth,4;zoomtoheight,6;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
				Def.Quad{
					Name="Diff3";
					InitCommand=cmd(x,-5*1;vertalign,bottom;zoomtowidth,4;zoomtoheight,9;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
				Def.Quad{
					Name="Diff4";
					InitCommand=cmd(x,0;vertalign,bottom;zoomtowidth,4;zoomtoheight,12;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
				Def.Quad{
					Name="Diff5";
					InitCommand=cmd(x,5*1;vertalign,bottom;zoomtowidth,4;zoomtoheight,15;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
				Def.Quad{
					Name="Diff6";
					InitCommand=cmd(x,5*2;vertalign,bottom;zoomtowidth,4;zoomtoheight,18;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
				Def.Quad{
					Name="Diff7";
					InitCommand=cmd(x,5*3;vertalign,bottom;zoomtowidth,4;zoomtoheight,21;diffusealpha,0;);
					OnCommand=cmd(sleep,.7;linear,.4;diffusealpha,1;diffuse,color("#000000"));
				};
			};

			LoadFont("_v 26px bold black")..{
				Text="LEVEL";
				InitCommand=cmd(y,6;zoom,0.4;);
				OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
			};
		};
	};
	Def.ActorFrame{
		Name="Premiums";
		InitCommand=function(self)
			local line1 = self:GetChild("Line1")
			local line2 = self:GetChild("Line2")
			local coinmode = GAMESTATE:GetCoinMode()
			local premium = GAMESTATE:GetPremium()
			self:visible(coinmode ~= 'CoinMode_Free' and premium ~= 'Premium_Off')
			if premium == 'Premium_2PlayersFor1Credit' then
				line1:settext("JOINT")
				line2:settext("PREMIUM")
				line1:addy(1)
				line1:zoom(0.6)
				line2:zoomx(0.38)
				line2:zoomy(0.4)
			elseif premium == 'Premium_DoubleFor1Credit' then
				line1:settext("1 CREDIT")
				line2:settext("DOUBLES")
				line1:zoom(0.4)
				line2:zoom(0.4)
			end
		end;
		LoadActor("_icon")..{
			InitCommand=cmd(x,SCREEN_RIGHT-200+53*2;y,SCREEN_TOP-2+34;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		LoadFont("_v 26px bold black")..{
			Name="Line1";
			InitCommand=cmd(x,SCREEN_RIGHT-199+53*2;y,SCREEN_TOP-2+28;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		LoadFont("_v 26px bold black")..{
			Name="Line2";
			InitCommand=cmd(x,SCREEN_RIGHT-199+53*2;y,SCREEN_TOP-2+40;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
	};
	Def.ActorFrame{
		Name="USBSongs";
		InitCommand=cmd(visible,false);
		LoadActor("_icon")..{
			InitCommand=cmd(x,SCREEN_RIGHT-200+53*3;y,SCREEN_TOP-2+34;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		LoadFont("_v 26px bold black")..{
			Text="USB";
			InitCommand=cmd(x,SCREEN_RIGHT-200+53*3;y,SCREEN_TOP-2+29;horizalign,center;zoom,.6;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
		LoadFont("_v 26px bold black")..{
			Text="SONGS";
			InitCommand=cmd(x,SCREEN_RIGHT-200+53*3;y,SCREEN_TOP-2+42;zoom,0.4;);
			OnCommand=cmd(diffusealpha,0;sleep,.7;linear,.4;diffusealpha,1);
		};
	};
};