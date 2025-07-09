local player = ...
local pn = player or GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20*WideScreenDiff()-SCREEN_WIDTH/2) or (SCREEN_LEFT+20*WideScreenDiff()-SCREEN_WIDTH/2)
if player then xPos = player == PLAYER_1 and -20*WideScreenDiff() or 20*WideScreenDiff() end
local SongOrCourse, StepsOrTrail, scorelist, topscore
local mines, holds, rolls, holdsAndRolls = 0, 0, 0, 0
local stats = getenv("ShowStats"..pname(pn))

local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3}
local barHeight		= 268
local totalWidth	= 14
local barCenter		= 0
local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(pn))))

if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
if not isEtterna() and not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
if not isEtterna() and not scorelist then scorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail) end
if scorelist then topscore = scorelist:GetHighScores()[1] end
if isEtterna() then
	local score = SCOREMAN:GetMostRecentScore()
	local origTable = getScoresByKey(pn)
	local rtTable = getRateTable(origTable) or {}
	local stuff = rtTable[getRate(score)] or {}
	if #stuff > 0 then topscore = stuff[1] end
end
local function StepCounter()
	local loadStepCounter = LoadFromCache(SongOrCourse,StepsOrTrail,"StepCounter")
	local output = 0
	if loadStepCounter and loadStepCounter ~= "" then
		loadStepCounter = split("_",loadStepCounter)
		for i=1,#loadStepCounter do output = output + (tonumber(loadStepCounter[i])*i) end
		return output*2
	end
end
if StepsOrTrail then
	local rv = StepsOrTrail:GetRadarValues(pn)
	mines,holds,rolls = rv:GetValue('RadarCategory_Mines'),rv:GetValue('RadarCategory_Holds'),rv:GetValue('RadarCategory_Rolls')
	holdsAndRolls = holds + rolls
end

local bgNum = stats
if bgNum == (isOpenDDR() and 6 or 7) then if topscore == nil then bgNum = 2 else bgNum = 3 end end
if bgNum > 0 then barCenter	= -totalWidth/2+barWidth[bgNum]/2 end

local Bars = Def.ActorFrame{}

