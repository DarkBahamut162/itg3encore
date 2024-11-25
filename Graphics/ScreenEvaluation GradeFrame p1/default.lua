local offsetInfo = getenv("OffsetTable")
local early = {
	["TapNoteScore_W1"] = 0,
	["TapNoteScore_W2"] = 0,
	["TapNoteScore_W3"] = 0,
	["TapNoteScore_W4"] = 0,
	["TapNoteScore_W5"] = 0
}
local late = {
	["TapNoteScore_W1"] = 0,
	["TapNoteScore_W2"] = 0,
	["TapNoteScore_W3"] = 0,
	["TapNoteScore_W4"] = 0,
	["TapNoteScore_W5"] = 0
}
local perfect = 0

if offsetInfo then
	for t in ivalues(offsetInfo[PLAYER_1]) do
		if t[2] and type(t[2]) == "number" then
			t[2] = (math.floor(t[2]*1000))/1000
			if t[2] < 0 then
				early[t[3]] = early[t[3]] + 1
			elseif t[2] > 0 then
				late[t[3]] = late[t[3]] + 1
			else
				perfect = perfect + 1
			end
		end
	end
end

return Def.ActorFrame{
	Def.ActorFrame{
		Name="JudgeFrames",
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
				Text=GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() == 'Difficulty_Beginner' and "WAY EARLY" or "WAY OFF",
				InitCommand=function(self) self:x(-150*WideScreenDiff()):horizalign(left):maxwidth(115) end,
				OnCommand=function(self) self:zoomx(0.8*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusebottomedge(color("#BBB9FB")):cropright(1.3):faderight(0.1):sleep(3.60):linear(0.7):cropright(-0.3) end,
				OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
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
		Condition=ThemePrefs.Get("ShowOffset") and getenv("EvalComboP1"),
		Name="OffsetFrames",
		Def.ActorFrame{
			Name="W1",
			InitCommand=function(self) self:y(-195*WideScreenDiff()) end,
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