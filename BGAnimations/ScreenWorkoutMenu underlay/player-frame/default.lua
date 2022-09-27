return Def.ActorFrame{
	LoadActor("player-frame"),
    LoadFont("_v 26px bold shadow")..{
        OnCommand=function(self) self:x(-110):y(-38):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Weight") end
    },
    LoadFont("_v 26px bold shadow")..{
        OnCommand=function(self) self:x(-110):y(-14):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Goal Type") end
    },
    LoadFont("_v 26px bold shadow")..{
        OnCommand=function(self) self:x(-110):y(10):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Goal Amount") end
    },
    LoadFont("_v 26px bold shadow")..{
        OnCommand=function(self) self:x(-110):y(34):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Simple Steps") end
    },
}