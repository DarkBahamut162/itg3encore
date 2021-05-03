local Player = ...
if not Player then error("[ScreenNameEntryTraditional Selection] needs Player") end

return Def.ActorFrame{
	LoadFont("ScreenNameEntryTraditional entry")..{
		InitCommand=cmd(halign,0;zoom,1.1),
		EntryChangedMessageCommand=function(self,param)
			if param.PlayerNumber == Player then
				self:settext(param.Text)
			end
		end
	}
}
