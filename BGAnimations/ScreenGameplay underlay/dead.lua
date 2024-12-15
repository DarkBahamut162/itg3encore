local centerCheck = getenv("Rotation"..pname(GAMESTATE:GetMasterPlayerNumber())) == 5 or false
return Def.ActorFrame{
	Def.ActorFrame{
		Name="DeadSingle",
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			self:visible( styleType ~= "StyleType_OnePlayerTwoSides" and styleType ~= "StyleType_TwoPlayersSharedSides" and not centerCheck )
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == Health.Dead then
				local dead = self:GetChild("Dead"..pname(param.PlayerNumber))
				dead:playcommand("Show")
			end
		end,
		Def.Quad{
			Name="DeadP1",
			InitCommand=function(self) self:diffuse(color("0,0,0,0.5")):faderight(0.3):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_1) end,
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end
		},
		Def.Quad{
			Name="DeadP2",
			InitCommand=function(self) self:diffuse(color("0,0,0,0.5")):fadeleft(0.3):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_2) end,
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end
		}
	},

	Def.ActorFrame{
		Name="DeadDouble",
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			self:visible( styleType == "StyleType_OnePlayerTwoSides" or styleType == "StyleType_TwoPlayersSharedSides" or centerCheck )
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == Health.Dead then
				self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
			end
		end,
		Def.Quad{
			InitCommand=function(self) self:cropleft(centerCheck and 0.25 or 0):cropright(centerCheck and 0.25 or 0):diffuse(color("0,0,0,0.5")):fadeleft(0.2):faderight(0.2):FullScreen():diffusealpha(0) end,
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end
		}
	}
}