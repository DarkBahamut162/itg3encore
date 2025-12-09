local player = ...
local pn = player or GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20*WideScreenDiff()-SCREEN_WIDTH/2) or (SCREEN_LEFT+20*WideScreenDiff()-SCREEN_WIDTH/2)
if player then xPos = player == PLAYER_1 and -20*WideScreenDiff() or 20*WideScreenDiff() end
local SongOrCourse, StepsOrTrail, scorelist, topscore
local stats = getenv("ShowStats"..pname(pn))
local graphPos = getenv("ShowStatsPos"..pname(pn)) == 0

local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3,2}
local barHeight		= 268
local totalWidth	= 14
local barCenter		= 0
local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(pn))))
local TotalSteps = 0
local faplus = getenv("SetScoreFA"..pname(pn))

if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
if not isEtterna("0.55") and not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
if not isEtterna("0.55") and not scorelist then scorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail) end
if scorelist then topscore = scorelist:GetHighScores()[1] end
if isEtterna("0.55") then
	local score = SCOREMAN:GetMostRecentScore()
	local origTable = getScoresByKey(pn)
	local rtTable = getRateTable(origTable) or {}
	local stuff = rtTable[getRate(score)] or {}
	if #stuff > 0 then topscore = stuff[1] end
end

local function StepCounter()
	if isEtterna() then
		return StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_Notes")*2
	else
		return DPMax(pn)
	end
end

if StepsOrTrail then
	if IsCourseSecret() or not IsCourseFixed() then
		TotalSteps = RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_TapsAndHolds")
	else
		local rv = StepsOrTrail:GetRadarValues(pn)
		TotalSteps =  rv:GetValue("RadarCategory_TapsAndHolds")
	end
end

local bgNum = stats
if bgNum == (isOpenDDR() and 6 or 7) then
	if topscore == nil then bgNum = 2 else bgNum = 3 end
else
	if faplus then bgNum = bgNum + 1 end
end
if bgNum > 0 then barCenter	= -totalWidth/2+barWidth[bgNum]/2 end

local Bars = Def.ActorFrame{}
local judgments = {
	"TapNoteScore_Miss",
	"TapNoteScore_W5",
	"TapNoteScore_W4",
	"TapNoteScore_W3",
	"TapNoteScore_W2",
	"TapNoteScore_W1"
}

function GetTotalTaps()
	local total = 0
	for judg in ivalues(judgments) do
		if faplus and judg == "TapNoteScore_W1" then
			total = total + getenv("W0"..pname(pn)) + getenv("W1"..pname(pn))
		else
			total = total + STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores(judg)
		end
	end
	return total
end

