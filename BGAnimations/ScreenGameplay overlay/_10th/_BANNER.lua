return Def.ActorFrame{
	Def.Sprite {
		Texture = "BANNER",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.Banner{
		InitCommand=function(self) self:x(0):y(0) end,
		BeginCommand=function(self) self:LoadFromSong(GAMESTATE:GetCurrentSong()):zoomtowidth(128):zoomtoheight(40) end
	}
}