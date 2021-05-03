-- name entry decorations
local t = LoadFallbackB()

-- Out of Ranking
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "OutOfRanking" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","OutOfRanking"))..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- Keyboard
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "Keyboard" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Keyboard"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- Selection (Entered name)
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "Selection" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Selection"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- Wheel
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "Wheel" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Wheel"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- Score
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "Score" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Score"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- Grade

-- DifficultyIcon
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "DifficultyIcon" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","DifficultyIcon"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name(MetricsName)
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

-- DifficultyDisplay
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "DifficultyDisplay" .. PlayerNumberToString(pn);
end

-- Banner
table.insert(t,StandardDecorationFromFile("Banner","Banner"))

-- current displayed feat (maximum is controlled by m_FeatDisplay[pn].size())
local curFeatNumber = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1
}

-- Master Controller
table.insert(t,Def.Actor{
	Name="MasterController",
	BeginCommand=function(self)
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=curFeatNumber[pn]})
		end
	end,
	OnCommand=cmd(queuecommand,"RunFeat"),

	-- Menu Timer message
	MenuTimerExpiredMessageCommand = function(self)
		for pn in ivalues(PlayerNumber) do
			SCREENMAN:GetTopScreen():Finish(pn)
		end
	end,

	-- inputs
	CodeMessageCommand=function(self,param)
		local ts = SCREENMAN:GetTopScreen()
		-- check if player is done entering name, or if screen is transitioning
		if ts:GetFinalized(param.PlayerNumber) or ts:IsTransitioning() then
			return
		end

		-- otherwise, handle inputs.
		-- param.PlayerNumber
		-- param.Name: "Left","Right","Backspace","Enter"

		if param.Name == "Left" or param.Name == "AltLeft" then
			MESSAGEMAN:Broadcast("KeyboardLeft",{Player=param.PlayerNumber})
		elseif param.Name == "Right" or param.Name == "AltRight" then
			MESSAGEMAN:Broadcast("KeyboardRight",{Player=param.PlayerNumber})
		elseif param.Name == "Backspace" then
			ts:Backspace(param.PlayerNumber)
			MESSAGEMAN:Broadcast("UpdateSelection",{Player=param.PlayerNumber})
		elseif param.Name == "Enter" then
			MESSAGEMAN:Broadcast("KeyboardEnter",{Player=param.PlayerNumber})

			-- todo: run any checks needed here?
		end
	end,

	-- only run the feat update in non-course modes
	RunFeatCommand=function(self)
		if not GAMESTATE:IsCourseMode() then
			self:sleep(THEME:GetMetric("ScreenNameEntryTraditional","FeatInterval"))
			self:queuecommand("DoChange")
		end
	end,
	-- broadcast a message in order for various theme elements to cycle.
	DoChangeCommand=function(self)
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local curIndex = curFeatNumber[pn]
			local nextIndex = (curIndex%STATSMAN:GetStagesPlayed())+1

			MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=nextIndex})
			curFeatNumber[pn] = nextIndex
		end
		self:queuecommand("RunFeat")
	end,
})

return t