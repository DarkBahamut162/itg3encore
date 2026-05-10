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

if isEtterna("0.65") then
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
elseif bannerForced and not isOutFoxV() then
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
	OptionsListOpenedMessageCommand=function(self) self:play() end,
	ControlMenuOpenedP1MessageCommand=function(self) self:play() end,
	ControlMenuOpenedP2MessageCommand=function(self) self:play() end,
	ShiftMenuOpenedP1MessageCommand=function(self) self:play() end,
	ShiftMenuOpenedP2MessageCommand=function(self) self:play() end
}

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","closed"),
	OptionsListClosedMessageCommand=function(self) self:play() end,
	ControlMenuClosedP1MessageCommand=function(self) self:play() end,
	ControlMenuClosedP2MessageCommand=function(self) self:play() end,
	ShiftMenuClosedP1MessageCommand=function(self) self:play() end,
	ShiftMenuClosedP2MessageCommand=function(self) self:play() end
}

t[#t+1] = Def.Sound {
	File = THEME:GetPathS("OptionsList","left"),
	OptionsListRightMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListLeftMessageCommand=function(self) self:queuecommand("Refresh") end,
	OptionsListQuickChangeMessageCommand=function(self) self:queuecommand("Refresh") end,
	RefreshCommand=function(self) self:play() end
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
		InitCommand=function(self) self:vertalign(bottom) if GetScreenAspectRatio() <= 1 then self:horizalign(right) end end,
		OnCommand=function(self) self:effectclock('beat'):diffuseramp():effectoffset(0.2):effectcolor1(color("#808080FF")):effectcolor2(color("#FFFFFFFF")):effectperiod(1):diffusealpha(0):linear(0.4):diffusealpha(1) end
	}
}

local Artist, Origin

t[#t+1] = Def.ActorFrame{
	CurrentSongChangedMessageCommand=function(self)
		if not courseMode and ThemePrefs.Get("ShowOrigin") then
			if SCREENMAN:GetTopScreen():IsTransitioning() then
				Artist:stoptweening():queuecommand("Off")
				Origin:stoptweening():queuecommand("Off") 
			elseif (GAMESTATE:GetCurrentSong() and GetSMParameter(GAMESTATE:GetCurrentSong(),"ORIGIN") or "") == "" then
				Artist:stoptweening():diffusealpha(1)
				Origin:stoptweening():diffusealpha(0)
			else
				Artist:stoptweening():queuecommand("AnimateArtist")
				Origin:stoptweening():queuecommand("AnimateOrigin") 
			end
		end
	end,
	loadfile(THEME:GetPathG('ScreenSelectMusic','BannerFrame'))(),
	loadfile(THEME:GetPathG(Var "LoadingScreen", "ArtistDisplay"))() .. {
		InitCommand=function(self)
			self:name("ArtistDisplay")
			Artist = self
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			if not courseMode and ThemePrefs.Get("ShowOrigin") then self:queuecommand("AnimateArtist") else self:diffusealpha(1) end
		end,
		AnimateArtistCommand=function(self) self:diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):queuecommand("AnimateArtist") end,
		OffCommand=function(self) self:stoptweening():stopeffect():accelerate(0.75):addx(SCREEN_WIDTH) end
	},
	loadfile(THEME:GetPathG(Var "LoadingScreen", "OriginDisplay"))() .. {
		InitCommand=function(self)
			self:name("OriginDisplay")
			Origin = self
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			if not courseMode and ThemePrefs.Get("ShowOrigin") then self:queuecommand("AnimateOrigin") else self:diffusealpha(0) end
		end,
		AnimateOriginCommand=function(self) self:diffusealpha(0):sleep(1.75):linear(0.25):diffusealpha(1):sleep(1.75):linear(0.25):diffusealpha(0):queuecommand("AnimateOrigin") end,
		OffCommand=function(self) self:stoptweening():stopeffect():accelerate(0.75):addx(SCREEN_WIDTH) end
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
			local s = SortOrderToLocalizedString(s)
			self:settext("SORT: ".. s:upper())
			self:playcommand("Sort")
		else return end
	end
}

local levels = {
	[2] = "StageAward_FullComboW3",
	[3] = "StageAward_SingleDigitW3",
	[4] = "StageAward_OneW3",
	[5] = "StageAward_FullComboW2",
	[6] = "StageAward_SingleDigitW2",
	[7] = "StageAward_OneW2",
	[8] = "StageAward_FullComboW1"
}

local states = {
	["StageAward_FullComboW3"]		= 2,
	["StageAward_SingleDigitW3"]	= 3,
	["StageAward_OneW3"]			= 4,
	["StageAward_FullComboW2"]		= 5,
	["StageAward_SingleDigitW2"]	= 6,
	["StageAward_OneW2"]			= 7,
	["StageAward_FullComboW1"]		= 8
}


