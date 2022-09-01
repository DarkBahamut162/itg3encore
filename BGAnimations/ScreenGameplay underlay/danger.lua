return Def.ActorFrame{
	Def.ActorFrame{
		Name="DangerP1",
		Def.ActorFrame{
			Name="Single",
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end,
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			LoadActor(THEME:GetPathB("_shared","danger/single"))..{
				InitCommand=function(self) self:faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:faderight(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("_shared","danger/_danger text"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("_shared","danger/_danger glow"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	},
	Def.ActorFrame{
		Name="DangerDouble",
		Def.ActorFrame{
			Name="Double",
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(bDoubles)
			end,
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == GAMESTATE:GetMasterPlayerNumber() then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			LoadActor(THEME:GetPathB("_shared","danger/double"))..{
				InitCommand=function(self) self:faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:faderight(0.1):fadeleft(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("_shared","danger/_danger text"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("_shared","danger/_danger glow"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	},
	Def.ActorFrame{
		Name="DangerP2",
		Def.ActorFrame{
			Name="Single",
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end,
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			LoadActor(THEME:GetPathB("_shared","danger/single"))..{
				InitCommand=function(self) self:faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:fadeleft(0.1):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("_shared","danger/_danger text"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			LoadActor(THEME:GetPathB("_shared","danger/_danger glow"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	}
}