local Players = GAMESTATE:GetHumanPlayers()
local t = Def.ActorFrame{ 
	Name="GameplayUnderlay",
}

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
	t[#t+1] = LoadActor("Score", player)..{
		Condition=GAMESTATE:GetPlayMode() ~= "PlayMode_Oni" and GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave',
	}
	t[#t+1] = LoadActor("RemainingTime", player)..{
		Condition=GAMESTATE:GetPlayMode() == "PlayMode_Oni",
	}
	t[#t+1] = LoadActor("DeltaSeconds", player)..{
		Condition=GAMESTATE:GetPlayMode() == "PlayMode_Oni",
	}
end

return t;