return Def.ActorFrame{
    Def.ActorFrame{
        LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_topright"))..{
            InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
            OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.4):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.5):queuecommand("On") end
        },
        LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_2top"))..{
            InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
            OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.1):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.35):queuecommand("On") end
        },
        LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_left"))..{
            InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
            OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.2):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.5):queuecommand("On") end
        },
        LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_right"))..{
            InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
            OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.2):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.7):queuecommand("On") end
        }
    }
}