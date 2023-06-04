local screen = Var "LoadingScreen"

local page = "options page"
if screen == "ScreenOptionsService" or
	THEME:GetMetric(screen,"Fallback") == "ScreenOptionsService" or
	screen == "ScreenOptionsEdit" or screen == "ScreenRecordsMenu"
then
	page = "service page"
else
	page = "options page"
end

return Def.ActorFrame{
	LoadActor(page)..{
		InitCommand=function(self) self:addy(-17):zoom(WideScreenDiff()) end,
		OffCommand=function(self) self:diffusealpha(1):accelerate(0.6):diffusealpha(0) end
	},
	LoadActor("line highlight mask right")..{
		InitCommand=function(self) self:addy(-145):x(291):zoom(WideScreenDiff()):zwrite(true):blend(Blend.NoEffect) end,
		OffCommand=function(self) self:diffusealpha(1):accelerate(0.6):diffusealpha(0) end
	}
}