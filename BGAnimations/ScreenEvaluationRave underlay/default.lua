local enableOffset = ThemePrefs.Get("ShowOffset")
local offsetInfo = getenv("OffsetTable")
local early = {
	[PLAYER_1] = {
		["TapNoteScore_W0"] = 0,
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	},
	[PLAYER_2] = {
		["TapNoteScore_W0"] = 0,
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	}
}
local late = {
	[PLAYER_1] = {
		["TapNoteScore_W0"] = 0,
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	},
	[PLAYER_2] = {
		["TapNoteScore_W0"] = 0,
		["TapNoteScore_W1"] = 0,
		["TapNoteScore_W2"] = 0,
		["TapNoteScore_W3"] = 0,
		["TapNoteScore_W4"] = 0,
		["TapNoteScore_W5"] = 0
	}
}
local perfect = { [PLAYER_1] = 0, [PLAYER_2] = 0 }

local counter = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
local average = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
local median = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
local offset = { [PLAYER_1] = {}, [PLAYER_2] = {} }
local errors = { [PLAYER_1] = {}, [PLAYER_2] = {} }

local peak = { [PLAYER_1] = -1, [PLAYER_2] = -1 }
local peak_counter = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
local maxRange = { [PLAYER_1] = -1, [PLAYER_2] = -1 }

local showOffset = { [PLAYER_1] = false, [PLAYER_2] = false }

local faplus = { [PLAYER_1] = getenv("SetScoreFAP1"), [PLAYER_2] = getenv("SetScoreFAP2") }
local c

