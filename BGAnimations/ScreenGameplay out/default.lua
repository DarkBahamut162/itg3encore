return Def.ActorFrame{
	Def.ActorFrame{
		--CLEAR
		Def.Quad{
			InitCommand=function(self) self:FullScreen():diffuse(color("#00000000")) end,
			StartTransitioningCommand=function(self) self:playcommand("Check"):diffusealpha(0):linear(0.3):diffusealpha(1):sleep(1) end,
			CheckCommand=function(self) if AnyPlayerFullComboed() then SOUND:PlayOnce( THEME:GetPathS( '', "FullComboSplash" ) ) if isEtterna("0.65") then self:sleep(3) else self:hibernate(3) end end end
		},
		Def.ActorFrame{
			InitCommand=function(self) self:visible(true) end,
			ForceFailMessageCommand=function(self) self:stoptweening():visible(false) end,
			Def.Sprite {
				Texture = "_round "..(isFinal() and "final" or "normal"),
				InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(0):addy(-30) end,
				StartTransitioningCommand=function(self) self:playcommand("Check"):diffusealpha(0):sleep(0.3):linear(0.3):diffusealpha(1):addy(30) end,
				CheckCommand=function(self) if AnyPlayerFullComboed() then if isEtterna("0.65") then self:sleep(3) else self:hibernate(3) end end end
			},
			Def.Sprite {
				Texture = "_cleared bottom "..(isFinal() and "final" or "normal"),
				InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+15*WideScreenDiff()):zoom(0.9*WideScreenDiff()):diffusealpha(0):addx(100) end,
				StartTransitioningCommand=function(self) self:playcommand("Check"):diffusealpha(0):sleep(0.6):decelerate(0.3):diffusealpha(1):addx(-100):sleep(0.5) end,
				CheckCommand=function(self) if AnyPlayerFullComboed() then if isEtterna("0.65") then self:sleep(3) else self:hibernate(3) end end end
			},
			Def.Sprite {
				Texture = "_cleared top "..(isFinal() and "final" or "normal"),
				InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+10*WideScreenDiff()):zoom(0.9*WideScreenDiff()):blend(Blend.Add):diffusealpha(0):addx(-100) end,
				StartTransitioningCommand=function(self) self:playcommand("Check"):diffusealpha(0):sleep(0.6):decelerate(0.3):diffusealpha(1):addx(100):sleep(0.5) end,
				CheckCommand=function(self) if AnyPlayerFullComboed() then if isEtterna("0.65") then self:sleep(3) else self:hibernate(3) end end end
			}
		}
	},
	Def.ActorFrame{
		--FORCEFAIL
		InitCommand=function(self) self:visible(false) end,
		ForceFailMessageCommand=function(self) self:stoptweening():visible(true) end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","failed/_stage "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(0):addy(-30) end,
			StartTransitioningCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1):addy(30) end
		},
		Def.ActorFrame{
			Name="NormalFail",
			InitCommand=function(self) self:visible(songfail(false)) end,
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenGameplay","failed/_failed "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:zoom(WideScreenDiff()):x(SCREEN_CENTER_X+2*WideScreenDiff()):y(SCREEN_CENTER_Y+30*WideScreenDiff()):diffusealpha(0):addx(-500) end,
				StartTransitioningCommand=function(self) self:sleep(0.4):decelerate(0.7):addx(500):diffusealpha(1) end
			}
		},
		Def.ActorFrame{
			Name="VertexFail",
			InitCommand=function(self) self:visible(songfail(true)) end,
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenGameplay","failed/v_failed"),
				InitCommand=function(self) self:zoom(WideScreenDiff()):x(SCREEN_CENTER_X+2*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):diffusealpha(0.2):cropleft(0.5):cropright(0.5) end,
				StartTransitioningCommand=function(self) self:sleep(0.7):decelerate(0.75):cropright(0):cropleft(0):diffusealpha(1) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("horiz-line","short"),
				InitCommand=function(self) self:zoomx(2*WideScreenDiff()):rotationz(90):x(SCREEN_CENTER_X+1*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):cropleft(0.5):cropright(0.5) end,
				StartTransitioningCommand=function(self) self:sleep(0.55):accelerate(0.15):cropleft(0):cropright(0):decelerate(0.725):addx(-SCREEN_WIDTH/2):linear(0.15):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("horiz-line","short"),
				InitCommand=function(self) self:zoomx(2*WideScreenDiff()):rotationz(90):x(SCREEN_CENTER_X+2*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):cropleft(0.5):cropright(0.5) end,
				StartTransitioningCommand=function(self) self:sleep(0.55):accelerate(0.15):cropleft(0):cropright(0):decelerate(0.725):addx(SCREEN_WIDTH/2):linear(0.15):diffusealpha(0) end
			}
		},
		Def.Quad{
			InitCommand=function(self) self:FullScreen():diffuse(color("#00000000")) end,
			ForceFailMessageCommand=function(self) self:sleep(3):linear(0.3):diffusealpha(1) end
		},
		Def.Sound {
			File = THEME:GetPathB("ScreenGameplay","failed/bleh.ogg"),
			ForceFailMessageCommand=function(self) self:play() end
		}
	}
}