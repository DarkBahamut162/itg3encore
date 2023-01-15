if Var "LoadingScreen" == "ScreenDemonstration2" then return Def.ActorFrame{} end

local pn = GAMESTATE:GetMasterPlayerNumber()
local startX = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/4 or -SCREEN_WIDTH/4
local SongOrCourse,StepsOrTrail,scorelist,topscore
local mines,holds,rolls,holdsAndRolls = 0,0,0,0

local barWidth		= {202,	92,	57,	36,	26,	20}
local barSpace		= {0,	18,	16,	20,	18,	16+1/3}
local barOffset		= {
	[1] = {0},
	[2] = {0,0},
	[3] = {0,-0.5,0},
	[4] = {0,-1,-2/3,-4/3},
	[5] = {0,0,0,0,0},
	[6] = {0,0,1,0,0,0}
}
local barHeight,totalWidth,barCenter = 228,202,0

if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
if not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
if not scorelist then scorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail) end
if scorelist then topscore = scorelist:GetHighScores()[1] end

if StepsOrTrail then
	local rv = StepsOrTrail:GetRadarValues(pn)
	mines,holds,rolls = rv:GetValue('RadarCategory_Mines'),rv:GetValue('RadarCategory_Holds'),rv:GetValue('RadarCategory_Rolls')
	holdsAndRolls = holds + rolls
end

local bgNum = getenv("ShowStats"..ToEnumShortString(pn))
if bgNum == 7 then if topscore == nil then bgNum = 2 else bgNum = 3 end end
if bgNum > 0 then barCenter	= -totalWidth/2+barWidth[bgNum]/2 end

local BarLabelTexts = {"Fantastics","Excellents","Greats","Decents","Way-Offs","Misses"}
local Numbers,BarLabels,Bars = Def.ActorFrame{},Def.ActorFrame{},Def.ActorFrame{}

