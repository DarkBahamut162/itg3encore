return Def.ActorFrame{
    Def.ActorFrame{
        Condition=EnabledAndProfile(PLAYER_1),
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/cardstats"),
            InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
            OnCommand=function(self) self:sleep(2):accelerate(0.3):addx(-SCREEN_WIDTH/2) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("_overlay/p1card",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(SCREEN_LEFT+60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(2):accelerate(0.3):addx(-SCREEN_WIDTH/2) end
		},
		Def.BitmapText {
			File = "_r bold 30px",
            InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+87*WideScreenDiff()):zoom(0.8*WideScreenDiff()):maxwidth(232) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
				end
			end,
            OnCommand=function(self) self:diffusetopedge(color("#fff000")):diffusebottomedge(color("#ffa500")):shadowlength(2):sleep(2):accelerate(0.3):addx(-SCREEN_WIDTH/2) end
        },
		Def.BitmapText {
			File = "_v profile",
            Text=getProfileSongs(PLAYER_1),
            InitCommand=function(self) self:x(SCREEN_LEFT+148*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(0.8*WideScreenDiff()) end,
            OnCommand=function(self) self:shadowlength(2):linear(0.2):diffusealpha(0.8):sleep(1.8):accelerate(0.3):addx(-SCREEN_WIDTH/2) end
        },
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/check"),
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+125*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropright(1):linear(0.3):cropright(0):sleep(1.7):accelerate(0.3):addx(-SCREEN_WIDTH/2) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/achpane"),
			InitCommand=function(self) self:x(SCREEN_LEFT+242*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:sleep(1.25):accelerate(0.3):cropleft(1):addx(-54) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_LEFT+238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*0)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) StarIcon(self, PLAYER_1) self:sleep(0.9):bouncebegin(0.4):zoom(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_LEFT+235*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*1)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) QuadIcon(self, PLAYER_1) self:sleep(0.95):bouncebegin(0.4):zoom(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_LEFT+238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*2)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) PercentIcon(self, PLAYER_1) self:sleep(1):bouncebegin(0.4):zoom(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_LEFT+238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*3)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) CalorieIcon(self, PLAYER_1) self:sleep(1.05):bouncebegin(0.4):zoom(0) end
		}
    },
    Def.ActorFrame{
        Condition=EnabledAndProfile(PLAYER_2),
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/cardstats"),
            InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
            OnCommand=function(self) self:sleep(2):accelerate(0.3):addx(SCREEN_WIDTH/2) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("_overlay/p2card",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(2):accelerate(0.3):addx(SCREEN_WIDTH/2) end
		},
		Def.BitmapText {
			File = "_r bold 30px",
            InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+87*WideScreenDiff()):zoom(0.8*WideScreenDiff()):maxwidth(232) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
				end
			end,
            OnCommand=function(self) self:diffusetopedge(color("#fffb81")):diffusebottomedge(color("#bcff04")):shadowlength(2):sleep(2):accelerate(0.3):addx(SCREEN_WIDTH/2) end
        },
		Def.BitmapText {
			File = "_v profile",
            Text=getProfileSongs(PLAYER_2),
            InitCommand=function(self) self:x(SCREEN_RIGHT-148*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(0.8*WideScreenDiff()) end,
            OnCommand=function(self) self:shadowlength(2):linear(0.2):diffusealpha(0.8):sleep(1.8):accelerate(0.3):addx(SCREEN_WIDTH/2) end
        },
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/check"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+125*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropright(1):linear(0.3):cropright(0):sleep(1.7):accelerate(0.3):addx(SCREEN_WIDTH/2) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/achpane"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-242*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
			OnCommand=function(self) self:cropright(0):sleep(1.25):accelerate(0.3):cropright(1):addx(54) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*0)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) StarIcon(self, PLAYER_2) self:sleep(0.9):bouncebegin(0.4):zoom(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-235*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*1)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) QuadIcon(self, PLAYER_2) self:sleep(0.95):bouncebegin(0.4):zoom(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*2)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) PercentIcon(self, PLAYER_2) self:sleep(1):bouncebegin(0.4):zoom(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("","_overlay/awards"),
			InitCommand=function(self) self:x(SCREEN_RIGHT-238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*3)*WideScreenDiff()):zoom(0.55*WideScreenDiff()) end,
			OnCommand=function(self) self:animate(0):playcommand("Update") end,
			UpdateCommand=function(self) CalorieIcon(self, PLAYER_2) self:sleep(1.05):bouncebegin(0.4):zoom(0) end
		}
    }
}