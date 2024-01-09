return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()):playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song and ThemePrefs.Get("ShowRounds") then
				if not GAMESTATE:IsEventMode() then
					if song:IsLong() then
						self:settext("COUNTS AS 2 ROUNDS"):diffuseshift():effectcolor1(color("#FFFF00")):effectcolor2(color("#FFFFFF")):effectclock("beat")
					elseif song:IsMarathon() then
						self:settext("COUNTS AS 3 ROUNDS"):diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#FFFFFF")):effectclock("beat")
					else
						self:settext(""):stopeffect()
					end
				else
					if song:IsLong() then
						self:settext("LONG"):diffuseshift():effectcolor1(color("#FFFF00")):effectcolor2(color("#FFFFFF")):effectclock("beat")
					elseif song:IsMarathon() then
						self:settext("MARATHON"):diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#FFFFFF")):effectclock("beat")
					else
						self:settext(""):stopeffect()
					end
				end
			else
				self:settext(""):stopeffect()
			end
		end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end
	}
}