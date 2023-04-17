local ColumnStepsType1 = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
local stepsType = THEME:GetString("StepsType",ToEnumShortString(ColumnStepsType1))

return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/back frame"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-1*WideScreenDiff()):CenterY():zoomx(WideScreenDiff()) end
	},
	LoadActor(THEME:GetPathB("horiz-line","long"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-34*WideScreenDiff()):zoomx(0.99*WideScreenDiff()) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/mask"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+2*WideScreenDiff()):zoomy(WideScreenDiff()):zwrite(true):blend(Blend.NoEffect):vertalign(bottom) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):valign(0):zoomto(SCREEN_WIDTH,78*WideScreenDiff()):zwrite(true):blend(Blend.NoEffect) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/center"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/left"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-(120+17)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/right"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-(120-14)*WideScreenDiff()):y(SCREEN_TOP+4*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end
	},
	Def.ActorFrame{
		Name="Icons",
		OnCommand=function(self) if stepsType == "Single" then self:diffusealpha(0):linear(0.5):diffusealpha(1) end end,
		OffCommand=function(self) if stepsType == "Double" then self:linear(0.5):diffusealpha(0) end end,
		LoadActor("dgrades")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenDiff()):y(SCREEN_TOP+56*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		LoadFont("_eurostile normal")..{
			Text="Normal",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+144*WideScreenDiff()):y(SCREEN_TOP+54*WideScreenDiff()):shadowlength(2):zoom(0.5*WideScreenDiff()):diffuse(ContrastingDifficultyColor("Medium")) end
		}
	}
}