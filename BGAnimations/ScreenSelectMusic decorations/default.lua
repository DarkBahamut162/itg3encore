local t = LoadFallbackB()
local courseMode = GAMESTATE:IsCourseMode()

t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "BannerReflection"))() .. {
	InitCommand=function(self)
		self:name("BannerReflection")
		ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
	end
}
t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "Triangle"))() .. {
	InitCommand=function(self)
		self:name("Triangle")
		ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
	end
}

if isEtterna() then
	t[#t+1] = Def.Sprite {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-91*WideScreenDiff()):ztest(true) end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
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
			self:scaletoclipped(320*WideScreenDiff(),120*WideScreenDiff()):LoadBackground(bnpath):x(SCREEN_CENTER_X+140*WideScreenDiff())
		end,
		CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end
    }
elseif not (isOutFoxV() or isOldStepMania()) then
	t[#t+1] = Def.FadingBanner{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-91*WideScreenDiff()):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH):ztest(true):vertalign(bottom):playcommand("Set") end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local sortOrder = GAMESTATE:GetSortOrder()
			if courseMode and SongOrCourse then
				self:LoadFromCourse(SongOrCourse)
			elseif not courseMode and SongOrCourse then
				self:LoadFromSong(SongOrCourse)
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
		CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
		WheelMovingMessageCommand=function(self) self:queuecommand("Set") end
	}
end

local function StepsDisplay(pn)
	local function set(self, player) self:SetFromGameState(player) end

	return Def.StepsDisplay {
		InitCommand=function(self) self:player(pn):Load("StepsDisplay",GAMESTATE:GetPlayerState(pn)) end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then self:visible(GAMESTATE:GetCurrentSong() ~= nil) end end,
		["CurrentSteps".. pname(pn) .."ChangedMessageCommand"]=function(self) if not courseMode then set(self, pn) end end,
		CurrentStepsChangedMessageCommand=function(self) if not courseMode then set(self, pn) end end,
		["CurrentTrail".. pname(pn) .."ChangedMessageCommand"]=function(self) if courseMode then set(self, pn) end end
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

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","opened"),
	OptionsListOpenedMessageCommand=function(self) self:play() end
}

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","closed"),
	OptionsListClosedMessageCommand=function(self) self:play() end
}

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","left"),
	OptionsListRightMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListLeftMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListQuickChangeMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self)self:play() end
}

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","start"),
	OptionsListStartMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListResetMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}
t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","pop"),
	OptionsListPopMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}
t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","push"),
	OptionsListPushMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("ScreenSelectMusic","select down"),
	SelectMenuOpenedMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
}

local function CDTitleUpdate(self)
	local song = GAMESTATE:GetCurrentSong()
	local cdtitle = self:GetChild("CDTitle")
	local size = 100

	if song then
		if song:HasCDTitle() then
			cdtitle:Load(song:GetCDTitlePath())
			local height = cdtitle:GetHeight()
			local width = cdtitle:GetWidth()

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
			cdtitle:visible(true)
		else
			cdtitle:visible(false)
		end
	else
		cdtitle:visible(false)
	end
end

t[#t+1] = Def.ActorFrame {
	Condition=not courseMode and (IsUsingWideScreen() or GetScreenAspectRatio() <= 1),
	InitCommand=function(self)
		if IsUsingWideScreen() then
			self:x(SCREEN_CENTER_X+302):y(SCREEN_CENTER_Y-88):rotationz(90)
		elseif GetScreenAspectRatio() <= 1 then
			self:x(SCREEN_CENTER_X+302*WideScreenDiff()):y(SCREEN_CENTER_Y-154*WideScreenDiff()):zoom(WideScreenDiff())
		end
	end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then CDTitleUpdate(self) end end,
	OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
	Def.Sprite {
		Name="CDTitle",
		InitCommand=function(self)self:vertalign(bottom) if GetScreenAspectRatio() <= 1 then self:horizalign(right) end end,
		OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectoffset(0.2):effectcolor1(color("#808080FF")):effectcolor2(color("#FFFFFFFF")):effectperiod(1):diffusealpha(0):linear(0.4):diffusealpha(1) end
	}
}

t[#t+1] = Def.ActorFrame{
	loadfile(THEME:GetPathG('ScreenSelectMusic','BannerFrame'))(),
	loadfile(THEME:GetPathG(Var "LoadingScreen", "ArtistDisplay"))() .. {
		InitCommand=function(self)
			self:name("ArtistDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	},
	loadfile(THEME:GetPathG(Var "LoadingScreen", "InfoDisplay"))() .. {
		InitCommand=function(self)
			self:name("InfoDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	},
	loadfile(THEME:GetPathG(Var "LoadingScreen", "SongTime"))() .. {
		InitCommand=function(self)
			self:name("SongTime")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
}

local enableMOD = ThemePrefs.Get("ShowMODDisplay")

t[#t+1] = Def.ActorFrame{
	loadfile(THEME:GetPathG(Var "LoadingScreen", "BPMDisplay"))() .. {
		InitCommand=function(self)
			self:name("BPMDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end,
		OnCommand=function(self) self:stoptweening():stopeffect():diffusealpha(1):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) if enableMOD then self:queuecommand("Animate") end end,
		AnimateCommand=function(self) self:diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):queuecommand("Animate") end,
		RateChangedMessageCommand=function(self) if enableMOD then self:stoptweening():stopeffect():diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):queuecommand("Animate") end end,
		SpeedChoiceChangedMessageCommand=function(self) if enableMOD then self:stoptweening():stopeffect():diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):queuecommand("Animate") end end,
		OffCommand=function(self) self:stoptweening():stopeffect():accelerate(0.75):addx(SCREEN_WIDTH) end
	}
}
if enableMOD then
	t[#t+1] = Def.ActorFrame{
		loadfile(THEME:GetPathG(Var "LoadingScreen", "MODDisplay"))() .. {
			InitCommand=function(self)
				self:name("MODDisplay")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end,
			OnCommand=function(self) self:stoptweening():stopeffect():diffusealpha(0):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH):queuecommand("Animate") end,
			AnimateCommand=function(self) self:diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):queuecommand("Animate") end,
			RateChangedMessageCommand=function(self) if enableMOD then self:stoptweening():stopeffect():diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):queuecommand("Animate") end end,
			SpeedChoiceChangedMessageCommand=function(self) if enableMOD then self:stoptweening():stopeffect():diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):queuecommand("Animate") end end,
			OffCommand=function(self) self:stoptweening():stopeffect():accelerate(0.75):addx(SCREEN_WIDTH) end
		}
	}
end

if not courseMode then
	if ShowStandardDecoration("StepsDisplayList") then
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StepsDisplayList"))() .. {
			InitCommand=function(self)
				self:name("StepsDisplayList")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
else
	if ShowStandardDecoration("CourseContentsList") then
		t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "CourseContentsList"))() .. {
			InitCommand=function(self)
				self:name("CourseContentsList")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	end
end

t[#t+1] = Def.BitmapText {
	File = "_v 26px bold shadow",
	InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-154*WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
	OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
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

return t