local Players = GAMESTATE:GetHumanPlayers()
local t = Def.ActorFrame{ Name="GameplayUnderlay" }

t[#t+1] = Def.ActorFrame{
	LoadActor("ScreenFilter");
	LoadActor("beginner")..{
		Condition=GAMESTATE:GetPlayMode() == 'PlayMode_Regular' and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner';
	};
	LoadActor("stepstats")..{
		Condition=getenv("StatsDisplayP1") == true or getenv("StatsDisplayP2") == true;
	};
	LoadActor("danger");
	LoadActor("dead");
};

for player in ivalues(Players) do
	t[#t+1] = LoadActor("score", player)
end

return t;