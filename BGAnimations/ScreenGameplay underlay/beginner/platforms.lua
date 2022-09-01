local pm = GAMESTATE:GetPlayMode()
local P1X = (getenv("RotationSoloP1") and GAMESTATE:GetNumPlayersEnabled() == 1) and SCREEN_CENTER_X or SCREEN_CENTER_X-SCREEN_WIDTH/4
local P2X = (getenv("RotationSoloP2") and GAMESTATE:GetNumPlayersEnabled() == 1) and SCREEN_CENTER_X or SCREEN_CENTER_X+SCREEN_WIDTH/4
local P1r = (getenv("RotationSoloP1") and GAMESTATE:GetNumPlayersEnabled()) and 0 or -20
local P2r = (getenv("RotationSoloP2") and GAMESTATE:GetNumPlayersEnabled()) and 0 or 20

return Def.ActorFrame{
	Def.ActorFrame{
		Name="PlatformP1",
		InitCommand=function(self) self:x(P1X):y(SCREEN_CENTER_Y+40):zoom(1.2):rotationx(P1r):fov(45):vanishpoint(SCREEN_CENTER_X-160,SCREEN_CENTER_Y+40) end,
		BeginCommand=function(self)
			local isHuman = GAMESTATE:IsHumanPlayer(PLAYER_1)
			local stepsDiff = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()
			self:visible(isHuman and stepsDiff=='Difficulty_Beginner' and pm == 'PlayMode_Regular')
		end,
		LoadActor("../platform")..{ InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")) end },
		LoadActor("panelglow")..{
			InitCommand=function(self) self:x(-45):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Left" then self:playcommand("Cross") end
			end
		},
		LoadActor("panelglow")..{
			InitCommand=function(self) self:x(46):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Right" then self:playcommand("Cross") end
			end
		},
		LoadActor("panelglow")..{
			InitCommand=function(self) self:y(-45):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Up" then self:playcommand("Cross") end
			end
		},
		LoadActor("panelglow")..{
			InitCommand=function(self) self:y(45):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Down" then self:playcommand("Cross") end
			end
		}
	},

	Def.ActorFrame{
		Name="PlatformP2",
		InitCommand=function(self) self:x(P2X):y(SCREEN_CENTER_Y+40):zoom(1.2):rotationx(P2r):fov(45):vanishpoint(SCREEN_CENTER_X+160,SCREEN_CENTER_Y+40) end,
		BeginCommand=function(self)
			local isHuman = GAMESTATE:IsHumanPlayer(PLAYER_2)
			local stepsDiff = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()
			self:visible(isHuman and stepsDiff=='Difficulty_Beginner' and pm == 'PlayMode_Regular')
		end,
		LoadActor("../platform")..{ InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")) end },
		LoadActor("panelglow")..{
			InitCommand=function(self) self:x(-45):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Left" then self:playcommand("Cross") end
			end
		},
		LoadActor("panelglow")..{
			InitCommand=function(self) self:x(46):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Right" then self:playcommand("Cross") end
			end
		},
		LoadActor("panelglow")..{
			InitCommand=function(self) self:y(-45):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Up" then self:playcommand("Cross") end
			end
		},
		LoadActor("panelglow")..{
			InitCommand=function(self) self:y(45):diffusealpha(0):blend(Blend.Add) end,
			CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.4):zoom(1):diffusealpha(0) end,
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Down" then self:playcommand("Cross") end
			end
		}
	}
}