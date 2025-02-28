local t = LoadFallbackB()

if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		local t2 = Def.ActorFrame{
			Def.Sprite {
				Texture = THEME:GetPathG("_difficulty icons",isFinal() and "final" or "normal"),
				InitCommand=function(self) self:zoomy(0.8):animate(0):zoomx((pn==PLAYER_2) and -0.8 or 0.8):playcommand("Update") end,
				UpdateCommand=function(self)
					local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(pn) or GAMESTATE:GetCurrentSteps(pn)
					if StepsOrTrail then self:setstate(DifficultyToState(StepsOrTrail:GetDifficulty())) end
				end
			},
			Def.StepsDisplay {
				InitCommand=function(self) self:Load("StepsDisplayEvaluation",pn):SetFromGameState(pn) end,
				UpdateNetEvalStatsMessageCommand=function(self,param)
					if GAMESTATE:IsPlayerEnabled(pn) or isVS() then self:SetFromSteps(param.Steps) end
				end
			}
		}
		t[#t+1] = t2 .. {
			InitCommand=function(self)
				self:name("StepsDisplay"..pname(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "MachineRecord"))(pn) .. {
			InitCommand=function(self)
				self:player(pn):name("MachineRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"))(pn)..{
			InitCommand=function(self)
				self:player(pn):name("PersonalRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "AutoPlayer"))(pn) .. {
			InitCommand=function(self)
				self:player(pn):name("AutoPlayer" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "PacemakerRecord"))(pn)..{
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

	if GAMESTATE:IsCourseMode() then
		local played = #STATSMAN:GetPlayedStageStats(1):GetPlayedSongs()
		for i = 1, played do
			local trail = GAMESTATE:GetCurrentTrail(pn):GetTrailEntry(i)
			if trail then
				fSecs = fSecs + trail:GetSong():GetFirstSecond()
			end
		end
	else
		fSecs = fSecs + GAMESTATE:GetCurrentSong():GetFirstSecond()
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

	local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local combo = PSS:GetComboList()
	local trueLast = #combo > 0 and combo[1]["StartSecond"]+combo[1]["SizeSeconds"] or 0
	local maxLast = lastGreatSecond ~= 0 and lastGreatSecond or lastPerfectSecond ~= 0 and lastPerfectSecond or lastMarvelousSecond
	local fix = trueLast < maxLast and trueLast/maxLast or 1
	local lastGreatSecond = lastGreatSecond * fix
	local lastPerfectSecond = lastPerfectSecond * fix
	local lastMarvelousSecond = lastMarvelousSecond * fix

	return Def.ActorFrame {
		Def.ActorFrame {
			Def.Quad{
				Condition=not isOutFox() and isVS(),
				OnCommand=function(self) self:valign(0):zoomto(194,SCREEN_WIDTH):MaskSource(false):y(34) end
			},
			Def.Quad{
				Condition=not isOutFox() and isVS(),
				OnCommand=function(self) self:valign(1):zoomto(194,SCREEN_WIDTH):MaskSource(false):y(-34) end
			}
		},
		Def.GraphDisplay {
			InitCommand=function(self) self:Load("GraphDisplay"..pname(pn)) end,
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
				if not isOutFox() and isVS() then self:MaskDest() end
			end
		},
		Def.ActorFrame {
			Condition=not isSurvival(pn),
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenEvaluation","underlay/FGC "..pname(pn)),
				Condition=not isVS() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(pn)),
				InitCommand=function(self)
					self:croptop(0.78) if not (PSS:FullComboOfScore('TapNoteScore_W3') and PlayerFullComboed(pn)) then self:cropright(1-(lastGreatSecond/length)) end
				end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenEvaluation","underlay/FEC "..pname(pn)),
				Condition=not isVS() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(pn)),
				InitCommand=function(self)
					self:croptop(0.78) if not (PSS:FullComboOfScore('TapNoteScore_W2') and PlayerFullComboed(pn)) then self:cropright(1-(lastPerfectSecond/length)) end
				end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenEvaluation","underlay/FFC "..pname(pn)),
				Condition=not isVS() and getenv("EvalCombo"..pname(pn)) and not (isOni() and not isLifeline(pn)),
				InitCommand=function(self)
					self:croptop(0.78) if not (PSS:FullComboOfScore('TapNoteScore_W1') and PlayerFullComboed(pn)) then self:cropright(1-(lastMarvelousSecond/length)) end
				end
			}
		}
	}
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = GraphDisplay(pn) .. {
				InitCommand=function(self)
					self:name("GraphDisplay"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
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
			t[#t+1] = ComboGraph(pn) .. {
				InitCommand=function(self)
					self:name("ComboGraph"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

local function StageAward( pn )
	return loadfile(THEME:GetPathG("ScreenEvaluation", "StageAward"))(pn)..{
		InitCommand=function(self) self:player(pn):name("StageAward"..pname(pn)) end
	}
end

if ShowStandardDecoration("StageAward") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StageAward(pn) .. {
				InitCommand=function(self)
					self:name("StageAward"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

local function PeakComboAward( pn )
	return loadfile( THEME:GetPathG(Var "LoadingScreen", "PeakComboAward"))(pn) .. {
		InitCommand=function(self) self:player(pn):name("PeakComboAward"..pname(pn)) end
	}
end

if ShowStandardDecoration("PeakComboAward") then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = PeakComboAward(pn) .. {
				InitCommand=function(self)
					self:name("PeakComboAward"..pname(pn))
					ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				end
			}
		end
	end
end

return t