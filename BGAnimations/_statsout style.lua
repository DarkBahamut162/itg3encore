return Def.ActorFrame{
	Def.ActorFrame{
		Condition=EnabledAndUSBReady(PLAYER_1),
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:croptop(0.5):cropbottom(0.5):sleep(0.15):accelerate(0.15):croptop(0.25):cropbottom(0.25):decelerate(0.2):croptop(0):cropbottom(0) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(0):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(-43*WideScreenDiff()):decelerate(0.2):addy(-43*WideScreenDiff()):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(0):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(43*WideScreenDiff()):decelerate(0.2):addy(43*WideScreenDiff()):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("_overlay/p1card",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.3):diffusealpha(0.6) end
		},
		LoadActor(THEME:GetPathB("","_disk"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.5):spin():diffusealpha(1) end
		},
		LoadFont("_r bold 30px")..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120*WideScreenDiff()):y(SCREEN_CENTER_Y+87*WideScreenDiff()):zoom(0.8*WideScreenDiff()):maxwidth(232) end,
			BeginCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_1) then self:settext("Player 1") end end,
			OnCommand=function(self) self:diffusetopedge(color("#fff000")):diffusebottomedge(color("#ffa500")):shadowlength(2):diffusealpha(0):sleep(0.4):linear(0.2):diffusealpha(1) end
		},
		LoadFont("_v profile")..{
			Text="Checking for\nsaved profiles...",
			InitCommand=function(self) self:x(SCREEN_LEFT+148*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(0.8*WideScreenDiff()) end,
			OnCommand=function(self) self:shadowlength(2):diffusealpha(0):sleep(0.65):linear(0.2):diffusealpha(1) end
		}
	},
	Def.ActorFrame{
		Condition=EnabledAndUSBReady(PLAYER_2),
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:croptop(0.5):cropbottom(0.5):sleep(0.15):accelerate(0.15):croptop(0.25):cropbottom(0.25):decelerate(0.2):croptop(0):cropbottom(0) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(0):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(-43):decelerate(0.2):addy(-43):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("horiz-line","short"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+155*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:cropleft(0.5):cropright(0.5):sleep(0):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(43):decelerate(0.2):addy(43):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("_overlay/p2card",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-60*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.3):diffusealpha(0.6) end
		},
		LoadActor(THEME:GetPathB("","_disk"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+165*WideScreenDiff()):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.5):spin():diffusealpha(1) end
		},
		LoadFont("_r bold 30px")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT-120*WideScreenDiff()):y(SCREEN_CENTER_Y+87*WideScreenDiff()):zoom(0.8*WideScreenDiff()):maxwidth(232) end,
			BeginCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_2) then self:settext("Player 2") end end,
			OnCommand=function(self) self:diffusetopedge(color("#fffb81")):diffusebottomedge(color("#bcff04")):shadowlength(2):diffusealpha(0):sleep(0.4):linear(0.2):diffusealpha(1) end
		},
		LoadFont("_v profile")..{
			Text="Checking for\nsaved profiles...",
			InitCommand=function(self) self:x(SCREEN_RIGHT-148):y(SCREEN_CENTER_Y+162):zoom(0.8*WideScreenDiff()) end,
			OnCommand=function(self) self:shadowlength(2):diffusealpha(0):sleep(0.65):linear(0.2):diffusealpha(1) end
		}
	}
}