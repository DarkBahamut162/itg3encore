local t = LoadFallbackB()

if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if (GAMESTATE:IsPlayerEnabled(pn) or isRave()) and not isTopScreen("ScreenEvaluationSummary") then
			local t2 = Def.ActorFrame{
				InitCommand=function(self) self:player(pn) end,
				LoadActor(THEME:GetPathG("_difficulty icons",isFinal() and "final" or "normal"))..{
					InitCommand=function(self) self:zoomy(0.8):animate(0):zoomx((pn==PLAYER_2) and -0.8 or 0.8):playcommand("Update") end,
					UpdateCommand=function(self)
						local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
						if StepsOrTrail then self:setstate(DifficultyToState(StepsOrTrail:GetDifficulty())) end
					end
				},
				Def.StepsDisplay {
					InitCommand=function(self) self:Load("StepsDisplayEvaluation",pn):SetFromGameState(pn) end,
					UpdateNetEvalStatsMessageCommand=function(self,param)
						if GAMESTATE:IsPlayerEnabled(pn) or isRave() then self:SetFromSteps(param.Steps) end
					end
				}
			}
			t[#t+1] = StandardDecorationFromTable("StepsDisplay"..pname(pn), t2)
		end
	end
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
			InitCommand=function(self)
				self:player(pn):name("MachineRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn)..{
			InitCommand=function(self)
				self:player(pn):name("PersonalRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "PacemakerRecord"), pn)..{
			InitCommand=function(self)
				self:player(pn):name("PacemakerRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

local function TotalPossibleStepSeconds()
	local fSecs = 0
	local s = STATSMAN:GetPlayedStageStats(1)
	local played = isITGmania() and #s:GetPlayedSongs() or #s:GetPossibleSongs()
	for a = 1, played do
		fSecs = fSecs + s:GetPossibleSongs()[a]:GetStepsSeconds()
	end

    local songoptions = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
    if not songoptions then return fSecs end

    return fSecs / songoptions:MusicRate()
end

local function CalcMinusStepSeconds(pn)
	local fSecs = 0
	local played = #STATSMAN:GetPlayedStageStats(1):GetPlayedSongs()
	local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
	if GAMESTATE:IsCourseMode() then
		for i = 1, played do
			local trail = StepsOrTrail:GetTrailEntry(i)
			if trail then
				fSecs = fSecs + trail:GetSong():GetFirstSecond()
				fSecs = fSecs + trail:GetSteps():GetTimingData():GetElapsedTimeFromBeat(0)
			end
		end
	else
		fSecs = fSecs + SongOrCourse:GetFirstSecond()
		fSecs = fSecs + StepsOrTrail:GetTimingData():GetElapsedTimeFromBeat(0)
	end

    local songoptions = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
    if not songoptions then return fSecs end

    return fSecs / songoptions:MusicRate()
end

local function GraphDisplay(pn)
	local length = TotalPossibleStepSeconds()
	local lastMarvelousSecond = getenv("LastFantastic"..pname(pn)) - CalcMinusStepSeconds(pn)
	local lastPerfectSecond = getenv("LastPerfect"..pname(pn)) - CalcMinusStepSeconds(pn)
	local lastGreatSecond = getenv("LastGreat"..pname(pn)) - CalcMinusStepSeconds(pn)

	local combo = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetComboList()
	local trueLast = #combo > 0 and combo[1]["StartSecond"]+combo[1]["SizeSeconds"] or 0
	local maxLast = lastGreatSecond ~= 0 and lastGreatSecond or lastPerfectSecond ~= 0 and lastPerfectSecond or lastMarvelousSecond
	local lastGreatSecond = lastGreatSecond * (trueLast/maxLast)
	local lastPerfectSecond = lastPerfectSecond * (trueLast/maxLast)
	local lastMarvelousSecond = lastMarvelousSecond * (trueLast/maxLast)

	return Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=function(self) self:Load("GraphDisplay"..pname(pn)) end,
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
			end
		},
		LoadActor(THEME:GetPathB("ScreenEvaluation","underlay/FGC "..pname(pn)))..{
			Condition=not isRave() and getenv("EvalCombo"..pname(pn)) and lastPerfectSecond > 0 and not (isOni() and not isLifeline(player)),
			InitCommand=function(self)
				self:croptop(0.75) if lastGreatSecond ~= 0 then self:cropright(1-(lastGreatSecond/length)) end
			end
		},
		LoadActor(THEME:GetPathB("ScreenEvaluation","underlay/FEC "..pname(pn)))..{
			Condition=not isRave() and getenv("EvalCombo"..pname(pn)) and lastMarvelousSecond > 0 and not (isOni() and not isLifeline(player)),
			InitCommand=function(self)
				self:croptop(0.75) if lastPerfectSecond ~= 0 then self:cropright(1-(lastPerfectSecond/length)) end
			end
		},
		LoadActor(THEME:GetPathB("ScreenEvaluation","underlay/FFC "..pname(pn)))..{
			Condition=not isRave() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(player)),
			InitCommand=function(self)
				self:croptop(0.75) if lastMarvelousSecond ~= 0 then self:cropright(1-(lastMarvelousSecond/length)) end
			end
		}
	}
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("GraphDisplay"..pname(pn), GraphDisplay(pn))
		end
	end
end

local function ComboGraph( pn )
	return Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=function(self) self:Load("ComboGraph"..pname(pn)) end,
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
			end
		}
	}
end

if ShowStandardDecoration("ComboGraph") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("ComboGraph"..pname(pn), ComboGraph(pn))
		end
	end
end

local function StageAward( pn )
	return LoadActor(THEME:GetPathG("ScreenEvaluation", "StageAward"), pn)..{
		InitCommand=function(self) self:player(pn):name("StageAward"..pname(pn)) end
	}
end

if ShowStandardDecoration("StageAward") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("StageAward"..pname(pn), StageAward(pn))
		end
	end
end

local function PeakComboAward( pn )
	return LoadActor( THEME:GetPathG(Var "LoadingScreen", "PeakComboAward"), pn ) .. {
		InitCommand=function(self) self:player(pn):name("PeakComboAward"..pname(pn)) end
	}
end

if ShowStandardDecoration("PeakComboAward") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("PeakComboAward"..pname(pn), PeakComboAward(pn))
		end
	end
end

return t