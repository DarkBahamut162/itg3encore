return Def.ActorFrame{
    Def.Sprite {
        Texture = "../player-frame/player-frame",
        OnCommand=function(self) self:zoomx(-1) end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(110):y(-38):horizalign(right):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Weight") end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(110):y(-14):horizalign(right):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Goal Type") end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(110):y(10):horizalign(right):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Goal Amount") end
    },
    Def.BitmapText {
        File = "_v 26px bold shadow",
        OnCommand=function(self) self:x(110):y(34):horizalign(right):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):shadowlength(2):settext("Simple Steps") end
    },
}