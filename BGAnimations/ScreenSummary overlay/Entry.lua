local version, index = ...

local base = (GAMESTATE:IsCourseMode() and "_course" or "_song").." frame "..(isFinal() and "final" or "normal")
if version ~= 2 then base = THEME:GetPathG(GAMESTATE:IsCourseMode() and "ScreenRanking2" or "ScreenRanking","ScrollerItem/"..base) end

local bannerX = 0
if version == 1 then bannerX = -212*WideScreenDiff() elseif version == 3 then bannerX = 212*WideScreenDiff() end

local borderLeft = -296*WideScreenDiff()
local borderLeftCenter = -110.5*WideScreenDiff()
local borderRightCenter = 110.5*WideScreenDiff()
local borderRight = 296*WideScreenDiff()

if version == 1 then borderLeft = -98.5*WideScreenDiff() elseif version == 3 then borderRight = 98.5*WideScreenDiff() end

local grade = {
    ["Grade_Tier00"] = "XXXXX",
    ["Grade_Tier01"] = "XXXX",
    ["Grade_Tier02"] = "XXX",
    ["Grade_Tier03"] = "XX",
    ["Grade_Tier04"] = "X",
    ["Grade_Tier05"] = "S+",
    ["Grade_Tier06"] = "S",
    ["Grade_Tier07"] = "S-",
    ["Grade_Tier08"] = "A+",
    ["Grade_Tier09"] = "A",
    ["Grade_Tier10"] = "A-",
    ["Grade_Tier11"] = "B+",
    ["Grade_Tier12"] = "B",
    ["Grade_Tier13"] = "B-",
    ["Grade_Tier14"] = "C+",
    ["Grade_Tier15"] = "C",
    ["Grade_Tier16"] = "C-",
    ["Grade_Tier17"] = "D+",
    ["Grade_Tier18"] = "D",
    ["Grade_Failed"] = "F"
}

local function GetPos(pos,FA)
    local option = FA and {3,3.875,4.75,5.625,6.5,7.375,8.25} or {0,3.25,4.25,5.25,6.25,7.25,8.25}
    return option[pos]
end

local playerScore = Def.ActorFrame{}
local showOffset = ThemePrefs.Get("ShowOffset")

