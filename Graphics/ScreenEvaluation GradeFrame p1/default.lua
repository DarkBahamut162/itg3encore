local offsetInfo = getenv("OffsetTable")
local showOffset = ThemePrefs.Get("ShowOffset")
local early = {
	["TapNoteScore_W0"] = 0,
	["TapNoteScore_W1"] = 0,
	["TapNoteScore_W2"] = 0,
	["TapNoteScore_W3"] = 0,
	["TapNoteScore_W4"] = 0,
	["TapNoteScore_W5"] = 0
}
local late = {
	["TapNoteScore_W0"] = 0,
	["TapNoteScore_W1"] = 0,
	["TapNoteScore_W2"] = 0,
	["TapNoteScore_W3"] = 0,
	["TapNoteScore_W4"] = 0,
	["TapNoteScore_W5"] = 0
}
local perfect = 0

local counter = 0
local average = 0
local median = 0
local offset = {}
local errors = {}

local peak = -1
local peak_counter = 0
local maxRange = -1

if offsetInfo and showOffset then
	for t in ivalues(offsetInfo[PLAYER_1]) do
		if t[2] and type(t[2]) == "number" then
			if t[2] < 0 then
				early[t[3]] = early[t[3]] + 1
			elseif t[2] > 0 then
				late[t[3]] = late[t[3]] + 1
			else
				perfect = perfect + 1
			end
			average = average + t[2]
			counter = counter + 1
			table.insert(offset,t[2])
			t[2] = math.round(t[2],3)
			if math.abs(t[2]) > maxRange then maxRange = math.abs(t[2]) end
			errors[t[2]] = errors[t[2]] and errors[t[2]] + 1 or 1
		end
	end

	for i = -maxRange,maxRange*2+0.001,0.001 do
		i = math.round(i,3)
		if errors[i] and errors[i] > peak_counter then
			peak = i
			peak_counter = errors[i]
		end
	end

    table.sort(offset)
	if #offset > 0 then
		if #offset % 2 == 1 then
			median = offset[math.ceil(#offset/2)]
		else
			median = (offset[#offset/2] + offset[#offset/2+1])/2
		end
	end

	average = math.round(average/counter,3)
end

local faplus = getenv("SetScoreFA"..pname(PLAYER_1))
local c

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	Def.ActorFrame{
		Name="Error",
		Condition=offsetInfo ~= nil and showOffset and getenv("EvalComboP1"),
		InitCommand=function(self) self:y(-212*WideScreenDiff()) end,
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			if screen and faplus then
				c.Error:addy(4+1.5)
				c.JudgeFrames:GetChild("W0"):addy(24+1.5)
				c.OffsetFrames:GetChild("W0"):addy(24+1.5)

				screen:GetChild("W1NumberP1"):addy(20+1.25)
				c.JudgeFrames:GetChild("W1"):addy(20+1.25)
				c.OffsetFrames:GetChild("W1"):addy(20+1.25)

				screen:GetChild("W2NumberP1"):addy(16+1)
				c.JudgeFrames:GetChild("W2"):addy(16+1)
				c.OffsetFrames:GetChild("W2"):addy(16+1)

				screen:GetChild("W3NumberP1"):addy(12.75)
				c.JudgeFrames:GetChild("W3"):addy(12.75)
				c.OffsetFrames:GetChild("W3"):addy(12.75)

				screen:GetChild("W4NumberP1"):addy(8.5)
				c.JudgeFrames:GetChild("W4"):addy(8.5)
				c.OffsetFrames:GetChild("W4"):addy(8.5)

				screen:GetChild("W5NumberP1"):addy(4.25)
				c.JudgeFrames:GetChild("W5"):addy(4.25)
				c.OffsetFrames:GetChild("W5"):addy(4.25)

				screen:GetChild("MissNumberP1"):addy(0)
				c.JudgeFrames:GetChild("Miss"):addy(0)
			end
		end,
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Condition=not isnan(average),
			Text="average "..average.." | median "..math.round(median,3).." | peak "..peak,
			InitCommand=function(self) self:x(-78*(5/6)*WideScreenDiff()*WideScreenDiff()):maxwidth(300*WideScreenSemiDiff()):y(faplus and -6*WideScreenDiff() or 0) end,
			OnCommand=function(self) self:zoomx(0.6*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):diffusealpha(0):sleep(3.60):linear(0.7):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() if WideScreenDiff_(1.4) < 1 and showOffset and getenv("EvalComboP1") then self:zoomx(5/6) end end,
		Name="JudgeFrames",
		Def.ActorFrame{
			Name="W0",
			Condition=faplus,
			InitCommand=function(self) self:y(-220*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_0 "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(2.9):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.05):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FANTASTIC+",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.RollingNumbers{
				Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self)
					self:player(PLAYER_1):name("W0Number" .. PlayerNumberToString(PLAYER_1))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
					self:Load("RollingNumbersJudgment"):targetnumber(getenv("W0"..pname(PLAYER_1)) or 0):x(0):y(0)
				end
			}
		},
		Def.ActorFrame{
			Name="W1",
			InitCommand=function(self) self:y(-195*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_A "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.05):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FANTASTIC",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.RollingNumbers{
				Condition=faplus,
				Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self)
					self:player(PLAYER_1):name("W1Number" .. PlayerNumberToString(PLAYER_1))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
					self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores('TapNoteScore_W1')-(getenv("W0"..pname(PLAYER_1)) or 0)):x(-6*WideScreenDiff()):y(0):queuecommand("Reset")
				end,
				ResetCommand=function(self) self:diffusealpha(1) end
			}
		},
		Def.ActorFrame{
			Name="W2",
			InitCommand=function(self) self:y(-170*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_B "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.10):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.1):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="EXCELLENT",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.75*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W3",
			InitCommand=function(self) self:y(-145*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_C "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.20):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.15):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="GREAT",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W4",
			InitCommand=function(self) self:y(-120*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_D "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.30):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.2):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text=GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "TOO EARLY" or "DECENT",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left):maxwidth(120) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W5",
			InitCommand=function(self) self:y(-95*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_E "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.40):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.25):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text=isOpenDDR() and "MISS" or GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left):maxwidth(115) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Condition=not isOpenDDR(),
			Name="Miss",
			InitCommand=function(self) self:y(-70*WideScreenDiff()) end,
			Def.Sprite {
				Texture = "_F "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.50):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.3):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="MISS",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		}
	},
	Def.ActorFrame{
		Condition=showOffset and getenv("EvalComboP1"),
		InitCommand=function(self) if WideScreenDiff_(1.4) < 1 then self:zoomx(5/6) end end,
		Name="OffsetFrames",
		Def.ActorFrame{
			Name="W0",
			Condition=faplus,
			InitCommand=function(self) self:y(-220*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-15*WideScreenDiff()):horizalign(right):diffuse(color("#FFFFFF")) end,
				OnCommand=function(self)
					self:settextf("%04d",perfect):AddAttribute(0, {Length = math.max(4-string.len(''..perfect), 0),Diffuse = color("#808080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W0"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(5*WideScreenDiff()):horizalign(right):diffuse(color("#FF0000")) end,
				OnCommand=function(self)
					self:settextf("%04d",late["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..late["TapNoteScore_W0"]), 0),Diffuse = color("#800000")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W1",
			InitCommand=function(self) self:y(-195*WideScreenDiff()) end,
			Def.BitmapText {
				Condition=not faplus,
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-15*WideScreenDiff()):horizalign(right):diffuse(color("#FFFFFF")) end,
				OnCommand=function(self)
					self:settextf("%04d",perfect):AddAttribute(0, {Length = math.max(4-string.len(''..perfect), 0),Diffuse = color("#808080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W1"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(5*WideScreenDiff()):horizalign(right):diffuse(color("#FF0000")) end,
				OnCommand=function(self)
					self:settextf("%04d",late["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..late["TapNoteScore_W1"]), 0),Diffuse = color("#800000")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W2",
			InitCommand=function(self) self:y(-170*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W2"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(5*WideScreenDiff()):horizalign(right):diffuse(color("#FF0000")) end,
				OnCommand=function(self)
					self:settextf("%04d",late["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..late["TapNoteScore_W2"]), 0),Diffuse = color("#800000")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W3",
			InitCommand=function(self) self:y(-145*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W3"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(5*WideScreenDiff()):horizalign(right):diffuse(color("#FF0000")) end,
				OnCommand=function(self)
					self:settextf("%04d",late["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..late["TapNoteScore_W3"]), 0),Diffuse = color("#800000")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Name="W4",
			InitCommand=function(self) self:y(-120*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W4"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(5*WideScreenDiff()):horizalign(right):diffuse(color("#FF0000")) end,
				OnCommand=function(self)
					self:settextf("%04d",late["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..late["TapNoteScore_W4"]), 0),Diffuse = color("#800000")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Condition=not isOpenDDR(),
			Name="W5",
			InitCommand=function(self) self:y(-95*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W5"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(5*WideScreenDiff()):horizalign(right):diffuse(color("#FF0000")) end,
				OnCommand=function(self)
					self:settextf("%04d",late["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..late["TapNoteScore_W5"]), 0),Diffuse = color("#800000")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		}
	},
	Def.Sprite {
		Texture = "graph",
		InitCommand=function(self) self:x(-52*WideScreenDiff()):y(100*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	},
	Def.Sprite {
		Texture = "_glass",
		InitCommand=function(self) self:diffusealpha(0.2):x(-52*WideScreenDiff()):y(100*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	}
}