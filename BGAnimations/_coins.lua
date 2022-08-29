return Def.ActorFrame{
	LoadFont("_v 26px bold black")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-16):diffusealpha(0):horizalign(center):shadowlength(0):zoom(0.5) end;
		OnCommand=function(self) self:linear(0.4):diffusealpha(1):playcommand("Refresh") end;
		RefreshCommand=function(self)
			if GAMESTATE:IsEventMode() then self:settext('EVENT MODE') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Free' then self:settext('FREE PLAY') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:settext('') return end

			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local credits=math.floor(coins/coinsPerCredit)
			local remainder=math.mod(coins,coinsPerCredit)
			local s='CREDIT(S) :  '
			if credits>0 then s=s..credits..'  ' end
			s=s..remainder..'/'..coinsPerCredit
			self:settext(s)
		end;
		SelectMenuOpenedMessageCommand=function(self)
			if DifficultyChangingAvailable() then
				self:stoptweening():bounceend(0.2):diffusealpha(0)
			end
		end;
		SelectMenuClosedMessageCommand=function(self)
			if DifficultyChangingAvailable() then
				self:stoptweening():linear(0.2):diffusealpha(1)
			end
		end;
	};
	LoadActor("updatecoin")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-16):diffusealpha(0):horizalign(center):shadowlength(2):zoom(0.5) end;
		OnCommand=function(self) self:playcommand("Refresh") end;
		RefreshCommand=function(self)
			self:diffusealpha(0):zoom(0):linear(0.08):zoom(0.5):diffusealpha(0.85):sleep(0.08):linear(0.1):diffusealpha(0)
		end;
		CoinInsertedMessageCommand=function(self) self:stoptweening():playcommand("Refresh") end;
	};
};