local player = ...
assert(player,"[Graphics/ScreenSelectMusic PaneNumbers] player required")

local stats = {
	{0,	25,	50,	100,200,300},
	{0,	25,	50,	100,150,200},
	{0,	25,	50,	100,150,200},
	{0,	15,	30,	45,	60,	75},
	{0,	10,	20,	30,	40,	50}
}

local colors = {
	{0.4,	0.4,	0.4},
	{0,		1,		0},
	{1,		1,		0},
	{1,		0.5,	0},
	{1,		0,		0},
	{0,		0.75,	1}
}

return Def.ActorFrame{
	InitCommand=function(self) self:y(-1) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end end,
	LoadFont("smallnumbers")..{
		Name="Jumps",
		InitCommand=function(self) self:x(-127+100):diffusealpha(0):maxwidth(22) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 0, 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then num = steps:GetRadarValues(player):GetValue('RadarCategory_Jumps') end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Jumps')
					numSongs = TrailUtil.GetNumSongs(trail)
				end
			end
			if song or course then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[1][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[1][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[1][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[1][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[1][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",num)
				if IsCourseSecret() then num = "???" end
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	LoadFont("smallnumbers")..{
		Name="Holds",
		InitCommand=function(self) self:x(-102+100):diffusealpha(0):maxwidth(22) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 0, 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then num = steps:GetRadarValues(player):GetValue('RadarCategory_Holds') end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Holds')
					numSongs = TrailUtil.GetNumSongs(trail)
				end
			end
			if song or course then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[2][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[2][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[2][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[2][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[2][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",num)
				if IsCourseSecret() then num = "???" end
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	LoadFont("smallnumbers")..{
		Name="Mines",
		InitCommand=function(self) self:x(-77+100):diffusealpha(0):maxwidth(22) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 0, 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then num = steps:GetRadarValues(player):GetValue('RadarCategory_Mines') end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Mines')
					numSongs = TrailUtil.GetNumSongs(trail)
				end
			end
			if song or course then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[3][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[3][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[3][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[3][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[3][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",num)
				if IsCourseSecret() then num = "???" end
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	LoadFont("smallnumbers")..{
		Name="Hands",
		InitCommand=function(self) self:x(-52+100):diffusealpha(0):maxwidth(22) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 0, 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then num = steps:GetRadarValues(player):GetValue('RadarCategory_Hands') end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Hands')
					numSongs = TrailUtil.GetNumSongs(trail)
				end
			end
			if song or course then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[4][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[4][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[4][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[4][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[4][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",num)
				if IsCourseSecret() then num = "???" end
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	LoadFont("smallnumbers")..{
		Name="Rolls",
		InitCommand=function(self) self:x(-27+100):diffusealpha(0):maxwidth(22) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 0, 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then num = steps:GetRadarValues(player):GetValue('RadarCategory_Rolls') end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Rolls')
					numSongs = TrailUtil.GetNumSongs(trail)
				end
			end
			if song or course then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[5][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[5][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[5][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[5][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[5][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",num)
				if IsCourseSecret() then num = "???" end
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	}
}