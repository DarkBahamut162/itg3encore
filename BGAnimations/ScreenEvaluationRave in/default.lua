return Def.ActorFrame{
	LoadActor(THEME:GetPathB("_fade in","normal")),
	Def.Actor{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(WideScreenDiff()):diffusealpha(1) end,
		OnCommand=function(self) self:sleep(4):linear(0.3):diffuse(color("0,0,0,0")):addy(-30) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+20*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.ActorFrame{
			Condition=GAMESTATE:IsWinner(PLAYER_1),
			LoadActor("p1win text")..{
				OnCommand=function(self) self:cropright(1.3):faderight(0.1):linear(0.7):cropright(-0.3):sleep(2.2):linear(0.3):diffuse(0,0,0,0) end
			},
			LoadActor("p1win glow")..{
				OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(0.7):cropleft(1):cropright(-0.3) end
			}
		},
		Def.ActorFrame{
			Condition=GAMESTATE:IsWinner(PLAYER_2),
			LoadActor("p2win text")..{
				OnCommand=function(self) self:cropright(1.3):faderight(0.1):linear(0.7):cropright(-0.3):sleep(2.2):linear(0.3):diffuse(0,0,0,0) end
			},
			LoadActor("p2win glow")..{
				OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(0.7):cropleft(1):cropright(-0.3) end
			}
		},
		Def.ActorFrame{
			Condition=not GAMESTATE:IsWinner(PLAYER_1) and not GAMESTATE:IsWinner(PLAYER_2),
			LoadActor("draw text")..{
				OnCommand=function(self) self:cropright(1.3):faderight(0.1):linear(0.7):cropright(-0.3):sleep(2.2):linear(0.3):diffuse(0,0,0,0) end
			},
			LoadActor("draw glow")..{
				OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(0.7):cropleft(1):cropright(-0.3) end
			}
		}
	}
}