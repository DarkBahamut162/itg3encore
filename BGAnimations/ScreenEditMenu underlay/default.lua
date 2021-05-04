return Def.ActorFrame{
	LoadActor("main")..{ InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-32) end; };
	LoadActor("explanation")..{ InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+138) end; };
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay"))
};