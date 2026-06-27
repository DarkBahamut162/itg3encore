return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheel _highlight "..(isFinal() and "Final" or "Normal"),
		InitCommand=function(self) self:blend(Blend.Add) end,
		NextSongMessageCommand=function(self) self:diffusealpha(0) end,
		PreviousSongMessageCommand=function(self) self:diffusealpha(0) end,
		HighlightReactivatedMessageCommand=function(self) self:diffusealpha(1) end
	}
}