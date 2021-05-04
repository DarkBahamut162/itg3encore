local player = ...

return Def.BitmapText{
    Font="_r bold numbers",
    Text="0.00%",

    Name=ToEnumShortString(player).."Score",
    InitCommand=function(self)
        self:valign(1):halign(1)

        self:zoom(1.1):x( _screen.cx - _screen.w/8 ):y(80)
        if player == PLAYER_2 then
            self:x( _screen.cx + _screen.w/3.4 )
        end
    end,
    JudgmentMessageCommand=function(self) self:queuecommand("RedrawScore") end,
    RedrawScoreCommand=function(self)
        local dp = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
        local percent = FormatPercentScore( dp ):sub(1,-2)
        self:settext(percent .. "%")
    end
}