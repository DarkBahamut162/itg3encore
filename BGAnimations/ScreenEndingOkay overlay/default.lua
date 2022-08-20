return Def.ActorFrame{
    LoadActor("intro/arrow")..{
        OnCommand=function(self) self:Center():addx(SCREEN_WIDTH*1.5):addy(SCREEN_HEIGHT*2):sleep(1.5):glow(1,1,1,1):decelerate(0.6):addx(-SCREEN_WIDTH*1.5):addy(-SCREEN_HEIGHT*2):glow(0,0,0,0):wag():effectmagnitude(4,0,4):effectperiod(8):sleep(1):linear(1):diffusealpha(0.5) end;
    };
    LoadActor("credits");
    LoadActor("p1gradient")..{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1);
        OnCommand=function(self) self:diffusealpha(0):x(SCREEN_CENTER_X-255):y(SCREEN_CENTER_Y-140):sleep(4):linear(0.6):diffusealpha(1) end;
    };
    Def.ActorFrame{
        Condition=HumanAndProfile(PLAYER_1) and not GAMESTATE:IsCourseMode();
        OnCommand=function(self) self:x(SCREEN_CENTER_X-276):y(SCREEN_CENTER_Y+41) end;
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Easy");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Easy")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*0) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Medium");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*1) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Hard");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*2) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Challenge");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Challenge")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*3) end;
        };
    };
    Def.ActorFrame{
        Condition=HumanAndProfile(PLAYER_1) and GAMESTATE:IsCourseMode();
        OnCommand=function(self) self:x(SCREEN_CENTER_X-276):y(SCREEN_CENTER_Y+41) end;
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CourseDifficulty", "Medium");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*1) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CourseDifficulty", "Hard");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*2) end;
        };
    };
    LoadActor("p2gradient")..{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2);
        OnCommand=function(self) self:diffusealpha(0):x(SCREEN_CENTER_X+255):y(SCREEN_CENTER_Y-140):sleep(4):linear(0.6):diffusealpha(1) end;
    };
    Def.ActorFrame{
        Condition=HumanAndProfile(PLAYER_2) and not GAMESTATE:IsCourseMode();
        OnCommand=function(self) self:x(SCREEN_CENTER_X+216):y(SCREEN_CENTER_Y+41) end;
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Easy");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Easy")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*0) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Medium");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*1) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Hard");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*2) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CustomDifficulty", "Challenge");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Challenge")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*3) end;
        };
    };
    Def.ActorFrame{
        Condition=HumanAndProfile(PLAYER_2) and GAMESTATE:IsCourseMode();
        OnCommand=function(self) self:x(SCREEN_CENTER_X+216):y(SCREEN_CENTER_Y+41) end;
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CourseDifficulty", "Medium");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*1) end;
        };
        LoadFont("_r bold 30px")..{
            Text=THEME:GetString("CourseDifficulty", "Hard");
            InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end;
            OnCommand=function(self) self:y(20*2) end;
        };
    };
    LoadFont("_r bold 30px")..{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1);
        Text=ScreenEndingGetDisplayName(PLAYER_1);
		OnCommand=function(self) self:x(SCREEN_CENTER_X-246):y(SCREEN_CENTER_Y-140):zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end;
    };
    LoadFont("_r bold 30px")..{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2);
        Text=ScreenEndingGetDisplayName(PLAYER_2);
		OnCommand=function(self) self:x(SCREEN_CENTER_X+246):y(SCREEN_CENTER_Y-140):zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end;
    };
    LoadActor("intro")..{
        OnCommand=function(self) self:Center():sleep(20):addx(SCREEN_WIDTH*4) end;
    };
    LoadActor("../ScreenTitleMenu background/newlogo")..{
        OnCommand=function(self) self:diffusealpha(0):Center():sleep(2):diffusealpha(1):sleep(1.5):linear(1):diffusealpha(0) end;
    };
    LoadActor("../ScreenTitleMenu background/glow")..{
        OnCommand=function(self) self:blend(Blend.Add):diffusealpha(0):Center():sleep(1.7):accelerate(0.2):glow(1,1,1,1):sleep(0.2):decelerate(1):glow(0,0,0,0):diffusealpha(0) end;
    };
    LoadActor("../ScreenEndingGood underlay/thank you for playing")..{
        InitCommand=function(self) self:x(SCREEN_CENTER_X-40):CenterY():addy(-110):addx(-SCREEN_WIDTH):sleep(0.2):decelerate(0.5):addx(SCREEN_WIDTH):linear(2.5):addx(20):linear(1):addx(5):diffusealpha(0) end;
    };
    LoadActor("topmask")..{
        InitCommand=function(self) self:diffusealpha(0):CenterX():y(SCREEN_TOP):vertalign(top):zoomtowidth(358):sleep(3.5):linear(0.5):diffusealpha(1) end;
    };
    LoadActor("../_ScreenEnding overlay common");
};