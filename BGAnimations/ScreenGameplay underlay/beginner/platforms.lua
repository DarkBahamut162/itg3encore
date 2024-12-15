local P1X = (getenv("RotationP1") == 5 and GAMESTATE:GetNumPlayersEnabled() == 1) and SCREEN_CENTER_X or SCREEN_CENTER_X-SCREEN_WIDTH/4
local P2X = (getenv("RotationP2") == 5 and GAMESTATE:GetNumPlayersEnabled() == 1) and SCREEN_CENTER_X or SCREEN_CENTER_X+SCREEN_WIDTH/4
local P1r = (getenv("RotationP1") == 5 and GAMESTATE:GetNumPlayersEnabled() == 1) and 0 or -20
local P2r = (getenv("RotationP2") == 5 and GAMESTATE:GetNumPlayersEnabled() == 1) and 0 or 20

return Def.ActorFrame{
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
		Name="PlatformP1",
		BeginCommand=function(self)
			self:visible(GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()=='Difficulty_Beginner' and isRegular())
		end,
		Def.ActorFrame{
			InitCommand=function(self) self:x(P1X):y(SCREEN_CENTER_Y+40*WideScreenDiff()):zoom(1.2*WideScreenDiff()):rotationx(P1r):fov(45):vanishpoint(SCREEN_CENTER_X-160,SCREEN_CENTER_Y+40) end,
			Condition=IsGame("dance") or IsGame("groove"),
			Def.Sprite {
				Texture = "dance platform",
				InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")) end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:x(-45):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Left" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:x(46):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Right" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:y(-45):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Up" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:y(45):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Down" then self:playcommand("Cross") end
				end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(P1X):y(SCREEN_BOTTOM):zoom(1.2*WideScreenDiff()):vanishpoint(SCREEN_CENTER_X-160,SCREEN_CENTER_Y+40) end,
			Condition=IsGame("pump"),
			Def.Sprite {
				Texture = "pump platform",
				InitCommand=function(self) self:y(7):x(4):valign(1):diffuse(color("0.6,0.6,0.6,0.8")) end
			},
			Def.Sprite {
				Texture = "panel_upleft",
				InitCommand=function(self) self:x(-61):y(-90):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "UpLeft" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_upleft",
				InitCommand=function(self) self:x(61):y(-90):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoomx(-1.1):zoomy(1.1):linear(0.4):zoomx(-1):zoomy(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "UpRight" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_center",
				InitCommand=function(self) self:y(-70):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Center" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_downleft",
				InitCommand=function(self) self:x(-80):y(-41):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "DownLeft" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_downleft",
				InitCommand=function(self) self:x(80):y(-41):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoomx(-1.1):zoomy(1.1):linear(0.4):zoomx(-1):zoomy(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "DownRight" then self:playcommand("Cross") end
				end
			}
		}
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
		Name="PlatformP2",
		BeginCommand=function(self)
			self:visible(GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()=='Difficulty_Beginner' and isRegular())
		end,
		Def.ActorFrame{
			InitCommand=function(self) self:x(P2X):y(SCREEN_CENTER_Y+40*WideScreenDiff()):zoom(1.2*WideScreenDiff()):rotationx(P2r):fov(45):vanishpoint(SCREEN_CENTER_X+160,SCREEN_CENTER_Y+40) end,
			Condition=IsGame("dance") or IsGame("groove"),
			Def.Sprite {
				Texture = "dance platform",
				InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")) end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:x(-45):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Left" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:x(46):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Right" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:y(-45):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Up" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panelglow",
				InitCommand=function(self) self:y(45):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Down" then self:playcommand("Cross") end
				end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(P2X):y(SCREEN_BOTTOM):zoom(1.2*WideScreenDiff()):vanishpoint(SCREEN_CENTER_X+160,SCREEN_CENTER_Y+40) end,
			Condition=IsGame("pump"),
			Def.Sprite {
				Texture = "pump platform",
				InitCommand=function(self) self:y(7):x(4):valign(1):diffuse(color("0.6,0.6,0.6,0.8")) end
			},
			Def.Sprite {
				Texture = "panel_upleft",
				InitCommand=function(self) self:x(-61):y(-90):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "UpLeft" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_upleft",
				InitCommand=function(self) self:x(61):y(-90):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoomx(-1.1):zoomy(1.1):linear(0.4):zoomx(-1):zoomy(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "UpRight" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_center",
				InitCommand=function(self) self:y(-70):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "Center" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_downleft",
				InitCommand=function(self) self:x(-80):y(-41):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "DownLeft" then self:playcommand("Cross") end
				end
			},
			Def.Sprite {
				Texture = "panel_downleft",
				InitCommand=function(self) self:x(80):y(-41):diffusealpha(0):blend(Blend.Add) end,
				CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoomx(-1.1):zoomy(1.1):linear(0.4):zoomx(-1):zoomy(1):diffusealpha(0) end,
				NoteCrossedMessageCommand=function(self,param)
					if param.ButtonName == "DownRight" then self:playcommand("Cross") end
				end
			}
		}
	}
}