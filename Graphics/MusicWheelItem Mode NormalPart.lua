return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _Mode NormalPart"..(isFinal() and "Final" or "Normal")
	}
}