local t = LoadFallbackB()

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if GAMESTATE:IsPlayerEnabled(pn) then
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "Disqualify"))(pn) .. {
			InitCommand=function(self)
				self:player(pn):name("Disqualify"..pname(pn)):playcommand("Update")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end,
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