if offsetInfo and enableOffset then
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
				average[pn] = average[pn] + t[2]
				counter[pn] = counter[pn] + 1
				table.insert(offset[pn],t[2])
				t[2] = math.round(t[2],3)
				if math.abs(t[2]) > maxRange[pn] then maxRange[pn] = math.abs(t[2]) end
				errors[pn][t[2]] = (errors[pn][t[2]] or 0) + 1
			end
		end

		for i = -maxRange[pn],maxRange[pn]*2+0.001,0.001 do
			i = math.round(i,3)
			if errors[pn][i] and errors[pn][i] > peak_counter[pn] then
				peak[pn] = i
				peak_counter[pn] = errors[pn][i]
			end
		end

		table.sort(offset[pn])
		if #offset[pn] > 0 then
			if #offset[pn] % 2 == 1 then
				median = offset[pn][math.ceil(#offset[pn]/2)]
			else
				median = (offset[pn][#offset[pn]/2] + offset[pn][#offset[pn]/2+1])/2
			end
		end

		average[pn] = math.round(average[pn]/counter[pn],3)
		showOffset[pn] = (counter[pn] > 0 and (getenv("EvalCombo"..pname(pn))) or not GAMESTATE:IsHumanPlayer(pn))
	end
end

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	OnCommand=function(self)
		local screen = SCREENMAN:GetTopScreen()
		if screen and faplus[PLAYER_1] then
			c.P1:GetChild("Judgments"):addy(7)
			 if enableOffset then c.P1:GetChild("Offsets"):addy(7) end
			screen:GetChild("W1NumberP1"):addy(7)
			screen:GetChild("W2NumberP1"):addy(7)
			screen:GetChild("W3NumberP1"):addy(7)
			screen:GetChild("W4NumberP1"):addy(7)
			screen:GetChild("W5NumberP1"):addy(7)
			screen:GetChild("MissNumberP1"):addy(7)
			screen:GetChild("JumpsNumberP1"):addy(7)
			screen:GetChild("HoldsNumberP1"):addy(7)
			screen:GetChild("MinesNumberP1"):addy(7)
			screen:GetChild("HandsNumberP1"):addy(7)
			screen:GetChild("RollsNumberP1"):addy(7)
			screen:GetChild("MaxComboNumberP1"):addy(7)
		end
		if screen and faplus[PLAYER_2] then
			c.P2:GetChild("Judgments"):addy(7)
			if enableOffset then c.P2:GetChild("Offsets"):addy(7) end
			screen:GetChild("W1NumberP2"):addy(7)
			screen:GetChild("W2NumberP2"):addy(7)
			screen:GetChild("W3NumberP2"):addy(7)
			screen:GetChild("W4NumberP2"):addy(7)
			screen:GetChild("W5NumberP2"):addy(7)
			screen:GetChild("MissNumberP2"):addy(7)
			screen:GetChild("JumpsNumberP2"):addy(7)
			screen:GetChild("HoldsNumberP2"):addy(7)
			screen:GetChild("MinesNumberP2"):addy(7)
			screen:GetChild("HandsNumberP2"):addy(7)
			screen:GetChild("RollsNumberP2"):addy(7)
			screen:GetChild("MaxComboNumberP2"):addy(7)
		end
	end,
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))(),
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenEvaluation","underlay/evaluation banner mask"),
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
				Condition=faplus[PLAYER_1],
				File = "_v 26px bold shadow",
				Text="FANTASTIC+",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*-1)*WideScreenDiff()):horizalign(left):addx(-EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.51*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
			},
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
			Name="Offsets",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluationRave","W1NumberP1X")-42*WideScreenDiff()) end,
			Def.ActorFrame{
				Condition=faplus[PLAYER_1],
				Name="W0",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W0NumberP1Y")) end,
				Def.ActorFrame{
					Condition=showOffset[PLAYER_1],
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
							self:settextf("%04d",early[PLAYER_1]["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_1]["TapNoteScore_W0"]), 0),Diffuse = color("#000080")})
							self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
						end,
						OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
					},
					Def.BitmapText {
						File = "_ScreenEvaluation numbers",
						InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
						OnCommand=function(self)
							self:settextf("%04d",late[PLAYER_1]["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_1]["TapNoteScore_W0"]), 0),Diffuse = color("#800000")})
							self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
						end,
						OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
					}
				},
				Def.RollingNumbers{
					Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
					InitCommand=function(self)
						self:player(PLAYER_1):name("W0Number" .. PlayerNumberToString(PLAYER_1))
						ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
						self:Load("RollingNumbersJudgment"):targetnumber(getenv("W0"..pname(PLAYER_1)) or 0):x(0):y(0):queuecommand("Reset")
					end,
					ResetCommand=function(self) self:horizalign(left) end
				}
			},
			Def.ActorFrame{
				Name="W1",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W1NumberP1Y")) end,
				Def.ActorFrame{
					Condition=showOffset[PLAYER_1],
					Def.BitmapText {
						Condition=not faplus[PLAYER_1],
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
				Def.RollingNumbers{
					Condition=faplus[PLAYER_1],
					Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
					InitCommand=function(self)
						self:player(PLAYER_1):name("W0Number" .. PlayerNumberToString(PLAYER_1))
						ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
						self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W1')-(getenv("W0"..pname(PLAYER_1)) or 0)):x(0):y(0):queuecommand("Reset")
					end,
					ResetCommand=function(self) self:horizalign(left):diffusealpha(1) end
				}
			},
			Def.ActorFrame{
				Condition=showOffset[PLAYER_1],
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
				Condition=showOffset[PLAYER_1],
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
				Condition=showOffset[PLAYER_1],
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
				Condition=not isOpenDDR() and showOffset[PLAYER_1],
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
				Condition=faplus[PLAYER_2],
				File = "_v 26px bold shadow",
				Text="FANTASTIC+",
				InitCommand=function(self) self:y(SCREEN_CENTER_Y-108*WideScreenDiff()+(16.5*-1)*WideScreenDiff()):horizalign(left):addx(EvalTweenDistance()) end,
				OnCommand=function(self) self:zoomx(0.65*WideScreenDiff()):zoomy(0.51*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
				OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
			},
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
			Name="Offsets",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenEvaluationRave","W1NumberP2X")-42*WideScreenDiff()) end,
			Def.ActorFrame{
				Condition=faplus[PLAYER_2],
				Name="W0",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W0NumberP2Y")) end,
				Def.ActorFrame{
					Condition=showOffset[PLAYER_2],
					Def.BitmapText {
						File = "_ScreenEvaluation numbers",
						InitCommand=function(self) self:y(-9*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FFFFFF")) end,
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
							self:settextf("%04d",early[PLAYER_2]["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..early[PLAYER_2]["TapNoteScore_W0"]), 0),Diffuse = color("#000080")})
							self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
						end,
						OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
					},
					Def.BitmapText {
						File = "_ScreenEvaluation numbers",
						InitCommand=function(self) self:y(3*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FF0000")) end,
						OnCommand=function(self)
							self:settextf("%04d",late[PLAYER_2]["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..late[PLAYER_2]["TapNoteScore_W0"]), 0),Diffuse = color("#800000")})
							self:zoom(0.25*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
						end,
						OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
					}
				},
				Def.RollingNumbers{
					Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
					InitCommand=function(self)
						self:player(PLAYER_2):name("W0Number" .. PlayerNumberToString(PLAYER_2))
						ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
						self:Load("RollingNumbersJudgment"):targetnumber(getenv("W0"..pname(PLAYER_2)) or 0):x(0):y(0):queuecommand("Reset")
					end,
					ResetCommand=function(self) self:horizalign(left) end
				}
			},
			Def.ActorFrame{
				Name="W1",
				InitCommand=function(self) self:y(THEME:GetMetric("ScreenEvaluationRave","W1NumberP2Y")) end,
				Def.ActorFrame{
					Condition=showOffset[PLAYER_2],
					Def.BitmapText {
						Condition=not faplus[PLAYER_2],
						File = "_ScreenEvaluation numbers",
						InitCommand=function(self) self:y(-9*WideScreenDiff()):horizalign(right):shadowlength(1):diffuse(color("#FFFFFF")) end,
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
				Def.RollingNumbers{
					Condition=faplus[PLAYER_2],
					Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
					InitCommand=function(self)
						self:player(PLAYER_2):name("W0Number" .. PlayerNumberToString(PLAYER_2))
						ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
						self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetTapNoteScores('TapNoteScore_W1')-(getenv("W0"..pname(PLAYER_2)) or 0)):x(0):y(0):queuecommand("Reset")
					end,
					ResetCommand=function(self) self:horizalign(left):diffusealpha(1) end
				}
			},
			Def.ActorFrame{
				Condition=showOffset[PLAYER_2],
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
				Condition=showOffset[PLAYER_2],
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
				Condition=showOffset[PLAYER_2],
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
				Condition=not isOpenDDR() and showOffset[PLAYER_2],
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