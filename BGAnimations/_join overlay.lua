-- so much crap
local t = Def.ActorFrame{
	LoadFont("_v 26px bold black")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-14;shadowlength,0;zoom,.6;diffusealpha,0;sleep,.5;linear,.2;diffusealpha,1;draworder,9999);
		OnCommand=cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#FFFFFF");playcommand,"Refresh");
		OffCommand=cmd(stoptweening;linear,.2;diffusealpha,0);
		RefreshCommand=function(self)
			self:settext(Get2PlayerJoinMessage())
		end;
		JoinedCommand=cmd(linear,.2;diffusealpha,0);
		PlayerJoinedMessageCommand=cmd(playcommand,"Joined");
		CurrentStyleChangedMessageCommand=cmd(playcommand,"Refresh");
		CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
		CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
	};

	-- P1
	Def.ActorFrame{
		Name="PressStartP1";
		InitCommand=cmd(x,SCREEN_LEFT+90;y,SCREEN_BOTTOM-44;playcommand,"Refresh");
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
				self:RunCommandsOnChildren(cmd(playcommand,"Joined"))
			end
		end;

		CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
		CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
		InsertCoinCommand=cmd(visible,false);
		PressStartCommand=cmd(visible,true);

		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			InitCommand=cmd(x,-10;zoom,-.6);
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=cmd(settext,"PRESS";shadowlength,2;zoom,0.6);
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("_common","base start button"))..{
			InitCommand=cmd(addx,45;shadowlength,0;zoom,0.5);
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("_common","start button"))..{
			InitCommand=cmd(addx,45;zoom,0.5;);
			OnCommand=cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#858585");effectclock,"beat");
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("_common","glow start button"))..{
			InitCommand=cmd(addx,45;zoom,0.5;blend,Blend.Add;);
			OnCommand=cmd(diffuseshift;effectcolor1,color("#6BFF75");effectcolor2,color("#FFFFFF00");effectclock,"beat");
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
	};
	Def.ActorFrame{
		
	};

	-- P2
	Def.ActorFrame{
		Name="PressStartP2";
		InitCommand=cmd(x,SCREEN_RIGHT-90;y,SCREEN_BOTTOM-44;playcommand,"Refresh");
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
				self:RunCommandsOnChildren(cmd(playcommand,"Joined"))
			end
		end;

		CoinModeChangedMessageCommand=cmd(playcommand,"Refresh");
		CoinInsertedMessageCommand=cmd(playcommand,"Refresh");
		InsertCoinCommand=cmd(visible,false);
		PressStartCommand=cmd(visible,true);

		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			InitCommand=cmd(x,10;zoom,.6);
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadFont("_v 26px bold diffuse")..{
			InitCommand=cmd(settext,"PRESS";x,-33;shadowlength,2;zoom,0.6);
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("_common","base start button"))..{
			InitCommand=cmd(addx,11;shadowlength,0;zoom,0.5);
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("_common","start button"))..{
			InitCommand=cmd(addx,11;zoom,0.5;);
			OnCommand=cmd(diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#858585");effectclock,"beat");
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
		LoadActor(THEME:GetPathG("_common","glow start button"))..{
			InitCommand=cmd(addx,11;zoom,0.5;blend,Blend.Add;);
			OnCommand=cmd(diffuseshift;effectcolor1,color("#6BFF75");effectcolor2,color("#FFFFFF00");effectclock,"beat");
			JoinedCommand=cmd(linear,.2;diffusealpha,0);
		};
	};
	Def.ActorFrame{
		
	};
};

return t;