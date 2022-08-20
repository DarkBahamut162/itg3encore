return Def.ActorFrame{
    Def.ActorFrame{
		LoadActor("frame");
		LoadFont("_r bold 30px")..{
			Text="Pat McIlroy";
			OnCommand=function(self) self:y(10):x(42):diffuse(color("#FFFFFF")) end;
		};
		LoadFont("_r normal")..{
			Text="Programming";
			OnCommand=function(self) self:y(-29):x(38):zoomx(0.57):zoomy(0.6):shadowlength(0):diffuse(color("#FFFFFF")) end;
		};
		LoadActor("_people")..{
			OnCommand=function(self) self:animate(0):setstate(14):x(-114) end;
		};
	};
}