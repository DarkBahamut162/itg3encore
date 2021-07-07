return Def.ActorFrame{
	LoadActor("back frame")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-1):CenterY():diffusealpha(0):zoomtowidth(228) end;
		OnCommand=function(self) self:decelerate(0.30):zoomx(1):diffusealpha(1) end;
	};
	LoadActor("horiz-line")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-34):diffusealpha(0):zoomtowidth(0) end;
		OnCommand=function(self) self:sleep(.2):decelerate(0.30):zoomx(.99):diffusealpha(1) end;
	};
	LoadActor("mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+2):zwrite(true):blend('BlendMode_NoEffect'):vertalign(bottom) end;
	};
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP):valign(0):zoomto(SCREEN_WIDTH,78):zwrite(true):blend('BlendMode_NoEffect') end;
	};
	LoadActor("center")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120):y(SCREEN_TOP+4):vertalign(top) end;
	};
	LoadActor("left")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120-17):y(SCREEN_TOP+4):vertalign(top):horizalign(right):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) end;
	};
	LoadActor("right")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120+14):y(SCREEN_TOP+4):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH) end;
	};

	Def.ActorFrame{
		Name="Icons";
		LoadActor("dgrades")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100):y(SCREEN_TOP+56) end;
		};
		LoadFont("_eurostile normal")..{
			Text="Easy";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-48):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Easy")) end;
		};
		LoadFont("_eurostile normal")..{
			Text="Medium";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+48):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Medium")) end;
		};
		LoadFont("_eurostile normal")..{
			Text="Hard";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+144):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Hard")) end;
		};
		LoadFont("_eurostile normal")..{
			Text="Expert";
			InitCommand=function(self) self:x(SCREEN_CENTER_X+240):y(SCREEN_TOP+54):shadowlength(2):zoom(0.5):diffuse(ContrastingDifficultyColor("Challenge")) end;
		};
	};
};