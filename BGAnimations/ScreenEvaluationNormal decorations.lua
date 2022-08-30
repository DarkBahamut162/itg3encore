local t = LoadFallbackB()

if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(PlayerNumber) do
		if (GAMESTATE:IsPlayerEnabled(pn) or isRave()) and Var "LoadingScreen" ~= "ScreenEvaluationSummary" then
			local t2 = Def.ActorFrame{
				InitCommand=function(self) self:player(pn) end,
				LoadActor(THEME:GetPathG("_difficulty","icons"))..{
					InitCommand=function(self) self:zoomy(0.8):animate(0):zoomx((pn==PLAYER_2) and -0.8 or 0.8):playcommand("Update") end,
					UpdateCommand=function(self)
						local course = GAMESTATE:GetCurrentTrail(pn)
						local steps = GAMESTATE:GetCurrentSteps(pn)
						if course then
							self:setstate(DifficultyToState(course:GetDifficulty()))
						elseif steps then
							self:setstate(DifficultyToState(steps:GetDifficulty()))
						end
					end
				},
				Def.StepsDisplay {
					InitCommand=function(self) self:Load("StepsDisplayEvaluation",pn):SetFromGameState(pn) end,
					UpdateNetEvalStatsMessageCommand=function(self,param)
						if GAMESTATE:IsPlayerEnabled(pn) or isRave() then
							self:SetFromSteps(param.Steps)
						end
					end
				}
			}
			t[#t+1] = StandardDecorationFromTable("StepsDisplay"..ToEnumShortString(pn), t2)
		end
	end
end

for pn in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
			InitCommand=function(self) 
				self:player(pn):name("MachineRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

for pn in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn)..{
			InitCommand=function(self) 
				self:player(pn):name("PersonalRecord" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

local function GraphDisplay(pn)
	return Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=function(self) self:Load("GraphDisplay"..ToEnumShortString(pn)) end,
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
			end
		}
	}
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("GraphDisplay"..ToEnumShortString(pn), GraphDisplay(pn))
		end
	end
end

local function ComboGraph( pn )
	return Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=function(self) self:Load("ComboGraph"..ToEnumShortString(pn)) end,
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats()
				self:Set( ss, ss:GetPlayerStageStats(pn) ):player( pn )
			end
		}
	}
end

if ShowStandardDecoration("ComboGraph") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("ComboGraph"..ToEnumShortString(pn), ComboGraph(pn))
		end
	end
end

local function StageAward( pn )
	return LoadActor(THEME:GetPathG("ScreenEvaluation", "StageAward"), pn)..{
		InitCommand=function(self) 
			self:player(pn):name("StageAward"..ToEnumShortString(pn))
		end
	}
end

if ShowStandardDecoration("StageAward") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("StageAward"..ToEnumShortString(pn), StageAward(pn))
		end
	end
end

local function PeakComboAward( pn )
	return LoadActor( THEME:GetPathG(Var "LoadingScreen", "PeakComboAward"), pn ) .. {
		InitCommand=function(self) 
			self:player(pn):name("PeakComboAward"..ToEnumShortString(pn))
		end
	}
end

if ShowStandardDecoration("PeakComboAward") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("PeakComboAward"..ToEnumShortString(pn), PeakComboAward(pn))
		end
	end
end

return t