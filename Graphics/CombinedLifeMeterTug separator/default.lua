return Def.ActorFrame{
	Def.Quad{ InitCommand=function(self) self:zoomto(2,14):diffuse(color("#000000")) end },
	LoadActor("back"),
	LoadActor("back")..{
		OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#000000")):effectperiod(0.3) end
	}
}