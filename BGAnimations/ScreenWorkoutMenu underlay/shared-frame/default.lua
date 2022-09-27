return Def.ActorFrame{
	LoadActor("shared-frame"),
    LoadFont("_eurostile normal")..{
        InitCommand=function(self) self:x(-274):y(-14):horizalign(left):zoom(0.5):diffuse(color(0.8,0.8,0.8,1)):settext("Select Type") end
    }
}