local finished = false
local wait = true

return Def.ActorFrame{
	Def.Actor{
		OnCommand=function(self)
			self:sleep(1):queuecommand("Waited")
		end,
		WaitedCommand=function() wait = false end,
		LoadingKeysoundMessageCommand=function(self,params)
			if params.Done == true then
				self:queuecommand("NextScreen")
			end
		end,
		NextScreenCommand=function(self)
			if wait == false and finished == false then
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
				finished = true
			end
		end
	},
}