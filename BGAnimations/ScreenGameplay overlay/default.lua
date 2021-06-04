local t = Def.ActorFrame{
	LoadActor(GetSongFrame());

	-- rave names
	Def.ActorFrame{
		Name="RaveNames";
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+58):visible(GAMESTATE:GetPlayMode() == 'PlayMode_Rave') end;
		OnCommand=function(self) self:addy(-100):sleep(0.5):decelerate(0.8):addy(100) end;
		OffCommand=function(self) self:accelerate(0.8):addy(-100) end;

		LoadFont("_v 26px bold black")..{
			InitCommand=function(self) self:x(-254):zoom(.55):shadowlength(0):maxwidth(180) end;
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_1) then
					self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_1));
				end
			end;
		};
		LoadFont("_v 26px bold black")..{
			InitCommand=function(self) self:x(254):zoom(.55):shadowlength(0):maxwidth(180) end;
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_2) then
					self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_2));
				end
			end;
		};
	};

	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("0,0,0,1")) end;
		OnCommand=function(self) self:linear(0.3):diffusealpha(0) end;
	};

	Def.ActorFrame{
		Name="ScreenStageHoldovers";
		InitCommand=function(self) self:visible(not GAMESTATE:IsDemonstration() and not GAMESTATE:IsCourseMode()) end;

		LoadActor(THEME:GetPathB("ScreenStageInformation","in/bottom/bar"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+156):zoomtowidth(SCREEN_WIDTH):faderight(.8):fadeleft(.8) end;
			OnCommand=function(self) self:sleep(2.25):cropright(0):linear(.6):cropleft(1) end;
		};
		Def.ActorFrame{
			Name="InfoP1";
			InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end;
			-- stage background left gradient
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_left gradient"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+150):horizalign(left) end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- stage background p1
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_p1"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+150):horizalign(left) end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- step artist p1
			LoadFont("_r bold 30px")..{
				Text="Step Artist:";
				InitCommand=function(self) self:x(SCREEN_LEFT+5):y(SCREEN_CENTER_Y+172):zoom(.6):halign(0):shadowlength(2) end;
				BeginCommand=function(self)
					local pm = GAMESTATE:GetPlayMode()
					local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and show)
				end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- step desc p1
			LoadFont("_r bold 30px")..{
				Name="AuthorText";
				InitCommand=function(self) self:x(SCREEN_LEFT+100):y(SCREEN_CENTER_Y+172):shadowlength(2):halign(0):zoom(.6) end;
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
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- player name p1
			LoadFont("_r bold 30px")..{
			Name="PlayerName";
			InitCommand=function(self) self:x(SCREEN_LEFT+44):y(SCREEN_CENTER_Y+142):shadowlength(2):halign(0):zoom(.8) end;
				BeginCommand=function(self)
					self:settext( PROFILEMAN:GetPlayerName(PLAYER_1) )
				end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
		};
		Def.ActorFrame{
			Name="InfoP2";
			InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end;
			-- stage background right gradient
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_right gradient"))..{
				InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+150):horizalign(right) end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- stage background p2
			LoadActor(THEME:GetPathB("ScreenStageInformation","in/_p2"))..{
				InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+150):horizalign(right) end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- step artist p2
			LoadFont("_r bold 30px")..{
				Text=":Step Artist";
				InitCommand=function(self) self:x(SCREEN_RIGHT-5):y(SCREEN_CENTER_Y+172):zoom(.6):halign(1):shadowlength(2) end;
				BeginCommand=function(self)
					local pm = GAMESTATE:GetPlayMode()
					local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and show)
				end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- step desc p2
			LoadFont("_r bold 30px")..{
				Name="AuthorText";
				InitCommand=function(self) self:x(SCREEN_RIGHT-100):y(SCREEN_CENTER_Y+172):shadowlength(2):halign(1):zoom(.6) end;
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
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
			-- player name p2
			LoadFont("_r bold 30px")..{
				Name="PlayerName";
				InitCommand=function(self) self:x(SCREEN_RIGHT-44):y(SCREEN_CENTER_Y+142):shadowlength(2):halign(1):zoom(.8) end;
				BeginCommand=function(self)
					self:settext( PROFILEMAN:GetPlayerName(PLAYER_2) )
				end;
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end;
			};
		};
	};

	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+147):maxwidth(SCREEN_WIDTH/8*7):shadowlength(2):horizalign(center):zoom(.5):diffusealpha(1) end;
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
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end;
	};
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+167):maxwidth(SCREEN_WIDTH/8*6.8):shadowlength(2):horizalign(center):zoom(.4):diffusealpha(1) end;
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
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end;
	};

	-- demo
	Def.ActorFrame{
		Name="DemonstrationFrame";
		BeginCommand=function(self) self:visible(GAMESTATE:IsDemonstration() and SCREENMAN:GetTopScreen():GetName() ~= 'ScreenJukebox') end;
		LoadActor(THEME:GetPathB("_metallic","streak"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+43):zoomtowidth(SCREEN_WIDTH) end;
			OnCommand=function(self) self:diffusealpha(.9):fadeleft(1):faderight(1) end;
		};
		LoadFont("_z 36px black")..{
			Text="DEMO";
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+43):zoom(.7) end;
			OnCommand=function(self) self:pulse():effectmagnitude(1.0,0.95,0):effectclock('beat'):effectperiod(1) end;
		};
		LoadActor("demonstration gradient")..{
			InitCommand=function(self) self:Center():FullScreen():diffusealpha(0.8) end;
		};
	};
};

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("FCSplash", pn)
end;

return t;