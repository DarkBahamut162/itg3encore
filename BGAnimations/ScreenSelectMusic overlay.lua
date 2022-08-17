local t = Def.ActorFrame{
	OffCommand = function(self, params)
		if isOni() then
			for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
				local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
				if playeroptions:MMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:MMod().."m",pn) break end
				if playeroptions:AMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:AMod().."a",pn) break end
				if playeroptions:CAMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:CAMod().."ca",pn) break end
				if playeroptions:XMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:XMod().."x",pn) end
				if playeroptions:CMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:CMod().."c",pn) end
			end
		end
	end;
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))..{
		InitCommand=function(self) self:ztest(true) end
	},
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),

	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_top")),

	StandardDecorationFromFileOptional("StyleIcon","StyleIcon"),
	StandardDecorationFromFileOptional("StageDisplay","StageDisplay"),

	Def.ActorFrame{
		Name="SelButtonMenu";
		InitCommand=function(self) self:y(SCREEN_BOTTOM-54):visible(DifficultyChangingAvailable()) end;
		LoadFont("_v 26px bold white")..{
			Text="&START; Change Sort";
			InitCommand=function(self) self:CenterX():zoomx(0.3):zoomy(0.6):diffusealpha(0):shadowlength(2) end;
			OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
			SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.6) end;
			SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.3) end;
		};
		Def.ActorFrame{
			Name="Easier";
			InitCommand=function(self)
				self:x(SCREEN_CENTER_X-100)
			end;
			LoadFont("_v 26px bold black")..{
				Text="&MENULEFT;";
				OnCommand=function(self) self:addy(36):x(-5):horizalign(right):zoomx(0.5):zoomy(0.7):diffusealpha(0):shadowlength(0) end;
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7) end;
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Easier";
				OnCommand=function(self) self:addy(36):x(0):horizalign(left):zoomx(0.5):zoomy(0.7):diffusealpha(0):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock('beat'):effectcolor1(color("#FFFFFF")):effectcolor2(color("#20D020")):shadowlength(0) end;
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7) end;
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5) end;
			};
		};
		Def.ActorFrame{
			Name="Harder";
			InitCommand=function(self)
				self:x(SCREEN_CENTER_X+100)
			end;
			LoadFont("_v 26px bold black")..{
				Text="Harder";
				OnCommand=function(self) self:addy(36):x(0):horizalign(right):zoomx(0.5):zoomy(0.7):diffusealpha(0):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock('beat'):effectcolor1(color("#FFFFFF")):effectcolor2(color("#E06060")):shadowlength(0) end;
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7) end;
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="&MENURIGHT;";
				OnCommand=function(self) self:addy(36):x(15):horizalign(center):zoomx(0.5):zoomy(0.7):diffusealpha(0):shadowlength(0) end;
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7) end;
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5) end;
			};
		};
	};

	-- stepartist crap
	Def.ActorFrame{
		Name="StepArtistP1";
		InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM-109):addx(-SCREEN_WIDTH):player(PLAYER_1):draworder(-2) end;
		OnCommand=function(self) self:decelerate(0.75):addx(SCREEN_WIDTH) end;
		OffCommand=function(self) self:accelerate(0.75):addx(-SCREEN_WIDTH) end;
		ShowCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-127) end;
		HideCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-109) end;
		SelectMenuOpenedMessageCommand=function(self)
			self:playcommand((GAMESTATE:GetCurrentSong() or GAMESTATE:GetCurrentCourse()) and "Show" or "Hide")
		end;
		SelectMenuClosedMessageCommand=function(self) self:playcommand("Hide") end;

		LoadActor(THEME:GetPathG("_pane","elements/_artist"))..{
			InitCommand=function(self) self:horizalign(left):zoom(0.5) end;
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=function(self) self:maxwidth(350):horizalign(left):x(20):y(2):shadowlength(0.5):zoom(0.5) end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Update") end;
			CurrentStepsP1ChangedMessageCommand=function(self) self:playcommand("Update") end;
			CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Update") end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				local course = GAMESTATE:GetCurrentCourse();
				local artist = ""
				local result = ""
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps ~= nil then
						result = "Stepartist: " .. steps:GetAuthorCredit()
					else
						result = "Stepartist: Unknown"
					end
				elseif course then
					local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							--prevent duplicates ~DarkBahamut162
							if not string.find(artist,entries[i]:GetSteps():GetAuthorCredit()) then
								if i == 1 then
									artist = entries[i]:GetSteps():GetAuthorCredit()
								elseif i < #entries then
									artist = artist .. ", " .. entries[i]:GetSteps():GetAuthorCredit()
								end
								if string.len(artist) >= 50 then
									artist = "Various"
									break
								end
							end
						end
						if artist then
							result = "Stepartist: " .. artist
						else
							result = "Stepartist: Unknown"
						end
					else
						result = "Stepartist: Unknown"
					end
				else
					self:playcommand("SelectMenuClosedMessageCommand")
				end

				if string.find(artist, "C. Foy") or string.find(artist, "Foy") then
					self:diffuseshift()
					self:effectclock("beat")
					self:effectcolor1(color("1,0.9,0.9,1"))
					self:effectcolor2(color("1,0.75,0.75,1"))
				else
					self:stopeffect()
				end

				self:settext(result)
			end;
		};
	};
	Def.ActorFrame{
		Name="StepArtistP2";
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM-109):addx(SCREEN_WIDTH):player(PLAYER_2):draworder(-2) end;
		OnCommand=function(self) self:decelerate(0.75):addx(-SCREEN_WIDTH) end;
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
		ShowCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-127) end;
		HideCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-109) end;
		SelectMenuOpenedMessageCommand=function(self)
			self:playcommand((GAMESTATE:GetCurrentSong() or GAMESTATE:GetCurrentCourse()) and "Show" or "Hide")
		end;
		SelectMenuClosedMessageCommand=function(self) self:playcommand("Hide") end;

		LoadActor(THEME:GetPathG("_pane","elements/_artist"))..{
			InitCommand=function(self) self:horizalign(left):zoomx(-.5):zoomy(0.5) end;
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=function(self) self:maxwidth(350):horizalign(right):x(-20):y(2):shadowlength(0.5):zoom(0.5) end;
			CurrentSongChangedMessageCommand=function(self) self:playcommand("Update") end;
			CurrentCourseChangedMessageCommand=function(self) self:playcommand("Update") end;
			CurrentStepsP2ChangedMessageCommand=function(self) self:playcommand("Update") end;
			CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Update") end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong();
				local course = GAMESTATE:GetCurrentCourse();
				local artist = ""
				local result = ""
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps ~= nil then
						result = "Stepartist: " .. steps:GetAuthorCredit()
					else
						result = "Stepartist: Unknown"
					end
				elseif course then
					local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							--prevent duplicates ~DarkBahamut162
							if not string.find(artist,entries[i]:GetSteps():GetAuthorCredit()) then
								if i == 1 then
									artist = entries[i]:GetSteps():GetAuthorCredit()
								elseif i < #entries then
									artist = artist .. ", " .. entries[i]:GetSteps():GetAuthorCredit()
								end
							end
						end
						if artist then
							result = "Stepartist: " .. artist
						else
							result = "Stepartist: Unknown"
						end
					else
						result = "Stepartist: Unknown"
					end
				else
					self:playcommand("SelectMenuClosedMessageCommand")
				end

				if string.find(artist, "C. Foy") or string.find(artist, "Foy") then
					self:diffuseshift()
					self:effectclock("beat")
					self:effectcolor1(color("1,0.9,0.9,1"))
					self:effectcolor2(color("1,0.75,0.75,1"))
				else
					self:stopeffect()
				end

				self:settext(result)
			end;
		};
	};

	-- stuff behind panedisplay, idk
	Def.ActorFrame{
		Name="Pane";
		InitCommand=function(self) self:draworder(-1) end;

		LoadActor(THEME:GetPathG("_pane","elements/_ldifficulty"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+12):y(SCREEN_BOTTOM-8):horizalign(right):vertalign(bottom):player(PLAYER_1) end;
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):sleep(0.5):decelerate(0.75):addx(SCREEN_WIDTH) end;
			OffCommand=function(self) self:accelerate(0.75):addx(-SCREEN_WIDTH) end;
		};
		LoadActor(THEME:GetPathG("_pane","elements/_ldifficulty"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-12):y(SCREEN_BOTTOM-8):zoomx(-1):horizalign(right):vertalign(bottom):player(PLAYER_2) end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):sleep(0.5):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
		};

		LoadActor(THEME:GetPathG("_pane","elements/_lbase"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+26):y(SCREEN_BOTTOM):horizalign(right):vertalign(bottom) end;
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end;
		};
		LoadActor(THEME:GetPathG("_pane","elements/_basewidth"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-174):y(SCREEN_BOTTOM):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end;
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end;
		};
		LoadActor(THEME:GetPathG("_pane","elements/_rbase"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-26):y(SCREEN_BOTTOM):horizalign(left):vertalign(bottom) end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
		LoadActor(THEME:GetPathG("_pane","elements/_basewidth"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+174):y(SCREEN_BOTTOM):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
	};

	Def.ActorFrame{
		Name="LightP1";
		InitCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local isDouble = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and not isDouble)
		end;
		LoadActor(THEME:GetPathG("_pane","elements/_lneon"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-90):y(SCREEN_BOTTOM-76):horizalign(right):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end;
		};
		LoadActor(THEME:GetPathG("_pane","elements/_neonwidth"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-146):y(SCREEN_BOTTOM-76):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end;
		};
	};
	Def.ActorFrame{
		Name="LightP2";
		InitCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local isDouble = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and not isDouble)
		end;
		LoadActor(THEME:GetPathG("_pane","elements/_rneon"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+90):y(SCREEN_BOTTOM-76):horizalign(left):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
		LoadActor(THEME:GetPathG("_pane","elements/_neonwidth"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+146):y(SCREEN_BOTTOM-76):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
	};
	Def.ActorFrame{
		Name="LightDouble";
		InitCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local isDouble = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(isDouble)
		end;
		Def.ActorFrame{
			Name="LeftSide";
			LoadActor(THEME:GetPathG("_pane","elements/_lneon"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-90):y(SCREEN_BOTTOM-76):horizalign(right):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
				OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end;
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end;
			};
			LoadActor(THEME:GetPathG("_pane","elements/_neonwidth"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-146):y(SCREEN_BOTTOM-76):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
				OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end;
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end;
			};
		};
		Def.ActorFrame{
			Name="RightSide";
			LoadActor(THEME:GetPathG("_pane","elements/_rneon"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X+90):y(SCREEN_BOTTOM-76):horizalign(left):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
				OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end;
			};
			LoadActor(THEME:GetPathG("_pane","elements/_neonwidth"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+146):y(SCREEN_BOTTOM-76):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end;
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end;
		};
		};
	};

	-- panedisplay stuff
	Def.ActorFrame{
		Name="PaneDisplayArea";
		InitCommand=function(self) self:y(SCREEN_BOTTOM-184) end;

		Def.ActorFrame{
			Name="PaneDisplayP1";
			InitCommand=function(self) self:x(SCREEN_LEFT+SCREEN_WIDTH/5.415):player(PLAYER_1) end;
			LoadActor(THEME:GetPathG("_pane","icons"));
			LoadActor(THEME:GetPathG("_pane","fill"),PLAYER_1);
			LoadActor(THEME:GetPathG("_pane","steps"),PLAYER_1);
			LoadActor(THEME:GetPathG("_player","scores"),PLAYER_1);
		};
		Def.ActorFrame{
			Name="PaneDisplayP2";
			InitCommand=function(self) self:x(SCREEN_RIGHT-SCREEN_WIDTH/5.415):player(PLAYER_2) end;
			LoadActor(THEME:GetPathG("_pane","icons"));
			LoadActor(THEME:GetPathG("_pane","fill"),PLAYER_2);
			LoadActor(THEME:GetPathG("_pane","steps"),PLAYER_2);
			LoadActor(THEME:GetPathG("_player","scores"),PLAYER_2);
		};
	};
	LoadActor(THEME:GetPathG("_pane","numbers"),PLAYER_1)..{
		InitCommand=function(self) self:x(SCREEN_LEFT+SCREEN_WIDTH/5.415):y(SCREEN_BOTTOM-54):player(PLAYER_1) end;
	};
	LoadActor(THEME:GetPathG("_pane","numbers"),PLAYER_2)..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-SCREEN_WIDTH/5.415):y(SCREEN_BOTTOM-54):player(PLAYER_2) end;
	};

	-- options message!
	LoadActor(THEME:GetPathG("ScreenSelectMusic","OptionsMessage"))..{
		InitCommand=function(self) self:Center():pause():diffusealpha(0) end;
		ShowPressStartForOptionsCommand=function(self) self:zoom(1.15):diffusealpha(0):decelerate(0.07):zoom(1):diffusealpha(1) end;
		ShowEnteringOptionsCommand=function(self) self:stoptweening():zoomy(0):setstate(1):accelerate(0.07):zoomy(1) end;
		HidePressStartForOptionsCommandCommand=function(self) self:stoptweening():linear(0.3):cropleft(1.3) end;
	};

	Def.ActorFrame{
		Name="OptionsListBaseP1";
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220):y(SCREEN_CENTER_Y+22) end;
		LoadActor(THEME:GetPathG("options","pane"))..{
			InitCommand=function(self) self:diffusealpha(0):zoomx(0.6) end;
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then
					self:stoptweening():linear(0.2):diffusealpha(1):zoomx(1)
				end
			end;
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then
					self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.6)
				end
			end;
		};
		LoadActor(THEME:GetPathG("options","pane"))..{
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0) end;
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then
					self:stoptweening():diffusealpha(0)
				end
			end;
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then
					self:stoptweening():diffusealpha(0)
				end
			end;
			OptionsListResetMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then
					self:stoptweening():diffusealpha(1):linear(0.2):diffusealpha(0)
				end
			end;
		};
	};
	Def.ActorFrame{
		Name="OptionsListBaseP2";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+220):y(SCREEN_CENTER_Y+22) end;
		LoadActor(THEME:GetPathG("options","pane"))..{
			InitCommand=function(self) self:zoomx(-1):diffusealpha(0):zoomx(0.6) end;
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then
					self:stoptweening():linear(0.2):diffusealpha(1):zoomx(1)
				end
			end;
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then
					self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.6)
				end
			end;
		};
		LoadActor(THEME:GetPathG("options","pane"))..{
			InitCommand=function(self) self:zoomx(-1):blend(Blend.Add):diffusealpha(0) end;
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then
					self:stoptweening():diffusealpha(0)
				end
			end;
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then
					self:stoptweening():diffusealpha(0)
				end
			end;
			OptionsListResetMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then
					self:stoptweening():diffusealpha(1):linear(0.2):diffusealpha(0)
				end
			end;
		};
	};

	LoadActor(THEME:GetPathB("","_coins"));
};

return t;