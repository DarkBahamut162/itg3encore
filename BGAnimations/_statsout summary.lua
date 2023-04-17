return Def.ActorFrame{
    Def.ActorFrame{
        Condition=EnabledAndProfile(PLAYER_1),
        LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
            InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
            OnCommand=function(self) self:croptop(0.5):cropbottom(0.5):sleep(1.15):accelerate(0.15):croptop(0.25):cropbottom(0.25):decelerate(0.2):croptop(0):cropbottom(0) end
        },
		LoadActor(THEME:GetPathB("_overlay/p1card",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(1.5):linear(0.3):diffusealpha(0.6) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(1):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(-43*WideScreenDiff()):decelerate(0.2):addy(-43*WideScreenDiff()):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(1):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(43*WideScreenDiff()):decelerate(0.2):addy(43*WideScreenDiff()):diffusealpha(0) end
		},
        LoadFont("_r bold 30px")..{
            InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+87*WideScreenDiff()):zoom(0.8*WideScreenDiff()):maxwidth(232) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
				end
			end,
            OnCommand=function(self) self:diffusetopedge(color("#fff000")):diffusebottomedge(color("#ffa500")):shadowlength(2):diffusealpha(0):sleep(1.4):linear(0.2):diffusealpha(1) end
        },
        LoadFont("_v profile")..{
            Text=getProfileSongs(PLAYER_1),
            InitCommand=function(self) self:x(SCREEN_LEFT+148*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(0.8*WideScreenDiff()) end,
            OnCommand=function(self) self:shadowlength(2):diffusealpha(0):sleep(1.65):linear(0.2):diffusealpha(1) end
        },
		LoadActor(THEME:GetPathB("","_overlay/achpane"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+242*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:addx(-54):cropleft(1):sleep(0.7+0.7):decelerate(0.3):addx(54):cropleft(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*0)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.35+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) StarIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+235*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*1)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.40+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) QuadIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*2)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.45+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) PercentIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*3)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.50+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) CalorieIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		}
    },
    Def.ActorFrame{
        Condition=EnabledAndProfile(PLAYER_2),
        LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
            InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
            OnCommand=function(self) self:croptop(0.5):cropbottom(0.5):sleep(1.15):accelerate(0.15):croptop(0.25):cropbottom(0.25):decelerate(0.2):croptop(0):cropbottom(0) end
        },
		LoadActor(THEME:GetPathB("_overlay/p2card",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(1.5):linear(0.3):diffusealpha(0.6) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(1):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(-43*WideScreenDiff()):decelerate(0.2):addy(-43*WideScreenDiff()):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(1):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(43*WideScreenDiff()):decelerate(0.2):addy(43*WideScreenDiff()):diffusealpha(0) end
		},
        LoadFont("_r bold 30px")..{
            InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+87*WideScreenDiff()):zoom(0.8*WideScreenDiff()):maxwidth(232) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
				end
			end,
            OnCommand=function(self) self:diffusetopedge(color("#fffb81")):diffusebottomedge(color("#bcff04")):shadowlength(2):diffusealpha(0):sleep(1.4):linear(0.2):diffusealpha(1) end
        },
        LoadFont("_v profile")..{
            Text=getProfileSongs(PLAYER_2),
            InitCommand=function(self) self:x(SCREEN_RIGHT-148*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(0.8*WideScreenDiff()) end,
            OnCommand=function(self) self:shadowlength(2):diffusealpha(0):sleep(1.65):linear(0.2):diffusealpha(1) end
        },
		LoadActor(THEME:GetPathB("","_overlay/achpane"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-242*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
			OnCommand=function(self) self:addx(54):cropright(1):sleep(0.7+0.7):decelerate(0.3):addx(-54):cropright(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*0)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.35+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) StarIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-235*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*1)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.40+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) QuadIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*2)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.45+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) PercentIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-238*WideScreenDiff()):y(SCREEN_CENTER_Y+(103+34*3)*WideScreenDiff()):zoom(0) end,
			OnCommand=function(self) self:animate(0):sleep(1.50+0.5):playcommand("Update") end,
			UpdateCommand=function(self,parent) CalorieIcon(self, PLAYER_1) self:bounceend(0.4):zoom(0.55*WideScreenDiff()) end
		}
    },
    Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			OnCommand=function(self) self:horizalign(right):zoomx(-1):x(SCREEN_LEFT):y(SCREEN_TOP+60):addx(-SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			OnCommand=function(self) self:horizalign(right):zoomx(-1):x(SCREEN_LEFT):y(SCREEN_TOP+140):addx(-SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			OnCommand=function(self) self:horizalign(right):x(SCREEN_RIGHT):y(SCREEN_TOP+60):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathB("","_overlay/joinin"))..{
			OnCommand=function(self) self:horizalign(right):x(SCREEN_RIGHT):y(SCREEN_TOP+140):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			OnCommand=function(self) self:animate(0):x(SCREEN_LEFT+30):y(SCREEN_TOP+60):zoom(0.55):setstate(4):diffusealpha(0.7):addx(-SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(SCREEN_WIDTH) end
		},
        LoadFont("_v profile")..{
			Text="SX Star Count: 10, 25, 50, 100",
            InitCommand=function(self) self:x(SCREEN_LEFT+55):y(SCREEN_TOP+60):horizalign(left):shadowlength(0):zoom(0.8):addx(-SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(SCREEN_WIDTH) end
        },
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			OnCommand=function(self) self:animate(0):x(SCREEN_LEFT+30):y(SCREEN_TOP+140):zoom(0.55):setstate(4):diffusealpha(0.7):addx(-SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(SCREEN_WIDTH) end
		},
        LoadFont("_v profile")..{
			Text="Expert Quads: 10, 25, 50, 100",
            InitCommand=function(self) self:x(SCREEN_LEFT+55):y(SCREEN_TOP+140):horizalign(left):shadowlength(0):zoom(0.8):addx(-SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(SCREEN_WIDTH) end
        },
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			OnCommand=function(self) self:animate(0):x(SCREEN_RIGHT-247):y(SCREEN_TOP+60):zoom(0.55):setstate(4):diffusealpha(0.7):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
		},
        LoadFont("_v profile")..{
			Text=": 500, 2.5k, 7.5k, 15k",
            InitCommand=function(self) self:x(SCREEN_RIGHT-15):y(SCREEN_TOP+60):horizalign(right):shadowlength(0):zoom(0.8):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
        },
        LoadFont("_v profile")..{
			Text="Total % of",
            InitCommand=function(self) self:x(SCREEN_RIGHT-226):y(SCREEN_TOP+54):horizalign(left):shadowlength(0):zoom(0.6):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
        },
        LoadFont("_v profile")..{
			Text="passed SX",
            InitCommand=function(self) self:x(SCREEN_RIGHT-228):y(SCREEN_TOP+66):horizalign(left):shadowlength(0):zoom(0.6):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
        },
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			OnCommand=function(self) self:animate(0):x(SCREEN_RIGHT-247):y(SCREEN_TOP+140):zoom(0.55):setstate(4):diffusealpha(0.7):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
		},
        LoadFont("_v profile")..{
			Text="Calories: .25k, .75k, 1.5k, 3k",
            InitCommand=function(self) self:x(SCREEN_RIGHT-20):y(SCREEN_TOP+140):horizalign(right):shadowlength(0):zoom(0.8):addx(SCREEN_WIDTH):sleep(1.3):decelerate(0.3):addx(-SCREEN_WIDTH) end
        }
	}
}