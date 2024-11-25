return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():draworder(100):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:linear(0.1):diffuse(color("1,1,1,1")) end
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():draworder(152):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:sleep(2):linear(0.4):diffuse(color("#000000")) end
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():draworder(150):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:sleep(1):linear(0.6):diffuse(color("0,0,0,0")) end
	},
	Def.Sprite {
		Texture = "_itg3",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-2):draworder(117):diffusealpha(0):zoomto(SCREEN_WIDTH,SCREEN_WIDTH/6.4) end,
		OnCommand=function(self) self:linear(1.2):diffusealpha(1) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","blueflare"),
		InitCommand=function(self) self:Center():blend(Blend.Add):draworder(115):zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4) end,
		OnCommand=function(self) self:decelerate(1.1):zoomtoheight(0):diffusealpha(0.2) end
	},
	loadfile(THEME:GetPathB("ScreenITG3","background/fire"))()..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomto(SCREEN_WIDTH,SCREEN_WIDTH/6.4):draworder(117) end,
		OnCommand=function(self) self:sleep(0.8):linear(0.5):diffusealpha(0) end
	},
	loadfile(THEME:GetPathB("ScreenITG3","background/fire"))()..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomto(SCREEN_WIDTH,SCREEN_WIDTH/6.4):draworder(117) end,
		OnCommand=function(self) self:sleep(0.8):linear(0.5):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "top",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-SCREEN_HEIGHT):draworder(110):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:decelerate(0.25):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/4) end
	},
	Def.Sprite {
		Texture = "bottom",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_HEIGHT):draworder(110):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:decelerate(0.25):y(SCREEN_CENTER_Y+SCREEN_HEIGHT/4) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","blueflare"),
		InitCommand=function(self) self:Center():blend(Blend.Add):draworder(115):diffusealpha(0.6):zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4) end,
		OnCommand=function(self) self:decelerate(0.7):zoomtoheight(0.2):diffusealpha(0) end
	}
}