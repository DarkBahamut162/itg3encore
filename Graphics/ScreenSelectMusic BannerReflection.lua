local courseMode = GAMESTATE:IsCourseMode()

return isEtterna() and Def.Sprite{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y+26*WideScreenDiff()):zoomy(-1):ztest(true) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local sortOrder = GAMESTATE:GetSortOrder()
			local bnpath
			if song then
				bnpath = song:GetBannerPath()
			elseif sortOrder == 'SortOrder_ModeMenu' then
				bnpath = THEME:GetPathG("Banner", "ModeMenu")
			else
				bnpath = SONGMAN:GetSongGroupBannerPath(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
			end
			if not bnpath or bnpath == "" then bnpath = THEME:GetPathG("Common", "fallback banner") end
			self:scaletoclipped(320*WideScreenDiff(),120*WideScreenDiff()):LoadBackground(bnpath):zoomy(-1):x(SCREEN_CENTER_X+140*WideScreenDiff())
		end,
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end
    } or Def.FadingBanner{
	InitCommand=function(self) self:playcommand("Set"):ztest(true):vertalign(bottom):zoomy(-1) end,
	SetCommand=function(self)
		local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local sortOrder = GAMESTATE:GetSortOrder()
		if SongOrCourse then
			if courseMode then self:LoadFromCourse(SongOrCourse) else self:LoadFromSong(SongOrCourse) end
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
							if isOutFoxV() then
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
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
	WheelMovingMessageCommand=function(self) self:queuecommand("Set") end
}