if version < 3 then
    playerScore[#playerScore+1] = Def.ActorFrame{
        Name="BannerAreaP1",
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["Meter"],
            InitCommand=function(self)
                self:shadowlength(1):diffuse(DifficultyToColor( P1[index]["Difficulty"] )):maxwidth(120)
                self:x(version == 2 and borderLeftCenter or borderLeft):valign(1):zoom(1/3*WideScreenDiff()):rotationz(90)
            end
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = grade[P1[index]["Grade"]],
                InitCommand=function(self)
                    self:y(P1[index]["FA"] and -12*WideScreenDiff() or -8*WideScreenDiff()):shadowlength(1)
                    if version == 2 then
                        self:x(scale(1/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/2*WideScreenDiff())
                    else
                        self:x(scale(1.5/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/2*WideScreenDiff())
                    end
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = FormatPercentScore(P1[index]["Score"]),
                InitCommand=function(self)
                    self:y(P1[index]["FA"] and 4*WideScreenDiff() or 12*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):shadowlength(1)
                    if version == 2 then
                        self:x(scale(1/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1.5/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff())
                    end
                end
            },
            Def.BitmapText {
                Condition=P1[index]["FA"],
                File = "_z bold 36px",
                Text = FormatPercentScore(tonumber(P1[index]["ScoreFA"]) or 0),
                InitCommand=function(self)
                    self:y(14*WideScreenDiff()):diffuse(TapNoteScoreToColor("TapNoteScore_W0")):shadowlength(1)
                    if version == 2 then
                        self:x(scale(1/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/5*WideScreenDiff())
                    else
                        self:x(scale(1.5/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    end
                end
            }
        },
        Def.ActorFrame{
            Condition=P1[index]["FA"],
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W0"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W1")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()):x(scale(2.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(1,true)/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(94)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W0_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(1,true)/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(94)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W0_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(1,true)/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(94)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W1"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor(P1[index]["FA"] and "TapNoteScore_W0" or "TapNoteScore_W1")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()*(P1[index]["FA"] and 0 or 1)):x(scale(2.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(2,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W1_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(2,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W1_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(2,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W2"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W2")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()):x(scale(3.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(3,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W2_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(3,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W2_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(3,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W3"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W3")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()):x(scale(4.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(4,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W3_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(4,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W3_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(4,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W4"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W4")):shadowlength(1)
                    if version == 2 then
                        self:y(12*WideScreenDiff()):x(scale(2.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(5,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W4_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(5,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W4_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(5,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W5"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W5")):shadowlength(1)
                    if version == 2 then
                        self:y(12*WideScreenDiff()):x(scale(3.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(6,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W5_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(6,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P1[index]["TapNoteScore_W5_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(6,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_Miss"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_Miss")):shadowlength(1)
                    
                    if version == 2 then
                        self:y(12*WideScreenDiff()):x(scale(4.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(GetPos(7,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = "Early",
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(GetPos(7,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = "Late",
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(GetPos(7,P1[index]["FA"])/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(P1[index]["FA"] and 94 or 110)
                    end
                }
            }
        }
    }
end
if version > 1 then
    playerScore[#playerScore+1] = Def.ActorFrame{
        Name="BannerAreaP2",
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["Meter"],
            InitCommand=function(self)
                self:shadowlength(1):diffuse(DifficultyToColor( P2[index]["Difficulty"] )):maxwidth(120)
                self:x(version == 2 and borderRightCenter or borderRight):valign(1):zoom(1/3*WideScreenDiff()):rotationz(-90)
            end
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = grade[P2[index]["Grade"]],
                InitCommand=function(self)
                    self:y(P2[index]["FA"] and -12*WideScreenDiff() or -8*WideScreenDiff()):shadowlength(1)
                    if version == 2 then
                        self:x(scale(1-1/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/2*WideScreenDiff())
                    else
                        self:x(scale(1-1.5/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/2*WideScreenDiff())
                    end
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = FormatPercentScore(P2[index]["Score"]),
                InitCommand=function(self)
                    self:y(P2[index]["FA"] and 4*WideScreenDiff() or 12*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2)):shadowlength(1)
                    if version == 2 then
                        self:x(scale(1-1/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-1.5/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff())
                    end
                end
            },
            Def.BitmapText {
                Condition=P2[index]["FA"],
                File = "_z bold 36px",
                Text = FormatPercentScore(tonumber(P2[index]["ScoreFA"]) or 0),
                InitCommand=function(self)
                    self:y(14*WideScreenDiff()):diffuse(TapNoteScoreToColor("TapNoteScore_W0")):shadowlength(1)
                    if version == 2 then
                        self:x(scale(1-1/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/5*WideScreenDiff())
                    else
                        self:x(scale(1-1.5/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    end
                end
            }
        },
        Def.ActorFrame{
            Condition=P2[index]["FA"],
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W0"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W1")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()):x(scale(1-2.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(1,true)/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(94)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W0_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(1,true)/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(94)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W0_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(1,true)/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(94)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W1"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor(P2[index]["FA"] and "TapNoteScore_W0" or "TapNoteScore_W1")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()*(P2[index]["FA"] and 0 or 1)):x(scale(1-2.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(2,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W1_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(2,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W1_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(2,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W2"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W2")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()):x(scale(1-3.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(3,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W2_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(3,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W2_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(3,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W3"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W3")):shadowlength(1)
                    if version == 2 then
                        self:y(-12*WideScreenDiff()):x(scale(1-4.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(4,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W3_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(4,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W3_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(4,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W4"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W4")):shadowlength(1)
                    if version == 2 then
                        self:y(12*WideScreenDiff()):x(scale(1-2.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(5,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W4_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(5,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W4_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(5,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W5"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_W5")):shadowlength(1)
                    if version == 2 then
                        self:y(12*WideScreenDiff()):x(scale(1-3.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(6,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W5_Early"],
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(6,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = P2[index]["TapNoteScore_W5_Late"],
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(6,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                }
            }
        },
        Def.ActorFrame{
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_Miss"],
                InitCommand=function(self)
                    self:diffuse(TapNoteScoreToColor("TapNoteScore_Miss")):shadowlength(1)
                    
                    if version == 2 then
                        self:y(12*WideScreenDiff()):x(scale(1-4.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/4*WideScreenDiff())
                    else
                        self:x(scale(1-GetPos(7,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                end
            },
            Def.ActorFrame{
                Condition=version ~= 2 and showOffset,
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = "Early",
                    InitCommand=function(self)
                        self:diffuse(color("#8080FF")):shadowlength(1)
                        self:y(-12*WideScreenDiff()):x(scale(1-GetPos(7,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                },
                Def.BitmapText {
                    File = "_z bold 36px",
                    Text = "Late",
                    InitCommand=function(self)
                        self:diffuse(color("#FF8080")):shadowlength(1)
                        self:y(12*WideScreenDiff()):x(scale(1-GetPos(7,P2[index]["FA"])/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight)):zoom(1/3*WideScreenDiff()):maxwidth(P2[index]["FA"] and 94 or 110)
                    end
                }
            }
        }
    }
end


return Def.ActorFrame{
	InitCommand=function(self) self:runcommandsonleaves(function(child) child:ztest(true) end) end,
	Def.Sprite {
        Name="Frame",
		Texture = base,
		InitCommand=function(self) self:zoom(WideScreenDiff()) if version == 3 then self:zoomx(-WideScreenDiff()) end end
	},
    Def.ActorFrame{
        Name="BannerArea",
        Def.Sprite {
            InitCommand=function(self) self:x(bannerX):scaletoclipped(128*WideScreenDiff(),40*WideScreenDiff()):diffusealpha(0.5):fadeleft(0.25):faderight(0.25) end,
            OnCommand=function(self) if Master[index] and Master[index]["Banner"] then self:LoadBanner(Master[index]["Banner"]) end end,
        },
        Def.BitmapText {
            File = "_v 26px bold white",
            InitCommand=function(self) self:x(bannerX):zoom(0.6*WideScreenDiff()):shadowlength(1):maxwidth(264):maxheight(58) end,
            OnCommand=function(self)
                if Master[index] then
                    local output = Master[index]["Title"]
                    if Master[index]["Subtitle"] ~= "" then output = addToOutput(output,Master[index]["Subtitle"],"\n") end
                    if Master[index]["Artist"] ~= "" then output = addToOutput(output,Master[index]["Artist"],"\n") end
                    self:settext(output)
                else
                    self:settext("Overall\nPerformance")
                end
            end
        }
    },
    playerScore
}