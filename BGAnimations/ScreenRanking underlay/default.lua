local ColumnStepsType1 = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
local stepsType = THEME:GetString("StepsType",ToEnumShortString(ColumnStepsType1))

return Def.ActorFrame{
	Def.Sprite {
		Texture = "back frame",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-1*WideScreenDiff()):CenterY():zoomx(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("horiz-line","long"),
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-34*WideScreenDiff()):zoomx(0.99*WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = "mask",
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+2*WideScreenDiff()):zoomy(WideScreenDiff()):zwrite(true):blend(Blend.NoEffect):vertalign(bottom) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):valign(0):zoomto(SCREEN_WIDTH,78*WideScreenDiff()):zwrite(true):blend(Blend.NoEffect) end
	},
	Def.Sprite {
		Texture = "center "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):vertalign(top):zoom(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = "left "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-(120+17)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):vertalign(top):horizalign(right):zoom(WideScreenDiff()):zoomtowidth(SCREEN_WIDTH) end
	},
	Def.Sprite {
		Texture = "right "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-(120-14)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):vertalign(top):horizalign(left):zoom(WideScreenDiff()):zoomtowidth(SCREEN_WIDTH) end
	},
	Def.ActorFrame{
		Name="Icons",
		OnCommand=function(self) if stepsType == "Single" then self:diffusealpha(0):linear(0.5):diffusealpha(1) end end,
		OffCommand=function(self) if stepsType == "Double" then self:linear(0.5):diffusealpha(0) end end,
		Def.Sprite {
			Texture = "dgrades "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenDiff()):y(SCREEN_TOP+56*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Easy",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-48*WideScreenDiff()):y(SCREEN_TOP+54*WideScreenDiff()):shadowlength(2):zoom(0.5*WideScreenDiff()):diffuse(ContrastingDifficultyColor("Easy")) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Medium",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+48*WideScreenDiff()):y(SCREEN_TOP+54*WideScreenDiff()):shadowlength(2):zoom(0.5*WideScreenDiff()):diffuse(ContrastingDifficultyColor("Medium")) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Hard",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+144*WideScreenDiff()):y(SCREEN_TOP+54*WideScreenDiff()):shadowlength(2):zoom(0.5*WideScreenDiff()):diffuse(ContrastingDifficultyColor("Hard")) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Expert",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+240*WideScreenDiff()):y(SCREEN_TOP+54*WideScreenDiff()):shadowlength(2):zoom(0.5*WideScreenDiff()):diffuse(ContrastingDifficultyColor("Challenge")) end
		}
	}
}