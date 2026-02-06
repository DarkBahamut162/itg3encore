return Def.ActorFrame{
	Def.Sprite {
		Texture = "LEFT_MAXCOMBO",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.BitmapText {
		File = "_iidx/ScoreDisplayNormal Text Blue",
		Text="   0",
		InitCommand=function(self) self:x(-6):y(45) end,
		ComboChangedMessageCommand=function(self,param)
			if param.Player == PLAYER_2 then self:visible(true) else self:visible(false) end
			local pss = param.PlayerStageStats
			local curCombo = pss:GetCurrentCombo()
			local maxCombo = pss:MaxCombo()
			if curCombo > maxCombo then self:settext(string.format("%4d",curCombo)):maxwidth(15*4) end
		end
	}
}