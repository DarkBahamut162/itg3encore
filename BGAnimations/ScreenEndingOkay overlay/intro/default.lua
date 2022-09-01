return Def.ActorFrame{
    LoadActor("in")..{
        OnCommand=function(self) self:x(-230):y(-41):diffusealpha(0):sleep(1.0):zoom(4):linear(0.3):diffusealpha(1):zoom(0.92):sleep(0.8):diffusealpha(0) end
    },
    LoadActor("in")..{
        OnCommand=function(self) self:x(-230):y(-41):diffusealpha(0):sleep(1.0):glow(1,1,1,1):zoom(1):linear(0.5):glow(1,1,1,0):zoom(3) end
    },
    LoadActor("the")..{
        OnCommand=function(self) self:x(-92):y(-41):diffusealpha(0):sleep(1.2):zoom(4):linear(0.3):diffusealpha(1):zoom(0.93):sleep(0.6):diffusealpha(0) end
    },
    LoadActor("the")..{
        OnCommand=function(self) self:x(-92):y(-41):diffusealpha(0):sleep(1.2):glow(1,1,1,1):zoom(1):linear(0.5):glow(1,1,1,0):zoom(3) end
    },
    LoadActor("groove")..{
        OnCommand=function(self) self:x(-48):y(43):diffusealpha(0):sleep(1.4):zoom(3.7):linear(0.3):diffusealpha(1):zoomy(0.86):zoomx(0.92):sleep(0.4):diffusealpha(0) end
    },
    LoadActor("groove")..{
        OnCommand=function(self) self:x(-48):y(46):diffusealpha(0):sleep(1.4):glow(1,1,1,1):zoom(1):linear(0.5):glow(1,1,1,0):zoom(3) end
    }
}