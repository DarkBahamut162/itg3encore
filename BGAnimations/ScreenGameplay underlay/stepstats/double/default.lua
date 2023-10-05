local player = ...
local pn = player or GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20*WideScreenDiff()-SCREEN_WIDTH/2) or (SCREEN_LEFT+20*WideScreenDiff()-SCREEN_WIDTH/2)
if player then xPos = player == PLAYER_1 and -20*WideScreenDiff() or 20*WideScreenDiff() end
local SongOrCourse, StepsOrTrail, scorelist, topscore
local mines, holds, rolls, holdsAndRolls = 0, 0, 0, 0

local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3}
local barHeight		= 268
local totalWidth	= 14
local barCenter		= 0

if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
if not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
if not scorelist then scorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail) end
if scorelist then topscore = scorelist:GetHighScores()[1] end

if StepsOrTrail then
	local rv = StepsOrTrail:GetRadarValues(pn)
	mines,holds,rolls = rv:GetValue('RadarCategory_Mines'),rv:GetValue('RadarCategory_Holds'),rv:GetValue('RadarCategory_Rolls')
	holdsAndRolls = holds + rolls
end

local bgNum = getenv("ShowStats"..pname(pn))
if bgNum == 7 then if topscore == nil then bgNum = 2 else bgNum = 3 end end
if bgNum > 0 then barCenter	= -totalWidth/2+barWidth[bgNum]/2 end

local Bars = Def.ActorFrame{}

