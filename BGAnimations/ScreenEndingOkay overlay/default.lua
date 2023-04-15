return Def.ActorFrame{
    LoadActor("intro/arrow")..{
        OnCommand=function(self) self:Center():addx(SCREEN_WIDTH*1.5):addy(SCREEN_HEIGHT*2):sleep(1.5):glow(1,1,1,1):decelerate(0.6):addx(-SCREEN_WIDTH*1.5):addy(-SCREEN_HEIGHT*2):glow(0,0,0,0):wag():effectmagnitude(4,0,4):effectperiod(8):sleep(1):linear(1):diffusealpha(0.5) end
    },
    LoadActor("credits"),
    Def.ActorFrame{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
        LoadActor("p1gradient")..{
            InitCommand=function(self) self:x(SCREEN_CENTER_X-255):y(SCREEN_CENTER_Y-140) end
        },
        LoadFont("_r bold 30px")..{
            Text=ScreenEndingGetDisplayName(PLAYER_1),
            InitCommand=function(self) self:x(SCREEN_CENTER_X-246):y(SCREEN_CENTER_Y-140):maxwidth(240) end,
            OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
        },
        Def.ActorFrame{
            Condition=HumanAndProfile(PLAYER_1),
            LoadActor(THEME:GetPathG('ScreenEnding', 'card p1'))..{
                InitCommand=function(self) self:x(SCREEN_CENTER_X-248):y(SCREEN_CENTER_Y+162) end
            },
            Def.ActorFrame{
                InitCommand=function(self) self:x(SCREEN_CENTER_X-276):y(SCREEN_CENTER_Y+41) end,
                LoadFont("_r bold 30px")..{
                    Text="Calories Today",
                    InitCommand=function(self) self:x(30):y(-50*2-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%1.0f Cal",PROFILEMAN:GetProfile(PLAYER_1):GetCaloriesBurnedToday()),
                    InitCommand=function(self) self:x(30):y(-50*2-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text="Current Combo",
                    InitCommand=function(self) self:x(30):y(-50*1-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetCurrentCombo(),
                    InitCommand=function(self) self:x(30):y(-50*1-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                }
            },
            Def.ActorFrame{
                Condition=not GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X-276):y(SCREEN_CENTER_Y+41) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Songs %",
                    InitCommand=function(self) self:x(30):y(-50*0-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",0),
                    InitCommand=function(self) self:x(30):y(-50*0-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Easy"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Easy")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*0) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Easy')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*0) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*2) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*2) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Challenge"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Challenge")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*3) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Challenge')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*3) end
                }
            },
            Def.ActorFrame{
                Condition=GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X-276):y(SCREEN_CENTER_Y+41) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Courses %",
                    InitCommand=function(self) self:x(30):y(-50*0-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",GetCoursesPercentComplete(PROFILEMAN:GetProfile(PLAYER_1),'StepsType_Dance_Single')),
                    InitCommand=function(self) self:x(30):y(-50*0-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetCoursesPercentComplete('StepsType_Dance_Single','Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*2) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetCoursesPercentComplete('StepsType_Dance_Single','Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*2) end
                }
            }
        }
    },
    Def.ActorFrame{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
        LoadActor("p2gradient")..{
            InitCommand=function(self) self:x(SCREEN_CENTER_X+255):y(SCREEN_CENTER_Y-140) end
        },
        LoadFont("_r bold 30px")..{
            Text=ScreenEndingGetDisplayName(PLAYER_2),
            InitCommand=function(self) self:x(SCREEN_CENTER_X+246):y(SCREEN_CENTER_Y-140):maxwidth(240) end,
            OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
        },
        Def.ActorFrame{
            Condition=HumanAndProfile(PLAYER_2),
            LoadActor(THEME:GetPathG('ScreenEnding', 'card p2'))..{
                InitCommand=function(self) self:x(SCREEN_CENTER_X+248):y(SCREEN_CENTER_Y+162) end
            },
            Def.ActorFrame{
                InitCommand=function(self) self:x(SCREEN_CENTER_X+216):y(SCREEN_CENTER_Y+41) end,
                LoadFont("_r bold 30px")..{
                    Text="Calories Today",
                    InitCommand=function(self) self:x(30):y(-50*2-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%1.0f Cal",PROFILEMAN:GetProfile(PLAYER_2):GetCaloriesBurnedToday()),
                    InitCommand=function(self) self:x(30):y(-50*2-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text="Current Combo",
                    InitCommand=function(self) self:x(30):y(-50*1-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetCurrentCombo(),
                    InitCommand=function(self) self:x(30):y(-50*1-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                }
            },
            Def.ActorFrame{
                Condition=not GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X+216):y(SCREEN_CENTER_Y+41) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Songs %",
                    InitCommand=function(self) self:x(30):y(-50*0-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",GetSongsPercentComplete(PROFILEMAN:GetProfile(PLAYER_2),'StepsType_Dance_Single')),
                    InitCommand=function(self) self:x(30):y(-50*0-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Easy"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Easy")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*0) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Easy')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*0) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*2) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*2) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Challenge"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Challenge")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*3) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete('StepsType_Dance_Single','Difficulty_Challenge')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*3) end
                }
            },
            Def.ActorFrame{
                Condition=GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X+216):y(SCREEN_CENTER_Y+41) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Courses %",
                    InitCommand=function(self) self:x(30):y(-50*0-50) end,
                    OnCommand=function(self) self:zoom(0.5):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",GetCoursesPercentComplete(PROFILEMAN:GetProfile(PLAYER_2),'StepsType_Dance_Single')),
                    InitCommand=function(self) self:x(30):y(-50*0-30) end,
                    OnCommand=function(self) self:zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetCoursesPercentComplete('StepsType_Dance_Single','Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*1) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:y(20*2) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetCoursesPercentComplete('StepsType_Dance_Single','Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5) end,
                    OnCommand=function(self) self:x(58):y(20*2) end
                }
            }
        }
    },
    LoadActor("intro")..{
        OnCommand=function(self) self:Center():sleep(20):addx(SCREEN_WIDTH*4) end
    },
    LoadActor("../ScreenTitleMenu background/newlogo "..(isFinal() and "final" or "normal"))..{
        OnCommand=function(self) self:diffusealpha(0):Center():sleep(2):diffusealpha(1):sleep(1.5):linear(1):diffusealpha(0) end
    },
    LoadActor("../ScreenTitleMenu background/glow "..(isFinal() and "final" or "normal"))..{
        OnCommand=function(self) self:blend(Blend.Add):diffusealpha(0):Center():sleep(1.7):accelerate(0.2):glow(1,1,1,1):sleep(0.2):decelerate(1):glow(0,0,0,0):diffusealpha(0) end
    },
    LoadActor("../ScreenEndingGood underlay/thank you for playing")..{
        InitCommand=function(self) self:x(SCREEN_CENTER_X-40):CenterY():addy(-110):addx(-SCREEN_WIDTH):sleep(0.2):decelerate(0.5):addx(SCREEN_WIDTH):linear(2.5):addx(20):linear(1):addx(5):diffusealpha(0) end
    },
    LoadActor("topmask")..{
        InitCommand=function(self) self:diffusealpha(0):CenterX():y(SCREEN_TOP):vertalign(top):zoomtowidth(358):sleep(3.5):linear(0.5):diffusealpha(1) end
    }
}