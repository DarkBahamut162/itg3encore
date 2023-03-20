return Def.ActorFrame{
	LoadActor("_top")..{
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:accelerate(0.3):diffusealpha(1) end
	},
	LoadActor("_shadow")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-94*WideScreenDiff()):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1):y(SCREEN_CENTER_Y-61*WideScreenDiff()) end
	},
	Def.ActorFrame{
		Name="BannerSection",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-77*WideScreenDiff()):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1):y(SCREEN_CENTER_Y-77*WideScreenDiff()+33*WideScreenDiff()) end,
		LoadActor("_banner mask")..{
			InitCommand=function(self) self:zbuffer(true):blend(Blend.NoEffect) end
		},
		Def.Banner{
			InitCommand=function(self) self:diffusealpha(0):ztest(true) end,
			OnCommand=function(self) self:playcommand("Set"):linear(1):diffusealpha(1) end,
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
		LoadActor("_banner glass")
	},
	LoadActor(THEME:GetPathB("ScreenStageInformation","in/_flares"))..{
		InitCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(1):zoom(WideScreenDiff()):linear(1):rotationz(250):diffusealpha(0) end
	}
}