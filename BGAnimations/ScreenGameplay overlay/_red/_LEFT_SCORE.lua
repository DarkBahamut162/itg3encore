return Def.ActorFrame{
	Def.Sprite {
		Texture = "LEFT_SCORE",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text Blue",
		InitCommand=function(self) self:x(19):y(51):horizalign(right) end,
		Text="     0",
		ScoreMessageCommand=function(self,param)
			if param.PLAYER == PLAYER_1 then
				if param.TYPE == "Score" then
					self:settext(string.format("%6d",param.SCORE)):maxwidth(15*6)
				elseif param.TYPE == "Percent" then
					self:settext(string.format("%4.2f%%",param.SCORE)):maxwidth(15*6)
				end
			end
		end
	}
}