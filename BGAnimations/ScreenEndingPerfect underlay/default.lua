return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("#000000FF")) end
	},
    loadfile(THEME:GetPathB("ScreenEndingPerfect","underlay/background"))(),
    loadfile(THEME:GetPathB("ScreenEndingPerfect","underlay/people"))(),
    loadfile(THEME:GetPathB("ScreenEndingPerfect","underlay/in the groove"))()..{
        OnCommand=function(self) self:sleep(20) end
    }
}