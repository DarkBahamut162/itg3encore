return Def.ActorFrame{
	Def.Sprite {
		Texture = "ScreenEvaluation _BannerFrame"..(isFinal() and "Final" or "Normal"),
	}
}