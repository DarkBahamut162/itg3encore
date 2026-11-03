local player = ...
assert(player,"[Graphics/_player scores] player required")

return Def.BitmapText {
	File = "_v 26px bold shadow",
	InitCommand=function(self) self:zoom(1/3):x(player == PLAYER_1 and 134 or -134):y(109):maxwidth(200):halign(player == PLAYER_1 and 0 or 1):valign(0):vertspacing(-6) end,
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	BeginCommand=function(self)
		local song = player == PLAYER_1 and SongsP1 or SongsP2
		local step = player == PLAYER_1 and StepsP1 or StepsP2
		local songCount = 0
		local stepCount = 0
		for _,_ in pairs(song) do songCount = songCount + 1 end
		for _,_ in pairs(step) do stepCount = stepCount + 1 end
		local textSong=songCount==1 and "Song" or "Songs"
		local textStep=stepCount==1 and "Chart" or "Charts"
		self:settext(songCount.." "..textSong.."\n"..stepCount.." "..textStep)
	end
}