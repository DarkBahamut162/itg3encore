if isTopScreen("ScreenDemonstration2") then return Def.ActorFrame{} end

local pn = ...
local players = GAMESTATE:GetNumPlayersEnabled()
local graph = (getenv("PlayerNoteGraph"..pname(pn)) or 0) > 1
local solo = getenv("Rotation"..pname(pn)) == 5 or getenv("ForceCutin")
local startX = SCREEN_CENTER_X
local SongOrCourse,StepsOrTrail,scorelist,topscore
local mines,holds,rolls,holdsAndRolls = 0,0,0,0
local bgNum = getenv("ShowStats"..pname(pn)) or 0
local size = getenv("ShowStatsSize"..pname(pn)) or 0

local barWidth		= {202,	92,	57,	36,	26,	20,     16}
local barSpace		= {0,	18,	16,	20,	18,	16+1/3, 15}
local barOffset		= {
	[1] = {0},
	[2] = {0,0},
	[3] = {0,-0.5,0},
	[4] = {0,-1,-2/3,-4/3},
	[5] = {0,0,0,0,0},
	[6] = {0,0,1,0,0,0},
	[7] = {0,0,0,0,0,0,0}
}

for i=1, 7 do
    barWidth[i] = barWidth[i] * 0.5
    barSpace[i] = barSpace[i] * 0.5
end
if players == 1 then
	if size == 2 then
		startX = THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX") / 8
		if pn == PLAYER_2 then startX = SCREEN_WIDTH - startX end
	else
		if pn == PLAYER_1 then
			startX = THEME:GetMetric(Var "LoadingScreen","PlayerP2OnePlayerOneSideX")
		else
			startX = THEME:GetMetric(Var "LoadingScreen","PlayerP1OnePlayerOneSideX")
		end
	end
else
	startX = startX + (pn == PLAYER_1 and -45 or 45)
end

local barHeight,totalWidth,barCenter = 228,202,0
barHeight = barHeight * 1.1
totalWidth = totalWidth * 0.5
local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-(getenv("SetPacemaker"..pname(pn)) or 0)))
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
		mines = RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_Mines")
		holds = RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_Holds")
		rolls = RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_Rolls")
		TotalSteps = RadarCategory_Trail(StepsOrTrail,pn,"RadarCategory_TapsAndHolds")
	else
		local rv = StepsOrTrail:GetRadarValues(pn)
		mines,holds,rolls = rv:GetValue('RadarCategory_Mines'),rv:GetValue('RadarCategory_Holds'),rv:GetValue('RadarCategory_Rolls')
		TotalSteps =  rv:GetValue("RadarCategory_TapsAndHolds")
	end
	holdsAndRolls = holds + rolls
end

if bgNum == (isOpenDDR() and 6 or 7) then
	if topscore == nil then bgNum = 2 else bgNum = 3 end
else
	if faplus then bgNum = bgNum + 1 end
end
if bgNum > 0 then barCenter	= -totalWidth/2+barWidth[bgNum]/2 end

local BarLabelTexts = {"Fantastics","Excellents","Greats","Decents","Way-Offs","Misses"}
BarLabelTexts[0] = "Fantastics+"
local Numbers,BarLabels,Bars = Def.ActorFrame{},Def.ActorFrame{},Def.ActorFrame{}
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

local function TNS(score)
	return score == "W0" and "TapNoteScore_W1" or "TapNoteScore_W0"
end

