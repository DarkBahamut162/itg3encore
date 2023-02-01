return Def.ActorFrame{
	LoadActor("ScreenEvaluation _BannerFrame"..(isFinal() and "Final" or "Normal"))
}