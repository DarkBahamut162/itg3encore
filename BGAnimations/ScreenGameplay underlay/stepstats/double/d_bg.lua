local pn = ...
local SongOrCourse,StepsOrTrail,scorelist,topscore
local stats = getenv("ShowStats"..pname(pn))
local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3}
local bgNum = stats
local target = 0.5
local tmax = 0
local stepsType = StepsTypeSingle()[GetUserPrefN("StylePosition")]
local stepType = split("_",stepsType)
if getenv("SetPacemaker"..pname(pn)) == 18 then
	local sps = 0
	local song = GAMESTATE:GetCurrentSong()
	local steps = GAMESTATE:GetCurrentSteps(pn)
	if IsGame("be-mu") or IsGame("beat") then
		sps = tonumber(LoadFromCache(song,steps,"StepsPerSecond")) / 2
	else
		sps = tonumber(LoadFromCache(song,steps,"StepsPerSecond")) * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4)
	end
	sps = math.floor(sps)
	local min = (PaceMaker[pn] and PaceMaker[pn][math.floor(sps)]) and 1 or 0.5
	for pms in ivalues(PaceMaker[pn][math.floor(sps)] or {}) do
		min = math.min(min,math.max(0.5,pms))
		tmax = math.max(tmax,pms)
	end
	target = math.min(0.5,min)
else
	target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-(getenv("SetPacemaker"..pname(pn)) or 0)))
end
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
if bgNum == 7 then if topscore == nil then bgNum = 2 else bgNum = 3 end end

return Def.ActorFrame{
	Def.Sprite {
		Texture = "base",
		InitCommand=function(self) self:y(35) end
	},
	Def.ActorFrame{
		Condition=stats == 7,
		Def.Sprite {
			Texture = THEME:GetPathG("horiz-line","short"),
			InitCommand=function(self)
				self:y(-tmax*268+164):valign(0):zoomx(0.08):zoomy(0.5):diffusealpha(1):fadeleft(0.25):faderight(0.25):diffuse(color("#FF0000")):diffuseramp():effectcolor1(color("#FF000080")):effectcolor2(color("#FF0000FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
			end,
			JudgmentMessageCommand=function(self,param) if param.Player == pn and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
			UpdateCommand=function(self) self:diffusealpha(DPCur(pn) < DPMax(pn)*tmax and 1 or 0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("horiz-line","short"),
			InitCommand=function(self)
				self:y(-target*268+164):valign(0):zoomx(0.08):zoomy(0.5):diffusealpha(1):fadeleft(0.25):faderight(0.25):diffuse(color("#FF0000")):diffuseramp():effectcolor1(color("#FF000080")):effectcolor2(color("#FF0000FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
			end,
			JudgmentMessageCommand=function(self,param) if param.Player == pn and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
			UpdateCommand=function(self) self:diffusealpha(DPCur(pn) < DPMax(pn)*target and 1 or 0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("horiz-line","short"),
			Condition=topscore ~= nil,
			InitCommand=function(self)
				self:x(-barWidth[bgNum]/2):y(-PercentDP(topscore)*268+164):valign(0):zoomx(0.08/3*2):zoomy(0.5):diffusealpha(1):fadeleft(0.25):faderight(0.25):diffuse(color("#00FF00")):diffuseramp():effectcolor1(color("#00FF0080")):effectcolor2(color("#00FF00FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
			end,
			JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
			UpdateCommand=function(self) self:diffusealpha(DPCur(pn) < DPMax(pn)*PercentDP(topscore) and 1 or 0) end
		}
	},
	Def.Sprite {
		Texture = "streak",
		InitCommand=function(self) self:y(185):addy(100) end,
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addy(-100) end
	},
	Def.Sprite {
		Texture = "streak",
		InitCommand=function(self) self:y(204):addy(100) end,
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addy(-100) end
	}
}