if stats < (isOpenDDR() and 6 or 7) then
	for i = 1,math.min((isOpenDDR() and 5 or 6),stats) do
		local score = i < (isOpenDDR() and 5 or 6) and "W"..i or "Miss"
		Bars[#Bars+1] = Def.Sprite {
			Texture = "../w"..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):diffusealpha(0.25):x(barCenter+barWidth[bgNum]*(i-1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=stats >= i,
			JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
			UpdateCommand=function(self)
				local Percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentageOfTaps('TapNoteScore_'..score)
				self:zoomy(Percent*barHeight)
			end
		}
		Bars[#Bars+1] = Def.Sprite {
			Texture = "../w"..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(i-1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=stats >= i,
			JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
			UpdateCommand=function(self)
				local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
				local Notes = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_'..score)
				self:zoomy(Notes/TotalSteps*barHeight)
			end
		}
	end
end

return Def.ActorFrame{
	OnCommand=function(self) self:Center() end,
	Def.ActorFrame{
		Condition=stats > 0,
		Name="Player",
		InitCommand=function(self) self:x(xPos):addx(pn == PLAYER_1 and 100*getenv("ShowStatsSize"..pname(pn)) or -100*getenv("ShowStatsSize"..pname(pn))):zoom(WideScreenDiff()) end,
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end,
		OnCommand=function(self)
			if GAMESTATE:GetNumPlayersEnabled() == 2 and GAMESTATE:GetNumSidesJoined() == 2 then
				self:addx(pn == PLAYER_1 and -100*getenv("ShowStatsSize"..pname(pn)) or 100*getenv("ShowStatsSize"..pname(pn))):diffusealpha(0):sleep(0.5):linear(0.8):diffusealpha(1)
			else
				self:sleep(0.5):decelerate(0.8):addx(pn == PLAYER_1 and -100*getenv("ShowStatsSize"..pname(pn)) or 100*getenv("ShowStatsSize"..pname(pn)))
			end
		end,
		OffCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end
			if GAMESTATE:GetNumPlayersEnabled() == 2 and GAMESTATE:GetNumSidesJoined() == 2 then
				self:linear(0.8):diffusealpha(0)
			else
				self:accelerate(0.8):addx(pn == PLAYER_1 and 100*getenv("ShowStatsSize"..pname(pn)) or -100*getenv("ShowStatsSize"..pname(pn)))
			end
		end,
		loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(pn)..{
			Condition=getenv("ShowNoteGraph"..pname(pn)) > 1,
			InitCommand=function(self) self:x(pn == PLAYER_1 and 53 or -53):y(-15):zoom(0.5) end
		},
		loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/double/d_bg"))(pn),
		Def.ActorFrame{
			Condition=stats < (isOpenDDR() and 6 or 7),
			Bars
		},
		Def.ActorFrame{
			Condition=stats == (isOpenDDR() and 6 or 7),
			Def.Sprite {
				Texture = "../w1",
				OnCommand=function(self)
					self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(barHeight):diffusealpha(0.25)
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:zoomy(((DPMax(pn)-(DPCurMax(pn)-DPCur(pn)))/DPMax(pn))*barHeight) end
			},
			Def.Sprite {
				Texture = "../w3",
				OnCommand=function(self)
					self:vertalign(bottom):x(barCenter+(barWidth[bgNum])*(topscore ~= nil and 1 or 0)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0):diffusealpha(0.25)
					if topscore ~= nil then self:zoomy(PercentDP(topscore)*barHeight) else self:zoomy(barHeight):cropleft(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore == nil then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:zoomy(((DPMax(pn)-(DPCurMax(pn)-DPCur(pn)))/DPMax(pn))*barHeight) end
			},
			Def.Sprite {
				Texture = "../w6",
				OnCommand=function(self) self:vertalign(bottom):x(barCenter+(barWidth[bgNum])*(topscore ~= nil and 2 or 1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(target*barHeight):diffusealpha(0.25) end
			},
			Def.Sprite {
				Texture = "../w1",
				InitCommand=function(self)
					self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0)
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:zoomy(DP(pn)*barHeight) end
			},
			Def.Sprite {
				Texture = "../w3",
				InitCommand=function(self)
					self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(topscore ~= nil and 1 or 0)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0)
					if topscore == nil then self:cropleft(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					if topscore then
						self:zoomy(DPCurMax(pn)/DPMax(pn)*PercentDP(topscore)*barHeight)
					else
						self:zoomy(DP(pn)*barHeight)
					end
				end
			},
			Def.Sprite {
				Texture = "../w6",
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(topscore ~= nil and 2 or 1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:zoomy(DPCurMax(pn)/DPMax(pn)*target*barHeight) end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(pn == PLAYER_1 and -62 or 62):y(144):zoom(0.33) end,
			Def.ActorFrame{
				Def.BitmapText {
					File = "_z bold gray 36px",
					Condition=stats < (isOpenDDR() and 6 or 7),
					Text="STATS",
					OnCommand=function(self) self:zoom(0.5):halign(0):shadowlength(1):addy(-174) end
				},
				Def.BitmapText {
					File = "_z bold gray 36px",
					Condition=stats == (isOpenDDR() and 6 or 7),
					Text="PACE",
					OnCommand=function(self) self:zoom(0.5):halign(0):shadowlength(1):addy(-174) end
				},
				Def.ActorFrame{
					Condition=stats < (isOpenDDR() and 6 or 7),
					InitCommand=function(self) self:y(-150) end,
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="LabelW1",
						Text="F",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(10-5):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W1")) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="LabelW2",
						Text="E",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(35-4):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W2")) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="LabelW3",
						Text="G",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(60-3):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W3")) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="LabelW4",
						Text="D",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(85-2):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W4")) end
					},
					Def.BitmapText {
						Condition=not isOpenDDR(),
						File = "ScreenGameplay judgment",
						Name="LabelW5",
						Text="W",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(110-1):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W5")) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="LabelMiss",
						Text="M",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(isOpenDDR() and 110-1 or 135):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_Miss")) end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="NumbersW1",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(10-5):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W1')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W1')) end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="NumbersW2",
						Text="?",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(35-4):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W2')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 2 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W2')) end end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="NumbersW3",
						Text="?",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(60-3):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W3')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 3 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W3')) end end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="NumbersW4",
						Text="?",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(85-2):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W4')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 4 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W4')) end end
					},
					Def.BitmapText {
						Condition=not isOpenDDR(),
						File = "_z numbers",
						Name="NumbersW5",
						Text="?",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(110-1):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W5')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 5 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W5')) end end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="NumbersMiss",
						Text="?",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(isOpenDDR() and 110-1 or 135):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_Miss')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= (isOpenDDR() and 5 or 6) then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_Miss')) end end
					}
				},
				Def.ActorFrame{
					Condition=stats == (isOpenDDR() and 6 or 7),
					InitCommand=function(self) self:y(-140) end,
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="PlayerName",
						Text="P",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(0):diffuse(TapNoteScoreToColor("TapNoteScore_W1"))
						end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Condition=topscore ~= nil,
						Name="HighscoreName",
						Text="H",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(90):diffuse(TapNoteScoreToColor("TapNoteScore_W3"))
						end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="TargetName",
						Text="T",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(120):diffuse(TapNoteScoreToColor("TapNoteScore_Miss"))
						end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="PlayerPoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(0):addx(125):diffuse(PlayerColor(pn)):settext(DPCur(pn))
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(DPCur(pn)) end
					},
					Def.BitmapText {
						File = "_z numbers",
						Condition=topscore ~= nil,
						Name="HighscorePoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(90):addx(125):diffuse(PlayerColor(pn)):settext(math.ceil(PercentDP(topscore)*StepCounter()))
						end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="TargetPoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(120):addx(125):diffuse(PlayerColor(pn)):settext(math.ceil(target*StepCounter()))
						end
					},

					Def.BitmapText {
						File = "_z numbers",
						Condition=topscore ~= nil,
						Name="PlayerHighscoreDifference",
						OnCommand=function(self) self:diffuse(color("#00FF00")):halign(1):shadowlength(1):addy(30):addx(125):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil then self:queuecommand("Update") end end,
						UpdateCommand=function(self)
							local curHighscoreDP = math.ceil(DPCurMax(pn)*PercentDP(topscore))
							self:settextf("%+04d",(DPCur(pn)-curHighscoreDP))
						end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="PlayerTargetDifference",
						OnCommand=function(self)
							self:diffuse(color("#FF0000")):halign(1):shadowlength(1):addy(60):addx(125):queuecommand("Update")
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self)
							local curTargetDP = math.ceil(DPCurMax(pn)*target)
							self:settextf("%+04d",(DPCur(pn)-curTargetDP))
						end
					},
				},
				Def.ActorFrame{
					OnCommand=function(self)
						if mines == 0 then
							self:GetChild("MineName"):visible(false)
							self:GetChild("MineCounter"):visible(false)
						end
						if holdsAndRolls == 0 then
							self:GetChild("HoldName"):visible(false)
							self:GetChild("HoldCounter"):visible(false)
						end
						self:queuecommand("Update")
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						self:GetChild("MineCounter"):settext(pss:GetTapNoteScores('TapNoteScore_HitMine').."/"..mines)
						self:GetChild("HoldCounter"):settext(pss:GetHoldNoteScores('HoldNoteScore_LetGo').."/"..holdsAndRolls)
					end,

					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="HoldName",
						Text="DROP'D",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(50):fadeleft(pn == PLAYER_1 and 1 or 0):faderight(pn == PLAYER_2 and 1 or 0):linear(1):fadeleft(0):faderight(0) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="MineName",
						Text="MINED",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(15):fadeleft(pn == PLAYER_1 and 1 or 0):faderight(pn == PLAYER_2 and 1 or 0):linear(1):fadeleft(0):faderight(0) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="HoldCounter",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(50):addx(125) end
					},
					Def.BitmapText {
						File = "ScreenGameplay judgment",
						Name="MineCounter",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(15):addx(125) end
					}
				},
			},
		}
	}
}