if getenv("ShowStats"..pname(pn)) < 7 then
	for i = 1,math.min(6,getenv("ShowStats"..pname(pn))) do
		local score = i < 6 and "W"..i or "Miss"
		Bars[#Bars+1] = LoadActor("../w"..i)..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(i-1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=getenv("ShowStats"..pname(pn)) >= i,
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
		LoadActor("../graph",pn)..{
			Condition=getenv("ShowNoteGraph"..pname(pn)) == 2,
			InitCommand=function(self) self:x(pn == PLAYER_1 and 53 or -53):y(-15):zoom(0.5) end
		},
		LoadActor("d_bg",pn),
		Def.ActorFrame{
			Condition=getenv("ShowStats"..pname(pn)) < 7,
			Bars
		},
		Def.ActorFrame{
			Condition=getenv("ShowStats"..pname(pn)) == 7,
			LoadActor("../w1")..{
				OnCommand=function(self)
					self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(barHeight):diffusealpha(0.25)
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					local DPMax = pss:GetPossibleDancePoints()
					local DP = pss:GetActualDancePoints()
					self:zoomy(((DPMax-(DPCurMax-DP))/DPMax)*barHeight)
				end
			},
			LoadActor("../w3")..{
				OnCommand=function(self)
					self:vertalign(bottom):x(barCenter+(barWidth[bgNum])*(topscore ~= nil and 1 or 0)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0):diffusealpha(0.25)
					if topscore ~= nil then self:zoomy(topscore:GetPercentDP()*barHeight) else self:zoomy(barHeight):cropleft(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore == nil then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					local DPMax = pss:GetPossibleDancePoints()
					local DP = pss:GetActualDancePoints()
					self:zoomy(((DPMax-(DPCurMax-DP))/DPMax)*barHeight)
				end
			},
			LoadActor("../w6")..{
				OnCommand=function(self)
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(pn))))
					self:vertalign(bottom):x(barCenter+(barWidth[bgNum])*(topscore ~= nil and 2 or 1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(target*barHeight):diffusealpha(0.25)
				end
			},
			LoadActor("../w1")..{
				InitCommand=function(self)
					self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0)
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local DP = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentDancePoints()
					self:zoomy(DP*barHeight)
				end
			},
			LoadActor("../w3")..{
				InitCommand=function(self)
					self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(topscore ~= nil and 1 or 0)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0)
					if topscore == nil then self:cropleft(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					if topscore then
						local DPMax = pss:GetPossibleDancePoints()
						self:zoomy(DPCurMax/DPMax*topscore:GetPercentDP()*barHeight)
					else
						local DP = pss:GetPercentDancePoints()
						self:zoomy(DP*barHeight)
					end
				end
			},
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*(topscore ~= nil and 2 or 1)):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(pn))))
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					local DPMax = pss:GetPossibleDancePoints()
					self:zoomy(DPCurMax/DPMax*target*barHeight)
				end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(pn == PLAYER_1 and -62 or 62):y(144):zoom(0.33) end,
			Def.ActorFrame{
				LoadFont("_z bold gray 36px")..{
					Condition=getenv("ShowStats"..pname(pn)) ~= 7,
					Text="STATS",
					OnCommand=function(self) self:zoom(0.5):halign(0):shadowlength(1):addy(-174) end
				},
				LoadFont("_z bold gray 36px")..{
					Condition=getenv("ShowStats"..pname(pn)) == 7,
					Text="PACE",
					OnCommand=function(self) self:zoom(0.5):halign(0):shadowlength(1):addy(-174) end
				},
				Def.ActorFrame{
					Condition=getenv("ShowStats"..pname(pn)) ~= 7,
					InitCommand=function(self) self:y(-150) end,
					LoadFont("ScreenGameplay judgment")..{
						Name="LabelW1",
						Text="F",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(10-5):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W1")) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="LabelW2",
						Text="E",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(35-4):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W2")) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="LabelW3",
						Text="G",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(60-3):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W3")) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="LabelW4",
						Text="D",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(85-2):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W4")) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="LabelW5",
						Text="W",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(110-1):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_W5")) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="LabelMiss",
						Text="M",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(135):shadowlength(1):diffuse(TapNoteScoreToColor("TapNoteScore_Miss")) end
					},
					LoadFont("_z numbers")..{
						Name="NumbersW1",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(10-5):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W1')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W1')) end
					},
					LoadFont("_z numbers")..{
						Name="NumbersW2",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(35-4):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W2')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W2')) end
					},
					LoadFont("_z numbers")..{
						Name="NumbersW3",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(60-3):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W3')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W3')) end
					},
					LoadFont("_z numbers")..{
						Name="NumbersW4",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(85-2):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W4')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W4')) end
					},
					LoadFont("_z numbers")..{
						Name="NumbersW5",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(110-1):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_W5')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_W5')) end
					},
					LoadFont("_z numbers")..{
						Name="NumbersMiss",
						InitCommand=function(self) self:maxwidth(125):halign(1):addy(135):addx(125):shadowlength(1):diffuse(TapNoteScoreToColor('TapNoteScore_Miss')):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_Miss')) end
					}
				},
				Def.ActorFrame{
					Condition=getenv("ShowStats"..pname(pn)) == 7,
					InitCommand=function(self) self:y(-140) end,
					LoadFont("ScreenGameplay judgment")..{
						Name="PlayerName",
						Text="P",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(0):diffuse(TapNoteScoreToColor("TapNoteScore_W1"))
						end
					},
					LoadFont("ScreenGameplay judgment")..{
						Condition=topscore ~= nil,
						Name="HighscoreName",
						Text="H",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(90):diffuse(TapNoteScoreToColor("TapNoteScore_W3"))
						end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="TargetName",
						Text="T",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(120):diffuse(TapNoteScoreToColor("TapNoteScore_Miss"))
						end
					},
					LoadFont("_z numbers")..{
						Name="PlayerPoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(0):addx(125):diffuse(PlayerColor(pn)):settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints())
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints()) end
					},
					LoadFont("_z numbers")..{
						Condition=topscore ~= nil,
						Name="HighscorePoints",
						OnCommand=function(self)
							self:maxwidth(125):halign(1):shadowlength(1):addy(90):addx(125):diffuse(PlayerColor(pn)):settext(math.ceil(topscore:GetPercentDP()*STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPossibleDancePoints()))
						end
					},
					LoadFont("_z numbers")..{
						Name="TargetPoints",
						OnCommand=function(self)
							local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",18-getenv("SetPacemaker"..pname(pn))))
							self:maxwidth(125):halign(1):shadowlength(1):addy(120):addx(125):diffuse(PlayerColor(pn)):settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPossibleDancePoints()))
						end
					},
	
					LoadFont("_z numbers")..{
						Condition=topscore ~= nil,
						Name="PlayerHighscoreDifference",
						OnCommand=function(self) self:diffuse(color("#00FF00")):halign(1):shadowlength(1):addy(30):addx(125):queuecommand("Update") end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil then self:queuecommand("Update") end end,
						UpdateCommand=function(self)
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local DPCurMax = pss:GetCurrentPossibleDancePoints()
							local curPlayerDP = pss:GetActualDancePoints()
							local curHighscoreDP = math.ceil(DPCurMax*topscore:GetPercentDP())
							self:settextf("%+04d",(curPlayerDP-curHighscoreDP))
						end
					},
					LoadFont("_z numbers")..{
						Name="PlayerTargetDifference",
						OnCommand=function(self)
							self:diffuse(color("#FF0000")):halign(1):shadowlength(1):addy(60):addx(125):queuecommand("Update")
						end,
						JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
						UpdateCommand=function(self)
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local DPCurMax = pss:GetCurrentPossibleDancePoints()
							local curPlayerDP = pss:GetActualDancePoints()
							local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",18-getenv("SetPacemaker"..pname(pn))))
							local curTargetDP = math.ceil(DPCurMax*target)
							self:settextf("%+04d",(curPlayerDP-curTargetDP))
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
					
					LoadFont("ScreenGameplay judgment")..{
						Name="HoldName",
						Text="DROP'D",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(50) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="MineName",
						Text="MINED",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(15) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="HoldCounter",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(50):addx(125) end
					},
					LoadFont("ScreenGameplay judgment")..{
						Name="MineCounter",
						OnCommand=function(self) self:maxwidth(125):halign(1):shadowlength(1):addy(15):addx(125) end
					}
				},
			},
		}
	}
}