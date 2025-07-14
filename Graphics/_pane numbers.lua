local player = ...
assert(player,"[Graphics/ScreenSelectMusic PaneNumbers] player required")
local c

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

local function RadarPaneNumber(self,stat,StepsOrTrail,RadarCategory)
	if StepsOrTrail then
		local val = StepsOrTrail:GetRadarValues(player):GetValue(RadarCategory)
		local numSongs = courseMode and TrailUtil.GetNumSongs(StepsOrTrail) or 1
		local itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
		if val <= stats[stat][1] then itemColor = color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1")
		elseif val <= stats[stat][2] * numSongs then itemColor = color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1")
		elseif val <= stats[stat][3] * numSongs then itemColor = color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1")
		elseif val <= stats[stat][4] * numSongs then itemColor = color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1")
		elseif val <= stats[stat][5] * numSongs then itemColor = color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1")
		else itemColor = color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1")
		end
		val = string.format("%03i",math.max(0,val))
		if IsCourseSecret() then val = "???" end
		self:settext(val)
		self:diffusecolor(itemColor)
		self:visible(true)
	else
		self:visible(false)
	end
end

return Def.ActorFrame{
	InitCommand=function(self) self:y(-1) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end  c = self:GetChildren() end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set") end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set")  end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set")  end end,
	CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set")  end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set")  end end,
	SetCommand=function(self)
		local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local StepsOrTrail
		if SongOrCourse then
			StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
		end

		RadarPaneNumber(c.Jumps,1,StepsOrTrail,"RadarCategory_Jumps")
		RadarPaneNumber(c.Holds,2,StepsOrTrail,"RadarCategory_Holds")
		RadarPaneNumber(c.Mines,3,StepsOrTrail,"RadarCategory_Mines")
		RadarPaneNumber(c.Hands,4,StepsOrTrail,"RadarCategory_Hands")
		RadarPaneNumber(c.Rolls,5,StepsOrTrail,"RadarCategory_Rolls")
	end,
	Def.BitmapText {
		File = "smallnumbers",
		Name="Jumps",
		InitCommand=function(self) self:x(-127+100):diffusealpha(0):maxwidth(22) end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "smallnumbers",
		Name="Holds",
		InitCommand=function(self) self:x(-102+100):diffusealpha(0):maxwidth(22) end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "smallnumbers",
		Name="Mines",
		InitCommand=function(self) self:x(-77+100):diffusealpha(0):maxwidth(22) end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "smallnumbers",
		Name="Hands",
		InitCommand=function(self) self:x(-52+100):diffusealpha(0):maxwidth(22) end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "smallnumbers",
		Name="Rolls",
		InitCommand=function(self) self:x(-27+100):diffusealpha(0):maxwidth(22) end,
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(1) end,
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		OffCommand=function(self) self:stoptweening():linear(0.12):diffusealpha(0) end
	}
}