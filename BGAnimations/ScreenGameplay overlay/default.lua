local t = Def.ActorFrame{
	LoadActor(GetSongFrame());

	-- rave names
	Def.ActorFrame{
		Name="RaveNames";
		InitCommand=cmd(CenterX;y,SCREEN_TOP+58;visible,GAMESTATE:GetPlayMode() == 'PlayMode_Rave';);
		OnCommand=cmd(addy,-100;sleep,0.5;decelerate,0.8;addy,100);
		OffCommand=cmd(accelerate,0.8;addy,-100);

		LoadFont("_v 26px bold black")..{
			InitCommand=cmd(x,-254;zoom,.55;shadowlength,0;maxwidth,180;);
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_1) then
					self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_1));
				end
			end;
		};
		LoadFont("_v 26px bold black")..{
			InitCommand=cmd(x,254;zoom,.55;shadowlength,0;maxwidth,180;);
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_2) then
					self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_2));
				end
			end;
		};
	};

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(linear,0.3;diffusealpha,0);
	};

	Def.ActorFrame{
		Name="ScreenStageHoldovers";
		InitCommand=cmd(visible,not GAMESTATE:IsDemonstration() and not GAMESTATE:IsCourseMode());

		LoadActor(THEME:GetPathB("ScreenStageInformation","background/bottom/bar"))..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+156;zoomtowidth,SCREEN_WIDTH;faderight,.8;fadeleft,.8;);
			OnCommand=cmd(sleep,2.25;cropright,0;linear,.6;cropleft,1);
		};
		Def.ActorFrame{
			Name="InfoP1";
			InitCommand=cmd(visible,GAMESTATE:IsPlayerEnabled(PLAYER_1));
			-- stage background left gradient
			LoadActor(THEME:GetPathB("ScreenStageInformation","background/_left gradient"))..{
				InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_CENTER_Y+150;horizalign,left;);
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- stage background p1
			LoadActor(THEME:GetPathB("ScreenStageInformation","background/_p1"))..{
				InitCommand=cmd(x,SCREEN_LEFT;y,SCREEN_CENTER_Y+150;horizalign,left;);
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- step artist p1
			LoadFont("_r bold 30px")..{
				Text="Step Artist:";
				InitCommand=cmd(x,SCREEN_LEFT+5;y,SCREEN_CENTER_Y+172;zoom,.6;halign,0;shadowlength,2);
				BeginCommand=function(self)
					local pm = GAMESTATE:GetPlayMode()
					local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and show)
				end;
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- step desc p1
			LoadFont("_r bold 30px")..{
				Name="AuthorText";
				InitCommand=cmd(x,SCREEN_LEFT+100;y,SCREEN_CENTER_Y+172;shadowlength,2;halign,0;zoom,.6);
				BeginCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local text
					if song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							text = steps:GetAuthorCredit()
						else
							text = ""
						end
					else
						text = ""
					end
					self:settext(text)
				end;
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- player name p1
			LoadFont("_r bold 30px")..{
			Name="PlayerName";
			InitCommand=cmd(x,SCREEN_LEFT+44;y,SCREEN_CENTER_Y+142;shadowlength,2;halign,0;zoom,.8);
				BeginCommand=function(self)
					self:settext( PROFILEMAN:GetPlayerName(PLAYER_1) )
				end;
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
		};
		Def.ActorFrame{
			Name="InfoP2";
			InitCommand=cmd(visible,GAMESTATE:IsPlayerEnabled(PLAYER_2));
			-- stage background right gradient
			LoadActor(THEME:GetPathB("ScreenStageInformation","background/_right gradient"))..{
				InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+150;horizalign,right;);
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- stage background p2
			LoadActor(THEME:GetPathB("ScreenStageInformation","background/_p2"))..{
				InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_CENTER_Y+150;horizalign,right;);
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- step artist p2
			LoadFont("_r bold 30px")..{
				Text=":Step Artist";
				InitCommand=cmd(x,SCREEN_RIGHT-5;y,SCREEN_CENTER_Y+172;zoom,.6;halign,1;shadowlength,2);
				BeginCommand=function(self)
					local pm = GAMESTATE:GetPlayMode()
					local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and show)
				end;
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- step desc p2
			LoadFont("_r bold 30px")..{
				Name="AuthorText";
				InitCommand=cmd(x,SCREEN_RIGHT-100;y,SCREEN_CENTER_Y+172;shadowlength,2;halign,1;zoom,.6);
				BeginCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local text
					if song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							text = steps:GetAuthorCredit()
						else
							text = ""
						end
					else
						text = ""
					end
					self:settext(text)
				end;
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
			-- player name p2
			LoadFont("_r bold 30px")..{
				Name="PlayerName";
				InitCommand=cmd(x,SCREEN_RIGHT-44;y,SCREEN_CENTER_Y+142;shadowlength,2;halign,1;zoom,.8);
				BeginCommand=function(self)
					self:settext( PROFILEMAN:GetPlayerName(PLAYER_2) )
				end;
				OnCommand=cmd(sleep,1;linear,1;diffusealpha,0;);
			};
		};
	};

	LoadFont("_r bold 30px")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+147;maxwidth,SCREEN_WIDTH/8*7;shadowlength,2;horizalign,center;zoom,.5;diffusealpha,1;);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text
			if song then
				text = song:GetDisplayFullTitle()
			else
				text = ""
			end
			self:settext(text)
		end;
		OnCommand=cmd(playcommand,"Set";sleep,1.5;linear,1;diffusealpha,0;);
	};
	LoadFont("_r bold 30px")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+167;maxwidth,SCREEN_WIDTH/8*6.8;shadowlength,2;horizalign,center;zoom,.4;diffusealpha,1;);
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text
			if song then
				text = song:GetDisplayArtist()
			else
				text = ""
			end
			self:settext(text)
		end;
		OnCommand=cmd(playcommand,"Set";sleep,1.5;linear,1;diffusealpha,0;);
	};

	-- demo
	Def.ActorFrame{
		Name="DemonstrationFrame";
		BeginCommand=cmd(visible,GAMESTATE:IsDemonstration() and SCREENMAN:GetTopScreen():GetName() ~= 'ScreenJukebox');
		LoadActor(THEME:GetPathB("_metallic","streak"))..{
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+43;zoomtowidth,SCREEN_WIDTH);
			OnCommand=cmd(diffusealpha,.9;fadeleft,1;faderight,1);
		};
		LoadFont("_z 36px black")..{
			Text="DEMO";
			InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+43;zoom,.7;);
			OnCommand=cmd(pulse;effectmagnitude,1.0,0.95,0;effectclock,'beat';effectperiod,1);
		};
		LoadActor("demonstration gradient")..{
			InitCommand=cmd(Center;FullScreen;diffusealpha,0.8);
		};
	};
};

return t;