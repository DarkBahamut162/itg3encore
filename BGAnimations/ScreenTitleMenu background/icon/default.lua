return Def.ActorFrame{
	Def.ActorFrame{
		Name="Stages",
		LoadActor("_icon")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-200):y(SCREEN_TOP-2+34) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		LoadFont("_v 26px bold black")..{
			Text=PREFSMAN:GetPreference('SongsPerPlay'),
			InitCommand=function(self) self:x(SCREEN_RIGHT-200+1):y(SCREEN_TOP-2+29):horizalign(center):zoom(0.8) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		LoadFont("_v 26px bold black")..{
			Text="ROUNDS",
			InitCommand=function(self) self:x(SCREEN_RIGHT-200):y(SCREEN_TOP-2+46):zoom(0.4) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Name="Difficulty",
		InitCommand=function(self) self:x(SCREEN_RIGHT-200+53*1) end,
		LoadActor("_icon")..{
			InitCommand=function(self) self:y(SCREEN_TOP-2+34) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		Def.ActorFrame{
			Name="DiffBars",
			InitCommand=function(self) self:y(SCREEN_TOP-2+40) end,
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
					local diffScale = PREFSMAN:GetPreference("LifeDifficultyScale")
					local thresholds = { 1.7, 1.5, 1.3, 1, 0.9, 0.7, 0.5 }
					for i = 1,7 do
						c["Diff"..i]:visible( diffScale <= thresholds[i] )
					end
				end,
				Def.Quad{
					Name="Diff1",
					InitCommand=function(self) self:x(-5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(3):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				},
				Def.Quad{
					Name="Diff2",
					InitCommand=function(self) self:x(-5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(6):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				},
				Def.Quad{
					Name="Diff3",
					InitCommand=function(self) self:x(-5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(9):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				},
				Def.Quad{
					Name="Diff4",
					InitCommand=function(self) self:x(0):vertalign(bottom):zoomtowidth(4):zoomtoheight(12):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				},
				Def.Quad{
					Name="Diff5",
					InitCommand=function(self) self:x(5*1):vertalign(bottom):zoomtowidth(4):zoomtoheight(15):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				},
				Def.Quad{
					Name="Diff6",
					InitCommand=function(self) self:x(5*2):vertalign(bottom):zoomtowidth(4):zoomtoheight(18):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				},
				Def.Quad{
					Name="Diff7",
					InitCommand=function(self) self:x(5*3):vertalign(bottom):zoomtowidth(4):zoomtoheight(21):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.7):linear(0.4):diffusealpha(1):diffuse(color("#000000")) end
				}
			},
			LoadFont("_v 26px bold black")..{
				Text="LEVEL",
				InitCommand=function(self) self:y(6):zoom(0.4) end,
				OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
			}
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
				line2:zoomx(0.38)
				line2:zoomy(0.4)
			elseif premium == 'Premium_DoubleFor1Credit' then
				line1:settext("1 CREDIT")
				line2:settext("DOUBLES")
				line1:zoom(0.4)
				line2:zoom(0.4)
			end
		end,
		LoadActor("_icon")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-200+53*2):y(SCREEN_TOP-2+34) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		LoadFont("_v 26px bold black")..{
			Name="Line1",
			InitCommand=function(self) self:x(SCREEN_RIGHT-199+53*2):y(SCREEN_TOP-2+28) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		LoadFont("_v 26px bold black")..{
			Name="Line2",
			InitCommand=function(self) self:x(SCREEN_RIGHT-199+53*2):y(SCREEN_TOP-2+40) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Name="USBSongs",
		InitCommand=function(self) self:visible(false) end,
		LoadActor("_icon")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-200+53*3):y(SCREEN_TOP-2+34) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		LoadFont("_v 26px bold black")..{
			Text="USB",
			InitCommand=function(self) self:x(SCREEN_RIGHT-200+53*3):y(SCREEN_TOP-2+29):horizalign(center):zoom(0.6) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		},
		LoadFont("_v 26px bold black")..{
			Text="SONGS",
			InitCommand=function(self) self:x(SCREEN_RIGHT-200+53*3):y(SCREEN_TOP-2+42):zoom(0.4) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.7):linear(0.4):diffusealpha(1) end
		}
	}
}