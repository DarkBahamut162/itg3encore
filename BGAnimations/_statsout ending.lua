return Def.ActorFrame{
    Def.ActorFrame{
        Condition=EnabledAndProfile(PLAYER_1),
        LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
            InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155) end,
            OnCommand=function(self) self:sleep(2):accelerate(0.3):addx(-300) end
        },
		LoadActor(THEME:GetPathB("","_overlay/p1card"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60):y(SCREEN_CENTER_Y+165) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(2):accelerate(0.3):addx(-300) end
		},
        LoadFont("_r bold 30px")..{
            InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+87) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
					self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_1))
				end
			end,
            OnCommand=function(self) self:diffusetopedge(color("#fff000")):diffusebottomedge(color("#ffa500")):shadowlength(2):horizalign(center):zoom(0.8):sleep(2):accelerate(0.3):addx(-300) end
        },
        LoadFont("_v profile")..{
            Text=getProfileSongs(PLAYER_1),
            InitCommand=function(self) self:x(SCREEN_LEFT+148):y(SCREEN_CENTER_Y+162) end,
            OnCommand=function(self) self:shadowlength(2):horizalign(center):zoom(0.8):linear(0.2):diffusealpha(0.8):sleep(1.8):accelerate(0.3):addx(-300) end
        },
		LoadActor(THEME:GetPathB("","_overlay/check"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+125) end,
			OnCommand=function(self) self:cropright(1):linear(0.3):cropright(0):sleep(1.7):accelerate(0.3):addx(-300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/achpane"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+242):y(SCREEN_CENTER_Y+155) end,
			OnCommand=function(self) self:cropleft(0):sleep(1.25):accelerate(0.3):cropleft(1):addx(-54) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*0) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) StarIcon(self, PLAYER_1) self:sleep(0.9):bouncebegin(0.4):zoom(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+235):y(SCREEN_CENTER_Y+103+34*1) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) QuadIcon(self, PLAYER_1) self:sleep(0.95):bouncebegin(0.4):zoom(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*2) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) PercentIcon(self, PLAYER_1) self:sleep(1):bouncebegin(0.4):zoom(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*3) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) CalorieIcon(self, PLAYER_1) self:sleep(1.05):bouncebegin(0.4):zoom(0) end
		}
    },
    Def.ActorFrame{
        Condition=EnabledAndProfile(PLAYER_2),
        LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
            InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+155) end,
            OnCommand=function(self) self:sleep(2):accelerate(0.3):addx(300) end
        },
		LoadActor(THEME:GetPathB("","_overlay/p2card"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-60):y(SCREEN_CENTER_Y+165) end,
			OnCommand=function(self) self:diffusealpha(0.6):sleep(2):accelerate(0.3):addx(300) end
		},
        LoadFont("_r bold 30px")..{
            InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+87) end,
			BeginCommand=function(self)
				if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
					self:settext(GAMESTATE:GetPlayerDisplayName(PLAYER_2))
				end
			end,
            OnCommand=function(self) self:diffusetopedge(color("#fffb81")):diffusebottomedge(color("#bcff04")):shadowlength(2):horizalign(center):zoom(0.8):sleep(2):accelerate(0.3):addx(300) end
        },
        LoadFont("_v profile")..{
            Text=getProfileSongs(PLAYER_2),
            InitCommand=function(self) self:x(SCREEN_RIGHT-148):y(SCREEN_CENTER_Y+162) end,
            OnCommand=function(self) self:shadowlength(2):horizalign(center):zoom(0.8):linear(0.2):diffusealpha(0.8):sleep(1.8):accelerate(0.3):addx(300) end
        },
		LoadActor(THEME:GetPathB("","_overlay/check"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120):y(SCREEN_CENTER_Y+125) end,
			OnCommand=function(self) self:cropright(1):linear(0.3):cropright(0):sleep(1.7):accelerate(0.3):addx(300) end
		},
		LoadActor(THEME:GetPathB("","_overlay/achpane"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-242):y(SCREEN_CENTER_Y+155) end,
			OnCommand=function(self) self:cropright(0):sleep(1.25):accelerate(0.3):cropright(1):addx(54) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y+103+34*0) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) StarIcon(self, PLAYER_1) self:sleep(0.9):bouncebegin(0.4):zoom(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-235):y(SCREEN_CENTER_Y+103+34*1) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) QuadIcon(self, PLAYER_1) self:sleep(0.95):bouncebegin(0.4):zoom(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y+103+34*2) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) PercentIcon(self, PLAYER_1) self:sleep(1):bouncebegin(0.4):zoom(0) end
		},
		LoadActor(THEME:GetPathB("","_overlay/awards"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-238):y(SCREEN_CENTER_Y+103+34*3) end,
            OnCommand=function(self) self:horizalign(center):animate(0):zoom(0.55):playcommand("Update") end,
            UpdateCommand=function(self,parent) CalorieIcon(self, PLAYER_1) self:sleep(1.05):bouncebegin(0.4):zoom(0) end
		}
    }
}