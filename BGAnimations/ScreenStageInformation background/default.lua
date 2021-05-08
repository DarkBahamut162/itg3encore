local t = Def.ActorFrame{
	LoadActor("top");
	LoadActor("bottom");
	LoadActor("highlight")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+5):y(SCREEN_CENTER_Y+60) end;
		OnCommand=function(self) self:diffusealpha(0):decelerate(0.2):diffusealpha(1) end;
	};

	Def.ActorFrame{
		Name="P1Frame";
		InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end;
		LoadActor("_left gradient")..{ InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+150):halign(0) end; };
		LoadActor("_p1")..{ InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+150):halign(0) end; };
		LoadFont("_r bold 30px")..{
			Text="Step Artist:";
			InitCommand=function(self) self:x(SCREEN_LEFT+5):y(SCREEN_CENTER_Y+172):zoom(.6):halign(0):shadowlength(2) end;
			BeginCommand=function(self)
				local pm = GAMESTATE:GetPlayMode()
				local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
				self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and show)
			end;
		};
		LoadFont("_r bold 30px")..{
			Name="AuthorText";
			InitCommand=function(self) self:x(SCREEN_LEFT+100):y(SCREEN_CENTER_Y+172):shadowlength(2):halign(0):zoom(.6) end;
			SetCommand=function(self)
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
			OnCommand=function(self) self:playcommand("Set") end;
		};
		LoadFont("_r bold 30px")..{
			Name="PlayerName";
			InitCommand=function(self) self:x(SCREEN_LEFT+44):y(SCREEN_CENTER_Y+142):shadowlength(2):halign(0):zoom(.8) end;
			SetCommand=function(self)
				self:settext( PROFILEMAN:GetPlayerName(PLAYER_1) )
			end;
			OnCommand=function(self) self:playcommand("Set") end;
		};
	};
	Def.ActorFrame{
		Name="P2Frame";
		InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end;
		LoadActor("_right gradient")..{ InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+150):halign(1) end; };
		LoadActor("_p2")..{ InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+150):halign(1) end; };
		LoadFont("_r bold 30px")..{
			Text=":Step Artist";
			InitCommand=function(self) self:x(SCREEN_RIGHT-5):y(SCREEN_CENTER_Y+172):zoom(.6):halign(1):shadowlength(2) end;
			BeginCommand=function(self)
				local pm = GAMESTATE:GetPlayMode()
				local show = (pm == 'PlayMode_Regular' or pm == 'PlayMode_Rave')
				self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and show)
			end;
		};
		LoadFont("_r bold 30px")..{
			Name="AuthorText";
			InitCommand=function(self) self:x(SCREEN_RIGHT-100):y(SCREEN_CENTER_Y+172):shadowlength(2):halign(1):zoom(.6) end;
			SetCommand=function(self)
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
			OnCommand=function(self) self:playcommand("Set") end;
		};
		LoadFont("_r bold 30px")..{
			Name="PlayerName";
			InitCommand=function(self) self:x(SCREEN_RIGHT-44):y(SCREEN_CENTER_Y+142):shadowlength(2):halign(1):zoom(.8) end;
			SetCommand=function(self)
				self:settext( PROFILEMAN:GetPlayerName(PLAYER_2) )
			end;
			OnCommand=function(self) self:playcommand("Set") end;
		};
	};
};

return t;