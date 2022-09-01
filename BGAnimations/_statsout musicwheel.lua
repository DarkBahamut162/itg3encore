return Def.ActorFrame{
	Def.ActorFrame{
		Condition=EnabledAndProfile(PLAYER_1),
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155) end,
			OnCommand=function(self) self:sleep(1):accelerate(0.3):addx(-300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/p1card"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60):y(SCREEN_CENTER_Y+165) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(1):accelerate(0.3):addx(-300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/load"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60):y(SCREEN_CENTER_Y+175) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(1):accelerate(0.3):addx(-300) end
		},
		LoadFont("_r bold 30px")..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+87):maxwidth(232) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
				end
			end,
			OnCommand=function(self) self:diffusetopedge(color("#fff000")):diffusebottomedge(color("#ffa500")):shadowlength(2):horizalign(center):zoom(0.8):sleep(1):accelerate(0.3):addx(-300) end
		},
		LoadFont("_v profile")..{
			Text=getProfileSongs(PLAYER_1),
			InitCommand=function(self) self:x(SCREEN_LEFT+148):y(SCREEN_CENTER_Y+162) end,
			OnCommand=function(self) self:shadowlength(2):horizalign(center):zoom(0.8):linear(0.2):diffusealpha(1):sleep(0.8):accelerate(0.3):addx(-300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/profileload"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155) end,
			OnCommand=function(self) self:blend(Blend.Add):linear(0.5):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Condition=EnabledAndProfile(PLAYER_2),
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+155) end,
			OnCommand=function(self) self:sleep(1):accelerate(0.3):addx(300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/p2card"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-60):y(SCREEN_CENTER_Y+165) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(1):accelerate(0.3):addx(300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/load"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-60):y(SCREEN_CENTER_Y+175) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(1):accelerate(0.3):addx(300) end
		},
		LoadFont("_r bold 30px")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+87):maxwidth(232) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
				end
			end,
			OnCommand=function(self) self:diffusetopedge(color("#fffb81")):diffusebottomedge(color("#bcff04")):shadowlength(2):horizalign(center):zoom(0.8):sleep(1):accelerate(0.3):addx(300) end
		},
		LoadFont("_v profile")..{
			Text=getProfileSongs(PLAYER_2),
			InitCommand=function(self) self:x(SCREEN_RIGHT-148):y(SCREEN_CENTER_Y+162) end,
			OnCommand=function(self) self:shadowlength(2):horizalign(center):zoom(0.8):linear(0.2):diffusealpha(1):sleep(0.8):accelerate(0.3):addx(300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/profileload"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+155) end,
			OnCommand=function(self) self:blend(Blend.Add):linear(0.5):diffusealpha(0) end
		}
	}
}