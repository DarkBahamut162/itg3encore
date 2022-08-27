local Players = GAMESTATE:GetHumanPlayers()
local t = Def.ActorFrame{ 
	Name="GameplayUnderlay",
}

local stats = false;
if getenv("ShowStatsP1") == nil and getenv("ShowStatsP2") == nil then
elseif getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0 then
	stats = true;
end

t[#t+1] = Def.ActorFrame{
	LoadActor("ScreenFilter");
	LoadActor("beginner")..{
		Condition=GAMESTATE:GetPlayMode() == 'PlayMode_Regular' and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner';
	};
	LoadActor("stepstats")..{
		Condition=stats;
	};
	LoadActor("danger")..{
		Condition=not isOni();
	};
	LoadActor("dead");
};

for player in ivalues(Players) do
	t[#t+1] = LoadActor("Score", player)..{
		Condition=not isOni() and not isRave();
	}
	t[#t+1] = LoadActor("RemainingTime", player)..{
		Condition=isOni() and not isLifeline(player);
	}
	t[#t+1] = LoadActor("DeltaSeconds", player)..{
		Condition=isOni() and not isLifeline(player);
	}
	t[#t+1] = LoadActor("Lives", player)..{
		Condition=isOni() and isLifeline(player);
		InitCommand=function(self)
			if player == PLAYER_1 then
				self:x(SCREEN_LEFT+20):y(OffsetLifebarHeight(PLAYER_1))
			else
				self:x(SCREEN_RIGHT-20):y(OffsetLifebarHeight(PLAYER_2))
			end
		end;
	}
end

return t;