local enableRounds = ThemePrefs.Get("ShowRounds")
local enableLua = ThemePrefs.Get("ShowHasLua")

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local output = ""
			if song and (enableRounds or enableLua) then
				if enableRounds then
					if not GAMESTATE:IsEventMode() then
						if song:IsLong() then
							output = "COUNTS AS 2 ROUNDS"
							self:diffuseshift():effectcolor1(color("#FFFF00")):effectcolor2(color("#FFFFFF")):effectclock("beat")
						elseif song:IsMarathon() then
							output = "COUNTS AS 3 ROUNDS"
							self:diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#FFFFFF")):effectclock("beat")
						else
							self:stopeffect()
						end
					else
						if song:IsLong() then
							output = "LONG"
							self:diffuseshift():effectcolor1(color("#FFFF00")):effectcolor2(color("#FFFFFF")):effectclock("beat")
						elseif song:IsMarathon() then
							output = "MARATHON"
							self:diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#FFFFFF")):effectclock("beat")
						else
							self:stopeffect()
						end
					end
				end
				if enableLua then
					if isOutFox() then
						local step = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
						if step and tobool(LoadFromCache(song,step,"HasLua")) then
							self:rainbow():effectclock("beat")
							if string.len(output) == 0 then output = "LUA" else output = output.." & LUA" end
						end
					else
						if HasLuaCheck() then
							self:rainbow():effectclock("beat")
							if string.len(output) == 0 then output = "LUA" else output = output.." & LUA" end
						end
					end
				end
			else
				self:stopeffect()
			end
			self:settext(output)
		end,
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end
	}
}