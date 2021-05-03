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

local t = Def.ActorFrame{
	LoadActor(page)..{ InitCommand=cmd(addy,-17); };
	LoadActor("line highlight mask right")..{
		InitCommand=cmd(addy,-145;x,291;zwrite,true;blend,'BlendMode_NoEffect');
	};
};

return t;