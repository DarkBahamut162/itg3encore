return Def.FadingBanner{
	InitCommand=function(self) self:playcommand("Set"):ztest(true):vertalign(bottom):zoomy(-1) end,
	BeginCommand=function(self) self:visible(not GAMESTATE:IsCourseMode()) end,
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local sortOrder = GAMESTATE:GetSortOrder()
		if song then
			self:LoadFromSong(song)
		elseif sortOrder == 'SortOrder_ModeMenu' then
			self:LoadFromSortOrder('SortOrder_ModeMenu')
		else
			local topScreen = SCREENMAN:GetTopScreen()
			if topScreen then
				local wheel = topScreen:GetMusicWheel()
				if wheel then
					local curIdx = wheel:GetCurrentIndex()
					local numItems = wheel:GetNumItems()

					if curIdx+1 == numItems-1 then
						self:LoadRandom()
					elseif curIdx+1 ~= numItems then
						local path = SONGMAN:GetSongGroupBannerPath( wheel:GetSelectedSection() )
						if path == "" or path == nil then
							self:LoadFromSong(nil)
						else
							if ProductFamily() == "OutFox" and tonumber(split("-",ProductVersion())[1]) == 0.5 then
								self:LoadFromSongGroup(split("/",path)[3])
							else
								self:LoadFromSongGroup(split("/",path)[2])
							end
						end
					elseif curIdx == 0 then
						self:LoadFromSong(nil)
					end
				end
			end
		end
		self:scaletoclipped(320*WideScreenDiff(),120*WideScreenDiff())
	end,
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
	CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end,
	WheelMovingMessageCommand=function(self) self:queuecommand("Set") end
}