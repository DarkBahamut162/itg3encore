local Banner = isEtterna("0.65") and Def.Sprite{
	InitCommand=function(self) self:diffusealpha(0):ztest(true) end,
	OnCommand=function(self) self:playcommand("Set"):linear(1):diffusealpha(1) end,
	SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local bnpath
		if song then
			bnpath = song:GetBannerPath()
		else
			bnpath = SONGMAN:GetSongGroupBannerPath(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
		end
		if not bnpath or bnpath == "" then bnpath = THEME:GetPathG("Common", "fallback banner") end
		self:scaletoclipped(292,114):LoadBackground(bnpath)
	end,
} or Def.Banner{
	Condition=not isEtterna(),
	InitCommand=function(self) self:diffusealpha(0):ztest(true) end,
	OnCommand=function(self) self:playcommand("Set"):linear(1):diffusealpha(1) end,
	SetCommand=function(self)
		local sel = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		if sel then if GAMESTATE:IsCourseMode() then self:LoadFromCourse(sel) else self:LoadFromSong(sel) end end
		self:scaletoclipped(292,114)
	end
}

return Def.ActorFrame{
	Def.Sprite {
		Texture = "_top",
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
	},
	Def.Sprite {
		Texture = "_shadow",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-94*WideScreenDiff()):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1):y(SCREEN_CENTER_Y-61*WideScreenDiff()) end
	},
	Def.ActorFrame{
		Name="BannerSection",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-77*WideScreenDiff()):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1):y(SCREEN_CENTER_Y-77*WideScreenDiff()+33*WideScreenDiff()) end,
		Def.Sprite {
			Texture = "_banner mask",
			InitCommand=function(self) self:zbuffer(true):blend(Blend.NoEffect) end
		},
		Banner,
		Def.Sprite {
			Texture = "_banner glass"
		}
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenStageInformation","in/_flares"),
		InitCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(1):zoom(WideScreenDiff()):linear(1):rotationz(250):diffusealpha(0) end
	}
}