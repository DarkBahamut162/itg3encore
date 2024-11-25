return Def.ActorFrame{
    Def.Sprite {
        Texture = "player-frame"
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(-110):y(-38):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Weight") end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(-110):y(-14):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Goal Type") end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(-110):y(10):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Goal Amount") end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(-110):y(34):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Simple Steps") end
    },
}