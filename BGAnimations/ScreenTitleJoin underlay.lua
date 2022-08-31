return Def.ActorFrame{
	LoadFont("_r bold shadow 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-100):shadowlength(0):zoomx(0.8):zoomy(0.7):settext("PRESS") end
	},
	Def.ActorFrame{
		Name="StartButton",
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-75) end,
		LoadActor(THEME:GetPathG("_common","base start button"))..{
			InitCommand=function(self) self:shadowlength(0):zoom(0.7) end
		},
		LoadActor(THEME:GetPathG("_common","start button"))..{
			InitCommand=function(self) self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#858585")):zoom(0.7):effectclock("beat") end
		},
		LoadActor(THEME:GetPathG("_common","glow start button"))..{
			InitCommand=function(self) self:blend(Blend.Add):shadowlength(0):diffuseshift():effectcolor1(color("#6BFF75")):effectcolor2(color("#FFFFFF00")):zoom(0.7):effectclock("beat") end
		}
	}
}