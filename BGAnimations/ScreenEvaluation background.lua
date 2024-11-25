return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenSelectMusic","background/CJ126 Eval "..(isFinal() and "Final" or "Normal")),
		InitCommand=function(self) self:FullScreen():diffusealpha(isFinal() and 0.2 or 1) end
	},
	Def.Sprite{
		BeginCommand=function(self)
			self:visible( not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong():GetBannerPath() )
		end,
		InitCommand=function(self)
			self:LoadFromSongBackground(GAMESTATE:GetCurrentSong()):FullScreen():blend(Blend.Add):diffusealpha(0.25)
		end,
		OnCommand=function(self)
			self:fadeleft(0.2):faderight(0.2):FullScreen()
			if isFinal() then self:diffuseshift():effectcolor1(color("#FFFFFF80")):effectcolor2(color("#FFFFFFFF")):effectperiod(12) end
		end
	}
}