prepSummary()

return Def.ActorFrame{
	loadfile(THEME:GetPathB("_fade in","normal"))(),
	Def.Actor{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(WideScreenDiff()):diffusealpha(1) end,
		OnCommand=function(self) self:sleep(4):linear(0.3):diffuse(color("0,0,0,0")):addy(-30) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+20*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.ActorFrame{
			Condition=GAMESTATE:IsWinner(PLAYER_1),
			Def.Sprite {
				Texture = "p1win text "..(isFinal() and "final" or "normal"),
				OnCommand=function(self) self:cropright(1.3):faderight(0.1):linear(0.7):cropright(-0.3):sleep(2.2):linear(0.3):diffuse(0,0,0,0) end
			},
			Def.Sprite {
				Texture = "p1win glow "..(isFinal() and "final" or "normal"),
				OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(0.7):cropleft(1):cropright(-0.3) end
			}
		},
		Def.ActorFrame{
			Condition=GAMESTATE:IsWinner(PLAYER_2),
			Def.Sprite {
				Texture = "p2win text "..(isFinal() and "final" or "normal"),
				OnCommand=function(self) self:cropright(1.3):faderight(0.1):linear(0.7):cropright(-0.3):sleep(2.2):linear(0.3):diffuse(0,0,0,0) end
			},
			Def.Sprite {
				Texture = "p2win glow "..(isFinal() and "final" or "normal"),
				OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(0.7):cropleft(1):cropright(-0.3) end
			}
		},
		Def.ActorFrame{
			Condition=not GAMESTATE:IsWinner(PLAYER_1) and not GAMESTATE:IsWinner(PLAYER_2),
			Def.Sprite {
				Texture = "draw text "..(isFinal() and "final" or "normal"),
				OnCommand=function(self) self:cropright(1.3):faderight(0.1):linear(0.7):cropright(-0.3):sleep(2.2):linear(0.3):diffuse(0,0,0,0) end
			},
			Def.Sprite {
				Texture = "draw glow "..(isFinal() and "final" or "normal"),
				OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(0.7):cropleft(1):cropright(-0.3) end
			}
		}
	}
}