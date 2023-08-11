GAMESTATE:SetCurrentPlayMode("PlayMode_Regular")

return Def.ActorFrame{
	StandardDecorationFromFile("Triangle","Triangle"),
	Def.ActorFrame{
		Name="Pane",
		InitCommand=function(self) self:draworder(-1) end,
		LoadActor(THEME:GetPathG("_pane","elements/_ldifficulty "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+12*WideScreenDiff()):y(SCREEN_BOTTOM-8*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):player(PLAYER_1) end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):sleep(0.5):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane","elements/_ldifficulty "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-12*WideScreenDiff()):y(SCREEN_BOTTOM-8*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(right):vertalign(bottom):player(PLAYER_2) end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):sleep(0.5):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane","elements/_lbase "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+26*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom) end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane","elements/_basewidth "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-174*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane","elements/_lbase "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+174*WideScreenDiff()):y(SCREEN_BOTTOM):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(left):vertalign(bottom) end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane","elements/_basewidth "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+174*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
		}
	},
	Def.ActorFrame{
		Name="LightP1",
		InitCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local isDouble = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and not isDouble)
		end,
		LoadActor(THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-90*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
		}
	},
	Def.ActorFrame{
		Name="LightP2",
		InitCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local isDouble = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and not isDouble)
		end,
		LoadActor(THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(left):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		LoadActor(THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
		}
	},
	Def.ActorFrame{
		Name="LightDouble",
		InitCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local isDouble = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(isDouble)
		end,
		Def.ActorFrame{
			Name="LeftSide",
			LoadActor(THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-90*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
			},
			LoadActor(THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X-146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
			}
		},
		Def.ActorFrame{
			Name="RightSide",
			LoadActor(THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(left):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
			},
			LoadActor(THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
			}
		}
	},
	LoadFont("_v 26px bold shadow")..{
		Text="Ctrl + Enter to select",
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-55):zoom(0.6*WideScreenDiff()):draworder(10):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(1):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))..{ InitCommand=function(self) self:ztest(true) end },
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop")),
	StandardDecorationFromFileOptional("UserList","UserList")
}