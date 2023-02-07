local ColumnStepsType1 = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
local stepsType = THEME:GetString("StepsType",ToEnumShortString(ColumnStepsType1))

return Def.ActorFrame{
	LoadActor("back frame")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-1):CenterY() end
	},
	LoadActor("horiz-line")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-34):zoomx(0.99) end
	},
	LoadActor("mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+2):zwrite(true):blend(Blend.NoEffect):vertalign(bottom) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):valign(0):zoomto(SCREEN_WIDTH,78):zwrite(true):blend(Blend.NoEffect) end
	},
	LoadActor("center")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120):y(SCREEN_TOP+4):vertalign(top) end
	},
	LoadActor("left")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120-17):y(SCREEN_TOP+4):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end
	},
	LoadActor("right")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120+14):y(SCREEN_TOP+4):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end
	},
	Def.ActorFrame{
		Name="Icons",
		OnCommand=function(self) if stepsType == "Single" then self:diffusealpha(0):linear(0.5):diffusealpha(1) end end,
		OffCommand=function(self) if stepsType == "Double" then self:linear(0.5):diffusealpha(0) end end,
		LoadActor("dgrades")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100):y(SCREEN_TOP+56) end
		},
		LoadFont("_eurostile normal")..{
			Text="Easy",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-48):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Easy")) end
		},
		LoadFont("_eurostile normal")..{
			Text="Medium",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+48):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Medium")) end
		},
		LoadFont("_eurostile normal")..{
			Text="Hard",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+144):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Hard")) end
		},
		LoadFont("_eurostile normal")..{
			Text="Expert",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+240):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Challenge")) end
		}
	}
}