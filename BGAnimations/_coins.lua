return Def.ActorFrame{
	OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
	OffCommand=function(self) self:accelerate(0.5):addy(100) end,
	LoadFont("_v 26px bold black")..{
		InitCommand=function(self) self:CenterX():y(isFinal() and SCREEN_BOTTOM-12*WideScreenDiff() or SCREEN_BOTTOM-16*WideScreenDiff()):diffusealpha(0):shadowlength(0):zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:linear(0.4):diffusealpha(1):playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:IsEventMode() then if not isGamePlay() then self:settext('EVENT MODE') end return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Free' then self:settext('FREE PLAY') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:settext('HOME MODE') return end

			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local credits=math.floor(coins/coinsPerCredit)
			local remainder=math.mod(coins,coinsPerCredit)
			local s='CREDIT(S) :  '
			if credits>0 then s=s..credits..'  ' end
			s=s..remainder..'/'..coinsPerCredit
			self:settext(s)
		end,
		SelectMenuOpenedMessageCommand=function(self) if DifficultyChangingAvailable() then self:stoptweening():bounceend(0.2):diffusealpha(0) end end,
		SelectMenuClosedMessageCommand=function(self) if DifficultyChangingAvailable() then self:stoptweening():linear(0.2):diffusealpha(1) end end
	},
	LoadActor("updatecoin")..{
		InitCommand=function(self) self:CenterX():y(isFinal() and SCREEN_BOTTOM-12 or SCREEN_BOTTOM-16):diffusealpha(0):shadowlength(2):zoom(0.5) end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self) self:diffusealpha(0):zoom(0):linear(0.08):zoom(0.5):diffusealpha(0.85):sleep(0.08):linear(0.1):diffusealpha(0) end,
		CoinInsertedMessageCommand=function(self) self:stoptweening():playcommand("Refresh") end
	},
	Def.ActorFrame{
		Name="TIME & DATE",
		OnCommand=function(self) self:CenterX():y(isGamePlay() and SCREEN_BOTTOM-26*WideScreenDiff() or SCREEN_BOTTOM-33*WideScreenDiff()) if GAMESTATE:IsEventMode() and isGamePlay() then self:y(SCREEN_BOTTOM-16*WideScreenDiff()) end end,
		LoadFont("_v 26px bold black")..{
			InitCommand=function(self) self:shadowlength(2):zoom(0.5*WideScreenDiff()):playcommand("Set") end,
			SetCommand=function(self) self:settext( string.format('%02i:%02i:%02i %s %02i %04i', Hour(), Minute(), Second(), string.sub(MonthToString(MonthOfYear()),1,3), DayOfMonth(), Year()) ):sleep(1/6):queuecommand("Set") end
		}
	}
}