if ThemePrefs.Get("ShowPackClears") and not courseMode then
	t[#t+1] = Def.ActorFrame {
		InitCommand=function(self) self:x(SCREEN_CENTER_X+132*WideScreenDiff()):y(SCREEN_CENTER_Y+12*WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
		CurrentSongChangedMessageCommand=function(self) self:visible(GAMESTATE:GetCurrentSong() == nil) end,
		Def.BitmapText {
			File = "_v 26px bold shadow",
			InitCommand=function(self) self:valign(0) end,
			CurrentSongChangedMessageCommand=function(self)
				local visible = GAMESTATE:GetCurrentSong() == nil
				self:visible(visible)
				if visible then
					local songs = SONGMAN:GetSongsInGroup(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
					local stepsType = StepsTypeSingle()[GetUserPrefN("StylePosition")]
					local songsTotal = 0
					local songsCleared = {}
					local stepsTotal = 0
					local stepsCleared = {}
					local FC = {
						[PLAYER_1]={["MFC"]=0,["PFC"]=0,["GFC"]=0},
						[PLAYER_2]={["MFC"]=0,["PFC"]=0,["GFC"]=0}
					}
					local grades = {
						[PLAYER_1]={},
						[PLAYER_2]={}
					}
					for s=1,#songs do
						local currentSongCleared = {}
						local currentSongClearedCheck = {}
						if songs[s]:HasStepsType(stepsType) then
							songsTotal = songsTotal + 1
							local steps = songs[s]:GetStepsByStepsType(stepsType)
							for ss=1,#steps do
								stepsTotal = stepsTotal + 1
								for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
									local grade = false
									local level = 0
									local profile = PROFILEMAN:GetProfile(pn):GetHighScoreList(songs[s],steps[ss]):GetHighScores()
									if #profile > 0 then
										for place,highscore in pairs(profile) do
											if not grade then
												grades[pn][highscore:GetGrade()] = (grades[pn][highscore:GetGrade()] or 0) + 1
												currentSongClearedCheck[pn]=currentSongClearedCheck[pn] or highscore:GetGrade()~="Grade_Failed"
												grade = true
											end
											if not ThemePrefs.Get("ShowLamps") then break end
											if level <= 0 then 
												if highscore:GetGrade() ~= "Grade_Failed" then level = 1 elseif level <= 0 then level = -1 end
											end
											local stageAward = highscore:GetStageAward()
											if states[stageAward] then
												if states[stageAward] > level then level = states[stageAward] end
											end
										end
										if level == 8 then
											FC[pn]["MFC"] = FC[pn]["MFC"] + 1
										elseif level >= 5 then
											FC[pn]["PFC"] = FC[pn]["PFC"] + 1
										elseif level >= 2 then
											FC[pn]["GFC"] = FC[pn]["GFC"] + 1
										end
										if currentSongClearedCheck[pn] then
											currentSongCleared[pn] = (currentSongCleared[pn] or 0) + 1
											stepsCleared[pn] = (stepsCleared[pn] or 0) + 1
										end
									end
								end
							end
						end
						for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
							if (currentSongCleared[pn] or 0) > 0 then songsCleared[pn] = (songsCleared[pn] or 0) + 1 end
						end
					end
					if songsTotal == 0 then self:settext("") else
						local attributes = {}
						local text = "Cleared Songs: "
						for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
							attributes[#attributes+1]={FIRST=string.len(''..text),LENGTH=string.len(''..(songsCleared[pn] or 0)),COLOR=PlayerColor(pn)}
							text = text..(songsCleared[pn] or 0)..((#GAMESTATE:GetHumanPlayers() == 2 and pn == PLAYER_1) and "|" or "")
						end
						text = text.."/"..songsTotal.." ("
						for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
							attributes[#attributes+1]={FIRST=string.len(''..text),LENGTH=string.len(''..string.format("%03.2f%%",(songsCleared[pn] or 0)/songsTotal*100)),COLOR=PlayerColor(pn)}
							text = text..string.format("%03.2f%%",(songsCleared[pn] or 0)/songsTotal*100)..((#GAMESTATE:GetHumanPlayers() == 2 and pn == PLAYER_1) and "|" or "")
						end
						text = text..")\nCleared Steps: "
						for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
							attributes[#attributes+1]={FIRST=string.len(''..text),LENGTH=string.len(''..(stepsCleared[pn] or 0)),COLOR=PlayerColor(pn)}
							text = text..(stepsCleared[pn] or 0)..((#GAMESTATE:GetHumanPlayers() == 2 and pn == PLAYER_1) and "|" or "")
						end
						text = text.."/"..stepsTotal.." ("
						for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
							attributes[#attributes+1]={FIRST=string.len(''..text),LENGTH=string.len(''..string.format("%03.2f%%",(stepsCleared[pn] or 0)/stepsTotal*100)),COLOR=PlayerColor(pn)}
							text = text..string.format("%03.2f%%",(stepsCleared[pn] or 0)/stepsTotal*100)..((#GAMESTATE:GetHumanPlayers() == 2 and pn == PLAYER_1) and "|" or "")
						end
						text = text..")"
						self:settext(text):ClearAttributes()
						
						for attribute in ivalues(attributes) do
							self:AddAttribute(attribute.FIRST,{
								Length = attribute.LENGTH,
								Diffuse = attribute.COLOR
							})
						end
						
					end
					for grade in ivalues({
						"Grade_Tier01","Grade_Tier02","Grade_Tier03","Grade_Tier04",
						"Grade_Tier05","Grade_Tier06","Grade_Tier07",
						"Grade_Tier08","Grade_Tier09","Grade_Tier10",
						"Grade_Tier11","Grade_Tier12","Grade_Tier13",
						"Grade_Tier14","Grade_Tier15","Grade_Tier16",
						"Grade_Tier17","Grade_Tier18","Grade_Failed"
					}) do
						self:GetParent():GetChild("Grades"):diffusealpha(songsTotal == 0 and 0 or 1)
						local text = ""
						local attributes = {}
						for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
							attributes[#attributes+1]={FIRST=string.len(''..text),LENGTH=string.len(''..(grades[pn][grade] or 0)),COLOR=PlayerColor(pn)}
							text = text..(grades[pn][grade] or 0).."|"
						end
						self:GetParent():GetChild("Grades"):GetChild(grade):settext(text):ClearAttributes()
						for attribute in ivalues(attributes) do
							self:GetParent():GetChild("Grades"):GetChild(grade):AddAttribute(attribute.FIRST,{
								Length = attribute.LENGTH,
								Diffuse = attribute.COLOR
							})
						end
					end
					if ThemePrefs.Get("ShowLamps") then
						for fc in ivalues({"MFC","PFC","GFC"}) do
							local text = ""
							local attributes = {}
							for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
								attributes[#attributes+1]={FIRST=string.len(''..text),LENGTH=string.len(''..(FC[pn][fc] or 0)),COLOR=PlayerColor(pn)}
								text = text..(FC[pn][fc] or 0).."|"
							end
							self:GetParent():GetChild("Grades"):GetChild(fc):settext(text):ClearAttributes()
							for attribute in ivalues(attributes) do
								self:GetParent():GetChild("Grades"):GetChild(fc):AddAttribute(attribute.FIRST,{
									Length = attribute.LENGTH,
									Diffuse = attribute.COLOR
								})
							end
						end
					end
				end
			end
		},
		Def.ActorFrame {
			Name="Grades",
			InitCommand=function(self) self:x(-24) end,
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="☆☆☆☆",
				InitCommand=function(self) self:x(-192):y(64):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="☆☆☆",
				InitCommand=function(self) self:x(-192):y(96):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="☆☆",
				InitCommand=function(self) self:x(-192):y(128):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="☆",
				InitCommand=function(self) self:x(-192):y(160):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="S+",
				InitCommand=function(self) self:x(-64):y(64):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="S",
				InitCommand=function(self) self:x(-64):y(96):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="S-",
				InitCommand=function(self) self:x(-64):y(128):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="A+",
				InitCommand=function(self) self:x(32):y(64):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="A",
				InitCommand=function(self) self:x(32):y(96):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="A-",
				InitCommand=function(self) self:x(32):y(128):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="B+",
				InitCommand=function(self) self:x(128):y(64):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="B",
				InitCommand=function(self) self:x(128):y(96):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="B-",
				InitCommand=function(self) self:x(128):y(128):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="C+",
				InitCommand=function(self) self:x(224):y(64):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="C",
				InitCommand=function(self) self:x(224):y(96):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="C-",
				InitCommand=function(self) self:x(224):y(128):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="D+",
				InitCommand=function(self) self:x(320):y(64):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="D",
				InitCommand=function(self) self:x(320):y(96):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="F",
				InitCommand=function(self) self:x(320):y(128):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FC",
				InitCommand=function(self) self:visible(ThemePrefs.Get("ShowLamps")):x(-64):y(160):diffuse(color("#7BE8FF")):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FC",
				InitCommand=function(self) self:visible(ThemePrefs.Get("ShowLamps")):x(128):y(160):diffuse(color("#FFA959")):valign(0):halign(0) end
			},
			Def.BitmapText {
				File = "_v 26px bold shadow",
				Text="FC",
				InitCommand=function(self) self:visible(ThemePrefs.Get("ShowLamps")):x(320):y(160):diffuse(color("#67FF19")):valign(0):halign(0) end
			},
			Def.BitmapText {
				Name="Grade_Tier01",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-192):y(64):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier02",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-192):y(96):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier03",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-192):y(128):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier04",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-192):y(160):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier05",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-64):y(64):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier06",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-64):y(96):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier07",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-64):y(128):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier08",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(32):y(64):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier09",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(32):y(96):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier10",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(32):y(128):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier11",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(128):y(64):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier12",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(128):y(96):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier13",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(128):y(128):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier14",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(224):y(64):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier15",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(224):y(96):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier16",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(224):y(128):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier17",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(320):y(64):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Tier18",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(320):y(96):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="Grade_Failed",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(320):y(128):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="MFC",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(-64):y(160):diffuse(color("#7BE8FF")):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="PFC",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(128):y(160):diffuse(color("#FFA959")):valign(0):halign(1) end
			},
			Def.BitmapText {
				Name="GFC",
				File = "_v 26px bold shadow",
				InitCommand=function(self) self:x(320):y(160):diffuse(color("#67FF19")):valign(0):halign(1) end
			}
		}
	}
end

return t