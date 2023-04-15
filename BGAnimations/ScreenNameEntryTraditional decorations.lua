local t = LoadFallbackB()

local curFeatNumber = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1
}

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if not getenv("HighScoreable"..pname(pn)) then
		t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","OutOfRanking"))..{
			InitCommand=function(self)
				self:player(pn)
				self:name("OutOfRanking" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end,
			BeginCommand=function(self)
				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=curFeatNumber[pn]})
			end,
			MenuTimerExpiredMessageCommand = function(self)
				SCREENMAN:GetTopScreen():Finish(pn)
			end,
			RunFeatCommand=function(self)
				if not GAMESTATE:IsCourseMode() then
					self:sleep(THEME:GetMetric("ScreenNameEntryTraditional","FeatInterval"))
					self:queuecommand("DoChange")
				end
			end,
			DoChangeCommand=function(self)
				local curIndex = curFeatNumber[pn]
				local nextIndex = (curIndex%STATSMAN:GetStagesPlayed())+1

				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=nextIndex})
				curFeatNumber[pn] = nextIndex
				self:queuecommand("RunFeat")
			end,
		}
	else
		t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Keyboard"),pn)..{
			InitCommand=function(self)
				self:player(pn)
				self:name("Keyboard" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Selection"),pn)..{
			InitCommand=function(self)
				self:player(pn)
				self:name("Selection" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Wheel"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("Wheel" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","Score"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("Score" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
	t[#t+1] = LoadActor(THEME:GetPathG("ScreenNameEntryTraditional","DifficultyIcon"),pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("DifficultyIcon" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

t[#t+1] = StandardDecorationFromFile("Banner","Banner")

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if getenv("HighScoreable"..pname(pn)) then
		t[#t+1] = Def.Actor{
			Name="MasterController",
			BeginCommand=function(self)
				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=curFeatNumber[pn]})
			end,
			OnCommand=function(self) self:queuecommand("RunFeat") end,
			MenuTimerExpiredMessageCommand = function(self)
				SCREENMAN:GetTopScreen():Finish(pn)
			end,
			CodeMessageCommand=function(self,param)
				local ts = SCREENMAN:GetTopScreen()
				if ts:GetFinalized(pn) or ts:IsTransitioning() then
					return
				end

				if param.Name == "Left" or param.Name == "AltLeft" then
					MESSAGEMAN:Broadcast("KeyboardLeft",{Player=pn})
				elseif param.Name == "Right" or param.Name == "AltRight" then
					MESSAGEMAN:Broadcast("KeyboardRight",{Player=pn})
				elseif param.Name == "Backspace" then
					MESSAGEMAN:Broadcast("KeyboardEnter",{Player=pn})
				elseif param.Name == "Enter" then
					MESSAGEMAN:Broadcast("KeyboardEnter",{Player=pn})
				end
			end,
			RunFeatCommand=function(self)
				if not GAMESTATE:IsCourseMode() then
					self:sleep(THEME:GetMetric("ScreenNameEntryTraditional","FeatInterval"))
					self:queuecommand("DoChange")
				end
			end,
			DoChangeCommand=function(self)
				local curIndex = curFeatNumber[pn]
				local nextIndex = (curIndex%STATSMAN:GetStagesPlayed())+1

				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=nextIndex})
				curFeatNumber[pn] = nextIndex
				self:queuecommand("RunFeat")
			end
		}
	end
end

return t