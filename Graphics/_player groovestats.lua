local player = ...
assert(player,"[Graphics/_player scores] player required")

return Def.ActorFrame{
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	Def.Sprite {
		Name="GrooveStats",
		Texture = THEME:GetPathG("GS","White"),
		InitCommand=function(self) self:x(player == PLAYER_1 and 146 or -146):y(73):setsize(20,20):shadowlength(1):diffuse(color("#00000000")) end,
		ForceUpdateMessageCommand=function(self) self:queuecommand("On") end,
		OnCommand=function(self)
			if not isGrooveStats(player) then
				self:diffuse(color("#FF0000"))
			elseif GS and GS[player] and not GS[player].IsPadPlayer then
				self:diffuse(color("#FF8000"))
			else
				local _,check = ValidForGrooveStats(player)
				if not check then
					self:diffuse(color("#FFFF00"))
				else
					self:diffuse(color("#00FF00"))
				end
			end
		end
	}
}