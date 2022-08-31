return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-100):shadowlength(0):zoom(1) end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then
				self:settext('')
				return
			end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
				self:playcommand("PressStart")
			else
				self:playcommand("InsertCoin")
			end
		end,
		InsertCoinCommand=function(self) self:settext(GetCreditType()):diffuseshift():effectcolor1(color("0,0,0,0.3")):effectcolor2(color("0,0,0,0")):effectperiod(2) end,
		PressStartCommand=function(self) self:settext(''):diffuseblink():effectcolor1(color("0,0,0,0.2")):effectcolor2(color("0,0,0,0")):effectperiod(GAMESTATE:GetCoinMode()=='CoinMode_Free' and 1.0 or 0.3) end
	},
	LoadFont("_r bold shadow 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-100):shadowlength(0):zoom(1) end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then
				self:settext('')
				return
			end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
				self:playcommand("PressStart")
			else
				self:playcommand("InsertCoin")
			end
		end,
		InsertCoinCommand=function(self) self:settext(GetCreditType()):diffuseshift():effectcolor1(color("1,1,1,0.2")):effectcolor2(color("1,1,1,1")):effectperiod(2) end,
		PressStartCommand=function(self) self:settext(''):diffuseblink():effectcolor1(color("1,1,1,0.2")):effectcolor2(color("1,1,1,1")):effectperiod(GAMESTATE:GetCoinMode()=='CoinMode_Free' and 1.0 or 0.3) end
	},
	LoadFont("_r bold shadow 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-48):shadowlength(0):zoom(0.65):diffusebottomedge(color("#00daff")):diffusetopedge(color("#4fc5de")) end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinInsertedMessageCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:IsEventMode() and GAMESTATE:GetCoinMode()~='CoinMode_Home' then self:settext('EVENT MODE') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Free' then self:settext('FREE PLAY') return end
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:visible(false) end

			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			local credits=math.floor(coins/coinsPerCredit)
			local remainder=math.mod(coins,coinsPerCredit)
			local s = "CREDIT(S)  "
			if credits > 0 then s = s..credits..'  ' end
			s = s..remainder..'/'..coinsPerCredit
			self:settext(s)
		end
	},
	LoadFont("_r bold shadow 30px")..{
		Text="PRESS",
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-100):visible(false):zoomx(0.8):zoomy(0.7) end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:visible(true) end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
				self:playcommand("PressStart")
			else
				self:playcommand("InsertCoin")
			end
		end,
		InsertCoinCommand=function(self) self:visible(false) end,
		PressStartCommand=function(self) self:visible(true) end
	},
	LoadActor(THEME:GetPathG("_common","base start button"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-75):zoom(0.7) end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:visible(true) end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
				self:playcommand("PressStart")
			else
				self:playcommand("InsertCoin")
			end
		end,
		InsertCoinCommand=function(self) self:visible(false) end,
		PressStartCommand=function(self) self:visible(true) end
	},
	LoadActor(THEME:GetPathG("_common","start button"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-75):visible(false):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#858585")):zoom(0.7):effectclock("beat") end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:visible(true) end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
				self:playcommand("PressStart")
			else
				self:playcommand("InsertCoin")
			end
		end,
		InsertCoinCommand=function(self) self:visible(false) end,
		PressStartCommand=function(self) self:visible(true) end
	},
	LoadActor(THEME:GetPathG("_common","glow start button"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-75):zoom(0.7):blend(Blend.Add):diffuseshift():effectcolor1(color("#6BFF75")):effectcolor2(color("#FFFFFF00")):effectclock("beat") end,
		OnCommand=function(self) self:playcommand("Refresh") end,
		CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if GAMESTATE:GetCoinMode()=='CoinMode_Home' then self:visible(true) end
			local coins=GAMESTATE:GetCoins()
			local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
			if coins >= coinsPerCredit or GAMESTATE:GetCoinMode()=='CoinMode_Free' then
				self:playcommand("PressStart")
			else
				self:playcommand("InsertCoin")
			end
		end,
		InsertCoinCommand=function(self) self:visible(false) end,
		PressStartCommand=function(self) self:visible(true) end
	}
}