if getenv("ShowStats"..ToEnumShortString(pn)) < 7 then
	for i = 1,math.min(6,getenv("ShowStats"..ToEnumShortString(pn))) do
		local score = i < 6 and "W"..i or "Miss"
		Numbers[#Numbers+1] = LoadFont("ScreenGameplay judgment")..{
			Name="Numbers"..score,
			InitCommand=function(self) self:zoom(0.75):addy(100):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):shadowlength(0):maxwidth(barWidth[bgNum]*2):diffuse(TapNoteScoreToColor('TapNoteScore_'..score)):queuecommand("Update") end,
			JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
			UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_'..score)) end
		}
		BarLabels[#BarLabels+1] = LoadFont("_v 26px bold black")..{
			Text=BarLabelTexts[i],
			InitCommand=function(self) self:rotationz(-90):addy(-20):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):shadowlength(0):queuecommand("FadeOn") end,
			FadeOnCommand=function(self) self:sleep(2+(0.25*(i-1))):linear(1):diffusealpha(0) end
		}
		Bars[#Bars+1] = LoadActor("../w"..i)..{
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= i,
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
	InitCommand=function(self) self:Center() end,
	Def.ActorFrame{
		Name="JudgePane",
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end,
		OnCommand=function(self)
			if IsGame("be-mu") then
				self:x(startX+(getenv("RotationSolo"..ToEnumShortString(pn)) and 78 or 0))
				self:y(getenv("RotationSolo"..ToEnumShortString(pn)) and SCREEN_HEIGHT/6 or 0)
			elseif IsGame("po-mu") then
				self:x(startX+(getenv("RotationSolo"..ToEnumShortString(pn)) and 72 or 0))
				self:y(getenv("RotationSolo"..ToEnumShortString(pn)) and SCREEN_HEIGHT/6 or 0)
			else
				self:x(startX+(getenv("RotationSolo"..ToEnumShortString(pn)) and 64 or 0))
				self:y(getenv("RotationSolo"..ToEnumShortString(pn)) and 34 or 0)
			end
			self:zoom(getenv("RotationSolo"..ToEnumShortString(pn)) and .75 or 1)
			:addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
			:decelerate(1)
			:addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -SCREEN_WIDTH/2 or SCREEN_WIDTH/2)
		end,
		OffCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end
			self:accelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
		end,
		LoadActor("s_bg"..getenv("ShowStats"..ToEnumShortString(pn))),
		Def.ActorFrame{
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) < 7,
			Def.ActorFrame{
				OnCommand=function(self)
					self:addx(10)
					if mines == 0 then
						self:GetChild("MineName"):visible(false)
						self:GetChild("MineCounter"):visible(false)
					end
					if holdsAndRolls == 0 then
						self:GetChild("HoldName"):visible(false)
						self:GetChild("HoldCounter"):visible(false)
					else
						if holds > 0 and rolls > 0 then
							self:GetChild("HoldName"):settext("Holds/Rolls Dropped:")
						elseif holds == 0 and rolls > 0 then
							self:GetChild("HoldName"):settext("Rolls Dropped:")
						end
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
					Text="Holds Dropped:",
					OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-110) end
				},
				LoadFont("ScreenGameplay judgment")..{
					Name="MineName",
					Text="Mines Hit: ",
					OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-110) end
				},
				LoadFont("ScreenGameplay judgment")..{
					Name="HoldCounter",
					OnCommand=function(self) self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(145):addx(90) end
				},
				LoadFont("ScreenGameplay judgment")..{
					Name="MineCounter",
					OnCommand=function(self) self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(125):addx(90) end
				}
			},
			Numbers,
			Def.ActorFrame{
				Name="BarLabels",
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end,
				BarLabels
			},
			Bars
		},
		Def.ActorFrame{
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) == 7,
			LoadActor("s_bg_7"),
			Def.ActorFrame{
				Name="BarLabels",
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end,
				LoadFont("_v 26px bold black")..{
					Text=PROFILEMAN:GetPlayerName(GAMESTATE:GetMasterPlayerNumber()),
					InitCommand=function(self) self:rotationz(-90):addx(barCenter):shadowlength(0):queuecommand("FadeOn") end,
					FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end
				},
				LoadFont("_v 26px bold black")..{
					Condition=topscore ~= nil,
					Text="Highscore",
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):shadowlength(0):queuecommand("FadeOn") end,
					FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end
				},
				LoadFont("_v 26px bold black")..{
					Text="Target",
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):shadowlength(0):queuecommand("FadeOn") end,
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end
				}
			},
			LoadFont("_z bold gray 36px")..{
				Name="Pacemaker",
				Text="Pacemaker",
				OnCommand=function(self) self:horizalign(center):zoom(0.5):shadowlength(0):addy(-145) end
			},
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerName",
				Text="Player:",
				OnCommand=function(self)
					self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-100):diffuse(TapNoteScoreToColor("TapNoteScore_W1"))
					if topscore then self:maxheight(15):addy(4) end
				end
			},
			LoadFont("ScreenGameplay judgment")..{
				Condition=topscore ~= nil,
				Name="TargetName",
				Text="Highscore:",
				OnCommand=function(self)
					self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(135):addx(-100):diffuse(TapNoteScoreToColor("TapNoteScore_W3"))
					if topscore then self:maxheight(15):addy(2) end
				end
			},
			LoadFont("ScreenGameplay judgment")..{
				Name="TargetName",
				Text="Target:",
				OnCommand=function(self)
					self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-100):diffuse(TapNoteScoreToColor("TapNoteScore_Miss"))
					if topscore then self:maxheight(15) end
				end
			},
			LoadFont("_z numbers")..{
				Name="PlayerPoints",
				OnCommand=function(self)
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(145+2.5):addx(100):diffuse(PlayerColor(pn)):settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints())
					if topscore then self:maxheight(15):addy(3.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints()) end
			},
			LoadFont("_z numbers")..{
				Condition=topscore ~= nil,
				Name="HighscorePoints",
				OnCommand=function(self)
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(135+2.5):addx(100):diffuse(PlayerColor(pn)):settext(math.ceil(topscore:GetPercentDP()*STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPossibleDancePoints()))
					if topscore then self:maxheight(15):addy(1.5) end
				end
			},
			LoadFont("_z numbers")..{
				Name="TargetPoints",
				OnCommand=function(self)
					local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(125+2.5):addx(100):diffuse(PlayerColor(pn)):settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPossibleDancePoints()))
					if topscore then self:maxheight(15):addy(-0.5) end
				end
			},

			LoadFont("_z numbers")..{
				Condition=topscore ~= nil,
				Name="PlayerHighscoreDifference",
				OnCommand=function(self) self:diffuse(color("#00FF00")):maxwidth(90):horizalign(left):zoom(0.3):shadowlength(0):addy(148):addx(100):queuecommand("Update") end,
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
					self:diffuse(color("#FF0000")):maxwidth(90):horizalign(left):zoom(0.3):shadowlength(0):addy(147):addx(100):queuecommand("Update")
					if topscore then self:addy(6.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					local curPlayerDP = pss:GetActualDancePoints()
					local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					local curTargetDP = math.ceil(DPCurMax*target)
					self:settextf("%+04d",(curPlayerDP-curTargetDP))
				end
			},
			LoadActor("../w1")..{
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):zoomy(barHeight):diffusealpha(0.25):addx(barCenter):zoomx(0.01*barWidth[bgNum])
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
					self:vertalign(bottom):addy(barHeight/2):diffusealpha(0.25):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 1 or 0)):zoomx(0.01*barWidth[bgNum])
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
					local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):zoomx(0.01*barWidth[bgNum]):zoomy(target*barHeight):diffusealpha(0.25)
				end
			},
			LoadActor("../w1")..{
				InitCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter):zoomx(0.01*barWidth[bgNum]):queuecommand("Update")
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
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 1 or 0)):zoomx(0.01*barWidth[bgNum]):queuecommand("Update")
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
				InitCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):zoomx(0.01*barWidth[bgNum]):queuecommand("Update")
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					local DPMax = pss:GetPossibleDancePoints()
					local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:zoomy(DPCurMax/DPMax*target*barHeight)
				end
			}
		}
	}
}