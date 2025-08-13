if isTopScreen("ScreenDemonstration2") then return Def.ActorFrame{} end

local pn = GAMESTATE:GetMasterPlayerNumber()
local graph = getenv("ShowNoteGraph"..pname(pn)) > 1
local solo = getenv("Rotation"..pname(pn)) == 5
local startX = pn == PLAYER_1 and SCREEN_WIDTH/4 or -SCREEN_WIDTH/4
if graph and getenv("ShowStats"..pname(pn)) == 0 then startX = startX * 2 end
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
local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 18-getenv("SetPacemaker"..pname(pn))))
local TotalSteps = 0

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

local bgNum = getenv("ShowStats"..pname(pn))
if bgNum == (isOpenDDR() and 6 or 7) then if topscore == nil then bgNum = 2 else bgNum = 3 end end
if bgNum > 0 then barCenter	= -totalWidth/2+barWidth[bgNum]/2 end

local BarLabelTexts = {"Fantastics","Excellents","Greats","Decents","Way-Offs","Misses"}
local Numbers,BarLabels,Bars = Def.ActorFrame{},Def.ActorFrame{},Def.ActorFrame{}

if getenv("ShowStats"..pname(pn)) < (isOpenDDR() and 6 or 7) then
	for i = 1,math.min((isOpenDDR() and 5 or 6),getenv("ShowStats"..pname(pn))) do
		local score = i < (isOpenDDR() and 5 or 6) and "W"..i or "Miss"
		Numbers[#Numbers+1] = Def.BitmapText {
			File = "ScreenGameplay judgment",
			Name="Numbers"..score,
			InitCommand=function(self) self:zoom(0.75):addy(isFinal() and 110 or 100):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):shadowlength(0):maxwidth(barWidth[bgNum]*2):diffuse(TapNoteScoreToColor('TapNoteScore_'..score)):queuecommand("Update") end,
			JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
			UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_'..score)) end
		}
		BarLabels[#BarLabels+1] = Def.BitmapText {
			File = "_v 26px bold black",
			Text=BarLabelTexts[(isOpenDDR() and score == "Miss") and i+1 or i],
			InitCommand=function(self) self:rotationz(-90):addy(-20):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):shadowlength(0):queuecommand("FadeOn") end,
			FadeOnCommand=function(self) self:sleep(2+(0.25*(i-1))):linear(1):diffusealpha(0) end
		}
		Bars[#Bars+1] = Def.Sprite {
			Texture = "../w"..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):diffusealpha(0.25):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=getenv("ShowStats"..pname(pn)) >= i,
			JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
			UpdateCommand=function(self)
				local Percent = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPercentageOfTaps('TapNoteScore_'..score)
				self:zoomy(Percent*barHeight)
			end
		}
		Bars[#Bars+1] = Def.Sprite {
			Texture = "../w"..((isOpenDDR() and score == "Miss") and i+1 or i),
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+barOffset[bgNum][i]+(barWidth[bgNum]+barSpace[bgNum])*(i-1)):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end,
			Condition=getenv("ShowStats"..pname(pn)) >= i,
			JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
			UpdateCommand=function(self)
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
			if IsGame("be-mu") or IsGame("beat") then
				local move = pn == PLAYER_1 and 78 or -78
				self:x(startX+(solo and move*WideScreenDiff_(16/10) or 0))
				self:y(solo and SCREEN_HEIGHT/6*WideScreenDiff_(16/10) or 0)
			elseif IsGame("po-mu") then
				local move = pn == PLAYER_1 and 72 or -72
				self:x(startX+(solo and move*WideScreenDiff_(16/10) or 0))
				self:y(solo and SCREEN_HEIGHT/6*WideScreenDiff_(16/10) or 0)
			else
				local move = pn == PLAYER_1 and 64 or -64
				self:x(startX+(solo and move*WideScreenDiff_(16/10) or 0))
				self:y(solo and 34*WideScreenDiff_(16/10) or 0)
			end
			if graph then
				local plus = pn == PLAYER_1 and 72 or -72
				self:addx(solo and plus/2*WideScreenDiff_(16/10) or plus*WideScreenDiff_(16/10))
			end
			self:zoom(solo and 0.75*WideScreenDiff_(16/10) or 1*WideScreenDiff_(16/10))
			:addx(pn == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
			:decelerate(1)
			:addx(pn == PLAYER_1 and -SCREEN_WIDTH/2 or SCREEN_WIDTH/2)
		end,
		OffCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end
			self:accelerate(0.8):addx(pn == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
		end,
		loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(pn)..{
			Condition=graph,
			InitCommand=function(self)
				if not isFinal() then self:zoomx(0.95):zoomy(0.85) end
				local move = solo and 5 or 66
				if getenv("ShowStats"..pname(pn)) == 0 then self:addx(pn == PLAYER_1 and move or -move) end
			end
		},
		Def.ActorFrame{
			Condition=getenv("ShowStats"..pname(pn)) > 0,
			Def.Sprite {
				Texture = "s_"..(isFinal() and "final" or "normal")
			},
			Def.Sprite {
				Texture = (isOpenDDR() and "ddr_bg" or "s_bg")..getenv("ShowStats"..pname(pn))
			},
			Def.Sprite {
				Texture = "s_glow final",
				Condition=isFinal(),
				InitCommand=function(self) self:blend(Blend.Add):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
			}
		},
		Def.ActorFrame{
			Condition=getenv("ShowStats"..pname(pn)) > 0 and getenv("ShowStats"..pname(pn)) < (isOpenDDR() and 6 or 7),
			Def.BitmapText {
				File = "_z bold gray 36px",
				Condition=isFinal(),
				Name="Statistics",
				Text="Statistics",
				OnCommand=function(self) self:zoom(0.5):shadowlength(0):addy(isFinal() and -174 or -164.5) end
			},
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
					OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(isFinal() and 155 or 145):addx(-110) end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="MineName",
					Text="Mines Hit: ",
					OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(isFinal() and 135 or 125):addx(-110) end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="HoldCounter",
					OnCommand=function(self) self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(isFinal() and 155 or 145):addx(90) end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="MineCounter",
					OnCommand=function(self) self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(isFinal() and 135 or 125):addx(90) end
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
			Condition=getenv("ShowStats"..pname(pn)) == (isOpenDDR() and 6 or 7),
			InitCommand=function(self) self:y(isFinal() and -19 or 0) end,
			Def.Sprite {
				Texture = THEME:GetPathG("horiz-line","short"),
				InitCommand=function(self)
					self:y(-target*barHeight+barHeight/2):valign(0):zoomx(1.25):zoomy(0.5):diffusealpha(0.5):fadeleft(0.25):faderight(0.25):diffuse(color("#FF0000")):diffuseramp():effectcolor1(color("#FF000080")):effectcolor2(color("#FF0000FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
				UpdateCommand=function(self) self:diffusealpha(DPCur(pn) < DPMax(pn)*target and 1 or 0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("horiz-line","short"),
				Condition=topscore ~= nil,
				InitCommand=function(self)
					self:x(-barWidth[bgNum]/2):y(-PercentDP(topscore)*barHeight+barHeight/2):valign(0):zoomx(1.25/3*2):zoomy(0.5):diffusealpha(0.5):fadeleft(0.25):faderight(0.25):diffuse(color("#00FF00")):diffuseramp():effectcolor1(color("#00FF0080")):effectcolor2(color("#00FF00FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore ~= nil and self:GetDiffuseAlpha() == 1 then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:diffusealpha(DPCur(pn) < DPMax(pn)*PercentDP(topscore) and 1 or 0)
				end
			},
			Def.Sprite {
				Texture = "s_glow final",
				Condition=isFinal(),
				InitCommand=function(self) self:blend(Blend.Add):y(19):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
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
			Def.BitmapText {
				File = "_z bold gray 36px",
				Name="Pacemaker",
				Text="Pacemaker",
				OnCommand=function(self) self:zoom(0.5):shadowlength(0):addy(isFinal() and -154.5 or -145) end
			},
			Def.ActorFrame{
				InitCommand=function(self) self:y(isFinal() and (topscore and -35 or 20) or 0):zoomy(isFinal() and (topscore and 1.33 or 1) or 1) end,
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="PlayerName",
					Text="Player:",
					OnCommand=function(self)
						self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-100):diffuse(TapNoteScoreToColor("TapNoteScore_W1"))
						if topscore then self:maxheight(15):addy(4) end
					end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Condition=topscore ~= nil,
					Name="TargetName",
					Text="Highscore:",
					OnCommand=function(self)
						self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(135):addx(-100):diffuse(TapNoteScoreToColor("TapNoteScore_W3"))
						if topscore then self:maxheight(15):addy(2) end
					end
				},
				Def.BitmapText {
					File = "ScreenGameplay judgment",
					Name="TargetName",
					Text="Target:",
					OnCommand=function(self)
						self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-100):diffuse(TapNoteScoreToColor("TapNoteScore_Miss"))
						if topscore then self:maxheight(15) end
					end
				},
				Def.BitmapText {
					File = "_z numbers",
					Name="PlayerPoints",
					OnCommand=function(self)
						self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(145+2.5):addx(100):diffuse(PlayerColor(pn)):settext(DPCur(pn))
						if topscore then self:maxheight(15):addy(3.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
					UpdateCommand=function(self) self:settext(math.round(DPCur(pn))) end
				},
				Def.BitmapText {
					File = "_z numbers",
					Condition=topscore ~= nil,
					Name="HighscorePoints",
					OnCommand=function(self)
						self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(135+2.5):addx(100):diffuse(PlayerColor(pn)):settext(math.ceil(PercentDP(topscore)*StepCounter()))
						if topscore then self:maxheight(15):addy(1.5) end
					end
				},
				Def.BitmapText {
					File = "_z numbers",
					Name="TargetPoints",
					OnCommand=function(self)
						self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(125+2.5):addx(100):diffuse(PlayerColor(pn)):settext(math.ceil(target*StepCounter()))
						if topscore then self:maxheight(15):addy(-0.5) end
					end
				},
			},
			Def.Sprite {
				Texture = "../w1",
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):zoomy(barHeight):diffusealpha(0.25):addx(barCenter):zoomx(0.01*barWidth[bgNum])
					if topscore == nil then self:cropright(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:zoomy(((DPMax(pn)-(DPCurMax(pn)-DPCur(pn)))/DPMax(pn))*barHeight)
				end
			},
			Def.Sprite {
				Texture = "../w3",
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):diffusealpha(0.25):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 1 or 0)):zoomx(0.01*barWidth[bgNum])
					if topscore ~= nil then self:zoomy(PercentDP(topscore)*barHeight) else self:zoomy(barHeight):cropleft(0.5) end
				end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn and topscore == nil then self:queuecommand("Update") end end,
				UpdateCommand=function(self)
					self:zoomy(((DPMax(pn)-(DPCurMax(pn)-DPCur(pn)))/DPMax(pn))*barHeight)
				end
			},
			Def.Sprite {
				Texture = "../w6",
				OnCommand=function(self)
					self:vertalign(bottom):addy(barHeight/2):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*(topscore ~= nil and 2 or 1)):zoomx(0.01*barWidth[bgNum]):zoomy(target*barHeight):diffusealpha(0.25)
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
		}
	}
}