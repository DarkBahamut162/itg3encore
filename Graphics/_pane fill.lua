local player = ...
assert(player,"[Graphics/_pane fill] player required")

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

return Def.ActorFrame{
	InitCommand=function(self) self:y(-1) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end ) end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:stoptweening():playcommand("Set") end )  end end,
	Def.Quad{
		Name="Jumps",
		InitCommand=function(self) self:x(-127+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end,
		BeginCommand=function(self) self:stoptweening():playcommand("Set") end,
		OnCommand=function(self) self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end,
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local steps
			if SongOrCourse then
				steps = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if courseMode then if steps then numSongs = TrailUtil.GetNumSongs(steps) end end
			else
				yZoom = 0
			end
			if steps then
				local val = math.max(0,steps:GetRadarValues(player):GetValue('RadarCategory_Jumps'))
				if val == stats[1][1] then self:diffusecolor( color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1") ) yZoom = 0
				elseif val <= stats[1][2] * numSongs then self:diffusecolor( color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1") ) yZoom = getValue(val, stats[1][1], stats[1][2])*24/5/(numSongs*2)
				elseif val <= stats[1][3] * numSongs then self:diffusecolor( color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1") ) yZoom = getValue(val, stats[1][2], stats[1][3])*24/5/(numSongs*2)+(0.2*24)
				elseif val <= stats[1][4] * numSongs then self:diffusecolor( color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1") ) yZoom = getValue(val, stats[1][3], stats[1][4])*24/5/(numSongs*2)+(0.4*24)
				elseif val <= stats[1][5] * numSongs then self:diffusecolor( color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1") ) yZoom = getValue(val, stats[1][4], stats[1][5])*24/5/(numSongs*2)+(0.6*24)
				elseif val <= stats[1][6] * numSongs then self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = getValue(val, stats[1][5], stats[1][6])*24/5/(numSongs*2)+(0.8*24)
				else self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = 24
				end
			else
				yZoom = 0
			end

			if isEtterna() then if self:GetDiffuseAlpha() < 0.5 then self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end end
			self:decelerate(0.1):zoomy(yZoom)
		end,
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
	},
	Def.Quad{
		Name="Holds",
		InitCommand=function(self) self:x(-102+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end,
		BeginCommand=function(self) self:stoptweening():playcommand("Set") end,
		OnCommand=function(self) self:sleep(0.4):decelerate(0.1):diffusealpha(0.5) end,
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local steps
			if SongOrCourse then
				steps = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if courseMode then if steps then numSongs = TrailUtil.GetNumSongs(steps) end end
			else
				yZoom = 0
			end
			if steps then
				local val = math.max(0,steps:GetRadarValues(player):GetValue('RadarCategory_Holds'))
				if val == stats[2][1] then self:diffusecolor( color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1") ) yZoom = 0
				elseif val <= stats[2][2] * numSongs then self:diffusecolor( color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1") ) yZoom = getValue(val, stats[2][1], stats[2][2])*24/5/(numSongs*2)
				elseif val <= stats[2][3] * numSongs then self:diffusecolor( color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1") ) yZoom = getValue(val, stats[2][2], stats[2][3])*24/5/(numSongs*2)+(0.2*24)
				elseif val <= stats[2][4] * numSongs then self:diffusecolor( color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1") ) yZoom = getValue(val, stats[2][3], stats[2][4])*24/5/(numSongs*2)+(0.4*24)
				elseif val <= stats[2][5] * numSongs then self:diffusecolor( color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1") ) yZoom = getValue(val, stats[2][4], stats[2][5])*24/5/(numSongs*2)+(0.6*24)
				elseif val <= stats[2][6] * numSongs then self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = getValue(val, stats[2][5], stats[2][6])*24/5/(numSongs*2)+(0.8*24)
				else self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = 24
				end
			else
				yZoom = 0
			end

			if isEtterna() then if self:GetDiffuseAlpha() < 0.5 then self:sleep(0.4):decelerate(0.1):diffusealpha(0.5) end end
			self:decelerate(0.1):zoomy(yZoom)
		end,
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
	},
	Def.Quad{
		Name="Mines",
		InitCommand=function(self) self:x(-77+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end,
		BeginCommand=function(self) self:stoptweening():playcommand("Set") end,
		OnCommand=function(self) self:sleep(0.5):decelerate(0.1):diffusealpha(0.5) end,
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local steps
			if SongOrCourse then
				steps = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if courseMode then if steps then numSongs = TrailUtil.GetNumSongs(steps) end end
			else
				yZoom = 0
			end
			if steps then
				local val = math.max(0,steps:GetRadarValues(player):GetValue('RadarCategory_Mines'))
				if val == stats[3][1] then self:diffusecolor( color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1") ) yZoom = 0
				elseif val <= stats[3][2] * numSongs then self:diffusecolor( color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1") ) yZoom = getValue(val, stats[3][1], stats[3][2])*24/5/(numSongs*2)
				elseif val <= stats[3][3] * numSongs then self:diffusecolor( color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1") ) yZoom = getValue(val, stats[3][2], stats[3][3])*24/5/(numSongs*2)+(0.2*24)
				elseif val <= stats[3][4] * numSongs then self:diffusecolor( color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1") ) yZoom = getValue(val, stats[3][3], stats[3][4])*24/5/(numSongs*2)+(0.4*24)
				elseif val <= stats[3][5] * numSongs then self:diffusecolor( color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1") ) yZoom = getValue(val, stats[3][4], stats[3][5])*24/5/(numSongs*2)+(0.6*24)
				elseif val <= stats[3][6] * numSongs then self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = getValue(val, stats[3][5], stats[3][6])*24/5/(numSongs*2)+(0.8*24)
				else self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = 24
				end
			else
				yZoom = 0
			end

			if isEtterna() then if self:GetDiffuseAlpha() < 0.5 then self:sleep(0.5):decelerate(0.1):diffusealpha(0.5) end end
			self:decelerate(0.1):zoomy(yZoom)
		end,
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
	},
	Def.Quad{
		Name="Hands",
		InitCommand=function(self) self:x(-52+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end,
		BeginCommand=function(self) self:stoptweening():playcommand("Set") end,
		OnCommand=function(self) self:sleep(0.6):decelerate(0.1):diffusealpha(0.5) end,
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local steps
			if SongOrCourse then
				steps = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if courseMode then if steps then numSongs = TrailUtil.GetNumSongs(steps) end end
			else
				yZoom = 0
			end
			if steps then
				local val = math.max(0,steps:GetRadarValues(player):GetValue('RadarCategory_Hands'))
				if val == stats[4][1] then self:diffusecolor( color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1") ) yZoom = 0
				elseif val <= stats[4][2] * numSongs then self:diffusecolor( color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1") ) yZoom = getValue(val, stats[4][1], stats[4][2])*24/5/(numSongs*2)
				elseif val <= stats[4][3] * numSongs then self:diffusecolor( color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1") ) yZoom = getValue(val, stats[4][2], stats[4][3])*24/5/(numSongs*2)+(0.2*24)
				elseif val <= stats[4][4] * numSongs then self:diffusecolor( color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1") ) yZoom = getValue(val, stats[4][3], stats[4][4])*24/5/(numSongs*2)+(0.4*24)
				elseif val <= stats[4][5] * numSongs then self:diffusecolor( color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1") ) yZoom = getValue(val, stats[4][4], stats[4][5])*24/5/(numSongs*2)+(0.6*24)
				elseif val <= stats[4][6] * numSongs then self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = getValue(val, stats[4][5], stats[4][6])*24/5/(numSongs*2)+(0.8*24)
				else self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = 24
				end
			else
				yZoom = 0
			end

			if isEtterna() then if self:GetDiffuseAlpha() < 0.5 then self:sleep(0.6):decelerate(0.1):diffusealpha(0.5) end end
			self:decelerate(0.1):zoomy(yZoom)
		end,
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
	},
	Def.Quad{
		Name="Rolls",
		InitCommand=function(self) self:x(-27+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end,
		BeginCommand=function(self) self:stoptweening():playcommand("Set") end,
		OnCommand=function(self) self:sleep(0.7):decelerate(0.1):diffusealpha(0.5) end,
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local steps
			if SongOrCourse then
				steps = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				if courseMode then if steps then numSongs = TrailUtil.GetNumSongs(steps) end end
			else
				yZoom = 0
			end
			if steps then
				local val = math.max(0,steps:GetRadarValues(player):GetValue('RadarCategory_Rolls'))
				if val == stats[5][1] then self:diffusecolor( color(colors[1][1]..","..colors[1][2]..","..colors[1][3]..",1") ) yZoom = 0
				elseif val <= stats[5][2] * numSongs then self:diffusecolor( color(colors[2][1]..","..colors[2][2]..","..colors[2][3]..",1") ) yZoom = getValue(val, stats[5][1], stats[5][2])*24/5/(numSongs*2)
				elseif val <= stats[5][3] * numSongs then self:diffusecolor( color(colors[3][1]..","..colors[3][2]..","..colors[3][3]..",1") ) yZoom = getValue(val, stats[5][2], stats[5][3])*24/5/(numSongs*2)+(0.2*24)
				elseif val <= stats[5][4] * numSongs then self:diffusecolor( color(colors[4][1]..","..colors[4][2]..","..colors[4][3]..",1") ) yZoom = getValue(val, stats[5][3], stats[5][4])*24/5/(numSongs*2)+(0.4*24)
				elseif val <= stats[5][5] * numSongs then self:diffusecolor( color(colors[5][1]..","..colors[5][2]..","..colors[5][3]..",1") ) yZoom = getValue(val, stats[5][4], stats[5][5])*24/5/(numSongs*2)+(0.6*24)
				elseif val <= stats[5][6] * numSongs then self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = getValue(val, stats[5][5], stats[5][6])*24/5/(numSongs*2)+(0.8*24)
				else self:diffusecolor( color(colors[6][1]..","..colors[6][2]..","..colors[6][3]..",1") ) yZoom = 24
				end
			else
				yZoom = 0
			end

			if isEtterna() then if self:GetDiffuseAlpha() < 0.5 then self:sleep(0.7):decelerate(0.1):diffusealpha(0.5) end end
			self:decelerate(0.1):zoomy(yZoom)
		end,
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
	}
}