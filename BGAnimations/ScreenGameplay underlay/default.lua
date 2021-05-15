local Players = GAMESTATE:GetHumanPlayers()
local t = Def.ActorFrame{ Name="GameplayUnderlay" }

t[#t+1] = Def.ActorFrame{
	LoadActor("ScreenFilter");
	LoadActor("beginner")..{
		InitCommand=function(self)
			local pm = GAMESTATE:GetPlayMode()
			local isBeginner = GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner'
			self:visible(pm == 'PlayMode_Regular' and isBeginner)
		end;
	};
	LoadActor("stepstats")..{
		InitCommand=function(self)
			local statsP1 = getenv("StatsDisplayP1")
			local statsP2 = getenv("StatsDisplayP2")
			self:visible(statsP1 == true or statsP2 == true)
		end;
	};
	LoadActor("danger");
	LoadActor("dead");
};

for player in ivalues(Players) do
	t[#t+1] = LoadActor("score", player)
end

return t;