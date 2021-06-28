local t = LoadFallbackB();

-- StepsDisplay
if ShowStandardDecoration("StepsDisplay") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			local t2 = Def.ActorFrame{
				InitCommand=function(self) self:player(pn) end;
				LoadActor(THEME:GetPathG("_difficulty","icons"))..{
					InitCommand=function(self) self:zoomy(.8):animate(0):zoomx((pn==PLAYER_2) and -0.8 or 0.8):playcommand("Update") end;
					UpdateCommand=function(self)
						local course = GAMESTATE:GetCurrentTrail(pn)
						local steps = GAMESTATE:GetCurrentSteps(pn)
						if course then
							self:setstate(DifficultyToState(course:GetDifficulty()))
						elseif steps then
							self:setstate(DifficultyToState(steps:GetDifficulty()))
						end
					end;
				};
				Def.StepsDisplay {
					InitCommand=function(self) self:Load("StepsDisplayEvaluation",pn):SetFromGameState(pn) end;
					UpdateNetEvalStatsMessageCommand=function(self,param)
						if GAMESTATE:IsPlayerEnabled(pn) then
							self:SetFromSteps(param.Steps)
						end;
					end;
				};
			};
			t[#t+1] = StandardDecorationFromTable("StepsDisplay"..ToEnumShortString(pn), t2);
		end
	end
end

-- records text
for pn in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		local MetricsName = "MachineRecord" .. PlayerNumberToString(pn);
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
			InitCommand=function(self) 
				self:player(pn); 
				self:name(MetricsName); 
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
			end;
		};
	end
end

for pn in ivalues(PlayerNumber) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
		t[#t+1] = LoadActor(THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn)..{
			InitCommand=function(self) 
				self:player(pn); 
				self:name(MetricsName); 
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
			end;
		};
	end
end

-- life graph
local function GraphDisplay(pn)
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=function(self) self:Load("GraphDisplay"..ToEnumShortString(pn)) end;
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("GraphDisplay"..ToEnumShortString(pn), GraphDisplay(pn));
		end
	end
end

-- combo graph
local function ComboGraph( pn )
	local t = Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=function(self) self:Load("ComboGraph"..ToEnumShortString(pn)) end;
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end

if ShowStandardDecoration("ComboGraph") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("ComboGraph"..ToEnumShortString(pn), ComboGraph(pn));
		end;
	end;
end;

-- awards
local function StageAward( pn )
	local MetricsName = "StageAward"..ToEnumShortString(pn);
	return LoadActor(THEME:GetPathG("ScreenEvaluation", "StageAward"), pn)..{
		InitCommand=function(self) 
			self:player(pn); 
			self:name(MetricsName); 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
		end;
	};
end
if ShowStandardDecoration("StageAward") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("StageAward"..ToEnumShortString(pn), StageAward(pn));
		end;
	end;
end;

local function PeakComboAward( pn )
	local MetricsName = "PeakComboAward"..ToEnumShortString(pn);
	return LoadActor( THEME:GetPathG(Var "LoadingScreen", "PeakComboAward"), pn ) .. {
		InitCommand=function(self) 
			self:player(pn); 
			self:name(MetricsName); 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
		end;
	};
end
if ShowStandardDecoration("PeakComboAward") then
	for pn in ivalues(PlayerNumber) do
		if GAMESTATE:IsPlayerEnabled(pn) then
			t[#t+1] = StandardDecorationFromTable("PeakComboAward"..ToEnumShortString(pn), PeakComboAward(pn));
		end;
	end;
end;

if GAMESTATE:GetPlayMode() == "PlayMode_Oni" then
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
		InitCommand=function(self) self:x(SCREEN_CENTER_X-156+EvalX()):y(SCREEN_CENTER_Y-60):draworder(101):zoom(2.5) end,
		OnCommand=function(self) self:addx(-EvalTweenDistance()):decelerate(0.5):addx(EvalTweenDistance()):sleep(2.5):decelerate(0.5):zoom(1):x(SCREEN_CENTER_X-56+EvalX()):y(SCREEN_CENTER_Y+48) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end,
		Def.BitmapText{
			Font="_r bold shadow 30px",
			Text="Total Time:",
			InitCommand=function(self) self:shadowlength(0):y(-10):horizalign(left):x(-40):zoom(0.6):skewx(-0.18):diffusebottomedge(color("#1F15E9")) end
		},
		Def.BitmapText{
			Font="_r bold shadow 30px",
			Text="????",
			InitCommand=function(self) local s=SecondsToMSSMsMs( STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetSurvivalSeconds() ); self:settext(s) end,
			OnCommand=function(self) self:shadowlength(0):x(10):y(10):zoom(0.8):diffusebottomedge(0.7,0.7,0.7,1) end
		},
	}
	t[#t+1] = Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
		InitCommand=function(self) self:x(SCREEN_CENTER_X+156+EvalX()):y(SCREEN_CENTER_Y-60):draworder(101):zoom(2.5) end,
		OnCommand=function(self) self:addx(EvalTweenDistance()):decelerate(0.5):addx(-EvalTweenDistance()):sleep(2.5):decelerate(0.5):zoom(1):x(SCREEN_CENTER_X+56+EvalX()):y(SCREEN_CENTER_Y+48) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end,
		Def.BitmapText{
			Font="_r bold shadow 30px",
			Text="Total Time:",
			InitCommand=function(self) self:shadowlength(0):y(-10):horizalign(left):x(-40):zoom(0.6):skewx(-0.18):diffusebottomedge(color("#1F15E9")) end,
		},
		Def.BitmapText{
			Font="_r bold shadow 30px",
			Text="????",
			InitCommand=function(self) local s=SecondsToMSSMsMs( STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetSurvivalSeconds() ); self:settext(s) end,
			OnCommand=function(self) self:shadowlength(0):x(10):y(10):zoom(0.8):diffusebottomedge(0.7,0.7,0.7,1) end,
		},
	}
end

return t;