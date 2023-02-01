local barWidth		= {28	,12	,8	,6		,4	,3}
local barSpace		= {2	,4	,2	,1.5	,2	,2}
local barOffset		= {
	[1] = {0},
	[2] = {0,0},
	[3] = {0,0,0},
	[4] = {0,0,0,0},
	[5] = {0,0,0,0,0},
	[6] = {0,1,0,0,0,0}
}
local barHeight		= 82
local totalWidth	= 28

local SongOrCourse, StepsOrTrail, scorelist, topscore = {},{},{},{}
local barCenter,bgNum = {},{}
local IIDX = false

if getenv("ShowStatsP1") == nil or getenv("ShowStatsP2") == nil then return Def.ActorFrame{} else
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsCourseMode() then SongOrCourse[pn],StepsOrTrail[pn] = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse[pn],StepsOrTrail[pn] = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
		if not scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then scorelist[pn] = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn]) end
		if not scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then scorelist[pn] = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn]) end
		if scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then topscore[pn] = scorelist[pn]:GetHighScores()[1] end
		if getenv("ShowStatsP1") == 7 and getenv("ShowStatsP2") == 7 then
			if topscore[pn] == nil then bgNum[pn] = 4 else bgNum[pn] = 6 end
			IIDX, barCenter[pn] = true, -totalWidth/2+barWidth[bgNum[pn]]/2
		else
			bgNum[pn] = math.min(6,getenv("ShowStats"..ToEnumShortString(pn)))
			if bgNum[pn] > 0 then barCenter[pn] = -totalWidth/2+barWidth[bgNum[pn]]/2 end
		end
	end

	local t = Def.ActorFrame{
		OnCommand=function(self)
			self:Center()
			if IsGame("be-mu") then
				self:zoomx(0.66)
			elseif IsGame("po-mu") then
				self:zoomx(0.77)
			end
		end
	}

	if not isRave() and not IIDX then
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			local Bars = Def.ActorFrame{}
			for i = 1,bgNum[pn] do
				local score = i < 6 and "W"..i or "Miss"
				Bars[#Bars+1] = LoadActor("../w"..i)..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]+barOffset[bgNum[pn]][i]+(barWidth[bgNum[pn]]+barSpace[bgNum[pn]])*(i-1)):addy(-111):zoomx(0.01*barWidth[bgNum[pn]]):zoomy(0) end,
					Condition=bgNum[pn] >= i,
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end,
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local Notes = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_'..score)
						self:zoomy(Notes/TotalSteps*barHeight)
					end
				}
			end

			t[#t+1] = Def.ActorFrame{
				Name="Player"..ToEnumShortString(pn),
				InitCommand=function(self)
					self:x(pn == PLAYER_1 and SCREEN_LEFT+20-SCREEN_WIDTH/2 or SCREEN_RIGHT-20-SCREEN_WIDTH/2)
					:addx(pn == PLAYER_1 and -100 or 100)
					:zoomx(pn == PLAYER_1 and -1 or 1) end,
				Condition=GAMESTATE:IsHumanPlayer(pn) and bgNum[pn] > 0,
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(pn == PLAYER_1 and 100 or -100) end,
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addx(pn == PLAYER_1 and -100 or 100) end,
				LoadActor("v_bg" .. bgNum[pn])..{ InitCommand=function(self) self:vertalign(bottom):y(-111+1) end },
				LoadActor("v_bg" .. bgNum[pn])..{ InitCommand=function(self) self:vertalign(bottom):y(-111+1):diffuse(color("#00000080")) end },
				Bars
			}
		end

		local Judgments = Def.ActorFrame{}
		local diffuses = {color("#60B5C7"),color("#FEA859"),color("#4AB812"),color("#D064FB"),color("#F76D47"),color("#FB0808")}
		local texts = {"F","E","G","D","W","M"}
		for i = 1,math.max(bgNum[PLAYER_1],bgNum[PLAYER_2]) do
			Judgments[#Judgments+1] = LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:shadowlength(1):y(SCREEN_TOP+92+15*(i-1)-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(diffuses[i]):settext(texts[i]) end
			}
		end

		t[#t+1] = Def.ActorFrame{
			Name="Labels",
			InitCommand=function(self) self:y(isRave() and -10 or 0):diffusealpha(0) end,
			Condition=bgNum[PLAYER_1] > 0 or bgNum[PLAYER_2] > 0,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end,
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):diffusealpha(0) end,
			Judgments
		}

		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			local Numbers = Def.ActorFrame{}
			for i = 1,math.max(bgNum[PLAYER_1],bgNum[PLAYER_2]) do
				local score = i < 6 and "W"..i or "Miss"
				Numbers[#Numbers+1] = LoadFont("_z numbers")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*(i-1)-SCREEN_HEIGHT/2)
						:zoom(0.6):maxwidth(SCREEN_WIDTH/4.5):horizalign(pn == PLAYER_1 and right or left):queuecommand("Update") end,
					Condition=bgNum[PLAYER_1] >= i or bgNum[PLAYER_2] >= i,
					UpdateCommand=function(self)
						self:diffuse(PlayerColor(pn))
						if bgNum[pn] < i and bgNum[pn == PLAYER_1 and PLAYER_2 or PLAYER_1] >= i then
							self:settext("?")
						else
							local Notes = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores('TapNoteScore_'..score)
							self:settext(Notes)
						end
					end
				}
			end

			t[#t+1] = Def.ActorFrame{
				Name="Numbers"..ToEnumShortString(pn),
				InitCommand=function(self) self:y(isRave() and -10 or 0):diffusealpha(0) end,
				Condition=bgNum[PLAYER_1] > 0 or bgNum[PLAYER_2] > 0,
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end,
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):diffusealpha(0) end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end) end end,
				Numbers
			}
		end
	elseif not isRave() and IIDX then
		local barWidth		= {202,	92,	57,	36,		26,	20}
		local barSpace		= {0,	18,	16,	19.5,	18,	16+1/3}
		local barHeight		= 228
		local totalWidth	= 202
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do barCenter[pn] = -totalWidth/2+barWidth[bgNum[pn]]/2 end
		t[#t+1] = Def.ActorFrame{
			OnCommand=function(self) self:zoomx(isFinal() and 3/5 or 2/3) end,
			LoadActor("../single/s_"..(isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:y(isFinal() and -14 or 0):zoomy(isFinal() and 0.75 or 1) end
			},
			LoadFont("_z bold gray 36px")..{
				Name="Pacemaker",
				Text="Pacemaker",
				OnCommand=function(self) self:horizalign(center):zoom(0.5):shadowlength(0):addy(-145) end
			},
			
			Def.ActorFrame{
				InitCommand=function(self) self:y(isFinal() and -28 or 0):zoomy(isFinal() and 0.75 or 1) end,
				LoadActor("../single/s_bg7"),
				LoadActor("../single/s_bg_7")..{
					InitCommand=function(self) self:cropleft(0.025):cropright(0.025):diffusealpha(0.5) end
				},
				LoadActor("../single/s_glow final")..{
					Condition=isFinal(),
					InitCommand=function(self) self:blend(Blend.Add):y(19):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
				},
				LoadActor("../w6")..{
					OnCommand=function(self)
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
						self:vertalign(bottom):addx(barCenter[PLAYER_1]):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_1]]):zoomy(target*barHeight):diffusealpha(0.25)
					end
				},
				LoadActor("../w3")..{
					OnCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*1):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_1]]):zoomy(barHeight):diffusealpha(0.25)
						if topscore[PLAYER_1] ~= nil then self:zoomy(topscore[PLAYER_1]:GetPercentDP()*barHeight) else self:cropright(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 and topscore[PLAYER_1] == nil then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local DPMax = pss:GetPossibleDancePoints()
						local DP = pss:GetActualDancePoints()
						self:zoomy(((DPMax-(DPCurMax-DP))/DPMax)*barHeight)
					end
				},
				LoadActor("../w1")..{
					OnCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*(topscore[PLAYER_1] ~= nil and 2 or 1)):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_1]]):zoomy(barHeight):diffusealpha(0.25)
						if topscore[PLAYER_1] == nil then self:cropleft(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local DPMax = pss:GetPossibleDancePoints()
						local DP = pss:GetActualDancePoints()
						self:zoomy(((DPMax-(DPCurMax-DP))/DPMax)*barHeight)
					end
				},
				LoadActor("../w1")..{
					OnCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*bgNum[PLAYER_2]/2):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_2]]):zoomy(barHeight):diffusealpha(0.25)
						if topscore[PLAYER_2] == nil then self:cropright(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local DPMax = pss:GetPossibleDancePoints()
						local DP = pss:GetActualDancePoints()
						self:zoomy(((DPMax-(DPCurMax-DP))/DPMax)*barHeight)
					end
				},
				LoadActor("../w3")..{
					OnCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2+(topscore[PLAYER_2] ~= nil and 1 or 0))):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_2]]):zoomy(barHeight):diffusealpha(0.25)
						if topscore[PLAYER_2] ~= nil then self:zoomy(topscore[PLAYER_2]:GetPercentDP()*barHeight) else self:cropleft(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 and topscore[PLAYER_2] == nil then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local DPMax = pss:GetPossibleDancePoints()
						local DP = pss:GetActualDancePoints()
						self:zoomy(((DPMax-(DPCurMax-DP))/DPMax)*barHeight)
					end
				},
				LoadActor("../w6")..{
					OnCommand=function(self)
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
						self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2+(topscore[PLAYER_2] ~= nil and 2 or 1))):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_2]]):zoomy(target*barHeight):diffusealpha(0.25)
					end
				},

				LoadActor("../w6")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*0):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_1]]):zoomy(0) end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local DPMax = pss:GetPossibleDancePoints()
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
						self:zoomy(DPCurMax/DPMax*target*barHeight)
					end
				},
				LoadActor("../w3")..{
					InitCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*1):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_1]]):zoomy(0)
						if topscore[PLAYER_1] == nil then self:cropright(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						if topscore[PLAYER_1] then
							local DPMax = pss:GetPossibleDancePoints()
							self:zoomy(DPCurMax/DPMax*topscore[PLAYER_1]:GetPercentDP()*barHeight)
						else
							local DP = pss:GetPercentDancePoints()
							self:zoomy(DP*barHeight)
						end
					end
				},
				LoadActor("../w1")..{
					InitCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*(topscore[PLAYER_1] ~= nil and 2 or 1)):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_1]]):zoomy(0)
						if topscore[PLAYER_1] == nil then self:cropleft(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DP = pss:GetPercentDancePoints()
						self:zoomy(DP*barHeight)
					end
				},
				LoadActor("../w1")..{
					InitCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2)):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_2]]):zoomy(0)
						if topscore[PLAYER_2] == nil then self:cropright(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DP = pss:GetPercentDancePoints()
						self:zoomy(DP*barHeight)
					end
				},
				LoadActor("../w3")..{
					InitCommand=function(self)
						self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2+(topscore[PLAYER_2] ~= nil and 1 or 0))):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_2]]):zoomy(0)
						if topscore[PLAYER_2] == nil then self:cropleft(0.5) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						if topscore[PLAYER_2] then
							local DPMax = pss:GetPossibleDancePoints()
							self:zoomy(DPCurMax/DPMax*topscore[PLAYER_2]:GetPercentDP()*barHeight)
						else
							local DP = pss:GetPercentDancePoints()
							self:zoomy(DP*barHeight)
						end
					end
				},
				LoadActor("../w6")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2+(topscore[PLAYER_2] ~= nil and 2 or 1))):addy(barHeight/2):zoomx(0.01*barWidth[bgNum[PLAYER_2]]):zoomy(0) end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local DPMax = pss:GetPossibleDancePoints()
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
						self:zoomy(DPCurMax/DPMax*target*barHeight)
					end
				},
				Def.ActorFrame{
					Name="BarLabels",
					InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end,
					LoadFont("_v 26px bold black")..{
						Text="Target P1",
						InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_1]):shadowlength(0):queuecommand("FadeOn") end,
						FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end
					},
					LoadFont("_v 26px bold black")..{
						Condition=topscore[PLAYER_1] ~= nil,
						Text="Highscore P1",
						InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*1):shadowlength(0):queuecommand("FadeOn") end,
						FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end
					},
					LoadFont("_v 26px bold black")..{
						Text=PROFILEMAN:GetPlayerName(PLAYER_1),
						InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_1]+(barWidth[bgNum[PLAYER_1]]+barSpace[bgNum[PLAYER_1]])*(topscore[PLAYER_1] ~= nil and 2 or 1)):shadowlength(0):queuecommand("FadeOn") end,
						FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end
					},
					LoadFont("_v 26px bold black")..{
						Text=PROFILEMAN:GetPlayerName(PLAYER_2),
						InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2)):shadowlength(0):queuecommand("FadeOn") end,
						FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end
					},
					LoadFont("_v 26px bold black")..{
						Condition=topscore[PLAYER_2] ~= nil,
						Text="Highscore P2",
						InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2+(topscore[PLAYER_2] ~= nil and 1 or 0))):shadowlength(0):queuecommand("FadeOn") end,
						FadeOnCommand=function(self) self:sleep(2.75):linear(1):diffusealpha(0) end
					},
					LoadFont("_v 26px bold black")..{
						Text="Target P2",
						InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_2]+(barWidth[bgNum[PLAYER_2]]+barSpace[bgNum[PLAYER_2]])*(bgNum[PLAYER_2]/2+(topscore[PLAYER_2] ~= nil and 2 or 1))):shadowlength(0):queuecommand("FadeOn") end,
						FadeOnCommand=function(self) self:sleep(3):linear(1):diffusealpha(0) end
					}
				}
			},
			Def.ActorFrame{
				InitCommand=function(self) self:y(isFinal() and -50 or 0) end,
				LoadFont("ScreenGameplay judgment")..{
					Name="PlayerName",
					OnCommand=function(self) self:maxwidth(125):horizalign(center):zoom(0.75):shadowlength(0):addy(145):settext("P"):diffuse(Color("Blue")) end
				},
				LoadFont("ScreenGameplay judgment")..{
					Name="TargetName",
					OnCommand=function(self) self:maxwidth(125):horizalign(center):zoom(0.75):shadowlength(0):addy(125):settext("T"):diffuse(Color("Red")) end
				},

				LoadFont("_z numbers")..{
					Name="PlayerPointsP1",
					Text="0",
					OnCommand=function(self)
						self:maxwidth(90):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-100):diffuse(PlayerColor(PLAYER_1))
						:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints())
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints()) end
				},
				LoadFont("_z numbers")..{
					Name="TargetPointsP1",
					Text="0",
					OnCommand=function(self)
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
						self:maxwidth(90):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-100):diffuse(PlayerColor(PLAYER_1))
						:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPossibleDancePoints()))
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerPointsP2",
					Text="0",
					OnCommand=function(self)
						self:maxwidth(90):horizalign(right):zoom(0.75):shadowlength(0):addy(145):addx(100):diffuse(PlayerColor(PLAYER_2))
						:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints())
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints()) end
				},
				LoadFont("_z numbers")..{
					Name="TargetPointsP2",
					Text="0",
					OnCommand=function(self)
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
						self:maxwidth(90):horizalign(right):zoom(0.75):shadowlength(0):addy(125):addx(100):diffuse(PlayerColor(PLAYER_2))
						:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPossibleDancePoints()))
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerHighscoreDifferenceP1",
					OnCommand=function(self)
						self:diffuse(color("#00FF00FF")):maxwidth(75):horizalign(right):zoom(0.375):shadowlength(0):addy(142):addx(-100)
						if topscore[PLAYER_1] ~= nil then self:settextf( "%+04d", 0 ) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 and topscore[PLAYER_1] ~= nil then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local curPlayerDP = pss:GetActualDancePoints()
						local curHighscoreDP = math.ceil(DPCurMax*topscore[PLAYER_1]:GetPercentDP())
						self:settextf( "%+04d", (curPlayerDP-curHighscoreDP) )
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerTargetDifferenceP1",
					OnCommand=function(self)
						self:diffuse(color("#FF0000FF")):maxwidth(75):horizalign(right):zoom(0.375):shadowlength(0):addy(148):addx(-100):settextf( "%+04d", 0 )
						if topscore[PLAYER_1] == nil then self:addy(-3) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local curPlayerDP = pss:GetActualDancePoints()
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
						local curTargetDP = math.ceil(DPCurMax*target)
						self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerHighscoreDifferenceP2",
					OnCommand=function(self)
						self:diffuse(color("#00FF00FF")):maxwidth(75):horizalign(left):zoom(0.375):shadowlength(0):addy(142):addx(100)
						if topscore[PLAYER_2] ~= nil then self:settextf( "%+04d", 0 ) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 and topscore[PLAYER_2] ~= nil then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local curPlayerDP = pss:GetActualDancePoints()
						local curHighscoreDP = math.ceil(DPCurMax*topscore[PLAYER_2]:GetPercentDP())
						self:settextf( "%+04d", (curPlayerDP-curHighscoreDP) )
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerTargetDifferenceP2",
					OnCommand=function(self)
						self:diffuse(color("#FF0000FF")):maxwidth(75):horizalign(left):zoom(0.375):shadowlength(0):addy(148):addx(100):settextf( "%+04d", 0 )
						if topscore[PLAYER_2] == nil then self:addy(-3) end
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local curPlayerDP = pss:GetActualDancePoints()
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
						local curTargetDP = math.ceil(DPCurMax*target)
						self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
					end
				}
			}
		}
	end
	return t
end