if (getenv("ShowStats"..pname(pn)) or 0) < (isOpenDDR() and 6 or 7) then
	for i = faplus and 0 or 1,math.min((isOpenDDR() and 5 or 6),getenv("ShowStats"..pname(pn)) or 0) do
		local score = i < (isOpenDDR() and 5 or 6) and "W"..i or "Miss"
		Numbers[#Numbers+1] = Def.BitmapText {
			Name="NumbersW"..i,
			File = "ScreenGameplay judgment",
			Text=0,
			InitCommand=function(self) self:zoom(0.75):addy(140):addx(barCenter+barOffset[bgNum][faplus and i+1 or i]+(barWidth[bgNum]+barSpace[bgNum])*(faplus and i or i-1)):shadowlength(0):maxwidth(barWidth[bgNum]*2):diffuse(TapNoteScoreToColor((faplus and i < 2) and TNS(score) or 'TapNoteScore_'..score)) end,
			JudgmentMessageCommand=function(self,param) if param.Player == pn and not (faplus and i < 2) then self:queuecommand("Update") end end,
			W0MessageCommand=function(self,param)
				if param.Player == pn then
					if self:GetName() == "NumbersW0" then self:settext(param.W0) end
					if self:GetName() == "NumbersW1" then self:settext(param.W1) end
				end
			end,
			UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_'..score)) end
		}
		BarLabels[#BarLabels+1] = Def.BitmapText {
			File = "_v 26px bold black",
			Text=BarLabelTexts[(isOpenDDR() and score == "Miss") and i+1 or i],
			InitCommand=function(self) self:rotationz(-90):addy(-20):zoom(0.6):addx(barCenter+barOffset[bgNum][faplus and i+1 or i]+(barWidth[bgNum]+barSpace[bgNum])*(faplus and i or i-1)):shadowlength(0):queuecommand("FadeOn") end,
			FadeOnCommand=function(self) self:sleep(2+(0.25*(faplus and i or i-1))):linear(1):diffusealpha(0) end
		}
		Bars[#Bars+1] = Def.Sprite {
			Name="PercentW"..i,
			Texture = "../"..(faplus and "dfa" or "d")..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+barOffset[bgNum][faplus and i+1 or i]+(barWidth[bgNum]+barSpace[bgNum])*(faplus and i or i-1)):addy(124):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=getenv("ShowStats"..pname(pn)) >= i,
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
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+barOffset[bgNum][faplus and i+1 or i]+(barWidth[bgNum]+barSpace[bgNum])*(faplus and i or i-1)):addy(124):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=getenv("ShowStats"..pname(pn)) >= i,
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
	InitCommand=function(self) self:CenterY() end,
	Def.ActorFrame{
		Name="JudgePane",
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end,
		OnCommand=function(self)
			local move = SCREEN_WIDTH/2
            self:x(startX):y(-16):zoom(solo and 0.75 or 0.9)
			if players == 2 or size == 2 then self:zoomx(0.65):addx(graph and (pn == PLAYER_1 and -32 or 32) or 0) end
			if players == 2 or size == 2 then move = move * -1 end
			self:addx(pn == PLAYER_1 and move or -move):decelerate(1):addx(pn == PLAYER_1 and -move or move)
		end,
		OffCommand=function(self)
			local move = SCREEN_WIDTH/2
			if players == 2 or size == 2 then move = move * -1 end
			if AnyPlayerFullComboed() then self:sleep(1) end
			self:accelerate(0.8):addx(pn == PLAYER_1 and move or -move)
		end,
		loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(size == 2 and OtherPlayer[pn] or pn)..{
			Condition=graph,
			InitCommand=function(self)
				self:x(pn == PLAYER_1 and 2 or -2):y(15):zoomx(0.5)
			end
		},
		Def.ActorFrame{
			Condition=(getenv("ShowStats"..pname(pn)) or 0) > 0,
			Def.Sprite { Texture = GetIIDXFrame(pn) }
		},
		Def.ActorFrame{
			Condition=(getenv("ShowStats"..pname(pn)) or 0) > 0 and (getenv("ShowStats"..pname(pn)) or 0) < (isOpenDDR() and 6 or 7),
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
				
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="HoldName",
					Text="Holds Dropped:",
					OnCommand=function(self) self:maxwidth(100):horizalign(left):zoom(0.6):shadowlength(0):addy(185):addx(-70) end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="MineName",
					Text="Mines Hit: ",
					OnCommand=function(self) self:maxwidth(100):horizalign(left):zoom(0.6):shadowlength(0):addy(165):addx(-70) end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="HoldCounter",
					OnCommand=function(self) self:maxwidth(100):horizalign(right):zoom(0.6):shadowlength(0):addy(185):addx(50) end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="MineCounter",
					OnCommand=function(self) self:maxwidth(100):horizalign(right):zoom(0.6):shadowlength(0):addy(165):addx(50) end
				}
			},
			Numbers,
			Bars,
			Def.ActorFrame{
				Name="BarLabels",
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end,
				BarLabels
			}
		},
		Def.ActorFrame{
			Condition=getenv("ShowStats"..pname(pn)) == (isOpenDDR() and 6 or 7),
			InitCommand=function(self) self:y(-2) end,
			
			Def.Sprite {
				Texture = "../d1",
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):zoomy(barHeight):addx(barCenter):zoomx(0.01*barWidth[bgNum])
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:zoomy(((DPMax(pn)-(DPCurMax(pn)-DPCur(pn)))/DPMax(pn))*barHeight)
				end
			},
			Def.Sprite {
				Texture = "../d3",
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 1 or 0)):zoomx(0.01*barWidth[bgNum])
					if topscore ~= nil then self:zoomy(PercentDP(topscore)*barHeight) else self:zoomy(barHeight):cropleft(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore == nil then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:zoomy(((DPMax(pn)-(DPCurMax(pn)-DPCur(pn)))/DPMax(pn))*barHeight)
				end
			},
			Def.Sprite {
				Texture = "../d6",
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):zoomx(0.01*barWidth[bgNum]):zoomy(target*barHeight)
				end
			},
			Def.Sprite {
				Texture = "../w1",
				InitCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter):zoomx(0.01*barWidth[bgNum]):queuecommand("Update")
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:zoomy(DP(pn)*barHeight)
				end
			},
			Def.Sprite {
				Texture = "../w3",
				InitCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 1 or 0)):zoomx(0.01*barWidth[bgNum]):queuecommand("Update")
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
				InitCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):zoomx(0.01*barWidth[bgNum]):queuecommand("Update")
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:zoomy(DPCurMax(pn)/DPMax(pn)*target*barHeight) end
			},

			Def.BitmapText {
				File = "_z numbers",
				Condition=topscore ~= nil,
				Name="PlayerHighscoreDifference",
				OnCommand=function(self) self:diffuse(color("#00FF00")):maxwidth(barWidth[bgNum]*2):zoom(0.5):shadowlength(0):x(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 1 or 0)):queuecommand("Update") end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil then self:queuecommand("Update") end end,
				UpdateCommand=function(self)

					local curHighscoreDP = math.ceil(DPCurMax(pn)*PercentDP(topscore))

					local addX = (curHighscoreDP/DPMax(pn))*barHeight
					local score = (DPCur(pn)-curHighscoreDP)
					self:settextf("%+04d",score)
					if score >= 0 then 
						self:diffuse(color("#00FF00")):y((barHeight/2-addX-6))
					else
						self:diffuse(color("#008000")):y((barHeight/2-addX+6))
					end
				end
			},
			Def.BitmapText {
				File = "_z numbers",
				Name="PlayerTargetDifference",
				OnCommand=function(self)
					self:diffuse(color("#FF0000")):maxwidth(barWidth[bgNum]*2):zoom(0.5):shadowlength(0):x(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):queuecommand("Update")
					if topscore then self:addy(6.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					local curTargetDP = math.ceil(DPCurMax(pn)*target)
					
					
					local addX = (curTargetDP/DPMax(pn))*barHeight
					local score = DPCur(pn)-curTargetDP
					self:settextf("%+04d",score)
					if score >= 0 then 
						self:diffuse(color("#FF0000")):y((barHeight/2-addX-6))
					else
						self:diffuse(color("#800000")):y((barHeight/2-addX+6))
					end
				end
			},

			Def.Sprite {
				Texture = THEME:GetPathG("horiz-line","short"),
				InitCommand=function(self)
					self:y(-target*barHeight+barHeight/2):valign(1):zoomx(0.65):zoomy(0.5):fadeleft(0.25):faderight(0.25):diffuse(color("#FF0000")):diffuseramp():effectcolor1(color("#FF000080")):effectcolor2(color("#FF0000FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:diffusealpha(DPCur(pn) < DPMax(pn)*target and 1 or 0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("horiz-line","short"),
				Condition=topscore ~= nil,
				InitCommand=function(self)
					self:x(-barWidth[bgNum]/2):y(-PercentDP(topscore)*barHeight+barHeight/2):valign(1):zoomx(0.65/3*2):zoomy(0.5):fadeleft(0.25):faderight(0.25):diffuse(color("#00FF00")):diffuseramp():effectcolor1(color("#00FF0080")):effectcolor2(color("#00FF00FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:diffusealpha(DPCur(pn) < DPMax(pn)*PercentDP(topscore) and 1 or 0)
				end
			},
			Def.ActorFrame{
				Name="BarLabels",
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end,
				Def.BitmapText {
					File = "_v 26px bold black",
					Text=PROFILEMAN:GetPlayerName(pn),
					InitCommand=function(self) self:rotationz(-90):addx(barCenter):shadowlength(0):queuecommand("FadeOn") end,
					FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_v 26px bold black",
					Condition=topscore ~= nil,
					Text="Highscore",
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):shadowlength(0):queuecommand("FadeOn") end,
					FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_v 26px bold black",
					Text="Target",
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):shadowlength(0):queuecommand("FadeOn") end,
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				InitCommand=function(self) self:y(0):zoomy(1) end,
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="PlayerName",
					Text="Player:",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(left):zoom(0.6):shadowlength(0):addy(165):addx(-60):diffuse(TapNoteScoreToColor("TapNoteScore_W1"))
						if topscore then self:addy(20) end
					end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Condition=topscore ~= nil,
					Name="TargetName",
					Text="Highscore:",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(left):zoom(0.6):shadowlength(0):addy(155):addx(-60):diffuse(TapNoteScoreToColor("TapNoteScore_W3"))
						if topscore then self:addy(10) end
					end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="TargetName",
					Text="Target:",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(left):zoom(0.6):shadowlength(0):addy(145):addx(-60):diffuse(TapNoteScoreToColor("TapNoteScore_Miss"))
					end
				},
				Def.BitmapText {
					File = "_z numbers",
					Name="PlayerPoints",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(right):zoom(0.6):shadowlength(0):addy(165):addx(60):diffuse(PlayerColor(pn)):settext(DPCur(pn))
						if topscore then self:addy(20) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
					UpdateCommand=function(self) self:settext(math.round(DPCur(pn))) end
				},
				Def.BitmapText {
					File = "_z numbers",
					Condition=topscore ~= nil,
					Name="HighscorePoints",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(right):zoom(0.6):shadowlength(0):addy(155):addx(60):diffuse(PlayerColor(pn)):settext(math.ceil(PercentDP(topscore)*StepCounter()))
						if topscore then self:addy(10) end
					end
				},
				Def.BitmapText {
					File = "_z numbers",
					Name="TargetPoints",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(right):zoom(0.6):shadowlength(0):addy(145):addx(60):diffuse(PlayerColor(pn)):settext(math.ceil(target*StepCounter()))
					end
				},
			}
		}
	}
}