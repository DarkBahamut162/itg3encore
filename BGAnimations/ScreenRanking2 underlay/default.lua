return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/back frame"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-1):CenterY():diffusealpha(0):zoomtowidth(228) end,
		OnCommand=function(self) self:decelerate(0.30):zoomx(1):diffusealpha(1) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/horiz-line"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-34):diffusealpha(0):zoomtowidth(0) end,
		OnCommand=function(self) self:sleep(0.2):decelerate(0.30):zoomx(0.99):diffusealpha(1) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/mask"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+2):zwrite(true):blend('BlendMode_NoEffect'):vertalign(bottom) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):valign(0):zoomto(SCREEN_WIDTH,78):zwrite(true):blend('BlendMode_NoEffect') end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/center"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120):y(SCREEN_TOP+4):vertalign(top) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/left"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120-17):y(SCREEN_TOP+4):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end
	},
	LoadActor(THEME:GetPathB("ScreenRanking","underlay/right"))..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120+14):y(SCREEN_TOP+4):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end
	},
	Def.ActorFrame{
		Name="Icons",
		LoadActor("dgrades")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100):y(SCREEN_TOP+56) end
		},
		LoadFont("_eurostile normal")..{
			Text="Normal",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+144):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Medium")) end
		},
		LoadFont("_eurostile normal")..{
			Text="Intense",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+240):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Hard")) end
		}
	}
}