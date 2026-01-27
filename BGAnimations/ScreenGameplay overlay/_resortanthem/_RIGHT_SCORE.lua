return Def.ActorFrame{
	Def.Sprite {
		Texture = "RIGHT_SCORE",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text White",
		InitCommand=function(self) self:x(71):y(32):horizalign(right):zoomx(0.95):zoomy(0.85) end,
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
	}
}