return Def.ActorFrame{
	InitCommand=function(self) self:rotationz(-3.5):zoom(1.2) end,
	Def.ActorFrame{
		Def.ActorFrame{
			Name="Stages",
			Def.BitmapText {
				File = "stencil",
				Text=PREFSMAN:GetPreference('SongsPerPlay'),
				InitCommand=function(self) self:x(-199):y(23) end,
				OnCommand=function(self) if GAMESTATE:IsEventMode() then self:settext("0::0"):rotationz(90) end end
			},
			Def.BitmapText {
				File = "stencil",
				Text="ROUNDS",
				InitCommand=function(self) self:x(-200):y(42):zoom(0.5):maxwidth(80) end
			}
		},
		Def.ActorFrame{
			Name="DiffBars",
			InitCommand=function(self) self:x(-147):y(34) end,
			Def.ActorFrame{
				Name="BG",
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(3):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(6):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(9):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(4):zoomtoheight(12):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(15):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(18):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(21):diffuse(color("#77777777")) end
				}
			},
			Def.ActorFrame{
				Name="Real",
				OnCommand=function(self)
					local c = self:GetChildren()
					local currentDiff = GetLifeDifficulty()
					for i = 1,7 do c["Diff"..i]:visible( i <= currentDiff ) end
				end,
				Def.Sprite {
					Texture = "_icon",
					Name="Diff1",
					InitCommand=function(self) self:x(-5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(3):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Diff2",
					InitCommand=function(self) self:x(-5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(6):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Diff3",
					InitCommand=function(self) self:x(-5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(9):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Diff4",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(4):zoomtoheight(12):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Diff5",
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(15):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Diff6",
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(18):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Diff7",
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(21):diffuse(color("#000000")) end
				}
			},
			Def.BitmapText {
				File = "stencil",
				Text="DIFFICULTY",
				InitCommand=function(self) self:y(7.5):zoom(0.5):maxwidth(80) end
			}
		},
		Def.ActorFrame{
			Name="TimingBars",
			InitCommand=function(self) self:x(-200+53*2):y(33) end,
			Def.ActorFrame{
				Name="BG",
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-4*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*1):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-4*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*2):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-4*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*3):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(-4*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*4):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*5):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(4*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*6):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(4*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*7):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(4*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*8):diffuse(color("#77777777")) end
				},
				Def.Sprite {
					Texture = "_icon",
					InitCommand=function(self) self:x(4*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*9):diffuse(color("#77777777")) end
				}
			},
			Def.ActorFrame{
				Name="Real",
				OnCommand=function(self)
					local c = self:GetChildren()
					local currentTiming = GetTimingDifficulty()
					for i = 1,9 do c["Timing"..i]:visible( i <= currentTiming ) end
				end,
				Def.Sprite {
					Texture = "_icon",
					Name="Timing1",
					InitCommand=function(self) self:x(-4*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*1):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing2",
					InitCommand=function(self) self:x(-4*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*2):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing3",
					InitCommand=function(self) self:x(-4*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*3):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing4",
					InitCommand=function(self) self:x(-4*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*4):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing5",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*5):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing6",
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*6):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing7",
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*7):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing8",
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*8):diffuse(color("#000000")) end
				},
				Def.Sprite {
					Texture = "_icon",
					Name="Timing9",
					InitCommand=function(self) self:x(5*4):vertalign(bottom):zoomtowidth(3):zoomtoheight(21/9*9):diffuse(color("#000000")) end
				}
			},
			Def.BitmapText {
				File = "stencil",
				Text="TIMING",
				InitCommand=function(self) self:y(7.5):zoom(0.5):maxwidth(80) end
			}
		},
		Def.ActorFrame{
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
					line1:zoom(0.6)
					line2:zoomx(0.45)
					line2:zoomy(0.5):valign(0):halign(0)
				elseif premium == 'Premium_DoubleFor1Credit' then
					line1:settext("ONE::CREDIT")
					line2:settext("DOUBLES")
					line1:zoom(0.5)
					line2:zoomx(0.5)
					line2:zoomy(0.47)
				end
			end,
			Def.BitmapText {
				File = "_v 26px bold black",
				Name="Line1",
				InitCommand=function(self) self:x(-202+53*3):y(25):vertspacing(-10) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			},
			Def.BitmapText {
				File = "_v 26px bold black",
				Name="Line2",
				InitCommand=function(self) self:x(-202+53*3):y(41) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			}
		},
		Def.ActorFrame{
			Name="USBSongs",
			InitCommand=function(self) self:visible(false) end,
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="USB",
				InitCommand=function(self) self:x(-198+53*3):y(25):zoom(0.8) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			},
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="SONGS",
				InitCommand=function(self) self:x(-198+53*3):y(40):zoom(0.6) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			}
		}
	}
}