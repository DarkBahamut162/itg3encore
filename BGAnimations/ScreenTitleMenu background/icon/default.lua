return Def.ActorFrame{
	Def.ActorFrame{
		Name="Stages",
		Def.Sprite {
			Texture = "_icon",
			Condition=not isFinal(),
			InitCommand=function(self) self:x(SCREEN_RIGHT-200*WideScreenDiff()):y(isFinal() and SCREEN_TOP+24*WideScreenDiff() or SCREEN_TOP+32*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			Text=isEtterna() and 0 or PREFSMAN:GetPreference('SongsPerPlay'),
			InitCommand=function(self) self:x(SCREEN_RIGHT-199*WideScreenDiff()):y(isFinal() and SCREEN_TOP+19*WideScreenDiff() or SCREEN_TOP+27*WideScreenDiff()):zoom(0.8*WideScreenDiff()) end,
			OnCommand=function(self)
				self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1)
				if GAMESTATE:IsEventMode() then self:settext("∞") end
			end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			Text="ROUNDS",
			InitCommand=function(self) self:x(SCREEN_RIGHT-200*WideScreenDiff()):y(isFinal() and SCREEN_TOP+36*WideScreenDiff() or SCREEN_TOP+42*WideScreenDiff()):zoom(0.4*WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Name="Difficulty",
		InitCommand=function(self) self:x(SCREEN_RIGHT+(-200+53*1)*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.Sprite {
			Texture = "_icon",
			Condition=not isFinal(),
			InitCommand=function(self) self:y(isFinal() and SCREEN_TOP+24 or SCREEN_TOP+32) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.ActorFrame{
			Name="DiffBars",
			InitCommand=function(self) self:y(isFinal() and SCREEN_TOP+30 or SCREEN_TOP+38) end,
			Def.ActorFrame{
				Name="BG",
				Def.Quad{
					InitCommand=function(self) self:x(-5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(3):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(-5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(6):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(-5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(9):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(4):zoomtoheight(12):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(15):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(18):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(21):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				}
			},
			Def.ActorFrame{
				Name="Real",
				OnCommand=function(self)
					local c = self:GetChildren()
					local currentDiff = GetLifeDifficulty()
					for i = 1,7 do
						c["Diff"..i]:visible( i <= currentDiff )
					end
				end,
				Def.Quad{
					Name="Diff1",
					InitCommand=function(self) self:x(-5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(3):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Diff2",
					InitCommand=function(self) self:x(-5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(6):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Diff3",
					InitCommand=function(self) self:x(-5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(9):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Diff4",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(4):zoomtoheight(12):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Diff5",
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(15):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#fff700") or color("#000000")) end
				},
				Def.Quad{
					Name="Diff6",
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(18):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#ff3300") or color("#000000")) end
				},
				Def.Quad{
					Name="Diff7",
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(21):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#ff0000") or color("#000000")) end
				}
			},
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="DIFFICULTY",
				InitCommand=function(self) self:y(6):zoom(0.4):maxwidth(120) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			}
		}
	},
	Def.ActorFrame{
		Name="Timing",
		InitCommand=function(self) self:x(SCREEN_RIGHT+(-200+53*2)*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.Sprite {
			Texture = "_icon",
			Condition=not isFinal(),
			InitCommand=function(self) self:y(isFinal() and SCREEN_TOP+24 or SCREEN_TOP+32) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.ActorFrame{
			Name="TimingBars",
			InitCommand=function(self) self:y(isFinal() and SCREEN_TOP+30 or SCREEN_TOP+38) end,
			Def.ActorFrame{
				Name="BG",
				Def.Quad{
					InitCommand=function(self) self:x(-4*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*1):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(-4*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*2):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(-4*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*3):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(-4*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*4):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*5):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(4*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*6):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(4*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*7):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(4*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*8):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				},
				Def.Quad{
					InitCommand=function(self) self:x(4*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*9):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#77777777")) end
				}
			},
			Def.ActorFrame{
				Name="Real",
				OnCommand=function(self)
					local c = self:GetChildren()
					local currentTiming = GetTimingDifficulty()
					for i = 1,9 do
						c["Timing"..i]:visible( i <= currentTiming )
					end
				end,
				Def.Quad{
					Name="Timing1",
					InitCommand=function(self) self:x(-4*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*1):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing2",
					InitCommand=function(self) self:x(-4*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*2):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing3",
					InitCommand=function(self) self:x(-4*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*3):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing4",
					InitCommand=function(self) self:x(-4*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*4):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#6fff00") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing5",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*5):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#fff700") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing6",
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*6):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#fff700") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing7",
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*7):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#ff3300") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing8",
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*8):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#ff3300") or color("#000000")) end
				},
				Def.Quad{
					Name="Timing9",
					InitCommand=function(self) self:x(5*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*9):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(isFinal() and color("#ff0000") or color("#000000")) end
				}
			},
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="TIMING",
				InitCommand=function(self) self:y(6):zoom(0.4) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			}
		}
	},
	Def.ActorFrame{
		Condition=GAMESTATE:GetCoinMode() == 'CoinMode_Pay' and not isEtterna(),
		Name="Premiums",
		InitCommand=function(self)
			local line1 = self:GetChild("Line1")
			local line2 = self:GetChild("Line2")
			local coinmode = GAMESTATE:GetCoinMode()
			local premium = GAMESTATE:GetPremium()
			self:visible(coinmode ~= 'CoinMode_Free' and premium ~= 'Premium_Off')
			if premium == 'Premium_2PlayersFor1Credit' then
				line1:settext("JOINT")
				line2:settext("PREMIUM")
				line1:addy(1)
				line1:zoom(0.6*WideScreenDiff())
				line2:zoomx(0.38*WideScreenDiff())
				line2:zoomy(0.4*WideScreenDiff())
			elseif premium == 'Premium_DoubleFor1Credit' then
				line1:settext("1 CREDIT")
				line2:settext("DOUBLES")
				line1:zoom(0.4*WideScreenDiff())
				line2:zoom(0.4*WideScreenDiff())
			end
		end,
		Def.Sprite {
			Texture = "_icon",
			Condition=not isFinal(),
			InitCommand=function(self) self:x(SCREEN_RIGHT+(-200+53*3)*WideScreenDiff()):y(isFinal() and SCREEN_TOP+24 or SCREEN_TOP+32):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			Name="Line1",
			InitCommand=function(self) self:x(SCREEN_RIGHT+(-199+53*3)*WideScreenDiff()):y(isFinal() and SCREEN_TOP+18 or SCREEN_TOP+26) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			Name="Line2",
			InitCommand=function(self) self:x(SCREEN_RIGHT+(-199+53*3)*WideScreenDiff()):y(isFinal() and SCREEN_TOP+30 or SCREEN_TOP+38) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Name="USBSongs",
		InitCommand=function(self) self:visible(false) end,
		Def.Sprite {
			Texture = "_icon",
			Condition=not isFinal(),
			InitCommand=function(self) self:x(SCREEN_RIGHT+(-200+53*3)*WideScreenDiff()):y(isFinal() and SCREEN_TOP+24 or SCREEN_TOP+32):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			Text="USB",
			InitCommand=function(self) self:x(SCREEN_RIGHT+(-200+53*3)*WideScreenDiff()):y(isFinal() and SCREEN_TOP+19 or SCREEN_TOP+27):zoom(0.6*WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			Text="SONGS",
			InitCommand=function(self) self:x(SCREEN_RIGHT+(-200+53*3)*WideScreenDiff()):y(isFinal() and SCREEN_TOP+32 or SCREEN_TOP+40):zoom(0.4*WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		}
	}
}