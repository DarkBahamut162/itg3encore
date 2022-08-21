return Def.ActorFrame{
    Def.ActorFrame{
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_topright"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen():diffusealpha(0) end;
            OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.5):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_topright"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen():rotationz(180):diffusealpha(0) end;
            OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.5):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_center"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen():diffusealpha(0) end;
            OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.8):diffusealpha(1.5):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_2top"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
            OnCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.2):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_2top"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
            OnCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.1):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.25) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_left"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
            OnCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.2):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_left"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen():rotationz(180) end;
            OnCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.4):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.2) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_right"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
            OnCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.2):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.5) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/_right"))..{
            InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
            OnCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.4):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.2) end;
        };
    };
    Def.ActorFrame{
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/glow"))..{
            InitCommand=function(self) self:Center():zoom(0.8):diffusealpha(0) end;
            OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(1):zoom(1):sleep(1.5):accelerate(0.58):diffusealpha(0):zoom(0.6) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/glow"))..{
            InitCommand=function(self) self:Center():blend(Blend.Add):zoom(1):diffusealpha(0) end;
            OnCommand=function(self) self:sleep(1.5):accelerate(0.3):diffusealpha(0.4):linear(1.2):zoom(1.4):diffusealpha(0) end;
        };
        LoadActor(THEME:GetPathB("","ScreenTitleMenu background/light"))..{
            InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+10):blend(Blend.Add):zoom(1) end;
            OnCommand=function(self) self:cropright(1.2):cropleft(-0.2):linear(1):cropright(-0.2):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(1.2):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.5) end;
        };
    };
};
