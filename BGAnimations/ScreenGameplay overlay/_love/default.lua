local t = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+24):addy(-100) end;
		OnCommand=function(self) self:sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(self) self:queuecommand("TweenOff") end;
		ShowGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOn") end;
		HideGameplayTopFrameMessageCommand=function(self) self:playcommand("TweenOff") end;
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end;
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
		LoadActor("_base shade");
	};

	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+27):addy(-100) end;
		OnCommand=function(self) self:sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(self) self:queuecommand("TweenOff") end;
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end;
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
		Def.SongMeterDisplay{
			InitCommand=function(self) self:SetStreamWidth(292) end;
			Stream=LoadActor("meter stream");
			Tip=LoadActor("tip")..{
				OnCommand=function(self) self:zoom(0):sleep(1.8):zoom(1):diffuseshift():effectcolor1(color("1,1,1,1")):effectcolor2(color("1,1,1,.5")):effectclock("beat"):effectperiod(4) end;
			};
		};
	};
	Def.ActorFrame{
		StandardDecorationFromFile("BPMDisplay","BPMDisplay");
	};
	Def.ActorFrame{
		OnCommand=function(self) self:addy(-100):sleep(0.5):queuecommand("TweenOn") end;
		OffCommand=function(self) self:queuecommand("TweenOff") end;
		TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end;
		TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;

		LoadActor("_uplight")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+24):blend(Blend.Add) end;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#4c0a0a")):effectcolor2(color("#ff5454")):effectperiod(1):effectoffset(0):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadActor("_uplight")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_TOP-2+24) end;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#ff4c4c")):effectperiod(1):effectoffset(0):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadActor("width")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-190):y(SCREEN_TOP-2+24):halign(1):zoomtowidth(3) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):zoomtowidth(SCREEN_WIDTH/2-200) end;
		};
		LoadActor("width")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+190):y(SCREEN_TOP-2+24):halign(0):zoomtowidth(3) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):zoomtowidth(SCREEN_WIDTH/2-200) end;
		};
		LoadActor("left")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-193):y(SCREEN_TOP-2+24):halign(1) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):x(SCREEN_LEFT+16) end;
		};
		LoadActor("left")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+193):y(SCREEN_TOP-2+24):halign(1):zoomx(-1) end;
			OnCommand=function(self) self:sleep(1.5):linear(.1):x(SCREEN_RIGHT-16) end;
		};
		LoadActor("base.png")..{ InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+24) end; };
		LoadActor("bpmbase")..{ InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+59) end; };
		LoadActor("_neons")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+24):blend(Blend.Add) end;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#4c0a0a")):effectcolor2(color("#ff5454")):effectperiod(1):effectoffset(0.05):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadActor("_neons")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_TOP-2+24) end;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#ff4c4c")):effectperiod(1):effectoffset(0.05):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadActor("bpmneon")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+49):blend(Blend.Add) end;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#4c0a0a")):effectcolor2(color("#ff5454")):effectperiod(1):effectoffset(0.05):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadActor("bpmneon")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_TOP-2+49) end;
			OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#ff4c4c")):effectperiod(1):effectoffset(0.05):diffusealpha(0):linear(.4):diffusealpha(1) end;
		};
		LoadFont("_r bold 30px")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP-2+23):maxwidth(540):diffusebottomedge(color("#dedede")) end;
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
			if AnyPlayerFullComboed() then self:sleep(1) end;
			self:queuecommand('TweenOff')
		end;

		Def.ActorFrame{
			Name="Player1";
			OnCommand=function(self) self:player(PLAYER_1):x(SCREEN_CENTER_X-240):y(SCREEN_TOP-2+29):addx(-SCREEN_WIDTH/3) end;
			TweenOnCommand=function(self) self:sleep(1.5):decelerate(0.5):addx(SCREEN_WIDTH/3) end;
			TweenOffCommand=function(self) self:accelerate(0.8):addx(-SCREEN_WIDTH/3) end;

			LoadActor("_difficulty icons")..{
				InitCommand=function(self) self:pause():playcommand("Update") end;
				UpdateCommand=function(self)
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					local course = GAMESTATE:GetCurrentTrail(PLAYER_1)
					if course then
						self:visible(true)
						self:setstate(DifficultyToState(course:GetDifficulty()))
					elseif steps then
						self:visible(true)
						self:setstate(DifficultyToState(steps:GetDifficulty()))
					else
						self:visible(false)
					end
				end;
			};
			LoadActor("difficulty glow")..{
				InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):draworder(110) end;
				OnCommand=function(self) self:sleep(2.4):decelerate(.5):diffusealpha(1):sleep(.2):decelerate(.8):diffusealpha(0):sleep(0) end;
				OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
			};
		};

		Def.ActorFrame{
			Name="Player2";
			OnCommand=function(self) self:player(PLAYER_2):x(SCREEN_CENTER_X+240):y(SCREEN_TOP-2+29):addx(SCREEN_WIDTH/3) end;
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
			LoadActor("difficulty glow")..{
				InitCommand=function(self) self:zoomx(-1):blend(Blend.Add):diffusealpha(0):draworder(110) end;
				OnCommand=function(self) self:sleep(2.4):decelerate(.5):diffusealpha(1):sleep(.2):decelerate(.8):diffusealpha(0):sleep(0) end;
				OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
			};
		};
	};
};

return t;