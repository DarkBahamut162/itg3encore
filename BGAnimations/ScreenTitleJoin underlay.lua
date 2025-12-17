return Def.ActorFrame{
	BeginCommand=function() InitOptions() resetRepeatCheck() end,
	Def.ActorFrame{
		Condition=isScreenTitle(),
		Def.BitmapText {
			File = "_r bold shadow 30px",
			InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-85-25*WideScreenDiff()):shadowlength(0):zoomx(0.8*WideScreenDiff()):zoomy(0.7*WideScreenDiff()):playcommand("Refresh") end,
			RefreshCommand=function(self)
				if GAMESTATE:GetCoinMode()=='CoinMode_Pay' then
					local coins=GAMESTATE:GetCoins()
					local coinsPerCredit=PREFSMAN:GetPreference('CoinsPerCredit')
					if coins >= coinsPerCredit then
						self:settext("PRESS START")
					else
						self:settext("INSERT COIN")
					end
				else
					self:settext("PRESS START")
				end
			end,
			CoinModeChangedMessageCommand=function(self) self:playcommand("Refresh") end,
			CoinInsertedMessageCommand=function(self) self:playcommand("Refresh") end
		},
		Def.ActorFrame{
			Name="StartButton",
			InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-85) end,
			Def.Sprite {
				Texture = THEME:GetPathG("_common","base start button "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:shadowlength(0):zoom(0.7*WideScreenDiff()) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("_common","start button "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#858585")):zoom(0.7*WideScreenDiff()):effectclock("beat") end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("_common","glow start button "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:blend(Blend.Add):shadowlength(0):diffuseshift():effectcolor1(color("#6BFF75")):effectcolor2(color("#FFFFFF00")):zoom(0.7*WideScreenDiff()):effectclock("beat") end
			}
		}
	}
}