return Def.ActorFrame{
	Def.ActorFrame{
		Def.Quad{
			InitCommand=function(self) self:FullScreen():diffuse(color("#00000000")) end,
			StartTransitioningCommand=function(self) self:queuecommand("Check"):linear(0.3):diffusealpha(1):sleep(1) end,
			CheckCommand=function(self) if AnyPlayerFullComboed() then SOUND:PlayOnce( THEME:GetPathS( '', "FullComboSplash" ) ) self:hibernate(3) end end
		},
		LoadActor("_round "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75*WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(0):addy(-30) end,
			StartTransitioningCommand=function(self) self:queuecommand("Check"):sleep(0.3):linear(0.3):diffusealpha(1):addy(30) end,
			CheckCommand=function(self) if AnyPlayerFullComboed() then self:hibernate(3) end end
		},
		LoadActor("_cleared bottom "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+15*WideScreenDiff()):zoom(0.9*WideScreenDiff()):diffusealpha(0):addx(100) end,
			StartTransitioningCommand=function(self) self:queuecommand("Check"):sleep(0.6):decelerate(0.3):diffusealpha(1):addx(-100):sleep(0.5) end,
			CheckCommand=function(self) if AnyPlayerFullComboed() then self:hibernate(3) end end
		},
		LoadActor("_cleared top "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+10*WideScreenDiff()):zoom(0.9*WideScreenDiff()):blend(Blend.Add):diffusealpha(0):addx(-100) end,
			StartTransitioningCommand=function(self) self:queuecommand("Check"):sleep(0.6):decelerate(0.3):diffusealpha(1):addx(100):sleep(0.5) end,
			CheckCommand=function(self) if AnyPlayerFullComboed() then self:hibernate(3) end end
		}
	}
}