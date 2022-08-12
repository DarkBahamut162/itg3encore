local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFile("BannerReflection","BannerReflection");
t[#t+1] = StandardDecorationFromFile("Triangle","Triangle");

t[#t+1] = Def.FadingBanner{
	InitCommand=function(self) self:x(SCREEN_CENTER_X+160-20):y(SCREEN_TOP+160-11):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH):ztest(true):vertalign(bottom):playcommand("Set") end;
	OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
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

					-- chance is the second to last item on the wheel
					if curIdx+1 == numItems-1 then
						self:LoadRandom()
					elseif curIdx+1 ~= numItems then
						local path = SONGMAN:GetSongGroupBannerPath( wheel:GetSelectedSection() )
						if path == "" or path == nil then
							self:LoadFromSong(nil)
						else
							self:LoadFromSongGroup(split("/",path)[2])
						end
					end
				end
			end
		end
		self:scaletoclipped(320,120)
	end;
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
	CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
	WheelMovingMessageCommand=function(self) self:queuecommand("Set") end;
};

-- stepsdisplay
local function StepsDisplay(pn)
	local function set(self, player) self:SetFromGameState(player); end

	local t = Def.StepsDisplay {
		InitCommand=function(self) self:player(pn):Load("StepsDisplay",GAMESTATE:GetPlayerState(pn)) end;
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			self:visible(song ~= nil)
		end;
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return t;
end

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local MetricsName = "StepsDisplay" .. PlayerNumberToString(pn);
	t[#t+1] = StepsDisplay(pn) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","opened"))..{
	OptionsListOpenedMessageCommand=function(self)
		self:play()
	end
}

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","closed"))..{
	OptionsListClosedMessageCommand=function(self)
		self:play()
	end
}

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","left"))..{
	OptionsListRightMessageCommand=function(self) self:queuecommand("Refresh")end,
	OptionsListLeftMessageCommand=function(self) self:queuecommand("Refresh")end,
	OptionsListQuickChangeMessageCommand=function(self) self:queuecommand("Refresh")end,
	RefreshCommand=function(self)
		self:play()
	end
}

t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","start"))..{
	OptionsListStartMessageCommand=function(self) self:queuecommand("Refresh")end,
	OptionsListResetMessageCommand=function(self) self:queuecommand("Refresh")end,
	RefreshCommand=function(self)
		self:play()
	end
}
t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","pop"))..{
	OptionsListPopMessageCommand=function(self) self:queuecommand("Refresh")end,
	RefreshCommand=function(self)
		self:play()
	end
}
t[#t+1] = LoadActor(THEME:GetPathS("OptionsList","push"))..{
	OptionsListPushMessageCommand=function(self) self:queuecommand("Refresh")end,
	RefreshCommand=function(self)
		self:play()
	end
}

t[#t+1] = LoadActor(THEME:GetPathS("ScreenSelectMusic","select down"))..{
	SelectMenuOpenedMessageCommand=function(self) self:queuecommand("Refresh")end,
	RefreshCommand=function(self)
		self:play()
	end
}

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathG('ScreenSelectMusic','BannerFrame'));
	StandardDecorationFromFile("ArtistDisplay","ArtistDisplay");
	StandardDecorationFromFile("BPMDisplay","BPMDisplay");
	StandardDecorationFromFile("CourseHasMods","CourseHasMods");
	StandardDecorationFromFileOptional("SongTime","SongTime");
	StandardDecorationFromFileOptional("StepsDisplayList","StepsDisplayList");
	StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList");
};

return t;