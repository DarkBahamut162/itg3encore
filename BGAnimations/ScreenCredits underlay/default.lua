return Def.ActorFrame{
    InitCommand=function(self) self:Center() end,
    LoadActor("../credits frame")..{
        OnCommand=function(self) self:zoomx(2):croptop(1):fadetop(1):linear(0.8):croptop(-1):fadetop(-1) end
    }
}