local t = LoadFallbackB()

local curFeatNumber = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1
}
local finished = {
	PlayerNumber_P1 = false,
	PlayerNumber_P2 = false
}

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end

	if not finished[event.PlayerNumber] then
		if getenv("HighScoreable"..pname(event.PlayerNumber)) then
			if event.type == "InputEventType_FirstPress" then
				if event.GameButton == "MenuLeft" then
					MESSAGEMAN:Broadcast("KeyboardLeft",{Player=event.PlayerNumber})
				elseif event.GameButton == "MenuRight" then
					MESSAGEMAN:Broadcast("KeyboardRight",{Player=event.PlayerNumber})
				elseif event.GameButton == "Select" then
					MESSAGEMAN:Broadcast("KeyboardBack",{Player=event.PlayerNumber})
				elseif event.GameButton == "Start" then
					MESSAGEMAN:Broadcast("KeyboardEnter",{Player=event.PlayerNumber})
				end
			elseif event.type == "InputEventType_Repeat" then
				if event.GameButton == "MenuLeft" then
					MESSAGEMAN:Broadcast("KeyboardLeft",{Player=event.PlayerNumber})
				elseif event.GameButton == "MenuRight" then
					MESSAGEMAN:Broadcast("KeyboardRight",{Player=event.PlayerNumber})
				end
			end
		else
			if event.type == "InputEventType_FirstPress" then
				if event.GameButton == "Start" then
					finished[event.PlayerNumber] = true
					SCREENMAN:GetTopScreen():Finish(event.PlayerNumber)
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
				end
			end
		end
	end
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if not getenv("HighScoreable"..pname(pn)) then
		t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","OutOfRanking"))()..{
			InitCommand=function(self)
				self:player(pn)
				self:name("OutOfRanking" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end,
			BeginCommand=function(self)
				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=curFeatNumber[pn]})
				if STATSMAN:GetStagesPlayed() > 1 then self:queuecommand("RunFeat") end
			end,
			MenuTimerExpiredMessageCommand = function(self)
				finished[pn] = true
				SCREENMAN:GetTopScreen():Finish(pn)
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
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
	else
		t[#t+1] = Def.Actor{
			Name="MasterController",
			BeginCommand=function(self)
				MESSAGEMAN:Broadcast("ChangeDisplayedFeat",{Player=pn,NewIndex=curFeatNumber[pn]})
			end,
			OnCommand=function(self) self:queuecommand("RunFeat") end,
			MenuTimerExpiredMessageCommand = function(self)
				finished[pn] = true
				SCREENMAN:GetTopScreen():Finish(pn)
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
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
			SelectKeyMessageCommand=function(self,param)
				if param.PlayerNumber == pn then
					local scroller = self:GetChild("KeyScroller")
					if param.Key == "BACK" then
						scroller:SetCurrentAndDestinationItem(scroller:GetNumItems()-2)
					elseif param.Key == "ENTER" then
						scroller:SetCurrentAndDestinationItem(scroller:GetNumItems()-1)
					end
				end
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","Keyboard"))(pn)..{
			InitCommand=function(self)
				self:player(pn)
				self:name("Keyboard" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
		t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","Selection"))(pn)..{
			InitCommand=function(self)
				self:player(pn)
				self:name("Selection" .. PlayerNumberToString(pn))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
	t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","Wheel"))(pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("Wheel" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
	t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","Score"))(pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("Score" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
	t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","DifficultyIcon"))(pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("DifficultyIcon" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
	t[#t+1] = loadfile(THEME:GetPathG("ScreenNameEntryTraditional","DifficultyMeter"))(pn)..{
		InitCommand=function(self)
			self:player(pn)
			self:name("DifficultyMeter" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "Banner"))() .. {
	InitCommand=function(self)
		self:name("Banner")
		ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
	end
}
t[#t+1] = Def.Actor{
	OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	EntryFinishedMessageCommand=function(self,param) finished[param.Player] = true end
}

return t