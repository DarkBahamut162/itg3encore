local centerCheck = getenv("Rotation"..pname(GAMESTATE:GetMasterPlayerNumber())) == 5 or false
return Def.ActorFrame{
	Def.ActorFrame{
		Name="DangerP1",
		OnCommand=function(self) if getenv("Flare"..pname(PLAYER_1)) == 11 then self:visible(false) end end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				if param.Level == 1 then self:visible(true) end
			end
		end,
		Def.ActorFrame{
			Condition=not isDouble() and not centerCheck,
			Name="Single",
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == Health.Danger then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/single"),
				InitCommand=function(self) self:faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:faderight(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger text "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger glow "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	},
	Def.ActorFrame{
		Condition=isDouble() or centerCheck,
		Name="DangerDouble",
		OnCommand=function(self) if getenv("Flare"..pname(GAMESTATE:GetMasterPlayerNumber())) == 11 then self:visible(false) end end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == GAMESTATE:GetMasterPlayerNumber() then
				if param.Level == 1 then self:visible(true) end
			end
		end,
		Def.ActorFrame{
			Name="Double",
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == GAMESTATE:GetMasterPlayerNumber() then
					if param.HealthState == Health.Danger then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/double"),
				InitCommand=function(self) self:cropleft(centerCheck and 0.25 or 0):cropright(centerCheck and 0.25 or 0):faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:cropleft(0.25):cropright(0.25):faderight(0.1):fadeleft(0.1):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger text "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger glow "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	},
	Def.ActorFrame{
		Condition=not isDouble() and not centerCheck,
		Name="DangerP2",
		OnCommand=function(self) if getenv("Flare"..pname(PLAYER_2)) == 11 then self:visible(false) end end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == PLAYER_2 then
				if param.Level == 1 then self:visible(true) end
			end
		end,
		Def.ActorFrame{
			Name="Single",
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == Health.Danger then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/single"),
				InitCommand=function(self) self:faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:fadeleft(0.1):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger text "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger glow "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	}
}