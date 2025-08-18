function OptionsRowWeight()
	local function IndexToPounds(i)
		return i*5
	end

	local function AllChoices()
		local ret = { }
		for i = 1,100 do
			ret[i] = string.format('%d lbs/%d kg',IndexToPounds(i),IndexToPounds(i)/2.204)
		end
		return ret
	end

	local t = {
		Name = "Weight",
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = AllChoices(),
		LoadSelections = function(self, list, pn)
			local val = PROFILEMAN:GetProfile(pn):GetWeightPounds()
			if val <= 0 then val = 100 end
			for i = 1,table.getn(self.Choices) do
				if val == IndexToPounds(i) then
					list[i] = true
					return
				end
			end
			list[20] = true -- 100 lbs
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,table.getn(self.Choices) do
				if list[i] then
					PROFILEMAN:GetProfile(pn):SetWeightPounds( IndexToPounds(i) )
					return
				end
			end
		end
	}	
	setmetatable( t, t )
	return t
end

function GetPlayersWithGoalType( gt )
	local t = {}
	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsHumanPlayer(pn) and WorkoutGetProfileGoalType(pn) == gt then
			t[pn] = pn
		end
	end
	return t
end

function OptionsRowGoalCalories()
	local function IndexToCalories(i)
		return i*10+20
	end

	local function AllChoices()
		local ret = { }
		for i = 1,98 do ret[i] = IndexToCalories(i).." cals" end
		return ret
	end

	local t = {
		Name = "GoalCalories",
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = true,
		Choices = AllChoices(),
		EnabledForPlayers = function() return GetPlayersWithGoalType( 0 ) end,
		ReloadRowMessages = { "GoalTypeChanged" },
		LoadSelections = function(self, list, pn)
			local val = PROFILEMAN:GetProfile(pn):GetGoalCalories()
			for i = 1,table.getn(self.Choices) do
				if val == IndexToCalories(i) then
					list[i] = true
					return
				end
			end
			list[13] = true	-- 150 cals
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,table.getn(self.Choices) do
				if list[i] then
					PROFILEMAN:GetProfile(pn):SetGoalCalories( IndexToCalories(i) )
					return
				end
			end
		end
	}	
	setmetatable( t, t )
	return t
end

function OptionsRowGoalSeconds()
	local function IndexToSeconds(i)
		return i*60+4*60
	end

	local function AllChoices()
		local ret = { }
		for i = 1,56 do ret[i] = (IndexToSeconds(i)/60).." mins" end
		return ret
	end

	local t = {
		Name = "GoalTime",
		LayoutType = "ShowOneInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = true,
		Choices = AllChoices(),
		EnabledForPlayers = function() return GetPlayersWithGoalType( 1 ) end,
		ReloadRowMessages = { "GoalTypeChanged" },
		LoadSelections = function(self, list, pn)
			local val = PROFILEMAN:GetProfile(pn):GetGoalSeconds()
			for i = 1,table.getn(self.Choices) do
				if val == IndexToSeconds(i) then
					list[i] = true
					return
				end
			end
			list[6] = true	-- 10 mins
		end,
		SaveSelections = function(self, list, pn)
			for i = 1,table.getn(self.Choices) do
				if list[i] then
					PROFILEMAN:GetProfile(pn):SetGoalSeconds( IndexToSeconds(i) )
					return
				end
			end
		end
	}	
	setmetatable( t, t )
	return t
end

function WorkoutResetStageStats()
	STATSMAN:Reset()
end

function WorkoutGetProfileGoalType( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalType()
end

function WorkoutGetStageCalories( pn )
	return STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetCaloriesBurned()
end

function WorkoutGetTotalCaloriesEvaluation( pn )
	return STATSMAN:GetAccumPlayedStageStats():GetPlayerStageStats(pn):GetCaloriesBurned()
end

function WorkoutGetTotalCaloriesGameplay( pn )
	return WorkoutGetTotalCaloriesEvaluation( pn ) + WorkoutGetStageCalories( pn )
end

function WorkoutGetTotalSeconds( pn )
	return STATSMAN:GetAccumPlayedStageStats():GetGameplaySeconds()
end

function WorkoutGetGoalCalories( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalCalories()
end

function WorkoutGetGoalSeconds( pn )
	return PROFILEMAN:GetProfile(pn):GetGoalSeconds()
end

function WorkoutGetPercentCompleteCaloriesEvaluation( pn )
	return WorkoutGetTotalCaloriesEvaluation(pn) / WorkoutGetGoalCalories(pn)
end

function WorkoutGetPercentCompleteCaloriesGameplay( pn )
	return WorkoutGetTotalCaloriesGameplay(pn) / WorkoutGetGoalCalories(pn)
end

function WorkoutGetPercentCompleteSeconds( pn )
	return WorkoutGetTotalSeconds(pn) / WorkoutGetGoalSeconds(pn)
end