local versions = {
	["Etterna"]					= "etterna",
	["StepMania - Etterna"]		= "etterna",
	["ITGmania"]				= "itgmania",
	["OpenDDR"]					= "openddr",
	["OutFox"]					= "outfox",
	["StepMania"]				= tonumber(split("-",ProductVersion())[1]) == 5.3 and "oldfox" or "stepmania"
}

return Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenOITG","overlay/inthegroove"))()..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoom(0.7*WideScreenDiff()) end
	},
	loadfile(THEME:GetPathB("ScreenOITG","overlay/"..versions[ProductFamily()]))()..{
		InitCommand=function(self) self:x(SCREEN_LEFT+SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+80):zoom(0.65*WideScreenDiff_(16/10)) end
	},
	loadfile(THEME:GetPathB("ScreenOITG","overlay/bxrx"))()..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-SCREEN_WIDTH/4):y(SCREEN_CENTER_Y+80):zoom(0.6*WideScreenDiff_(16/10)) end
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffusealpha(1) end,
		OnCommand=function(self) self:sleep(0.1):accelerate(0.5):diffusealpha(0) end
	},
	loadfile(THEME:GetPathB("ScreenAttract","overlay"))()
}