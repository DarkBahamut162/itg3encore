local player = ...
assert(player,"[Graphics/_pane icons] player required")

return Def.ActorFrame{
	Condition=isWidescreen() and isOutFox(),
	InitCommand=function(self) self:y(-1) end,
	Def.Sprite{
		InitCommand=function(self) self:xy(-96,110):CropTo(58,58):Load(LoadModule("Options.GetProfileData.lua")(player)["Image"]) end,
		OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.4):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
	},
	Def.ActorFrame{
		LoadActor("border")..{
			InitCommand=function(self) self:xy(-96,110):shadowlength(1):zoom(0.8) end,
			OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.4):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		}
	}
}