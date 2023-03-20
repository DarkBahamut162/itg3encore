return Def.ActorFrame{
	LoadActor("_bottom")..{
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
	},
	LoadActor("lines")..{
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
	},
	Def.Banner{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+103*WideScreenDiff()):blend(Blend.Add):fadetop(0.3):croptop(0.3):diffusetopedge(color("#FFFFFF00")):ztest(true) end,
		OnCommand=function(self) self:playcommand("Set"):rotationz(180):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):linear(1):y(SCREEN_CENTER_Y+103-33*WideScreenDiff()):diffusealpha(0.2) end,
		SetCommand=function(self)
			local sel
			if GAMESTATE:IsCourseMode() then
				sel = GAMESTATE:GetCurrentCourse()
				if sel then self:LoadFromCourse(sel) end
			else
				sel = GAMESTATE:GetCurrentSong()
				if sel then self:LoadFromSong(sel) end
			end
			self:scaletoclipped(292,114)
		end
	},
	LoadActor("_flaremask")..{
		InitCommand=function(self) self:FullScreen():zbuffer(true):blend(Blend.NoEffect) end
	},
	LoadActor(THEME:GetPathB("ScreenStageInformation","in/_flares"))..{
		InitCommand=function(self) self:Center():ztest(true):diffusealpha(1):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1):rotationz(-250):diffusealpha(0) end
	},
	LoadActor("bar")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+136*WideScreenDiff()):zoom(WideScreenDiff()):visible(not GAMESTATE:IsCourseMode()):zoomtowidth(SCREEN_WIDTH):faderight(0.8):fadeleft(0.8):cropright(1) end,
		OnCommand=function(self) self:linear(0.7):cropright(0) end
	},
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+127*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*7):shadowlength(2):zoom(0.5*WideScreenDiff()):diffusealpha(0) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayFullTitle() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(0.1):linear(0.3):diffusealpha(1) end
	},
	LoadFont("_r bold 30px")..{
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