return Def.ActorFrame{
	Def.Sprite {
		Texture = "RIGHT_FA",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text Blue",
		InitCommand=function(self) self:x(64):y(46):horizalign(right) end,
		Text="     0",
		ScoreMessageCommand=function(self,param)
			if param.PLAYER == PLAYER_2 then
				if param.TYPE == "Score" then
					self:settext(string.format("%6d",param.SCORE)):maxwidth(15*6)
				elseif param.TYPE == "Percent" then
					self:settext(string.format("%4.2f%%",param.SCORE)):maxwidth(15*6)
				end
			end
		end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text White",
		InitCommand=function(self) self:x(64):y(64):horizalign(right) end,
		Text="     0",
		FAScoreMessageCommand=function(self,param)
			if param.PLAYER == PLAYER_2 then
				if param.TYPE == "Score" then
					self:settext(string.format("%6d",param.SCORE)):maxwidth(15*6)
				elseif param.TYPE == "Percent" then
					self:settext(string.format("%4.2f%%",param.SCORE)):maxwidth(15*6)
				end
			end
		end
	}
}