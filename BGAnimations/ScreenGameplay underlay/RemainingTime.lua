local player = ...
assert( player )

return Def.BitmapText{
	Font= "_r bold numbers",
	Name="SurvivalTime",
	Text="0:00:00",
	InitCommand=function(self)
		self:valign(1):halign(1)
		self:zoom(1.1):x( _screen.cx - _screen.w/8 ):y(80)
		if player == PLAYER_2 then
			self:x( _screen.cx + _screen.w/3.4 )
		end
		self:shadowlength(1):diffuse(PlayerColor(player)):diffusebottomedge(ColorMidTone(PlayerColor(player)))
		self:settext(SecondsToMSSMsMs( STATSMAN:GetCurStageStats():GetPlayerStageStats( player ):GetLifeRemainingSeconds() ))
		self:queuecommand('Update')
	end,
	OnCommand=function(self) self:addy(-100):sleep(0.5):decelerate(0.8):addy(100) end;
	OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1); end self:accelerate(0.8); self:addy(-100); end;
	UpdateCommand=function(self)
		self:settext(SecondsToMSSMsMs( STATSMAN:GetCurStageStats():GetPlayerStageStats( player ):GetLifeRemainingSeconds() ))
		self:sleep(0.01666)
		self:queuecommand('Update')
	end,
}