local t = Def.ActorFrame{
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

return t;