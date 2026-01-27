return Def.ActorFrame{
	Def.Sprite {
		Texture = "LEFT_BOTH",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text Blue",
		InitCommand=function(self) self:x(26):y(32):horizalign(right) end,
		Text="     0",
		ScoreMessageCommand=function(self,param)
			if param.PLAYER == PLAYER_1 then
				if param.TYPE == "Score" then
					self:settext(string.format("%6d",param.SCORE)):maxwidth(15*6)
				elseif param.TYPE == "Percent" then
					self:settext(string.format("%4.2f%%",param.SCORE)):maxwidth(15*6)
				end
			else
				if GAMESTATE:GetNumPlayersEnabled() == 1 then self:visible(false) end
			end
		end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text Blue",
		Text="   0",
		InitCommand=function(self) self:x(-4):y(48) end,
		ComboChangedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				local pss = param.PlayerStageStats
				local curCombo = pss:GetCurrentCombo()
				local maxCombo = pss:MaxCombo()
				if curCombo > maxCombo then self:settext(string.format("%4d",curCombo)):maxwidth(15*4) end
			else
				if GAMESTATE:GetNumPlayersEnabled() == 1 then self:visible(false) end
			end
		end
	}
}