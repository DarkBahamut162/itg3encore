return Def.ActorFrame{
	LoadActor("MusicWheel _highlight "..(isFinal() and "Final" or "Normal"))..{
		InitCommand=function(self) self:blend(Blend.Add) end
	}
}