return Def.ActorFrame{
    Def.ActorFrame{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
        LoadActor("p1gradient")..{
            InitCommand=function(self) self:x(SCREEN_CENTER_X-182*WideScreenDiff()):y(SCREEN_CENTER_Y-140*WideScreenDiff()):zoom(WideScreenDiff()):halign(1) end
        },
        LoadFont("_r bold 30px")..{
            Text=ScreenEndingGetDisplayName(PLAYER_1),
            InitCommand=function(self) self:x(SCREEN_CENTER_X-199*WideScreenDiff()):y(SCREEN_CENTER_Y-140*WideScreenDiff()):maxwidth(240):halign(1) end,
            OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
        },
        Def.ActorFrame{
            Condition=HumanAndProfile(PLAYER_1),
            LoadActor(THEME:GetPathG('ScreenEnding', 'card p1'))..{
                InitCommand=function(self) self:x(SCREEN_CENTER_X-248*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(WideScreenDiff()) end
            },
            Def.ActorFrame{
                InitCommand=function(self) self:x(SCREEN_CENTER_X-276*WideScreenDiff()):y(SCREEN_CENTER_Y+41*WideScreenDiff()) end,
                LoadFont("_r bold 30px")..{
                    Text="Calories Today",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*2-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%1.0f Cal",PROFILEMAN:GetProfile(PLAYER_1):GetCaloriesBurnedToday()),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*2-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text="Current Combo",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*1-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetCurrentCombo(),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*1-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                }
            },
            Def.ActorFrame{
                Condition=not GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X-276*WideScreenDiff()):y(SCREEN_CENTER_Y+41*WideScreenDiff()) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Songs %",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",0),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Easy"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Easy")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*0*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Easy')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*0*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*2*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*2*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Challenge"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Challenge")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*3*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*3*WideScreenDiff()) end
                }
            },
            Def.ActorFrame{
                Condition=GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X-276*WideScreenDiff()):y(SCREEN_CENTER_Y+41*WideScreenDiff()) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Courses %",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",GetCoursesPercentComplete(PROFILEMAN:GetProfile(PLAYER_1),StepsTypeSingle()[GetUserPrefN("StylePosition")])),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetCoursesPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*2*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_1):GetCoursesPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_1)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*2*WideScreenDiff()) end
                }
            }
        }
    },
    Def.ActorFrame{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
        LoadActor("p2gradient")..{
            InitCommand=function(self) self:x(SCREEN_CENTER_X+182*WideScreenDiff()):y(SCREEN_CENTER_Y-140*WideScreenDiff()):zoom(WideScreenDiff()):halign(0) end
        },
        LoadFont("_r bold 30px")..{
            Text=ScreenEndingGetDisplayName(PLAYER_2),
            InitCommand=function(self) self:x(SCREEN_CENTER_X+199*WideScreenDiff()):y(SCREEN_CENTER_Y-140*WideScreenDiff()):maxwidth(240):halign(0) end,
            OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
        },
        Def.ActorFrame{
            Condition=HumanAndProfile(PLAYER_2),
            LoadActor(THEME:GetPathG('ScreenEnding', 'card p2'))..{
                InitCommand=function(self) self:x(SCREEN_CENTER_X+248*WideScreenDiff()):y(SCREEN_CENTER_Y+162*WideScreenDiff()):zoom(WideScreenDiff()) end
            },
            Def.ActorFrame{
                InitCommand=function(self) self:x(SCREEN_CENTER_X+216*WideScreenDiff()):y(SCREEN_CENTER_Y+41*WideScreenDiff()) end,
                LoadFont("_r bold 30px")..{
                    Text="Calories Today",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*2-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%1.0f Cal",PROFILEMAN:GetProfile(PLAYER_2):GetCaloriesBurnedToday()),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*2-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text="Current Combo",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*1-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetCurrentCombo(),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*1-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                }
            },
            Def.ActorFrame{
                Condition=not GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X+216*WideScreenDiff()):y(SCREEN_CENTER_Y+41*WideScreenDiff()) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Songs %",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",GetSongsPercentComplete(PROFILEMAN:GetProfile(PLAYER_2),StepsTypeSingle()[GetUserPrefN("StylePosition")])),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Easy"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Easy")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*0*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Easy')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*0*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*2*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*2*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CustomDifficulty", "Challenge"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Challenge")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*3*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetSongsPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Challenge')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*3*WideScreenDiff()) end
                }
            },
            Def.ActorFrame{
                Condition=GAMESTATE:IsCourseMode(),
                InitCommand=function(self) self:x(SCREEN_CENTER_X+216*WideScreenDiff()):y(SCREEN_CENTER_Y+41*WideScreenDiff()) end,
                LoadFont("_r bold 30px")..{
                    Text="Single Courses %",
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-50)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",GetCoursesPercentComplete(PROFILEMAN:GetProfile(PLAYER_2),StepsTypeSingle()[GetUserPrefN("StylePosition")])),
                    InitCommand=function(self) self:x(30*WideScreenDiff()):y((-50*0-30)*WideScreenDiff()) end,
                    OnCommand=function(self) self:zoom(0.7*WideScreenDiff()):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Medium"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Medium")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetCoursesPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Medium')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*1*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=THEME:GetString("CourseDifficulty", "Hard"),
                    InitCommand=function(self) self:diffuse(CustomDifficultyToColor("Hard")):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:y(20*2*WideScreenDiff()) end
                },
                LoadFont("_r bold 30px")..{
                    Text=string.format("%05.2f%%",PROFILEMAN:GetProfile(PLAYER_2):GetCoursesPercentComplete(StepsTypeSingle()[GetUserPrefN("StylePosition")],'Difficulty_Hard')),
                    InitCommand=function(self) self:diffuse(PlayerColor(PLAYER_2)):shadowlength(2):zoom(0.5*WideScreenDiff()) end,
                    OnCommand=function(self) self:x(58*WideScreenDiff()):y(20*2*WideScreenDiff()) end
                }
            }
        }
    },
    LoadActor("../_scrolling ITG credits"),
    LoadActor("../_ScreenEnding overlay common")
}