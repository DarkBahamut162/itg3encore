local enableOffsets = ThemePrefs.Get("ShowOffset")
local offsetInfo = getenv("OffsetTable")
local early = {
	[PLAYER_1] = {
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	},
	[PLAYER_2] = {
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	}
}
local late = {
	[PLAYER_1] = {
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	},
	[PLAYER_2] = {
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	}
}
local perfect = {
	[PLAYER_1] = 0,
	[PLAYER_2] = 0
}

if offsetInfo then
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		for t in ivalues(offsetInfo[pn]) do
			if t[2] and type(t[2]) == "number" then
				if t[2] < 0 then
					early[pn][t[3]] = early[pn][t[3]] + 1
				elseif t[2] > 0 then
					late[pn][t[3]] = late[pn][t[3]] + 1
				else
					perfect[pn] = perfect[pn] + 1
				end
			end
		end
	end
end

return Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))(),
	Def.Sprite {
		Texture = "../ScreenEvaluation underlay/evaluation banner mask",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135):zoom(WideScreenDiff()):zbuffer(true):blend(Blend.NoEffect):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(2.8):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = "frame",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-30*WideScreenDiff()):zoomx(0.80*WideScreenDiff()):zoomy(1.005*WideScreenDiff()):addy(SCREEN_HEIGHT) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addy(-SCREEN_HEIGHT) end,
			OffCommand=function(self) self:accelerate(0.3):addy(SCREEN_HEIGHT) end
		},
		Def.Sprite {
			Texture = "base frame "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-27):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")-32*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		Def.Sprite {
			Texture = "base frame "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+27):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")-32*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		}
	},
	Def.ActorFrame{
		Name="P1",
		Def.ActorFrame{
			Name="Judgments",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-269*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FANTASTIC",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*0)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.51*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="EXCELLENT",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*1)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="GREAT",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*2)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text=GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "TOO EARLY" or "DECENT",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*3)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text=GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*4)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MISS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*5)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="JUMPS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*6)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="HOLDS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*7)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MINES",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*8)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="HANDS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*9)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="ROLLS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*10)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MAX COMBO",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*11)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			}
		},
		Def.ActorFrame{
			Condition=enableOffsets and getenv("EvalComboP1"),
			Name="Offsets",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluationRave","W1NumberP1X")-42*WideScreenDiff()) end,
			Def.ActorFrame{
				Name="W1",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W1NumberP1Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-9*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FFFFFF")) end,
					OnCommand=function(self)
						self:settextf("%04d",perfect[PLAYER_1]):AddAttribute(0, {Length = math.max(4-string.len(''..perfect[PLAYER_1]), 0),Diffuse = color("#808080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_1]["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_1]["TapNoteScore_W1"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_1]["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_1]["TapNoteScore_W1"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="W2",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W2NumberP1Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_1]["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_1]["TapNoteScore_W2"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_1]["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_1]["TapNoteScore_W2"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="W3",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W3NumberP1Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_1]["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_1]["TapNoteScore_W3"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_1]["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_1]["TapNoteScore_W3"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="W4",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W4NumberP1Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_1]["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_1]["TapNoteScore_W4"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_1]["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_1]["TapNoteScore_W4"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Condition=not isOpenDDR(),
				Name="W5",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W5NumberP1Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_1]["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_1]["TapNoteScore_W5"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_1]["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_1]["TapNoteScore_W5"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			}
		}
	},
	Def.ActorFrame{
		Name="P2",
		Def.ActorFrame{
			Name="Judgments",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+75*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FANTASTIC",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*0)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.51*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="EXCELLENT",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*1)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="GREAT",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*2)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text=GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == 'Difficulty_Beginner' and "TOO EARLY" or "DECENT",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*3)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text=GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*4)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MISS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*5)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="JUMPS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*6)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="HOLDS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*7)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MINES",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*8)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="HANDS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*9)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="ROLLS",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*10)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MAX COMBO",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*11)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.5*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			}
		},
		Def.ActorFrame{
			Condition=enableOffsets and getenv("EvalComboP2"),
			Name="Offsets",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluationRave","W1NumberP2X")-42*WideScreenDiff()) end,
			Def.ActorFrame{
				Name="W1",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W1NumberP2Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FFFFFF")) end,
					OnCommand=function(self)
						self:settextf("%04d",perfect[PLAYER_2]):AddAttribute(0, {Length = math.max(4-string.len(''..perfect[PLAYER_2]), 0),Diffuse = color("#808080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_2]["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_2]["TapNoteScore_W1"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_2]["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_2]["TapNoteScore_W1"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="W2",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W2NumberP2Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_2]["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_2]["TapNoteScore_W2"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_2]["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_2]["TapNoteScore_W2"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="W3",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W3NumberP2Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_2]["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_2]["TapNoteScore_W3"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_2]["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_2]["TapNoteScore_W3"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="W4",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W4NumberP2Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_2]["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_2]["TapNoteScore_W4"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_2]["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_2]["TapNoteScore_W4"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Condition=not isOpenDDR(),
				Name="W5",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W5NumberP2Y")) end,
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(-3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#0000FF")) end,
					OnCommand=function(self)
						self:settextf("%04d",early[PLAYER_2]["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_2]["TapNoteScore_W5"]), 0),Diffuse = color("#000080")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_ScreenEvaluation numbers",
					InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
					OnCommand=function(self)
						self:settextf("%04d",late[PLAYER_2]["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_2]["TapNoteScore_W5"]), 0),Diffuse = color("#800000")})
						self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
					end,
					OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
				}
			}
		}
	},
	loadfile(THEME:GetPathB("ScreenEvaluation","underlay/Score"))(PLAYER_1)..{Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1)},
	loadfile(THEME:GetPathB("ScreenEvaluation","underlay/Score"))(PLAYER_2)..{Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2)},
	Def.BitmapText {
		File = "_angel glow",
		Text="Song Title",
		InitCommand=function(self) self:x(isFinal() and SCREEN_CENTER_X or SCREEN_CENTER_X-300*WideScreenDiff()):halign(isFinal() and 0.5 or 0):y(SCREEN_CENTER_Y-169*WideScreenDiff()):animate(0):maxwidth(700):zoom(0.6*WideScreenDiff()):shadowlength(0):playcommand("Update") end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end,
		UpdateCommand=function(self)
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			if SongOrCourse then self:settext(SongOrCourse:GetDisplayFullTitle()) end
		end
	}
}