return Def.ActorFrame{
    InitCommand=function(self) self:Center() end,
    Def.Sprite {
        Texture = THEME:GetPathG("credits","frame"),
        OnCommand=function(self) self:ztest(1):zoomx(WideScreenDiff()) end
    },
    Def.Quad{
        OnCommand=function(self) self:y(-226):zwrite(1):blend(Blend.NoEffect):zoomtowidth(340*WideScreenDiff()):zoomtoheight(70*WideScreenDiff()) end
    },
    loadfile(THEME:GetPathB("","_ITG credits text"))()
}