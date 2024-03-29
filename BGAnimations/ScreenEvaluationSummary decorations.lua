return Def.ActorFrame{
    LoadFallbackB(),
    StandardDecorationFromFileOptional("BannerList","BannerList"),
    LoadActor(THEME:GetPathG("ScreenEvaluation","BannerFrame"))..{
        InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135*WideScreenDiff()):zoom(WideScreenDiff()) end,
        OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.5):diffusealpha(1) end,
        OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
    }
}