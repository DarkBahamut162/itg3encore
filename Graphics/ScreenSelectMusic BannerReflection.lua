return Def.FadingBanner{
	InitCommand=function(self) self:playcommand("Set"):ztest(true):vertalign(bottom):zoomy(-1) end;
	BeginCommand=function(self) self:visible(not GAMESTATE:IsCourseMode()) end;
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local sortOrder = GAMESTATE:GetSortOrder()
		if song then
			self:LoadFromSong(song)
		elseif sortOrder == 'SortOrder_ModeMenu' then
			self:LoadFromSortOrder('SortOrder_ModeMenu')
		else
			-- load fallback first
			self:LoadFromSong(nil)

			local topScreen = SCREENMAN:GetTopScreen()
			if topScreen then
				local wheel = topScreen:GetMusicWheel()
				if wheel then
					local curIdx = wheel:GetCurrentIndex()
					local numItems = wheel:GetNumItems()

					-- chance is the second to last item on the wheel
					if curIdx+1 == numItems-1 then
						self:LoadRandom()
					elseif curIdx+1 ~= numItems then
						-- try to find group banner
					end
				end
			end
		end
		self:scaletoclipped(320,120)
	end;
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
	WheelMovingMessageCommand=function(self) self:queuecommand("Set") end;
};