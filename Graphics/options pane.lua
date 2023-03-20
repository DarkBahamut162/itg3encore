return Def.ActorFrame{
	LoadActor("options pane "..(isFinal() and "final" or "normal"))..{
		InitCommand=function(self) self:zoom(WideScreenDiff()) end
	}
}