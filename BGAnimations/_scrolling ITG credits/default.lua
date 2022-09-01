return Def.ActorFrame{
    InitCommand=function(self) self:Center() end,
    LoadActor("credits frame")..{
        OnCommand=function(self) self:ztest(1) end
    },
    Def.Quad{
        OnCommand=function(self) self:y(-226):zwrite(1):blend("BlendMode_NoEffect"):zoomtowidth(340):zoomtoheight(70) end
    },
    LoadActor("../_ITG credits text")
}