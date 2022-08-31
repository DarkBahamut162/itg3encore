return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("0,0,0,1")) end
	},
	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("0,0,0,0.2")) end
	}
}