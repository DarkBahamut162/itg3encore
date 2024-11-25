local Player = ...
if not Player then error("[ScreenNameEntryTraditional Selection] needs Player") end

setenv("HighScoreNameP1",GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
setenv("HighScoreNameP2",GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))

return Def.ActorFrame{
	Def.BitmapText {
		File = "ScreenNameEntryTraditional entry",
		InitCommand=function(self) self:settext(getenv("HighScoreName"..pname(Player))):zoom(1.1):maxwidth(240) end,
		EntryChangedMessageCommand=function(self,param)
			if param.Player == Player then self:settext(getenv("HighScoreName"..pname(Player))) end
		end
	}
}