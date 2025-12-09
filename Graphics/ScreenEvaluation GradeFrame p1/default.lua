local offsetInfo = getenv("OffsetTable")
local columnInfo = getenv("perColJudgeData")
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
local column = {}
local perfect = 0

local counter = 0
local average = 0
local median = 0
local offset = {}
local errors = {}

local peak = -1
local peak_counter = 0
local maxRange = -1
local NumColumns = GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
local maxJudg = 0

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

if columnInfo then
	for col=1,NumColumns do
		column[col] = {
			["TapNoteScore_W0"] = 0,
			["TapNoteScore_W1"] = 0,
			["TapNoteScore_W2"] = 0,
			["TapNoteScore_W3"] = 0,
			["TapNoteScore_W4"] = 0,
			["TapNoteScore_W5"] = 0,
			["TapNoteScore_Miss"] = 0
		}
		for tns,t in pairs(columnInfo[PLAYER_1][col]) do
			tns = "TapNoteScore_"..tns
			if column[col][tns] then column[col][tns] = t end
			maxJudg = math.max(maxJudg,t)
		end
	end
end

showOffset = showOffset and offsetInfo and offsetInfo[PLAYER_1] and #offsetInfo[PLAYER_1] > 0 and counter > 0 and getenv("EvalComboP1")
local faplus = getenv("SetScoreFA"..pname(PLAYER_1))
local c

local width = {
	["TapNoteScore_W0"] = 300,
	["TapNoteScore_W1"] = 290,
	["TapNoteScore_W2"] = 280,
	["TapNoteScore_W3"] = 270,
	["TapNoteScore_W4"] = 260,
	["TapNoteScore_W5"] = 250,
	["TapNoteScore_Miss"] = 240
}
local ctrlHeld = false
local keyboardEnabled = ThemePrefs.Get("KeyboardEnabled")
local switched = false

local function GetJudgmentsOfTNS(tns)
	local output = ""
	for col=1,NumColumns do
		local current = column[col][tns] and column[col][tns] or "0"
		for len=string.len(current),string.len(maxJudg)-1 do current = " "..current end
		output = addToOutput(output,current,"x")
	end
	return output
end

local InputHandler = function(event)
	if event.PlayerNumber ~= PLAYER_1 then return false end
	if keyboardEnabled then
		if event.type == "InputEventType_FirstPress" then
			if string.find(event.DeviceInput.button,"left ctrl") and not ctrlHeld then ctrlHeld = true end
		elseif event.type == "InputEventType_Release" then
			if string.find(event.DeviceInput.button,"left ctrl") and ctrlHeld then ctrlHeld = false end
		end
	else
		if event.type == "InputEventType_FirstPress" then
			if event.GameButton == "Select" and not ctrlHeld then ctrlHeld = true end
		elseif event.type == "InputEventType_Release" then
			if event.GameButton == "Select" and ctrlHeld then ctrlHeld = false end
		end
	end
	if ctrlHeld and event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" or event.GameButton == "MenuRight" then
			if not switched then
				if faplus then c.JudgeFrames:GetChild("W0"):GetChild("W0JudgmentP1"):settext("") end
				c.JudgeFrames:GetChild("W1"):GetChild("W1JudgmentP1"):settext("")
				c.JudgeFrames:GetChild("W2"):GetChild("W2JudgmentP1"):settext("")
				c.JudgeFrames:GetChild("W3"):GetChild("W3JudgmentP1"):settext("")
				c.JudgeFrames:GetChild("W4"):GetChild("W4JudgmentP1"):settext("")
				c.JudgeFrames:GetChild("W5"):GetChild("W5JudgmentP1"):settext("")
				c.JudgeFrames:GetChild("Miss"):GetChild("MissJudgmentP1"):settext("")
				if faplus then c.JudgeFrames:GetChild("W0"):GetChild("W0ColumnP1"):diffusealpha(1) end
				c.JudgeFrames:GetChild("W1"):GetChild("W1ColumnP1"):diffusealpha(1)
				c.JudgeFrames:GetChild("W2"):GetChild("W2ColumnP1"):diffusealpha(1)
				c.JudgeFrames:GetChild("W3"):GetChild("W3ColumnP1"):diffusealpha(1)
				c.JudgeFrames:GetChild("W4"):GetChild("W4ColumnP1"):diffusealpha(1)
				c.JudgeFrames:GetChild("W5"):GetChild("W5ColumnP1"):diffusealpha(1)
				c.JudgeFrames:GetChild("Miss"):GetChild("MissColumnP1"):diffusealpha(1)
				local screen = SCREENMAN:GetTopScreen()
				if screen then
					if faplus then
						c.JudgeFrames:GetChild("W0"):GetChild("W0NumberP1"):diffusealpha(0)
						c.JudgeFrames:GetChild("W1"):GetChild("W1NumberP1"):diffusealpha(0)
					else
						screen:GetChild("W1NumberP1"):diffusealpha(0)
					end
					screen:GetChild("W2NumberP1"):diffusealpha(0)
					screen:GetChild("W3NumberP1"):diffusealpha(0)
					screen:GetChild("W4NumberP1"):diffusealpha(0)
					screen:GetChild("W5NumberP1"):diffusealpha(0)
					screen:GetChild("MissNumberP1"):diffusealpha(0)
				end
				switched = true
			elseif switched then
				if faplus then c.JudgeFrames:GetChild("W0"):GetChild("W0JudgmentP1"):settext("FANTASTIC+") end
				c.JudgeFrames:GetChild("W1"):GetChild("W1JudgmentP1"):settext("FANTASTIC")
				c.JudgeFrames:GetChild("W2"):GetChild("W2JudgmentP1"):settext("EXCELLENT")
				c.JudgeFrames:GetChild("W3"):GetChild("W3JudgmentP1"):settext("GREAT")
				c.JudgeFrames:GetChild("W4"):GetChild("W4JudgmentP1"):settext("DECENT")
				c.JudgeFrames:GetChild("W5"):GetChild("W5JudgmentP1"):settext("WAY OFF")
				c.JudgeFrames:GetChild("Miss"):GetChild("MissJudgmentP1"):settext("MISS")
				if faplus then c.JudgeFrames:GetChild("W0"):GetChild("W0ColumnP1"):diffusealpha(0) end
				c.JudgeFrames:GetChild("W1"):GetChild("W1ColumnP1"):diffusealpha(0)
				c.JudgeFrames:GetChild("W2"):GetChild("W2ColumnP1"):diffusealpha(0)
				c.JudgeFrames:GetChild("W3"):GetChild("W3ColumnP1"):diffusealpha(0)
				c.JudgeFrames:GetChild("W4"):GetChild("W4ColumnP1"):diffusealpha(0)
				c.JudgeFrames:GetChild("W5"):GetChild("W5ColumnP1"):diffusealpha(0)
				c.JudgeFrames:GetChild("Miss"):GetChild("MissColumnP1"):diffusealpha(0)
				local screen = SCREENMAN:GetTopScreen()
				if screen then
					if faplus then
						c.JudgeFrames:GetChild("W0"):GetChild("W0NumberP1"):diffusealpha(1)
						c.JudgeFrames:GetChild("W1"):GetChild("W1NumberP1"):diffusealpha(1)
					else
						screen:GetChild("W1NumberP1"):diffusealpha(1)
					end
					screen:GetChild("W2NumberP1"):diffusealpha(1)
					screen:GetChild("W3NumberP1"):diffusealpha(1)
					screen:GetChild("W4NumberP1"):diffusealpha(1)
					screen:GetChild("W5NumberP1"):diffusealpha(1)
					screen:GetChild("MissNumberP1"):diffusealpha(1)
				end
				switched = false
			end
		end
	end
