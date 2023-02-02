return Def.ActorFrame{
	LoadActor("CJ112 "..(isFinal() and "Final" or "Normal"))..{
		InitCommand=function(self) self:FullScreen() end
	},
	Def.Actor{ InitCommand=function(self) self:clearzbuffer(true) end }
}