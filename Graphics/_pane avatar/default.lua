local player = ...
assert(player,"[Graphics/_pane icons] player required")

return Def.ActorFrame{
	Condition=IsUsingWideScreen() and hasAvatar(player),
	InitCommand=function(self) self:y(ThemePrefs.Get("ShowStepCounter") and 3 or -1) end,
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	Def.Sprite{
		InitCommand=function(self) self:xy(player == PLAYER_1 and -96 or 96,110):CropTo(58,58):Load(LoadModule("Options.GetProfileData.lua")(player)["Image"]) end
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = "border "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:xy(player == PLAYER_1 and -96 or 96,110):shadowlength(1):zoom(0.8) end
		}
	}
}