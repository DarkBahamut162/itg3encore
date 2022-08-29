local player = ...
assert( player )

return Def.BitmapText{
	Font="_r bold numbers",
	Text="0.00%",

	Name=ToEnumShortString(player).."Score",
	InitCommand=function(self)
		self:valign(1):halign(1)
		self:diffuse(PlayerColor(player))
		self:zoom(1.1):x( _screen.cx - _screen.w/8 ):y(80)
		if player == PLAYER_2 then
			self:x( _screen.cx + _screen.w/3.4 )
		end
	end,
	OnCommand=function(self)
		self:visible(not getenv("HideScore"..ToEnumShortString(player)))
		self:diffuse(PlayerColor(player)):addy(-100):sleep(0.5):decelerate(0.8):addy(100) end;
	OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end;
	JudgmentMessageCommand=function(self,params)
		if params.TapNoteScore and params.TapNoteScore ~= 'TapNoteScore_Invalid'
			and params.TapNoteScore ~= 'TapNoteScore_None' then
			self:queuecommand("RedrawScore")
		end
	end,
	RedrawScoreCommand=function(self)
		local dp = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
		local percent = FormatPercentScore( dp ):sub(1,-2)
		self:settext(percent .. "%")
	end
}