local t = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+27):addy(-100) end;
		OnCommand=function(self) self:sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(self) self:queuecommand("TweenOff") end;
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end;
		-- xxx: if any player full comboed, sleep 3
		TweenOffCommand=function(self) self:accelerate(0.8):addy(-100) end;
		Def.SongMeterDisplay{
			InitCommand=function(self) self:SetStreamWidth(292) end;
			Stream=LoadActor("meter stream");
			Tip=LoadActor("tip");
		};
	};
	Def.ActorFrame{
		OnCommand=function(self) self:addy(-100):sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(self) self:queuecommand("TweenOff") end;
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end;
		-- todo: full combo
		TweenOffCommand=function(self) self:accelerate(0.8):addy(-100) end;

		LoadActor("width")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-190):y(SCREEN_TOP+23):halign(1) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):zoomtowidth(SCREEN_WIDTH/2-200) end;
		};
		LoadActor("width")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+190):y(SCREEN_TOP+23):halign(0) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):zoomtowidth(SCREEN_WIDTH/2-200) end;
		};
		LoadActor("left")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-193):y(SCREEN_TOP+23):halign(1) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):x(SCREEN_LEFT+16) end;
		};
		LoadActor("left")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+193):y(SCREEN_TOP+23):halign(1):zoomx(-1) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):x(SCREEN_RIGHT-16) end;
		};
		LoadActor("base")..{ InitCommand=function(self) self:CenterX():y(SCREEN_TOP+24) end; };
		LoadActor("_neons")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+24):blend(Blend.Add) end;
			--effectdelay,0.5;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#007892")):effectcolor2(color("#00EAFF")):effectperiod(0.5):effectoffset(0.05):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadActor("_neons")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_TOP+24) end;
			--effectdelay,0.5;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#00EAFF")):effectperiod(0.5):effectoffset(0.05):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadFont("_serpentine outline")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP+23):maxwidth(540*0.6825):diffusebottomedge(color("#dedede")) end;
			OnCommand=function(self) self:addy(3):zoom(.5):shadowlength(2):zoomy(0):sleep(2):decelerate(0.3):zoomy(.45):animate(0):playcommand("Update") end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end;
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
		OnCommand=function(self) self:draworder(1):sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(self) self:queuecommand("Hide") end;
		ShowGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOn") end;
		HideGameplayTopFrameMessageCommand=function(self) self:queuecommand("Hide") end;
		HideCommand=function(self)
			--if AnyPlayerFullComboed() then self:sleep(3) end
			self:queuecommand('TweenOff')
		end;

		Def.ActorFrame{
			Name="Player1";
			OnCommand=function(self) self:player(PLAYER_1):x(SCREEN_CENTER_X-256):y(SCREEN_TOP+32):addx(-SCREEN_WIDTH/3) end;
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(SCREEN_WIDTH/3) end;
			TweenOffCommand=function(self) self:accelerate(0.8):addx(-SCREEN_WIDTH/3) end;

			LoadActor("_difficulty icons")..{
				InitCommand=function(self) self:pause():playcommand("Update") end;
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
			LoadActor("_difficulty names")..{
				InitCommand=function(self) self:pause():playcommand("Update") end;
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
			OnCommand=function(self) self:player(PLAYER_2):x(SCREEN_CENTER_X+256):y(SCREEN_TOP+32):addx(SCREEN_WIDTH/3) end;
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(-SCREEN_WIDTH/3) end;
			TweenOffCommand=function(self) self:accelerate(0.8):addx(SCREEN_WIDTH/3) end;

			LoadActor("_difficulty icons")..{
				InitCommand=function(self) self:pause():zoomx(-1):playcommand("Update") end;
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
			LoadActor("_difficulty names")..{
				InitCommand=function(self) self:x(19):pause():playcommand("Update") end;
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