return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/CJ126"))..{
		InitCommand=function(self) self:Center():zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_WIDTH/4*3) end
	},
	Def.Sprite{
		BeginCommand=function(self)
			self:visible( not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong():GetBannerPath() )
		end,
		InitCommand=function(self)
			self:LoadFromSongBackground(GAMESTATE:GetCurrentSong())
			self:FullScreen()
			self:blend("BlendMode_Add")
			self:diffusealpha(0.25)
		end,
		OnCommand=function(self) self:fadeleft(0.2):faderight(0.2):Center():zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_WIDTH/16*10) end
	}
}