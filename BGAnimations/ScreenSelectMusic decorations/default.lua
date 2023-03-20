local t = LoadFallbackB()

t[#t+1] = LoadFont("_v 26px bold shadow") .. {
	InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-160*WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
	OnCommand=function(self) if isFinal() then self:addx(SCREEN_WIDTH) else self:addy(-100) end self:decelerate(0.75) if isFinal() then self:addx(-SCREEN_WIDTH) else self:addy(100) end end,
	OffCommand=function(self) self:accelerate(0.75) if isFinal() then self:addx(SCREEN_WIDTH) else self:addy(-100) end  end,
	BeginCommand=function(self) self:playcommand("Set") end,
	SortOrderChangedMessageCommand=function(self) self:playcommand("Set") end,
	SetCommand=function(self)
		local s = GAMESTATE:GetSortOrder()
		if s ~= nil then
			local s = SortOrderToLocalizedString( s )
			self:settext( "SORT: " .. string.upper( s ) )
			self:playcommand("Sort")
		else return end
	end
}

t[#t+1] = StandardDecorationFromFile("BannerReflection","BannerReflection")
t[#t+1] = StandardDecorationFromFile("Triangle","Triangle")

t[#t+1] = Def.FadingBanner{
	InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-91*WideScreenDiff()):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH):ztest(true):vertalign(bottom):playcommand("Set") end,
	OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
		local sortOrder = GAMESTATE:GetSortOrder()
		if song then
			self:LoadFromSong(song)
		elseif course then
			self:LoadFromCourse(course)
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
							self:LoadFromSongGroup(split("/",path)[2])
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

local function StepsDisplay(pn)
	local function set(self, player) self:SetFromGameState(player) end

	return Def.StepsDisplay {
		InitCommand=function(self) self:player(pn):Load("StepsDisplay",GAMESTATE:GetPlayerState(pn)) end,
		CurrentSongChangedMessageCommand=function(self) self:visible(GAMESTATE:GetCurrentSong() ~= nil) end,
		["CurrentSteps".. pname(pn) .."ChangedMessageCommand"]=function(self) set(self, pn) end,
		["CurrentTrail".. pname(pn) .."ChangedMessageCommand"]=function(self) set(self, pn) end
	}
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = StepsDisplay(pn) .. {
		InitCommand=function(self)
			self:player(pn):name("StepsDisplay" .. PlayerNumberToString(pn))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","opened"))..{
	OptionsListOpenedMessageCommand=function(self) self:play() end
}

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","closed"))..{
	OptionsListClosedMessageCommand=function(self) self:play() end
}

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","left"))..{
	OptionsListRightMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListLeftMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListQuickChangeMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self)self:play() end
}

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","start"))..{
	OptionsListStartMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListResetMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}
t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","pop"))..{
	OptionsListPopMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}
t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","push"))..{
	OptionsListPushMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}

t[#t+1] = LoadActor(THEME:GetPathS("ScreenSelectMusic","select down"))..{
	SelectMenuOpenedMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}

local function CDTitleUpdate(self)
	local song = GAMESTATE:GetCurrentSong()
	local cdtitle = self:GetChild("CDTitle")
	local height = cdtitle:GetHeight()
	local width = cdtitle:GetWidth()
	local size = 100

	if song then
		if song:HasCDTitle() then
			cdtitle:visible(true)
			cdtitle:Load(song:GetCDTitlePath())
		else
			cdtitle:visible(false)
		end
	else
		cdtitle:visible(false)
	end

	if height >= size and width >= size then
		if height >= width then
			cdtitle:zoom(size/height)
		else
			cdtitle:zoom(size/width)
		end
	elseif height >= size then
		cdtitle:zoom(size/height)
	elseif width >= size then
		cdtitle:zoom(size/width)
	else 
		cdtitle:zoom(1)
	end
end

t[#t+1] = Def.ActorFrame {
	Condition=IsUsingWideScreen(),
	InitCommand=function(self) self:x(SCREEN_CENTER_X+302):y(SCREEN_CENTER_Y-88):rotationz(90):SetUpdateFunction(CDTitleUpdate) end,
	OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
	Def.Sprite {
		Name="CDTitle",
		InitCommand=function(self) self:vertalign(bottom) end,
		OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectoffset(0.2):effectcolor1(color("#808080FF")):effectcolor2(color("#FFFFFFFF")):effectperiod(1):diffusealpha(0):linear(0.4):diffusealpha(1) end
	}
}

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathG('ScreenSelectMusic','BannerFrame')),
	StandardDecorationFromFile("ArtistDisplay","ArtistDisplay"),
	StandardDecorationFromFile("BPMDisplay","BPMDisplay"),
	StandardDecorationFromFile("CourseHasMods","CourseHasMods"),
	StandardDecorationFromFileOptional("SongTime","SongTime"),
	StandardDecorationFromFileOptional("StepsDisplayList","StepsDisplayList"),
	StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList")
}

return t