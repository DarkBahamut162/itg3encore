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

local playerScore = Def.ActorFrame{}
local showOffset = ThemePrefs.Get("ShowOffset")

if version < 3 then
    playerScore[#playerScore+1] = Def.ActorFrame{
        Name="BannerAreaP1",
        Def.BitmapText {
            File = "_z bold 36px",
            Text =P1[index]["Meter"],
            InitCommand=function(self)
                self:shadowlength(1):diffuse(DifficultyToColor( P1[index]["Difficulty"] ))
                self:x(borderLeft):valign(1):zoom(1/3*WideScreenDiff()):rotationz(90)
            end
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = grade[P1[index]["Grade"]],
            InitCommand=function(self)
                self:y(-8*WideScreenDiff()):shadowlength(1)
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
                self:y(12*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):shadowlength(1)
                if version == 2 then
                    self:x(scale(1/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1.5/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff())
                end
            end
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["TapNoteScore_W1"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W1")):shadowlength(1)
                if version == 2 then
                    self:y(-12*WideScreenDiff()):x(scale(2.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(3.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(3.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W1_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(3.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["TapNoteScore_W2"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W2")):shadowlength(1)
                if version == 2 then
                    self:y(-12*WideScreenDiff()):x(scale(3.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(4.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(4.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W2_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(4.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["TapNoteScore_W3"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W3")):shadowlength(1)
                if version == 2 then
                    self:y(-12*WideScreenDiff()):x(scale(4.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(5.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(5.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W3_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(5.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["TapNoteScore_W4"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W4")):shadowlength(1)
                if version == 2 then
                    self:y(12*WideScreenDiff()):x(scale(2.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(6.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(6.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W4_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(6.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["TapNoteScore_W5"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W5")):shadowlength(1)
                if version == 2 then
                    self:y(12*WideScreenDiff()):x(scale(3.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(7.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(7.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P1[index]["TapNoteScore_W5_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(7.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P1[index]["TapNoteScore_Miss"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_Miss")):shadowlength(1)
                
                if version == 2 then
                    self:y(12*WideScreenDiff()):x(scale(4.25/5,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(8.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(8.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = "Late",
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(8.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        }
    }
end
if version > 1 then
    playerScore[#playerScore+1] = Def.ActorFrame{
        Name="BannerAreaP2",
        Def.BitmapText {
            File = "_z bold 36px",
            Text = grade[P2[index]["Grade"]],
            InitCommand=function(self)
                self:y(-8*WideScreenDiff()):shadowlength(1):diffuse(DifficultyToColor( P2[index]["Difficulty"] ))
                if version == 2 then
                    self:x(scale(1-1/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/2*WideScreenDiff())
                else
                    self:x(scale(1-1.5/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/2*WideScreenDiff())
                end
            end
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = FormatPercentScore(P2[index]["Score"]),
            InitCommand=function(self)
                self:y(12*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2)):shadowlength(1)
                if version == 2 then
                    self:x(scale(1-1/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-1.5/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff())
                end
            end
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["TapNoteScore_W1"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W1")):shadowlength(1)
                if version == 2 then
                    self:y(-12*WideScreenDiff()):x(scale(1-2.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-3.25/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(3.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W1_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(3.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["TapNoteScore_W2"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W2")):shadowlength(1)
                if version == 2 then
                    self:y(-12*WideScreenDiff()):x(scale(1-3.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-4.25/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(4.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W2_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(4.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["TapNoteScore_W3"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W3")):shadowlength(1)
                if version == 2 then
                    self:y(-12*WideScreenDiff()):x(scale(1-4.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-5.25/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(5.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W3_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(5.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["TapNoteScore_W4"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W4")):shadowlength(1)
                if version == 2 then
                    self:y(12*WideScreenDiff()):x(scale(1-2.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-6.25/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(6.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W4_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(6.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["TapNoteScore_W5"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_W5")):shadowlength(1)
                if version == 2 then
                    self:y(12*WideScreenDiff()):x(scale(1-3.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-7.25/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(7.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = P2[index]["TapNoteScore_W5_Late"],
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(7.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            }
        },
        Def.BitmapText {
            File = "_z bold 36px",
            Text = P2[index]["TapNoteScore_Miss"],
            InitCommand=function(self)
                self:diffuse(TapNoteScoreToColor("TapNoteScore_Miss")):shadowlength(1)
                
                if version == 2 then
                    self:y(12*WideScreenDiff()):x(scale(1-4.25/5,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/4*WideScreenDiff())
                else
                    self:x(scale(1-8.25/9,0,1,version==3 and borderLeft or borderRightCenter,borderRight )):zoom(1/3*WideScreenDiff()):maxwidth(110)
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
                    self:y(-12*WideScreenDiff()):x(scale(8.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
            },
            Def.BitmapText {
                File = "_z bold 36px",
                Text = "Late",
                InitCommand=function(self)
                    self:diffuse(color("#FF8080")):shadowlength(1)
                    self:y(12*WideScreenDiff()):x(scale(8.25/9,0,1,borderLeft,version==1 and borderRight or borderLeftCenter)):zoom(1/3*WideScreenDiff()):maxwidth(110)
                end
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
            OnCommand=function(self) if Master[index] then self:settext(Master[index]["Subtitle"] == "" and Master[index]["Title"].."\n"..Master[index]["Artist"] or Master[index]["Title"].."\n"..Master[index]["Subtitle"].."\n"..Master[index]["Artist"]) else self:settext("Overall\nPerformance") end end
        }
    },
    playerScore
}