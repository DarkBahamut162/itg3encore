local finished = false
local loaded = false
local wait = true

return Def.ActorFrame{
	Def.Actor{
		OnCommand=function(self)
			self:sleep(1):queuecommand("Waited")
		end,
		WaitedCommand=function() wait = false end,
		LoadingKeysoundMessageCommand=function(self,params)
			if params.Done == true and not loaded then
				self:queuecommand("NextScreen")
				loaded = true
			end
		end,
		NextScreenCommand=function(self)
			if not wait and not finished then
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
				finished = true
			end
		end
	}
}