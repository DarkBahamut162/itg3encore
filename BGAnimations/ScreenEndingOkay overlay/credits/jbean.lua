return Def.ActorFrame{
    Def.ActorFrame{
		Def.Sprite {
			Texture = "frame "..(isFinal() and "final" or "normal")
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Text="Jordan Frederick",
			OnCommand=function(self) self:y(10):x(42):diffuse(color("#FFFFFF")) end
		},
		Def.BitmapText {
			File = "_r normal",
			Text="Stepcharts",
			OnCommand=function(self) self:y(-29):x(38):zoomx(0.57):zoomy(0.6):shadowlength(0):diffuse(color("#FFFFFF")) end
		},
		Def.Sprite {
			Texture = "_people",
			OnCommand=function(self) self:animate(0):setstate(5):x(-114) end
		},
		Def.Sprite {
			Texture = "_people",
			OnCommand=function(self) self:animate(0):setstate(6):x(-114):diffusealpha(0):queuecommand("Look") end,
			LookCommand=function(self) self:sleep(5):diffusealpha(1):sleep(0.4):diffusealpha(0):queuecommand("Look") end
		}
	}
}