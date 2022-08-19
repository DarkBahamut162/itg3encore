return Def.ActorFrame{
    Def.ActorFrame{
        LoadActor("p1gradient")..{
            Condition=GAMESTATE:IsHumanPlayer(PLAYER_1);
            OnCommand=function(self) self:x(SCREEN_CENTER_X-230):y(SCREEN_CENTER_Y-140) end;
        };
        -- P1
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
    };
    Def.ActorFrame{
        -- P2
        LoadActor("p2gradient")..{
            Condition=GAMESTATE:IsHumanPlayer(PLAYER_2);
            OnCommand=function(self) self:x(SCREEN_CENTER_X+230):y(SCREEN_CENTER_Y-140) end;
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
    };

    LoadActor("../_scrolling ITG credits");
    LoadActor("../_ScreenEnding overlay common");

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
};