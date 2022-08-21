-- so much crap
return Def.ActorFrame{
	LoadFont("_v 26px bold black")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-14):shadowlength(0):zoom(0.6):diffusealpha(0):sleep(0.5):linear(0.2):diffusealpha(1):draworder(9999) end;
		OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#FFFFFF")):playcommand("Refresh") end;
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		RefreshCommand=function(self)
			self:settext(Get2PlayerJoinMessage())
		end;
		JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		PlayerJoinedMessageCommand=function(self) self:playcommand("Joined") end;
		CurrentStyleChangedMessageCommand=function(self) self:playcommand("Refresh") end;
		CoinInsertedMessageCommand=function(self) self:playcommand("Refresh") end;
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end;
	};

	-- P1
	Def.ActorFrame{
		Name="PressStartP1";
		InitCommand=function(self) self:x(SCREEN_LEFT+90):y(SCREEN_BOTTOM-44):playcommand("Refresh") end;
		RefreshCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then self:visible(false); return end
			if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then self:visible(true) return end;
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free'
				or GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit' then
				self:playcommand('PressStart') 
			else 
				self:playcommand('InsertCoin') 
			end
		end;
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				self:RunCommandsOnChildren(function(self) self:playcommand("Joined") end);
			end
		end;

		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end;
		CoinInsertedMessageCommand=function(self) self:playcommand("Refresh") end;
		InsertCoinCommand=function(self) self:visible(false) end;
		PressStartCommand=function(self) self:visible(true) end;

		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			InitCommand=function(self) self:x(-10):zoom(-.6) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=function(self) self:settext("PRESS"):shadowlength(2):zoom(0.6) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_common","base start button"))..{
			InitCommand=function(self) self:addx(45):shadowlength(0):zoom(0.5) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_common","start button"))..{
			InitCommand=function(self) self:addx(45):zoom(0.5) end;
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#858585")):effectclock("beat") end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_common","glow start button"))..{
			InitCommand=function(self) self:addx(45):zoom(0.5):blend(Blend.Add) end;
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#6BFF75")):effectcolor2(color("#FFFFFF00")):effectclock("beat") end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
	};
	Def.ActorFrame{
		
	};

	-- P2
	Def.ActorFrame{
		Name="PressStartP2";
		InitCommand=function(self) self:x(SCREEN_RIGHT-90):y(SCREEN_BOTTOM-44):playcommand("Refresh") end;
		RefreshCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then self:visible(false); return end
			if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then self:visible(true) return end;
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free'
				or GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit' then
				self:playcommand('PressStart') 
			else 
				self:playcommand('InsertCoin') 
			end
		end;
		PlayerJoinedMessageCommand=function(self,param)
			if param.Player == PLAYER_2 then
				self:RunCommandsOnChildren(function(self) self:playcommand("Joined") end);
			end
		end;

		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end;
		CoinInsertedMessageCommand=function(self) self:playcommand("Refresh") end;
		InsertCoinCommand=function(self) self:visible(false) end;
		PressStartCommand=function(self) self:visible(true) end;

		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			InitCommand=function(self) self:x(10):zoom(0.6) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=function(self) self:settext("PRESS"):x(-33):shadowlength(2):zoom(0.6) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_common","base start button"))..{
			InitCommand=function(self) self:addx(11):shadowlength(0):zoom(0.5) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_common","start button"))..{
			InitCommand=function(self) self:addx(11):zoom(0.5) end;
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#858585")):effectoffset(-0.05):effectclock("beat"):effectperiod(1/177.38*120) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathG("_common","glow start button"))..{
			InitCommand=function(self) self:addx(11):zoom(0.5):blend(Blend.Add) end;
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#6BFF75")):effectcolor2(color("#FFFFFF00")):effectoffset(-0.05):effectclock("beat"):effectperiod(1/177.38*120) end;
			JoinedCommand=function(self) self:linear(0.2):diffusealpha(0) end;
		};
	};
};