if stats < (isOpenDDR() and 6 or 7) then
	for i = faplus and 0 or 1,math.min((isOpenDDR() and 5 or 6),stats) do
		local score = i < (isOpenDDR() and 5 or 6) and "W"..i or "Miss"
		Bars[#Bars+1] = Def.Sprite {
			Name="PercentW"..i,
			Texture = "../"..(faplus and "fa" or "w")..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):diffusealpha(0.25):x(barCenter+barWidth[bgNum]*(faplus and i or i-1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=stats >= i,
			JudgmentMessageCommand=function(self,param) if param.Player == pn and not (faplus and i < 2) then self:queuecommand("Update") end end,
			W0MessageCommand=function(self,param)
				if param.Player == pn then
					if self:GetName() == "PercentW0" then self:zoomy((param.W0/GetTotalTaps())*barHeight) end
					if self:GetName() == "PercentW1" then self:zoomy((param.W1/GetTotalTaps())*barHeight) end
				end
			end,
			UpdateCommand=function(self)
				local Percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentageOfTaps('TapNoteScore_'..score)
				self:zoomy(Percent*barHeight)
			end
		}
		Bars[#Bars+1] = Def.Sprite {
			Name="NotesW"..i,
			Texture = "../"..(faplus and "fa" or "w")..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(faplus and i or i-1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=stats >= i,
			JudgmentMessageCommand=function(self,param) if param.Player == pn and not (faplus and i < 2) then self:queuecommand("Update") end end,
			W0MessageCommand=function(self,param)
				if param.Player == pn then
					if self:GetName() == "NotesW0" then self:zoomy((param.W0/TotalSteps)*barHeight) end
					if self:GetName() == "NotesW1" then self:zoomy((param.W1/TotalSteps)*barHeight) end
				end
			end,
			UpdateCommand=function(self)
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
			Condition=getenv("PlayerNoteGraph"..pname(pn)) > 1,
			InitCommand=function(self) self:x(pn == PLAYER_1 and 53 or -53):y(graphPos and -15 or 70):zoom(0.5) end
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
			InitCommand=function(self) self:x(pn == PLAYER_1 and -80 or 80):y(graphPos and 163 or -30):zoom(0.5) end,
			Def.ActorFrame{
				Def.ActorFrame{
					Condition=stats < (isOpenDDR() and 6 or 7),
					InitCommand=function(self)
						self:y(-150)
						if faplus then
							local c = self:GetChildren()
							c.NumbersW1:addy(18):addy(4)
							c.NumbersW2:addy(15):addy(4)
							c.NumbersW3:addy(12):addy(4)
							c.NumbersW4:addy(09):addy(4)
							c.NumbersW5:addy(06):addy(4)
							c.NumbersMiss:addy(03):addy(4)
						end
					end,
					Def.BitmapText {
						Condition=faplus,
						File = "_z numbers",
						Name="NumbersW0",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(10-5):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W1')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn and not faplus then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W1')) end,
						W0MessageCommand=function(self,param) if param.Player == pn then self:settext(param.W0) end end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="NumbersW1",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(10-5):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor(faplus and 'TapNoteScore_W0' or 'TapNoteScore_W1')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn and not faplus then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W1')) end,
						W0MessageCommand=function(self,param) if param.Player == pn then self:settext(param.W1) end end
					},
					Def.BitmapText {
						Condition=stats >= 2,
						File = "_z numbers",
						Name="NumbersW2",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(35-4):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W2')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 2 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W2')) end end
					},
					Def.BitmapText {
						Condition=stats >= 3,
						File = "_z numbers",
						Name="NumbersW3",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(60-3):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W3')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 3 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W3')) end end
					},
					Def.BitmapText {
						Condition=stats >= 4,
						File = "_z numbers",
						Name="NumbersW4",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(85-2):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W4')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 4 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W4')) end end
					},
					Def.BitmapText {
						Condition=stats >= 5 and not isOpenDDR(),
						File = "_z numbers",
						Name="NumbersW5",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(110-1):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W5')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= 5 then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W5')) end end
					},
					Def.BitmapText {
						Condition=stats >= (isOpenDDR() and 5 or 6),
						File = "_z numbers",
						Name="NumbersMiss",
						Text="0",
						InitCommand=function(self) self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):addy(isOpenDDR() and 110-1 or 135):addx(pn == PLAYER_1 and 125 or -125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_Miss')) end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) if stats >= (isOpenDDR() and 5 or 6) then self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_Miss')) end end
					}
				},
				Def.ActorFrame{
					Condition=stats == (isOpenDDR() and 6 or 7),
					InitCommand=function(self) self:y(-140) end,
					Def.BitmapText {
						File = "_z numbers",
						Name="PlayerPoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):shadowlength(1):addy(0):addx(pn == PLAYER_1 and 125 or -125):diffuse(PlayerColor(pn)):diffusebottomedge(TapNoteScoreToColor("TapNoteScore_W1")):settext(DPCur(pn))
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(math.round(DPCur(pn))) end
					},
					Def.BitmapText {
						File = "_z numbers",
						Condition=topscore ~= nil,
						Name="HighscorePoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):shadowlength(1):addy(90):addx(pn == PLAYER_1 and 125 or -125):diffuse(PlayerColor(pn)):diffusebottomedge(TapNoteScoreToColor("TapNoteScore_W3")):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(math.ceil(DPCurMax(pn)*PercentDP(topscore))) end
					},
					Def.BitmapText {
						File = "_z numbers",
						Name="TargetPoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(pn == PLAYER_1 and 1 or 0):shadowlength(1):addy(120):addx(pn == PLAYER_1 and 125 or -125):diffuse(PlayerColor(pn)):diffusebottomedge(TapNoteScoreToColor("TapNoteScore_Miss")):queuecommand("Update")
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(math.ceil(DPCurMax(pn)*target)) end
					},

					Def.BitmapText {
						File = "_z numbers",
						Condition=topscore ~= nil,
						Name="PlayerHighscoreDifference",
						OnCommand=function(self) self:diffuse(color("#00FF00")):halign(pn == PLAYER_1 and 1 or 0):shadowlength(1):addy(30):addx(pn == PLAYER_1 and 125 or -125):queuecommand("Update") end,
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
							self:diffuse(color("#FF0000")):halign(pn == PLAYER_1 and 1 or 0):shadowlength(1):addy(60):addx(pn == PLAYER_1 and 125 or -125):queuecommand("Update")
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self)
							local curTargetDP = math.ceil(DPCurMax(pn)*target)
							self:settextf("%+04d",(DPCur(pn)-curTargetDP))
						end
					}
				}
			}
		}
	}
}