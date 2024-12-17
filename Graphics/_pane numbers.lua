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

local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	InitCommand=function(self) self:y(-1) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end ) end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	Def.BitmapText {
		File = "smallnumbers",
		Name="Jumps",
		InitCommand=function(self) self:x(-127+100):diffusealpha(0):maxwidth(22) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local num, numSongs = 0, 1
			if SongOrCourse then
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if StepsOrTrail then
					num = StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Jumps')
					if courseMode then numSongs = TrailUtil.GetNumSongs(StepsOrTrail) end
				end
			end
			if SongOrCourse then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[1][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[1][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[1][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[1][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[1][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",math.max(0,num))
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
	Def.BitmapText {
		File = "smallnumbers",
		Name="Holds",
		InitCommand=function(self) self:x(-102+100):diffusealpha(0):maxwidth(22) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local num, numSongs = 0, 1
			if SongOrCourse then
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if StepsOrTrail then
					num = StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Jumps')
					if courseMode then numSongs = TrailUtil.GetNumSongs(StepsOrTrail) end
				end
			end
			if SongOrCourse then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[2][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[2][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[2][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[2][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[2][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",math.max(0,num))
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
	Def.BitmapText {
		File = "smallnumbers",
		Name="Mines",
		InitCommand=function(self) self:x(-77+100):diffusealpha(0):maxwidth(22) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local num, numSongs = 0, 1
			if SongOrCourse then
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if StepsOrTrail then
					num = StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Jumps')
					if courseMode then numSongs = TrailUtil.GetNumSongs(StepsOrTrail) end
				end
			end
			if SongOrCourse then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[3][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[3][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[3][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[3][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[3][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",math.max(0,num))
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
	Def.BitmapText {
		File = "smallnumbers",
		Name="Hands",
		InitCommand=function(self) self:x(-52+100):diffusealpha(0):maxwidth(22) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local num, numSongs = 0, 1
			if SongOrCourse then
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if StepsOrTrail then
					num = StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Jumps')
					if courseMode then numSongs = TrailUtil.GetNumSongs(StepsOrTrail) end
				end
			end
			if SongOrCourse then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[4][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[4][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[4][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[4][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[4][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",math.max(0,num))
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
	Def.BitmapText {
		File = "smallnumbers",
		Name="Rolls",
		InitCommand=function(self) self:x(-27+100):diffusealpha(0):maxwidth(22) end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local num, numSongs = 0, 1
			if SongOrCourse then
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if StepsOrTrail then
					num = StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Jumps')
					if courseMode then numSongs = TrailUtil.GetNumSongs(StepsOrTrail) end
				end
			end
			if SongOrCourse then
				self:visible(true)
				local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				if num <= stats[5][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
				elseif num <= stats[5][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
				elseif num <= stats[5][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
				elseif num <= stats[5][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
				elseif num <= stats[5][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
				else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
				end
				num = string.format("%03i",math.max(0,num))
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