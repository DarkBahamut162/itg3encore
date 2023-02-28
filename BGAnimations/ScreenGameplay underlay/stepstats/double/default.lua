local pn = GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20-SCREEN_WIDTH/2) or (SCREEN_LEFT+34-SCREEN_WIDTH/4*3)
local SongOrCourse, StepsOrTrail, scorelist, topscore

local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3}
local barHeight		= 268
local totalWidth	= 14
local barCenter		= 0

if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
if not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
if not scorelist then scorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail) end
if scorelist then topscore = scorelist:GetHighScores()[1] end

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
		InitCommand=function(self) self:x(xPos):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and 100 or -100) end,
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end,
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -100 or 100) end,
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and 100 or -100) end,
		LoadActor("d_bg"),
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
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..pname(pn))))
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
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..pname(pn))))
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPCurMax = pss:GetCurrentPossibleDancePoints()
					local DPMax = pss:GetPossibleDancePoints()
					self:zoomy(DPCurMax/DPMax*target*barHeight)
				end
			}
		}
	}
}