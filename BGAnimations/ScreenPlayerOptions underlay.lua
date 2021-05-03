return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop")),
	StandardDecorationFromFileOptional("StyleIcon","StyleIcon"),
	StandardDecorationFromFileOptional("StageDisplay","StageDisplay"),
};