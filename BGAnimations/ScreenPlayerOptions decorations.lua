local t = LoadFallbackB()

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = StandardDecorationFromFile("Disqualify"..ToEnumShortString(pn), "Disqualify")..{
			UpdateCommand=function(self)
				local disqualify = GAMESTATE:CurrentOptionsDisqualifyPlayer(pn)
				self:diffusealpha(disqualify and 1 or 0)
			end,
			ChangeValueMessageCommand=function(self,param)
				if param.PlayerNumber == pn then self:playcommand("Update") end
			end,
			ChangeRowMessageCommand=function(self,param)
				if param.PlayerNumber == pn then self:playcommand("Update") end
			end,
			SelectMultipleMessageCommand=function(self,param)
				if param.PlayerNumber == pn then self:playcommand("Update") end
			end
		}
	end
end

return t