return Def.ActorFrame{
	LoadActor("CJ112 "..(isFinal() and "Final" or "Normal"))..{
		InitCommand=function(self) self:Center():FullScreen() end
	},
	Def.Actor{ InitCommand=function(self) self:clearzbuffer(true) end }
}