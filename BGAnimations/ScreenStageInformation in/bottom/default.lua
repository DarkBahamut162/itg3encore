local Banner = isEtterna() and Def.Sprite{
	InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+103*WideScreenDiff()):blend(Blend.Add):fadetop(0.3):croptop(0.3):diffusetopedge(color("#FFFFFF00")):ztest(true) end,
	OnCommand=function(self) self:playcommand("Set"):rotationz(180):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):linear(1):y(SCREEN_CENTER_Y+103*WideScreenDiff()-33*WideScreenDiff()):diffusealpha(0.2) end,
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
	InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+103*WideScreenDiff()):blend(Blend.Add):fadetop(0.3):croptop(0.3):diffusetopedge(color("#FFFFFF00")):ztest(true) end,
	OnCommand=function(self) self:playcommand("Set"):rotationz(180):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):linear(1):y(SCREEN_CENTER_Y+103*WideScreenDiff()-33*WideScreenDiff()):diffusealpha(0.2) end,
	SetCommand=function(self)
		local sel = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		if sel then if GAMESTATE:IsCourseMode() then self:LoadFromCourse(sel) else self:LoadFromSong(sel) end end
		self:scaletoclipped(292,114)
	end
}

return Def.ActorFrame{
	Def.Sprite {
		Texture = "_bottom",
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
	},
	Def.Sprite {
		Texture = "lines",
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
	},
	Banner,
	Def.Sprite {
		Texture = "_flaremask",
		InitCommand=function(self) self:FullScreen():zbuffer(true):blend(Blend.NoEffect) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenStageInformation","in/_flares"),
		InitCommand=function(self) self:Center():ztest(true):diffusealpha(1):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1):rotationz(-250):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "bar",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+136*WideScreenDiff()):zoom(WideScreenDiff()):visible(not GAMESTATE:IsCourseMode()):zoomtowidth(SCREEN_WIDTH):faderight(0.8):fadeleft(0.8):cropright(1) end,
		OnCommand=function(self) self:linear(0.7):cropright(0) end
	},
	Def.BitmapText {
		File = "_r bold 30px",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+127*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*7):shadowlength(2):zoom(0.5*WideScreenDiff()):diffusealpha(0) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayFullTitle() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(0.1):linear(0.3):diffusealpha(1) end
	},
	Def.BitmapText {
		File = "_r bold 30px",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+147*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*6.8/WideScreenDiff()):shadowlength(2):zoom(0.4*WideScreenDiff()):diffusealpha(0) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayArtist() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(0.1):linear(0.3):diffusealpha(1) end
	}
}