local t = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(CenterX;y,SCREEN_TOP+27;addy,-100;);
		OnCommand=cmd(sleep,0.5;queuecommand,"TweenOn");
		OffCommand=cmd(queuecommand,"TweenOff");
		TweenOnCommand=cmd(decelerate,0.8;addy,100);
		-- xxx: if any player full comboed, sleep 3
		TweenOffCommand=cmd(accelerate,0.8;addy,-100);
		Def.SongMeterDisplay{
			InitCommand=cmd(SetStreamWidth,292);
			Stream=LoadActor("meter stream");
			Tip=LoadActor("tip");
		};
	};
	Def.ActorFrame{
		OnCommand=cmd(addy,-100;sleep,0.5;queuecommand,"TweenOn");
		OffCommand=cmd(queuecommand,"TweenOff");
		TweenOnCommand=cmd(decelerate,0.8;addy,100);
		-- todo: full combo
		TweenOffCommand=cmd(accelerate,0.8;addy,-100);

		LoadActor("width")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-190;y,SCREEN_TOP+23;halign,1);
			OnCommand=cmd(sleep,1.5;linear,.1;zoomtowidth,SCREEN_WIDTH/2-200);
		};
		LoadActor("width")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+190;y,SCREEN_TOP+23;halign,0);
			OnCommand=cmd(sleep,1.5;linear,.1;zoomtowidth,SCREEN_WIDTH/2-200);
		};
		LoadActor("left")..{
			InitCommand=cmd(x,SCREEN_CENTER_X-193;y,SCREEN_TOP+23;halign,1);
			OnCommand=cmd(sleep,1.5;linear,.1;x,SCREEN_LEFT+16);
		};
		LoadActor("left")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+193;y,SCREEN_TOP+23;halign,1;zoomx,-1);
			OnCommand=cmd(sleep,1.5;linear,.1;x,SCREEN_RIGHT-16);
		};
		LoadActor("base")..{ InitCommand=cmd(CenterX;y,SCREEN_TOP+24); };
		LoadActor("_neons")..{
			InitCommand=cmd(CenterX;y,SCREEN_TOP+24;blend,Blend.Add);
			--effectdelay,0.5;
			OnCommand=cmd(effectclock,'beat';diffuseramp;effectcolor1,color("#007892");effectcolor2,color("#00EAFF");effectperiod,0.5;effectoffset,0.05;diffusealpha,0;linear,.4;diffusealpha,1;);
		};
		LoadActor("_neons")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+24);
			--effectdelay,0.5;
			OnCommand=cmd(effectclock,'beat';diffuseramp;effectcolor1,color("#FFFFFF00");effectcolor2,color("#00EAFF");effectperiod,0.5;effectoffset,0.05;diffusealpha,0;linear,.4;diffusealpha,1;);
		};
		LoadFont("_serpentine outline")..{
			InitCommand=cmd(CenterX;y,SCREEN_TOP+23;maxwidth,540*0.6825;diffusebottomedge,color("#dedede"));
			OnCommand=cmd(addy,3;zoom,.5;shadowlength,2;zoomy,0;sleep,2;decelerate,0.3;zoomy,.45;animate,0;playcommand,"Update");
			CurrentSongChangedMessageCommand=cmd(playcommand,"Update");
			UpdateCommand=function(self)
				local text = ""
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if song then
					text = song:GetDisplayFullTitle()
				end
				if course then
					text = course:GetDisplayFullTitle() .. " - " .. text;
				end
				self:settext(text);
			end;
		};
	};

	-- difficulty
	Def.ActorFrame{
		OnCommand=cmd(draworder,1;sleep,0.5;queuecommand,"TweenOn");
		OffCommand=cmd(queuecommand,"Hide");
		ShowGameplayTopFrameMessageCommand=cmd(playcommand,"TweenOn");
		HideGameplayTopFrameMessageCommand=cmd(queuecommand,"Hide");
		HideCommand=function(self)
			--if AnyPlayerFullComboed() then self:sleep(3) end
			self:queuecommand('TweenOff')
		end;

		Def.ActorFrame{
			Name="Player1";
			OnCommand=cmd(player,PLAYER_1;x,SCREEN_CENTER_X-256;y,SCREEN_TOP+32;addx,-SCREEN_WIDTH/3);
			TweenOnCommand=cmd(sleep,1.5;decelerate,0.5;addx,SCREEN_WIDTH/3);
			TweenOffCommand=cmd(accelerate,0.8;addx,-SCREEN_WIDTH/3);

			LoadActor(THEME:GetPathB("ScreenGameplay","overlay/_extreme/_difficulty icons"))..{
				InitCommand=cmd(pause;playcommand,"Update");
				UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps then
						self:visible(true)
						self:setstate(DifficultyToState(steps:GetDifficulty()))
					else
						self:visible(false)
					end
				end;
			};
			LoadActor(THEME:GetPathB("ScreenGameplay","overlay/_extreme/_difficulty names"))..{
				InitCommand=cmd(pause;playcommand,"Update");
				UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps then
						self:visible(true)
						self:setstate(DifficultyToState(steps:GetDifficulty()))
					else
						self:visible(false)
					end
				end;
			};
		};

		Def.ActorFrame{
			Name="Player2";
			OnCommand=cmd(player,PLAYER_2;x,SCREEN_CENTER_X+256;y,SCREEN_TOP+32;addx,SCREEN_WIDTH/3);
			TweenOnCommand=cmd(sleep,1.5;decelerate,0.5;addx,-SCREEN_WIDTH/3);
			TweenOffCommand=cmd(accelerate,0.8;addx,SCREEN_WIDTH/3);

			LoadActor(THEME:GetPathB("ScreenGameplay","overlay/_extreme/_difficulty icons"))..{
				InitCommand=cmd(pause;zoomx,-1;playcommand,"Update");
				UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps then
						self:visible(true)
						self:setstate(DifficultyToState(steps:GetDifficulty()))
					else
						self:visible(false)
					end
				end;
			};
			LoadActor(THEME:GetPathB("ScreenGameplay","overlay/_extreme/_difficulty names"))..{
				InitCommand=cmd(x,19;pause;playcommand,"Update");
				UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps then
						self:visible(true)
						self:setstate(DifficultyToState(steps:GetDifficulty()))
					else
						self:visible(false)
					end
				end;
			};
		};
	};
};

return t;