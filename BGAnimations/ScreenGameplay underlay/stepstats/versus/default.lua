local barWidth		= {28	,12	,8	,6		,4	,3,	3}
local barSpace		= {2	,4	,2	,1.5	,2	,2, 2}
local barHeight		= 82
local totalWidth	= 28
local barCenter		= {}

local SongOrCourse, StepsOrTrail, scorelist, topscore = {},{},{},{}
local DPCurMax = {
	[PLAYER_1] = 0,
	[PLAYER_2] = 0,
}
local IIDX = false

-- all this because of ScreenDemonstration... ~DarkBahamut162
if getenv("ShowStatsP1") == nil or getenv("ShowStatsP2") == nil then
	return Def.ActorFrame{}
else
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsCourseMode() then
			SongOrCourse[pn] = GAMESTATE:GetCurrentCourse()
			StepsOrTrail[pn] = GAMESTATE:GetCurrentTrail(pn)
		else
			SongOrCourse[pn] = GAMESTATE:GetCurrentSong()
			StepsOrTrail[pn] = GAMESTATE:GetCurrentSteps(pn)
		end
		
		if not scorelist[pn] then
			scorelist[pn] = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn])
		end
		if not scorelist[pn] then
			scorelist[pn] = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn])
		end
		
		if scorelist[pn] then
			topscore[pn] = scorelist[pn]:GetHighScores()[1]
		end
		if getenv("ShowStats"..ToEnumShortString(pn)) > 0 then
			barCenter[pn] = -totalWidth/2+barWidth[getenv("ShowStats"..ToEnumShortString(pn))]/2
		end
	end
	if getenv("ShowStatsP1") == 7 and getenv("ShowStatsP2") == 7 then IIDX = true end

	local t = Def.ActorFrame{
		OnCommand=function(self)
			self:x( SCREEN_CENTER_X )
			self:y( SCREEN_CENTER_Y)
		end;
	};

	if not isRave() and not IIDX then
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			t[#t+1] = Def.ActorFrame{
				Name="Player"..ToEnumShortString(pn);
				InitCommand=function(self)
					self:x(pn == PLAYER_1 and SCREEN_LEFT+20-SCREEN_WIDTH/2 or SCREEN_RIGHT-20-SCREEN_WIDTH/2)
					:addx(pn == PLAYER_1 and -100 or 100)
					:zoomx(pn == PLAYER_1 and -1 or 1) end;
				Condition=GAMESTATE:IsHumanPlayer(pn) and getenv("ShowStats"..ToEnumShortString(pn)) > 0;
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(pn == PLAYER_1 and 100 or -100) end;
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(pn == PLAYER_1 and -100 or 100) end;
	
				LoadActor("v_bg" .. getenv("ShowStats"..ToEnumShortString(pn)))..{
					InitCommand=function(self) self:vertalign(bottom):y(-111+1) end;
				};
				LoadActor("../w1")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]):addy(-111):zoomx(0.01*barWidth[getenv("ShowStats"..ToEnumShortString(pn))]):zoomy(0) end;
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 1;
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
						self:zoomy(w1Notes/TotalSteps*barHeight)
					end;
				};
				LoadActor("../w2")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]+(barWidth[getenv("ShowStats"..ToEnumShortString(pn))]+barSpace[getenv("ShowStats"..ToEnumShortString(pn))])*1):addy(-111):zoomx(0.01*barWidth[getenv("ShowStats"..ToEnumShortString(pn))]):zoomy(0) end;
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
						self:zoomy(w2Notes/TotalSteps*barHeight)
					end;
				};
				LoadActor("../w3")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]+(barWidth[getenv("ShowStats"..ToEnumShortString(pn))]+barSpace[getenv("ShowStats"..ToEnumShortString(pn))])*2):addy(-111):zoomx(0.01*barWidth[getenv("ShowStats"..ToEnumShortString(pn))]):zoomy(0) end;
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
						self:zoomy(w3Notes/TotalSteps*barHeight)
					end;
				};
				LoadActor("../w4")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]+(barWidth[getenv("ShowStats"..ToEnumShortString(pn))]+barSpace[getenv("ShowStats"..ToEnumShortString(pn))])*3):addy(-111):zoomx(0.01*barWidth[getenv("ShowStats"..ToEnumShortString(pn))]):zoomy(0) end;
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
						self:zoomy(w4Notes/TotalSteps*barHeight)
					end;
				};
				LoadActor("../w5")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]+(barWidth[getenv("ShowStats"..ToEnumShortString(pn))]+barSpace[getenv("ShowStats"..ToEnumShortString(pn))])*4):addy(-111):zoomx(0.01*barWidth[getenv("ShowStats"..ToEnumShortString(pn))]):zoomy(0) end;
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
						self:zoomy(w5Notes/TotalSteps*barHeight)
					end;
				};
				LoadActor("../w6")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenter[pn]+(barWidth[getenv("ShowStats"..ToEnumShortString(pn))]+barSpace[getenv("ShowStats"..ToEnumShortString(pn))])*5):addy(-111):zoomx(0.01*barWidth[getenv("ShowStats"..ToEnumShortString(pn))]):zoomy(0) end;
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
					JudgmentMessageCommand=function(self,param)
						if param.Player == pn then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local TotalSteps = StepsOrTrail[pn]:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
						self:zoomy(missNotes/TotalSteps*barHeight)
					end;
				};
			};
		end

		t[#t+1] = Def.ActorFrame{
			Name="Labels";
			InitCommand=function(self) self:y(isRave() and -10 or 0):diffusealpha(0) end;
			Condition=getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):diffusealpha(0) end;
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#60B5C7")):settext("F") end;
				Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#FEA859")):settext("E") end;
				Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#4AB812")):settext("G") end;
				Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:y(SCREEN_TOP+92+15*3-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#D064FB")):settext("D") end;
				Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:y(SCREEN_TOP+92+15*4-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#F76D47")):settext("W") end;
				Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:y(SCREEN_TOP+92+15*5-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#FB0808")):settext("M") end;
				Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
			};
		};

		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			t[#t+1] = Def.ActorFrame{
				Name="Numbers"..ToEnumShortString(pn);
				InitCommand=function(self) self:y(isRave() and -10 or 0):diffusealpha(0) end;
				Condition=getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0;
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end;
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):diffusealpha(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end)
					end
				end;
				LoadFont("ScreenGameplay judgment")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/4.5):horizalign(pn == PLAYER_1 and right or left):settext("0") end;
					Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
					UpdateCommand=function(self)
						if getenv("ShowStats"..ToEnumShortString(pn)) < 1 and getenv("ShowStats"..ToEnumShortString(pn == PLAYER_1 and PLAYER_2 or PLAYER_1)) >= 1 then
							self:settext("?")
						else
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:settext(w1Notes)
						end
					end;
				};
				LoadFont("ScreenGameplay judgment")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(pn == PLAYER_1 and right or left):settext("0") end;
					Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
					UpdateCommand=function(self)
						if getenv("ShowStats"..ToEnumShortString(pn)) < 2 and getenv("ShowStats"..ToEnumShortString(pn == PLAYER_1 and PLAYER_2 or PLAYER_1)) >= 2 then
							self:settext("?")
						else
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:settext(w2Notes)
						end
					end;
				};
				LoadFont("ScreenGameplay judgment")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(pn == PLAYER_1 and right or left):settext("0") end;
					Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
					UpdateCommand=function(self)
						if getenv("ShowStats"..ToEnumShortString(pn)) < 3 and getenv("ShowStats"..ToEnumShortString(pn == PLAYER_1 and PLAYER_2 or PLAYER_1)) >= 3 then
							self:settext("?")
						else
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
							self:settext(w3Notes)
						end
					end;
				};
				LoadFont("ScreenGameplay judgment")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*3-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(pn == PLAYER_1 and right or left):settext("0") end;
					Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
					UpdateCommand=function(self)
						if getenv("ShowStats"..ToEnumShortString(pn)) < 4 and getenv("ShowStats"..ToEnumShortString(pn == PLAYER_1 and PLAYER_2 or PLAYER_1)) >= 4 then
							self:settext("?")
						else
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
							self:settext(w4Notes)
						end
					end;
				};
				LoadFont("ScreenGameplay judgment")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*4-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(pn == PLAYER_1 and right or left):settext("0") end;
					Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
					UpdateCommand=function(self)
						if getenv("ShowStats"..ToEnumShortString(pn)) < 5 and getenv("ShowStats"..ToEnumShortString(pn == PLAYER_1 and PLAYER_2 or PLAYER_1)) >= 5 then
							self:settext("?")
						else
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
							self:settext(w5Notes)
						end
					end;
				};
				LoadFont("ScreenGameplay judgment")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8 or 8):y(SCREEN_TOP+92+15*5-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(pn == PLAYER_1 and right or left):settext("0") end;
					Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
					UpdateCommand=function(self)
						if getenv("ShowStats"..ToEnumShortString(pn)) < 6 and getenv("ShowStats"..ToEnumShortString(pn == PLAYER_1 and PLAYER_2 or PLAYER_1)) >= 6 then
							self:settext("?")
						else
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
							local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
							self:settext(missNotes)
						end
					end;
				};
			};
		end
	elseif not isRave() and IIDX then
		local barWidth		= {202,	92,	57,	36,		26,	20,		20}
		local barSpace		= {0,	18,	16,	19.5,	18,	16+1/3,	16+1/3}
		local barHeight		= 228
		local totalWidth	= 202
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			if getenv("ShowStats"..ToEnumShortString(pn)) > 0 then
				barCenter[pn] = -totalWidth/2+barWidth[getenv("ShowStats"..ToEnumShortString(pn))]/2
			end
		end
		t[#t+1] = Def.ActorFrame{
			OnCommand=function(self) self:zoomx(2/3) end;
			JudgmentMessageCommand=function(self,param)
				if param.TapNoteScore and
				param.TapNoteScore ~= 'TapNoteScore_Invalid' and
				param.TapNoteScore ~= 'TapNoteScore_AvoidMine' and
				param.TapNoteScore ~= 'TapNoteScore_HitMine' and
				param.TapNoteScore ~= 'TapNoteScore_CheckpointMiss' and
				param.TapNoteScore ~= 'TapNoteScore_CheckpointHit' and
				param.TapNoteScore ~= 'TapNoteScore_None' then
					if param.Player == PLAYER_1 then
						DPCurMax[PLAYER_1] = DPCurMax[PLAYER_1] + 5
					elseif param.Player == PLAYER_2 then
						DPCurMax[PLAYER_2] = DPCurMax[PLAYER_2] + 5
					end
				end
			end;
			LoadActor("../single/s_bg7");
			LoadActor("../single/s_bg_7");
			Def.ActorFrame{
				Name="BarLabels";
				-- only show on first stage
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end;
				LoadFont("_v 26px bold black")..{
					Text="Target P1";
					InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*0):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Highscore P1";
					InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*1):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text=PROFILEMAN:GetPlayerName(PLAYER_1);
					InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*2):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text=PROFILEMAN:GetPlayerName(PLAYER_2);
					InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*3):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Highscore P2";
					InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*4):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.75):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Target P2";
					InitCommand=function(self) self:rotationz(-90):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*5):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(3):linear(1):diffusealpha(0) end;
				};
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="Pacemaker";
				Text="Pacemaker";
				OnCommand=function(self) self:horizalign(center):zoom(0.75):shadowlength(0):addy(-145) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerName";
				Text="Player";
				OnCommand=function(self) self:maxwidth(125):horizalign(center):zoom(0.75):shadowlength(0):addy(145) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="TargetName";
				Text="Target";
				OnCommand=function(self) self:maxwidth(125):horizalign(center):zoom(0.75):shadowlength(0):addy(125) end;
			};

			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerPointsP1";
				Text="0";
				OnCommand=function(self)
					self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-100)
					:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints())
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_1 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints())
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="TargetPointsP1";
				Text="0";
				OnCommand=function(self)
					self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-100)
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
					self:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPossibleDancePoints()))
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerPointsP2";
				Text="0";
				OnCommand=function(self)
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(145):addx(100)
					:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints())
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_2 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints())
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="TargetPointsP2";
				Text="0";
				OnCommand=function(self)
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(125):addx(100)
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
					self:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPossibleDancePoints()))
				end;
			};

			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerHighscoreDifferenceP1";
				OnCommand=function(self)
					self:diffuse(color("#00FF00FF")):maxwidth(125):horizalign(right):zoom(0.375):shadowlength(0):addy(140):addx(-100)
					if topscore[PLAYER_1] ~= nil then self:settextf( "%+04d", 0 ) end
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_1 and topscore[PLAYER_1] ~= nil then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local curPlayerDP = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints()
					local curHighscoreDP = math.ceil(DPCurMax[PLAYER_1]*topscore[PLAYER_1]:GetPercentDP())
					self:settextf( "%+04d", (curPlayerDP-curHighscoreDP) )
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerTargetDifferenceP1";
				OnCommand=function(self)
					self:diffuse(color("#FF0000FF")):maxwidth(125):horizalign(right):zoom(0.375):shadowlength(0):addy(150):addx(-100):settextf( "%+04d", 0 )
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_1 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local curPlayerDP = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints()
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
					local curTargetDP = math.ceil(DPCurMax[PLAYER_1]*target)
					self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerHighscoreDifferenceP2";
				OnCommand=function(self)
					self:diffuse(color("#00FF00FF")):maxwidth(125):horizalign(left):zoom(0.375):shadowlength(0):addy(140):addx(100)
					if topscore[PLAYER_2] ~= nil then self:settextf( "%+04d", 0 ) end
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_2 and topscore[PLAYER_2] ~= nil then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local curPlayerDP = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints()
					local curHighscoreDP = math.ceil(DPCurMax[PLAYER_2]*topscore[PLAYER_2]:GetPercentDP())
					self:settextf( "%+04d", (curPlayerDP-curHighscoreDP) )
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerTargetDifferenceP2";
				OnCommand=function(self)
					self:diffuse(color("#FF0000FF")):maxwidth(125):horizalign(left):zoom(0.375):shadowlength(0):addy(150):addx(100):settextf( "%+04d", 0 )
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_2 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local curPlayerDP = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints()
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
					local curTargetDP = math.ceil(DPCurMax[PLAYER_2]*target)
					self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
				end;
			};

			-- Target Target P1
			LoadActor("../w6")..{
				OnCommand=function(self)
					self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*0):addy(barHeight/2):zoomx(0.01*barWidth[6])
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
					self:zoomy(target*barHeight):diffusealpha(0.25)
				end;
			};
			-- Highscore Target P1
			LoadActor("../w3")..{
				OnCommand=function(self)
					self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*1):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0)
					if topscore[PLAYER_1] then
						self:zoomy(topscore[PLAYER_1]:GetPercentDP()*barHeight):diffusealpha(0.25)
					end
				end;
			};
			-- Highscore Target P2
			LoadActor("../w3")..{
				OnCommand=function(self)
					self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*4):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0)
					if topscore[PLAYER_2] then
						self:zoomy(topscore[PLAYER_2]:GetPercentDP()*barHeight):diffusealpha(0.25)
					end
				end;
			};
			-- Target Target P2
			LoadActor("../w6")..{
				OnCommand=function(self)
					self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*5):addy(barHeight/2):zoomx(0.01*barWidth[6])
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
					self:zoomy(target*barHeight):diffusealpha(0.25)
				end;
			};

			-- Target Current P1
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*0):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_1 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
					local DPMax = pss:GetPossibleDancePoints()
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_1))))
					self:zoomy(DPCurMax[PLAYER_1]/DPMax*target*barHeight)
				end;
			};
			-- Highscore Current P1
			LoadActor("../w3")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*1):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_1 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
					if topscore[PLAYER_1] then
						local DPMax = pss:GetPossibleDancePoints()
						self:zoomy(DPCurMax[PLAYER_1]/DPMax*topscore[PLAYER_1]:GetPercentDP()*barHeight)
					else
						local DP = pss:GetPercentDancePoints()
						self:zoomy(DP*barHeight)
					end
				end;
			};
			-- Player Current P1
			LoadActor("../w1")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_1]+(barWidth[6]+barSpace[6])*2):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_1 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
					local DP = pss:GetPercentDancePoints()
					self:zoomy(DP*barHeight)
				end;
			};
			-- Player Current P2
			LoadActor("../w1")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*3):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_2 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
					local DP = pss:GetPercentDancePoints()
					self:zoomy(DP*barHeight)
				end;
			};
			-- Highscore Current P2
			LoadActor("../w3")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*4):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_2 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
					if topscore[PLAYER_2] then
						local DPMax = pss:GetPossibleDancePoints()
						self:zoomy(DPCurMax[PLAYER_2]/DPMax*topscore[PLAYER_2]:GetPercentDP()*barHeight)
					else
						local DP = pss:GetPercentDancePoints()
						self:zoomy(DP*barHeight)
					end
				end;
			};
			-- Target Current P2
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter[PLAYER_2]+(barWidth[6]+barSpace[6])*5):addy(barHeight/2):zoomx(0.01*barWidth[6]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == PLAYER_2 then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
					local DPMax = pss:GetPossibleDancePoints()
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(PLAYER_2))))
					self:zoomy(DPCurMax[PLAYER_2]/DPMax*target*barHeight)
				end;
			};
		};
	end

	return t
end