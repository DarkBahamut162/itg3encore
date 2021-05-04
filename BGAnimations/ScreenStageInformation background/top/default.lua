local t = Def.ActorFrame{
	LoadActor("_top")..{
		InitCommand=function(self) self:Center():FullScreen():diffusealpha(0) end;
		OnCommand=cmd(accelerate,0.3;diffusealpha,1);
	};
	LoadActor("_shadow")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-94;);
		OnCommand=cmd(linear,1;y,SCREEN_CENTER_Y-61);
	};
	Def.ActorFrame{
		Name="BannerSection";
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-77;);
		OnCommand=cmd(linear,1;y,SCREEN_CENTER_Y-44);

		LoadActor("_banner mask")..{
			InitCommand=cmd(zbuffer,true;blend,'BlendMode_NoEffect');
		};
		Def.Banner{
			InitCommand=cmd(diffusealpha,0;ztest,true);
			OnCommand=cmd(playcommand,"Set";linear,1;diffusealpha,1;);
			SetCommand=function(self)
				local sel
				if GAMESTATE:IsCourseMode() then
					sel = GAMESTATE:GetCurrentCourse()
					if sel then self:LoadFromCourse(sel) end
				else
					sel = GAMESTATE:GetCurrentSong()
					if sel then self:LoadFromSong(sel) end
				end
				self:scaletoclipped(292,114);
			end;
		};
		LoadActor("_banner glass");
	};
	LoadActor(THEME:GetPathB("ScreenStageInformation","background/_flares"))..{
		InitCommand=function(self) self:Center() end;
		OnCommand=cmd(diffusealpha,1;zoom,1;linear,1;rotationz,250;diffusealpha,0);
	};
};

return t;