end

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() end,
	Def.ActorFrame{
		Name="Error",
		InitCommand=function(self) self:y(-212*WideScreenDiff()) end,
		OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
		OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen()
			if screen then
				c.JudgeFrames:GetChild("W1"):GetChild("W1ColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_W1")):maxwidth(width["TapNoteScore_W1"])
				c.JudgeFrames:GetChild("W2"):GetChild("W2ColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_W2")):maxwidth(width["TapNoteScore_W2"])
				c.JudgeFrames:GetChild("W3"):GetChild("W3ColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_W3")):maxwidth(width["TapNoteScore_W3"])
				c.JudgeFrames:GetChild("W4"):GetChild("W4ColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_W4")):maxwidth(width["TapNoteScore_W4"])
				c.JudgeFrames:GetChild("W5"):GetChild("W5ColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_W5")):maxwidth(width["TapNoteScore_W5"])
				c.JudgeFrames:GetChild("Miss"):GetChild("MissColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_Miss")):maxwidth(width["TapNoteScore_Miss"])
				if faplus then
					c.JudgeFrames:GetChild("W0"):GetChild("W0ColumnP1"):settext(GetJudgmentsOfTNS("TapNoteScore_W0")):maxwidth(width["TapNoteScore_W0"])
					c.Error:addy(4+1.5*WideScreenDiff())
					c.JudgeFrames:GetChild("W0"):addy(25.5*WideScreenDiff())

					screen:GetChild("W1NumberP1"):addy(21.25*WideScreenDiff())
					c.JudgeFrames:GetChild("W1"):addy(21.25*WideScreenDiff())

					screen:GetChild("W2NumberP1"):addy(17*WideScreenDiff())
					c.JudgeFrames:GetChild("W2"):addy(17*WideScreenDiff())

					screen:GetChild("W3NumberP1"):addy(12.75*WideScreenDiff())
					c.JudgeFrames:GetChild("W3"):addy(12.75*WideScreenDiff())

					screen:GetChild("W4NumberP1"):addy(8.5*WideScreenDiff())
					c.JudgeFrames:GetChild("W4"):addy(8.5*WideScreenDiff())

					screen:GetChild("W5NumberP1"):addy(4.25*WideScreenDiff())
					c.JudgeFrames:GetChild("W5"):addy(4.25*WideScreenDiff())

					screen:GetChild("MissNumberP1"):addy(0)
					c.JudgeFrames:GetChild("Miss"):addy(0)

					if showOffset then
						c.OffsetFrames:GetChild("W0"):addy(25.5*WideScreenDiff())
						c.OffsetFrames:GetChild("W1"):addy(21.25*WideScreenDiff())
						c.OffsetFrames:GetChild("W2"):addy(17*WideScreenDiff())
						c.OffsetFrames:GetChild("W3"):addy(12.75*WideScreenDiff())
						c.OffsetFrames:GetChild("W4"):addy(8.5*WideScreenDiff())
						c.OffsetFrames:GetChild("W5"):addy(4.25*WideScreenDiff())
					end
				end
			end
		end,
		Def.BitmapText {
			File="_v 26px bold shadow",
			Condition=showOffset,
			Text="average "..average.." | median "..math.round(median,3).." | peak "..peak,
			InitCommand=function(self) self:x(-78*(5/6)*WideScreenDiff()*WideScreenDiff()):maxwidth(300*WideScreenSemiDiff()):y(faplus and -3*WideScreenDiff() or 2*WideScreenDiff()) end,
			OnCommand=function(self) self:zoomx(0.6*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):diffusealpha(0):sleep(3.60):linear(0.7):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) c = self:GetChildren() if WideScreenDiff_(1.4) < 1 and showOffset then self:zoomx(5/6) end end,
		Name="JudgeFrames",
		Def.ActorFrame{
			Name="W0",
			Condition=faplus,
			InitCommand=function(self) self:y(-220*WideScreenDiff()) end,
			Def.Sprite {
				Texture="_0 "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(2.9):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.05):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W0Judgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
				Text="FANTASTIC+",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W0Column"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-60*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
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
				Texture="_A "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.05):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W1Judgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
				Text="FANTASTIC",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W1Column"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-63*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
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
				Texture="_B "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.10):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.1):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W2Column"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-66*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
			},
			Def.BitmapText {
				Name="W2Judgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
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
				Texture="_C "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.20):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.15):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W3Column"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-69*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
			},
			Def.BitmapText {
				Name="W3Judgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
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
				Texture="_D "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.30):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.2):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W4Column"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-72*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
			},
			Def.BitmapText {
				Name="W4Judgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
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
				Texture="_E "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.40):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.25):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="W5Column"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-75*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
			},
			Def.BitmapText {
				Name="W5Judgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
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
				Texture="_F "..(isFinal() and "Final" or "Normal"),
				InitCommand=function(self) self:x(-156*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoom(WideScreenDiff()):addx(-100):diffusealpha(0):sleep(3.50):bounceend(0.4):addx(100):diffusealpha(1) end,
				OffCommand=function(self) self:sleep(0.3):bouncebegin(0.4):addx(-100):diffusealpha(0) end
			},
			Def.BitmapText {
				Name="MissColumn"..PlayerNumberToString(PLAYER_1),
				File=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
				InitCommand=function(self) self:x(-78*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):diffusealpha(0):zoom(0.6*WideScreenDiff()) end
			},
			Def.BitmapText {
				Name="MissJudgment"..PlayerNumberToString(PLAYER_1),
				File="_v 26px bold shadow",
				Text="MISS",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		}
	},
	Def.ActorFrame{
		Condition=showOffset,
		InitCommand=function(self) if WideScreenDiff_(1.4) < 1 then self:zoomx(5/6) end end,
		Name="OffsetFrames",
		Def.ActorFrame{
			Name="W0",
			Condition=faplus,
			InitCommand=function(self) self:y(-220*WideScreenDiff()) end,
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-15*WideScreenDiff()):horizalign(right):diffuse(color("#FFFFFF")) end,
				OnCommand=function(self)
					self:settextf("%04d",perfect):AddAttribute(0, {Length = math.max(4-string.len(''..perfect), 0),Diffuse = color("#808080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W0"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W0"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
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
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-15*WideScreenDiff()):horizalign(right):diffuse(color("#FFFFFF")) end,
				OnCommand=function(self)
					self:settextf("%04d",perfect):AddAttribute(0, {Length = math.max(4-string.len(''..perfect), 0),Diffuse = color("#808080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W1"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W1"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
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
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W2"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W2"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
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
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W3"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W3"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
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
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W4"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W4"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
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
				File="_ScreenEvaluation numbers",
				InitCommand=function(self) self:x(-156*WideScreenDiff()):y(-5*WideScreenDiff()):horizalign(right):diffuse(color("#0000FF")) end,
				OnCommand=function(self)
					self:settextf("%04d",early["TapNoteScore_W5"]):AddAttribute(0, {Length = math.max(4-string.len(''..early["TapNoteScore_W5"]), 0),Diffuse = color("#000080")})
					self:zoom(0.4*WideScreenDiff()):cropleft(1.3):fadeleft(0.1):sleep(3.60):linear(0.7):cropleft(-0.3)
				end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			},
			Def.BitmapText {
				File="_ScreenEvaluation numbers",
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
		Texture="graph",
		InitCommand=function(self) self:x(-52*WideScreenDiff()):y(100*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	},
	Def.Sprite {
		Texture="_glass",
		InitCommand=function(self) self:diffusealpha(0.2):x(-52*WideScreenDiff()):y(100*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	}
}