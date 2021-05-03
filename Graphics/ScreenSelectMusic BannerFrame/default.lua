local t = Def.ActorFrame{
	Def.ActorFrame{
		Name="LengthFrame";
		InitCommand=cmd(visible,not GAMESTATE:IsCourseMode(););

		LoadActor(THEME:GetPathG("_pane","elements/_length"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X+20;y,SCREEN_CENTER_Y-34;valign,1;diffusealpha,0;ztest,true;zoom,.6;);
			ShowCommand=cmd(stoptweening;linear,0.2;diffusealpha,1);
			HideCommand=cmd(stoptweening;linear,0.2;diffusealpha,0;);
			SelectMenuOpenedMessageCommand=function(self)
				if not GAMESTATE:GetCurrentSong() then
					self:playcommand("Hide")
				else
					self:playcommand("Show")
				end
			end;
			SelectMenuClosedMessageCommand=cmd(playcommand,"Hide");
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-14;y,SCREEN_CENTER_Y-44;diffusealpha,0;shadowlength,0.5;horizalign,left;zoom,.6;);
			OnCommand=cmd(addx,SCREEN_WIDTH;decelerate,0.75;addx,-SCREEN_WIDTH;);
			OffCommand=cmd(linear,.12;diffusealpha,0;);
			ShowCommand=cmd(stoptweening;linear,0.2;diffusealpha,1);
			HideCommand=cmd(stoptweening;linear,0.2;diffusealpha,0;);
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					self:visible(true)
					self:settext(string.format("Song Length: %s",SecondsToMMSS(song:MusicLengthSeconds())))
				else
					self:visible(false)
				end
			end;
			SelectMenuOpenedMessageCommand=function(self)
				if not GAMESTATE:GetCurrentSong() then
					self:playcommand("Hide")
				else
					self:playcommand("Show")
				end
			end;
			SelectMenuClosedMessageCommand=cmd(playcommand,"Hide");
		};
	};
	Def.ActorFrame{
		Name="LengthReflection";
		InitCommand=cmd(visible,not GAMESTATE:IsCourseMode());

		LoadActor(THEME:GetPathG("_pane","elements/_length"))..{
			InitCommand=cmd(x,SCREEN_CENTER_X+20;y,SCREEN_CENTER_Y-34;valign,1;diffusealpha,0;ztest,true;zoomx,.6;zoomy,-.6;);
			ShowCommand=cmd(stoptweening;linear,0.2;diffusealpha,1);
			HideCommand=cmd(stoptweening;linear,0.2;diffusealpha,0;);
			SelectMenuOpenedMessageCommand=function(self)
				if not GAMESTATE:GetCurrentSong() then
					self:playcommand("Hide")
				else
					self:playcommand("Show")
				end
			end;
			SelectMenuClosedMessageCommand=cmd(playcommand,"Hide");
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-14;y,SCREEN_CENTER_Y-23;diffusealpha,0;shadowlength,0;horizalign,left;zoomx,.6;zoomy,-.6;visible,not GAMESTATE:IsCourseMode());
			OnCommand=cmd(addx,SCREEN_WIDTH;decelerate,0.75;addx,-SCREEN_WIDTH;);
			OffCommand=cmd(linear,.12;diffusealpha,0;);
			ShowCommand=cmd(stoptweening;linear,0.2;diffusealpha,1);
			HideCommand=cmd(stoptweening;linear,0.2;diffusealpha,0;);
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				if song then
					self:visible(true)
					self:settext(string.format("Song Length: %s",SecondsToMMSS(song:MusicLengthSeconds())))
				else
					self:visible(false)
				end
			end;
			SelectMenuOpenedMessageCommand=function(self)
				if not GAMESTATE:GetCurrentSong() then
					self:playcommand("Hide")
				else
					self:playcommand("Show")
				end
			end;
			SelectMenuClosedMessageCommand=cmd(playcommand,"Hide");
		};
	};

	Def.ActorFrame{
		Name="Frame";
		LoadActor("frame")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+140;y,SCREEN_CENTER_Y-20);
			OnCommand=cmd(addx,SCREEN_WIDTH;decelerate,0.75;addx,-SCREEN_WIDTH);
			OffCommand=cmd(accelerate,0.75;addx,SCREEN_WIDTH);
		};
		LoadFont("_v 26px bold diffuse")..{
			Text="ARTIST:";
			InitCommand=cmd(x,SCREEN_CENTER_X+10;y,SCREEN_CENTER_Y-24);
			OnCommand=cmd(diffusealpha,1;shadowlength,2.5;zoom,.5;addx,SCREEN_WIDTH;decelerate,0.75;addx,-SCREEN_WIDTH);
			OffCommand=cmd(accelerate,0.75;addx,SCREEN_WIDTH);
		};
		LoadFont("_v 26px bold diffuse")..{
			Text="BPM:";
			InitCommand=cmd(x,SCREEN_CENTER_X+280;y,SCREEN_CENTER_Y-24);
			OnCommand=cmd(diffusealpha,1;shadowlength,2.5;zoom,.5;addx,SCREEN_WIDTH;decelerate,0.75;addx,-SCREEN_WIDTH);
			OffCommand=cmd(accelerate,0.75;addx,SCREEN_WIDTH);
		};
	};
};

return t;