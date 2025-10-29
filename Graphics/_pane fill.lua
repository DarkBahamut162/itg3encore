local player = ...
assert(player,"[Graphics/_pane fill] player required")
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

local function getValue(val0, val1, val2)
	return ((val0 - val1) / (val2 - val1))
end

local function RadarFillColor(self,stat,StepsOrTrail,RadarCategory)
	local yZoom = 0
	if StepsOrTrail then
		local numSongs = courseMode and TrailUtil.GetNumSongs(StepsOrTrail) or 1
		local val = math.max(0,StepsOrTrail:GetRadarValues(player):GetValue(RadarCategory))
		if val == stats[stat][1] then self:diffusecolor( color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1") )
		elseif val <= stats[stat][2] * numSongs then self:diffusecolor( color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1") ) yZoom = getValue(val, stats[1][1], stats[1][2])*24/5/(numSongs*2)
		elseif val <= stats[stat][3] * numSongs then self:diffusecolor( color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1") ) yZoom = getValue(val, stats[1][2], stats[1][3])*24/5/(numSongs*2)+(0.2*24)
		elseif val <= stats[stat][4] * numSongs then self:diffusecolor( color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1") ) yZoom = getValue(val, stats[1][3], stats[1][4])*24/5/(numSongs*2)+(0.4*24)
		elseif val <= stats[stat][5] * numSongs then self:diffusecolor( color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1") ) yZoom = getValue(val, stats[1][4], stats[1][5])*24/5/(numSongs*2)+(0.6*24)
		elseif val <= stats[stat][6] * numSongs then self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = getValue(val, stats[1][5], stats[1][6])*24/5/(numSongs*2)+(0.8*24)
		else self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = 24
		end
	end
	self:decelerate(0.1):zoomy(yZoom)
end

return Def.ActorFrame{
	InitCommand=function(self) self:y(-1) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end c = self:GetChildren() end,
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set") end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set") end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set") end end,
	CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set") end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening() end ):playcommand("Set") end end,
	SetCommand=function(self)
		local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local StepsOrTrail
		if SongOrCourse then
			StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
		end

		RadarFillColor(c.Jumps,1,StepsOrTrail,"RadarCategory_Jumps")
		RadarFillColor(c.Holds,2,StepsOrTrail,"RadarCategory_Holds")
		RadarFillColor(c.Mines,3,StepsOrTrail,"RadarCategory_Mines")
		RadarFillColor(c.Hands,4,StepsOrTrail,"RadarCategory_Hands")
		RadarFillColor(c.Rolls,5,StepsOrTrail,"RadarCategory_Rolls")
	end,
	Def.Quad{ Name="Jumps", InitCommand=function(self) self:x(-127+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0.5):blend(Blend.Add) end },
	Def.Quad{ Name="Holds", InitCommand=function(self) self:x(-102+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0.5):blend(Blend.Add) end },
	Def.Quad{ Name="Mines", InitCommand=function(self) self:x(-77+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0.5):blend(Blend.Add) end },
	Def.Quad{ Name="Hands", InitCommand=function(self) self:x(-52+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0.5):blend(Blend.Add) end },
	Def.Quad{ Name="Rolls", InitCommand=function(self) self:x(-27+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0.5):blend(Blend.Add) end }
}