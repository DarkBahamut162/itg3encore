return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _SectionCollapsed NormalPart"..(isFinal() and "Final" or "Normal")
	}
}