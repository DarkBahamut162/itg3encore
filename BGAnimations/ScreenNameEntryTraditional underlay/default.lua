return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop")),
	LoadActor("name entry banner mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+138):zbuffer(true):blend(Blend.NoEffect):addy(200):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:decelerate(0.3):addy(-200) end
	},
	Def.ActorFrame{
		Name="P1Side",
		InitCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1)) end,
		LoadActor("name frame "..(isFinal() and "final" or "normal"))..{
			Condition=getenv("HighScoreable"..pname(PLAYER_1)),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-157*WideScreenDiff()):y(SCREEN_CENTER_Y+72*WideScreenDiff()):addx(-SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:decelerate(0.3):addx(SCREEN_WIDTH/2) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-SCREEN_WIDTH/2) end
		},
		LoadActor("name entry "..(isFinal() and "final" or "normal").." BGA score frame")..{
			InitCommand=function(self)
				if isFinal() then
					self:x(SCREEN_CENTER_X-195*WideScreenDiff()):y(SCREEN_CENTER_Y+134*WideScreenDiff())
				else
					self:x(SCREEN_CENTER_X-200*WideScreenDiff()):y(SCREEN_CENTER_Y+145*WideScreenDiff())
				end
				self:addx(-SCREEN_WIDTH/2):zoom(WideScreenDiff()):blend(Blend.Add)
			end,
			OnCommand=function(self) self:decelerate(0.3):addx(SCREEN_WIDTH/2) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-SCREEN_WIDTH/2) end
		},
		LoadActor("name entry "..(isFinal() and "final" or "normal").." BGA list frame")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-157*WideScreenDiff()):y(SCREEN_CENTER_Y-70*WideScreenDiff()):addx(-SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:decelerate(0.3):addx(SCREEN_WIDTH/2) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-SCREEN_WIDTH/2) end
		}
	},
	Def.ActorFrame{
		Name="P2Side",
		InitCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2)) end,
		LoadActor("name frame "..(isFinal() and "final" or "normal"))..{
			Condition=getenv("HighScoreable"..pname(PLAYER_2)),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+156*WideScreenDiff()):y(SCREEN_CENTER_Y+72*WideScreenDiff()):addx(SCREEN_WIDTH/2):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
			OnCommand=function(self) self:decelerate(0.3):addx(-SCREEN_WIDTH/2) end,
			OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH/2) end
		},
		LoadActor("name entry "..(isFinal() and "final" or "normal").." BGA score frame")..{
			InitCommand=function(self)
				if isFinal() then
					self:x(SCREEN_CENTER_X+195*WideScreenDiff()):y(SCREEN_CENTER_Y+134*WideScreenDiff())
				else
					self:x(SCREEN_CENTER_X+200*WideScreenDiff()):y(SCREEN_CENTER_Y+145*WideScreenDiff())
				end
				self:addx(SCREEN_WIDTH/2):zoom(WideScreenDiff()):blend(Blend.Add)
			end,
			OnCommand=function(self) self:decelerate(0.3):addx(-SCREEN_WIDTH/2) end,
			OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH/2) end
		},
		LoadActor("name entry "..(isFinal() and "final" or "normal").." BGA list frame")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+156*WideScreenDiff()):y(SCREEN_CENTER_Y-70*WideScreenDiff()):addx(SCREEN_WIDTH/2):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
			OnCommand=function(self) self:decelerate(0.3):addx(-SCREEN_WIDTH/2) end,
			OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH/2) end
		}
	},
	LoadActor("light")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+4.5*WideScreenDiff()):zoomy(0.815*WideScreenDiff()):zoomx(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(1):linear(0.4):diffusealpha(1):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock("beat"):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFFFF")):effectperiod(2) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
	}
}