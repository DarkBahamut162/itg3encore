return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _SectionExpanded NormalPart"..(isFinal() and "Final" or "Normal")
	}
}