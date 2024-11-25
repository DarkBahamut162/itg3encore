local t = Def.ActorFrame{}

if ShowStandardDecoration("BannerList") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "BannerList"))() .. {
		InitCommand=function(self)
			self:name("BannerList")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

return Def.ActorFrame{
    LoadFallbackB(),
    t,
    loadfile(THEME:GetPathG("ScreenEvaluation","BannerFrame"))()..{
        InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135*WideScreenDiff()):zoom(WideScreenDiff()) end,
        OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.5):diffusealpha(1) end,
        OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
    }
}