return Def.ActorFrame{
    InitCommand=function(self) self:Center() end,
    Def.Sprite {
        Texture = THEME:GetPathG("credits","frame"),
        OnCommand=function(self) self:zoomx(2*WideScreenDiff_(16/10)):croptop(1):fadetop(1):linear(0.8):croptop(-1):fadetop(-1) end
    }
}