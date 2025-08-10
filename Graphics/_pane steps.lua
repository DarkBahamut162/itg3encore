local player = ...
assert(player,"[Graphics/_pane steps] player required")
local c

local topedge = {
	color("1,1,1"),
	color("0,1,0"),
	color("0.75,1,0"),
	color("1,1,0"),
	color("1,0.53,0"),
	color("1,0.4,0"),
	color("0,0.75,1"),
	color("0.66,0,1"),
	color("1,0,0"),
	color("0.99,0.29,1")
}

local bottomedge = {
	color("0.89,0.89,0.89"),
	color("0.35,1,0.35"),
	color("0.84,1,0.33"),
	color("1,1,0.38"),
	color("1,0.65,0.25"),
	color("1,0.58,0.30"),
	color("0.38,0.85,1"),
	color("0.76,0.31,1"),
	color("1,0.33,0.33"),
	color("1,1,1")
}

local courseMode = GAMESTATE:IsCourseMode()

local function StepsDifficultyColor(self,SongOrCourse,StepsOrTrail,RadarCategory)
	if SongOrCourse and StepsOrTrail and (not courseMode or (courseMode and not IsCourseSecret())) then
		local numSongs = courseMode and TrailUtil.GetNumSongs(StepsOrTrail) or 1
		val = 0
		if RadarCategory == "RadarCategory_Notes" and not VersionDateCheck(20150500) then
			val = RadarCategory_Notes(SongOrCourse,StepsOrTrail)
		else
			val = StepsOrTrail:GetRadarValues(player):GetValue(RadarCategory)
		end
		if not courseMode or (courseMode and not IsCourseSecret()) then
			if val == 0 then
				self:diffusetopedge(topedge[1])
				self:diffusebottomedge(bottomedge[1])
			elseif val <= 249 * numSongs then
				self:diffusetopedge(topedge[2])
				self:diffusebottomedge(bottomedge[2])
			elseif val <= 374 * numSongs then
				self:diffusetopedge(topedge[3])
				self:diffusebottomedge(bottomedge[3])
			elseif val <= 499 * numSongs then
				self:diffusetopedge(topedge[4])
				self:diffusebottomedge(bottomedge[4])
			elseif val <= 624 * numSongs then
				self:diffusetopedge(topedge[5])
				self:diffusebottomedge(bottomedge[5])
			elseif val <= 749 * numSongs then
				self:diffusetopedge(topedge[6])
				self:diffusebottomedge(bottomedge[6])
			elseif val <= 874 * numSongs then
				self:diffusetopedge(topedge[7])
				self:diffusebottomedge(bottomedge[7])
			elseif val <= 999 * numSongs then
				self:diffusetopedge(topedge[8])
				self:diffusebottomedge(bottomedge[8])
			elseif val <= 1199 * numSongs then
				self:diffusetopedge(topedge[9])
				self:diffusebottomedge(bottomedge[9])
			else
				self:diffusetopedge(topedge[10])
				self:diffusebottomedge(bottomedge[10])
			end
		end
	else
		self:diffusetopedge(color("#ffffff"))
		self:diffusebottomedge(color("#ffffff"))
		val = "?"
	end
	self:settext(val)
	self:maxwidth(150)
end

return Def.ActorFrame{
	InitCommand=function(self) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end c = self:GetChildren() end,
	OnCommand=function(self) self:diffusealpha(0):sleep(0.85):linear(0.2):diffusealpha(1) end,
	OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:playcommand("Set") end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:playcommand("Set") end end,
	CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:playcommand("Set") end end,
	SetCommand=function(self)
		local val = 0
		local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)

		StepsDifficultyColor(c.StepCount,SongOrCourse,StepsOrTrail,"RadarCategory_TapsAndHolds")
		StepsDifficultyColor(c.TotalCount,SongOrCourse,StepsOrTrail,"RadarCategory_Notes")
	end,
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="StepCount",
		InitCommand=function(self) self:x(-67):y(120+8-5):zoom(0.35):diffusealpha(0):shadowlength(1) end
	},
	Def.BitmapText {
		File = "_z 36px shadowx",
		Name="TotalCount",
		InitCommand=function(self) self:x(-67):y(120+8+5):zoom(0.35):diffusealpha(0):shadowlength(1) end
	},
	Def.BitmapText {
		File = "_v 26px bold white",
		Name="Label",
		InitCommand=function(self) self:x(-67):y(120-6):settext("STEPS"):shadowlength(1):zoomx(0.45):zoomy(0.4):diffusebottomedge(color("#8F8F8F")) end
	},
	Def.BitmapText {
		File = "_v 26px bold white",
		Name="Label",
		InitCommand=function(self) self:x(-67):y(120+22):settext("TOTAL"):shadowlength(1):zoomx(0.45):zoomy(0.4):diffusebottomedge(color("#8F8F8F")) end
	}
}