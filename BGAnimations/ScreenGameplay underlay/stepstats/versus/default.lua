local barWidth		= {28	,12	,8	,6	,4	,3};
local barSpace		= {2	,4	,2	,1.5	,2	,2};
local barHeight		= 82;
local totalWidth	= 28;
local barCenterP1	= 0;
local barCenterP2	= 0;

-- all this because of ScreenDemonstration... ~DarkBahamut162
if getenv("ShowStatsP1") == nil or getenv("ShowStatsP2") == nil then
	return Def.ActorFrame{}
else
	if getenv("ShowStatsP1") > 0 then
		barCenterP1 = -totalWidth/2+barWidth[getenv("ShowStatsP1")]/2;
	end
	if getenv("ShowStatsP2") > 0 then
		barCenterP2 = -totalWidth/2+barWidth[getenv("ShowStatsP2")]/2;
	end

	return Def.ActorFrame{
		OnCommand=function(self)
			self:x( SCREEN_CENTER_X )
			self:y( SCREEN_CENTER_Y)
		end;

		Def.ActorFrame{
			Condition=not isRave() and getenv("ShowStatsP1") > 0;
			Def.ActorFrame{
				Name="PlayerP1";
				InitCommand=function(self) self:x(SCREEN_LEFT+20-SCREEN_WIDTH/2):addx(-100):zoomx(-1) end;
				Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and getenv("ShowStatsP1") > 0;
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(100) end;
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(-100) end;

				LoadActor("v_bg" .. getenv("ShowStatsP1"))..{
					InitCommand=function(self) self:vertalign(bottom):y(-111+1) end;
				};
				LoadActor("../w1")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP1):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP1")]):zoomy(0) end;
					Condition=getenv("ShowStatsP1") >= 1;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_1 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
								self:zoomy(w1Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
								self:zoomy(w1Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w2")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP1+(barWidth[getenv("ShowStatsP1")]+barSpace[getenv("ShowStatsP1")])*1):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP1")]):zoomy(0) end;
					Condition=getenv("ShowStatsP1") >= 2;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_1 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
								self:zoomy(w2Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
								self:zoomy(w2Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w3")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP1+(barWidth[getenv("ShowStatsP1")]+barSpace[getenv("ShowStatsP1")])*2):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP1")]):zoomy(0) end;
					Condition=getenv("ShowStatsP1") >= 3;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_1 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
								self:zoomy(w3Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
								self:zoomy(w3Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w4")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP1+(barWidth[getenv("ShowStatsP1")]+barSpace[getenv("ShowStatsP1")])*3):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP1")]):zoomy(0) end;
					Condition=getenv("ShowStatsP1") >= 4;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_1 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
								self:zoomy(w4Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
								self:zoomy(w4Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w5")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP1+(barWidth[getenv("ShowStatsP1")]+barSpace[getenv("ShowStatsP1")])*4):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP1")]):zoomy(0) end;
					Condition=getenv("ShowStatsP1") >= 5;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_1 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
								self:zoomy(w5Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
								self:zoomy(w5Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w6")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP1+(barWidth[getenv("ShowStatsP1")]+barSpace[getenv("ShowStatsP1")])*5):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP1")]):zoomy(0) end;
					Condition=getenv("ShowStatsP1") >= 6;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_1 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
								self:zoomy(missNotes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
								local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
								self:zoomy(missNotes/TotalSteps*barHeight)
							end
						end
					end;
				};
			};

			Def.ActorFrame{
				Name="PlayerP2";
				InitCommand=function(self) self:x(SCREEN_RIGHT-20-SCREEN_WIDTH/2):addx(100) end;
				Condition=GAMESTATE:IsHumanPlayer(PLAYER_2) and getenv("ShowStatsP2") > 0;
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(-100) end;
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(100) end;

				LoadActor("v_bg" .. getenv("ShowStatsP2"))..{
					InitCommand=function(self) self:vertalign(bottom):y(-111+1) end;
				};
				LoadActor("../w1")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP2):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP2")]):zoomy(0) end;
					Condition=getenv("ShowStatsP2") >= 1;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_2 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
								self:zoomy(w1Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
								self:zoomy(w1Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w2")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP2+(barWidth[getenv("ShowStatsP2")]+barSpace[getenv("ShowStatsP2")])*1):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP2")]):zoomy(0) end;
					Condition=getenv("ShowStatsP2") >= 2;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_2 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
								self:zoomy(w2Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
								self:zoomy(w2Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w3")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP2+(barWidth[getenv("ShowStatsP2")]+barSpace[getenv("ShowStatsP2")])*2):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP2")]):zoomy(0) end;
					Condition=getenv("ShowStatsP2") >= 3;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_2 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
								self:zoomy(w3Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
								self:zoomy(w3Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w4")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP2+(barWidth[getenv("ShowStatsP2")]+barSpace[getenv("ShowStatsP2")])*3):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP2")]):zoomy(0) end;
					Condition=getenv("ShowStatsP2") >= 4;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_2 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
								self:zoomy(w4Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
								self:zoomy(w4Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w5")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP2+(barWidth[getenv("ShowStatsP2")]+barSpace[getenv("ShowStatsP2")])*4):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP2")]):zoomy(0) end;
					Condition=getenv("ShowStatsP2") >= 5;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_2 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
								self:zoomy(w5Notes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
								self:zoomy(w5Notes/TotalSteps*barHeight)
							end
						end
					end;
				};
				LoadActor("../w6")..{
					InitCommand=function(self) self:vertalign(bottom):addx(barCenterP2+(barWidth[getenv("ShowStatsP2")]+barSpace[getenv("ShowStatsP2")])*5):addy(-111):zoomx(0.01*barWidth[getenv("ShowStatsP2")]):zoomy(0) end;
					Condition=getenv("ShowStatsP2") >= 5;
					JudgmentMessageCommand=function(self,param)
						if param.Player == PLAYER_2 then self:queuecommand("Update") end
					end;
					UpdateCommand=function(self)
						local song = GAMESTATE:GetCurrentSong()
						local course = GAMESTATE:GetCurrentCourse()
						if course then
							local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
							if trail then
								local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
								self:zoomy(missNotes/TotalSteps*barHeight)
							end
						elseif song then
							local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
							if steps then
								local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
								local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
								local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
								self:zoomy(missNotes/TotalSteps*barHeight)
							end
						end
					end;
				};
			};
		};

		Def.ActorFrame{
			Name="Labels";
			InitCommand=function(self) self:y(isRave() and -10 or 0):addy(-100) end;
			Condition=getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
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

		Def.ActorFrame{
			Name="NumbersP1";
			InitCommand=function(self) self:y(isRave() and -10 or 0):addy(-100) end;
			Condition=getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
			JudgmentMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then
					self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end);
				end
			end;
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/4.5):horizalign(right):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") < 1 and getenv("ShowStatsP2") >= 1 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
						self:settext(w1Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(right):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") < 2 and getenv("ShowStatsP2") >= 2 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
						self:settext(w2Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(right):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") < 3 and getenv("ShowStatsP2") >= 3 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
						self:settext(w3Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*3-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(right):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") < 4 and getenv("ShowStatsP2") >= 4 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
						self:settext(w4Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*4-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(right):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") < 5 and getenv("ShowStatsP2") >= 5 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
						self:settext(w5Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*5-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(right):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") < 6 and getenv("ShowStatsP2") >= 6 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
						self:settext(missNotes)
					end
				end;
			};
		};

		Def.ActorFrame{
			Name="NumbersP2";
			InitCommand=function(self) self:y(isRave() and -10 or 0):addy(-100) end;
			Condition=getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
			JudgmentMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then
					self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end);
				end
			end;
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/4.5):horizalign(left):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") >= 1 and getenv("ShowStatsP2") < 1 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
						self:settext(w1Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(left):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") >= 2 and getenv("ShowStatsP2") < 2 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
						self:settext(w2Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(left):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") >= 3 and getenv("ShowStatsP2") < 3 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
						self:settext(w3Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*3-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(left):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") >= 4 and getenv("ShowStatsP2") < 4 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
						self:settext(w4Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*4-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(left):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") >= 5 and getenv("ShowStatsP2") < 5 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
						self:settext(w5Notes)
					end
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*5-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(left):settext("0") end;
				Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
				UpdateCommand=function(self)
					if getenv("ShowStatsP1") >= 6 and getenv("ShowStatsP2") < 6 then
						self:settext("?")
					else
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
						self:settext(missNotes)
					end
				end;
			};
		};
	};
end