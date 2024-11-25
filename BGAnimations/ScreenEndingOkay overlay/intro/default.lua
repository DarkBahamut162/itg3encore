return Def.ActorFrame{
    Def.Sprite {
        Texture = "in",
        OnCommand=function(self) self:x(-230*WideScreenDiff()):y(-41*WideScreenDiff()):diffusealpha(0):sleep(1.0):zoom(4*WideScreenDiff()):linear(0.3):diffusealpha(1):zoom(0.92*WideScreenDiff()):sleep(0.8):diffusealpha(0) end
    },
    Def.Sprite {
        Texture = "in",
        OnCommand=function(self) self:x(-230*WideScreenDiff()):y(-41*WideScreenDiff()):diffusealpha(0):sleep(1.0):glow(1,1,1,1):zoom(1*WideScreenDiff()):linear(0.5):glow(1,1,1,0):zoom(3*WideScreenDiff()) end
    },
    Def.Sprite {
        Texture = "the",
        OnCommand=function(self) self:x(-92*WideScreenDiff()):y(-41*WideScreenDiff()):diffusealpha(0):sleep(1.2):zoom(4*WideScreenDiff()):linear(0.3):diffusealpha(1):zoom(0.93*WideScreenDiff()):sleep(0.6):diffusealpha(0) end
    },
    Def.Sprite {
        Texture = "the",
        OnCommand=function(self) self:x(-92*WideScreenDiff()):y(-41*WideScreenDiff()):diffusealpha(0):sleep(1.2):glow(1,1,1,1):zoom(1*WideScreenDiff()):linear(0.5):glow(1,1,1,0):zoom(3*WideScreenDiff()) end
    },
    Def.Sprite {
        Texture = "groove",
        OnCommand=function(self) self:x(-48*WideScreenDiff()):y(43*WideScreenDiff()):diffusealpha(0):sleep(1.4):zoom(3.7*WideScreenDiff()):linear(0.3):diffusealpha(1):zoomy(0.86*WideScreenDiff()):zoomx(0.92*WideScreenDiff()):sleep(0.4):diffusealpha(0) end
    },
    Def.Sprite {
        Texture = "groove",
        OnCommand=function(self) self:x(-48*WideScreenDiff()):y(46*WideScreenDiff()):diffusealpha(0):sleep(1.4):glow(1,1,1,1):zoom(1*WideScreenDiff()):linear(0.5):glow(1,1,1,0):zoom(3*WideScreenDiff()) end
    }
}