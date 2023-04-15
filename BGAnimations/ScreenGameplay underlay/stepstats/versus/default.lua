local SongOrCourse, StepsOrTrail, scorelist, topscore = {},{},{},{}
local bgNum = {}
local IIDX = false
local atLeastOneHighscoreExists = false

if getenv("ShowStatsP1") == nil or getenv("ShowStatsP2") == nil then return Def.ActorFrame{} else
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsCourseMode() then SongOrCourse[pn],StepsOrTrail[pn] = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(pn) else SongOrCourse[pn],StepsOrTrail[pn] = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(pn) end
		if not scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then scorelist[pn] = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn]) end
		if not scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then scorelist[pn] = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse[pn],StepsOrTrail[pn]) end
		if scorelist[pn] and GAMESTATE:IsHumanPlayer(pn) then topscore[pn] = scorelist[pn]:GetHighScores()[1] end
		if getenv("ShowStatsP1") == 7 and getenv("ShowStatsP2") == 7 then
			if topscore[pn] == nil then bgNum[pn] = 4 else bgNum[pn] = 6 end
			IIDX = true
		else
			bgNum[pn] = math.min(6,getenv("ShowStats"..pname(pn)))
		end
	end
	if topscore[PLAYER_1] ~= nil or topscore[PLAYER_2] ~= nil then atLeastOneHighscoreExists = true end

	local t = Def.ActorFrame{}
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsHumanPlayer(pn) and bgNum[pn] > 0 then
			t[#t+1] = Def.ActorFrame{
				Name="Player"..pname(pn),
				LoadActor("../double",pn)..{
					InitCommand=function(self) self:zoom((atLeastOneHighscoreExists and IIDX or not IIDX) and 3/4 or 1) end
				}
			}
		end
	end

	if not isRave() and not IIDX then
		local Judgments = Def.ActorFrame{
			InitCommand=function(self) self:Center() end
		}
		local diffuses = {color("#60B5C7"),color("#FEA859"),color("#4AB812"),color("#D064FB"),color("#F76D47"),color("#FB0808")}
		local texts = {"F","E","G","D","W","M"}
		for i = 1,math.min(6,math.max(bgNum[PLAYER_1],bgNum[PLAYER_2])) do
			Judgments[#Judgments+1] = LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:shadowlength(1):y(SCREEN_TOP+(85+13*(i-1))*WideScreenDiff()-SCREEN_HEIGHT/2):zoom(0.5*WideScreenDiff()):diffuse(diffuses[i]):settext(texts[i]) end
			}
		end

		t[#t+1] = Def.ActorFrame{
			Name="Labels",
			InitCommand=function(self) self:y(isRave() and -10*WideScreenDiff() or 0):diffusealpha(0) end,
			Condition=bgNum[PLAYER_1] > 0 or bgNum[PLAYER_2] > 0,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end,
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):diffusealpha(0) end,
			Judgments
		}

		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			local Numbers = Def.ActorFrame{
				InitCommand=function(self) self:Center() end
			}
			for i = 1,math.min(6,math.max(bgNum[PLAYER_1],bgNum[PLAYER_2])) do
				local score = i < 6 and "W"..i or "Miss"
				Numbers[#Numbers+1] = LoadFont("_z numbers")..{
					InitCommand=function(self) self:x(pn == PLAYER_1 and -8*WideScreenDiff() or 8*WideScreenDiff()):y(SCREEN_TOP+(85+13*(i-1))*WideScreenDiff()-SCREEN_HEIGHT/2)
						:zoom(0.6*WideScreenDiff()):maxwidth(125):horizalign(pn == PLAYER_1 and right or left):queuecommand("Update") end,
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
				Name="Numbers"..pname(pn),
				InitCommand=function(self) self:y(isRave() and -10 or 0):diffusealpha(0) end,
				Condition=bgNum[PLAYER_1] > 0 or bgNum[PLAYER_2] > 0,
				OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end,
				OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):diffusealpha(0) end,
				JudgmentMessageCommand=function(self,param) if param.Player == pn then self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end) end end,
				Numbers
			}
		end
	elseif not isRave() and IIDX then
		local Judgments = Def.ActorFrame{
			InitCommand=function(self) self:Center() end
		}
		local diffuses = atLeastOneHighscoreExists and {color("#16AFF3"),color("#00000000"),color("#00000000"),color("#09FF10"),color("#EA3548")} or {color("#16AFF3"),color("#00000000"),color("#EA3548")}
		local texts = atLeastOneHighscoreExists and {"P","","","H","T"} or {"P","","T"}
		for i = 1,#texts do
			Judgments[#Judgments+1] = LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:shadowlength(1):y(SCREEN_TOP+(85+16*(i-1))*WideScreenDiff()-SCREEN_HEIGHT/2):zoom(0.5*WideScreenDiff()):diffuse(diffuses[i]):settext(texts[i]) end
			}
		end

		t[#t+1] = Def.ActorFrame{
			Name="Labels",
			InitCommand=function(self) self:y(isRave() and -10*WideScreenDiff() or 0):diffusealpha(0) end,
			Condition=bgNum[PLAYER_1] > 0 or bgNum[PLAYER_2] > 0,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):diffusealpha(1) end,
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):diffusealpha(0) end,
			Judgments
		}

		t[#t+1] = Def.ActorFrame{
			InitCommand=function(self) self:CenterX() end,
			Def.ActorFrame{
				InitCommand=function(self) self:y(SCREEN_TOP+85*WideScreenDiff()) end,
				LoadFont("_z numbers")..{
					Name="PlayerPointsP1",
					Text="0",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(right):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(16*0*WideScreenDiff()):addx(-5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1))
						:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints())
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetActualDancePoints()) end
				},
				LoadFont("_z numbers")..{
					Condition=topscore[PLAYER_1] ~= nil,
					Name="HighscorePointsP1",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(right):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(16*3*WideScreenDiff()):addx(-5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):settext(math.ceil(topscore[PLAYER_1]:GetPercentDP()*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPossibleDancePoints()))
					end
				},
				LoadFont("_z numbers")..{
					Name="TargetPointsP1",
					Text="0",
					OnCommand=function(self)
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..pname(PLAYER_1))))
						self:maxwidth(100):horizalign(right):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(atLeastOneHighscoreExists and 16*4*WideScreenDiff() or 16*2*WideScreenDiff()):addx(-5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1))
						:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetPossibleDancePoints()))
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerPointsP2",
					Text="0",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(left):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(16*0*WideScreenDiff()):addx(5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2))
						:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints())
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self) self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetActualDancePoints()) end
				},
				LoadFont("_z numbers")..{
					Condition=topscore[PLAYER_2] ~= nil,
					Name="HighscorePointsP2",
					OnCommand=function(self)
						self:maxwidth(100):horizalign(left):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(16*3*WideScreenDiff()):addx(5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2)):settext(math.ceil(topscore[PLAYER_2]:GetPercentDP()*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPossibleDancePoints()))
					end
				},
				LoadFont("_z numbers")..{
					Name="TargetPointsP2",
					Text="0",
					OnCommand=function(self)
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..pname(PLAYER_2))))
						self:maxwidth(100):horizalign(left):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(atLeastOneHighscoreExists and 16*4*WideScreenDiff() or 16*2*WideScreenDiff()):addx(5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2))
						:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetPossibleDancePoints()))
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerHighscoreDifferenceP1",
					OnCommand=function(self)
						self:diffuse(color("#00FF00")):maxwidth(100):horizalign(right):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(16*1*WideScreenDiff()):addx(-5*WideScreenDiff())
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
						self:diffuse(color("#FF0000")):maxwidth(100):horizalign(right):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(atLeastOneHighscoreExists and 16*2*WideScreenDiff() or 16*1*WideScreenDiff()):addx(-5*WideScreenDiff()):settextf( "%+04d", 0 )
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_1 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local curPlayerDP = pss:GetActualDancePoints()
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..pname(PLAYER_1))))
						local curTargetDP = math.ceil(DPCurMax*target)
						self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
					end
				},
				LoadFont("_z numbers")..{
					Name="PlayerHighscoreDifferenceP2",
					OnCommand=function(self)
						self:diffuse(color("#00FF00")):maxwidth(100):horizalign(left):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(16*1*WideScreenDiff()):addx(5*WideScreenDiff())
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
						self:diffuse(color("#FF0000")):maxwidth(100):horizalign(left):zoom(0.75*WideScreenDiff()):shadowlength(0):addy(atLeastOneHighscoreExists and 16*2*WideScreenDiff() or 16*1*WideScreenDiff()):addx(5*WideScreenDiff()):settextf( "%+04d", 0 )
					end,
					JudgmentMessageCommand=function(self,param) if param.Player == PLAYER_2 then self:queuecommand("Update") end end,
					UpdateCommand=function(self)
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
						local DPCurMax = pss:GetCurrentPossibleDancePoints()
						local curPlayerDP = pss:GetActualDancePoints()
						local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..pname(PLAYER_2))))
						local curTargetDP = math.ceil(DPCurMax*target)
						self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
					end
				}
			}
		}
	end
	return t
end