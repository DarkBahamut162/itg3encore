return Def.ActorFrame{
    LoadActor("thank you for playing")..{
        OnCommand=function(self) self:Center():addy(-110):addx(-SCREEN_WIDTH):sleep(0.2):decelerate(0.5):addx(SCREEN_WIDTH):linear(2.5):addx(20):linear(1):addx(5):diffusealpha(0) end;
    };
    LoadActor("in the groove")..{
        OnCommand=function(self) self:hibernate(0):sleep(4.2) end;
    };
    LoadActor("credits")..{
        OnCommand=function(self) self:Center() end;
    };
    LoadActor("in the groove/waves")..{
        OnCommand=function(self) self:addy(20):hibernate(3.65) end;
    };
};