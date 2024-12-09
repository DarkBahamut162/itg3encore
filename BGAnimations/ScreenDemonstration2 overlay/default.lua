local posX = THEME:GetMetric(Var "LoadingScreen","PlayerP1"..ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()).."X")

local width_square = 294
local width_field = 2 * (64 + GAMESTATE:GetCurrentStyle():GetColumnInfo(GAMESTATE:GetMasterPlayerNumber(), GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()).XOffset)

local posX_now = SCREEN_WIDTH/4*3

if width_field > 400 then posX, posX_now = SCREEN_CENTER_X, SCREEN_WIDTH/8*7 end

return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenGameplay","overlay/demonstration gradient"),
		InitCommand=function(self) self:FullScreen():diffusealpha(0.8) end
	},
	Def.BitmapText {
		File = "_v tutorial",
		Text="Colored Arrows\nscroll from\nlow to high.",
		InitCommand=function(self) self:x(posX_now):CenterY():addx(SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(5):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "focus square "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:x(posX):y(SCREEN_CENTER_Y+60):zoomx(width_field/width_square*WideScreenDiff_(16/10)):zoomy(1.05):diffuseblink():effectperiod(0.5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(6):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_v tutorial",
		Text="Step when a\nColored Arrow\noverlaps the\nTarget Arrows\nat the top.",
		InitCommand=function(self) self:x(posX_now):CenterY():addx(SCREEN_WIDTH):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(11):decelerate(0.5):addx(-SCREEN_WIDTH):sleep(5):linear(0.3):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "focus rect "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:x(posX):y(SCREEN_CENTER_Y-124):zoomx(width_field/width_square*WideScreenDiff_(16/10)):zoomy(0.8*WideScreenDiff_(16/10)):diffuseblink():effectperiod(0.5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(12):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_v tutorial",
		Text="The\nTraffic Light\nhelps you\nunderstand\nthe timing.",
		InitCommand=function(self) self:x(posX_now):CenterY():addx(SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(17):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "focus rect "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+15):zoom(WideScreenDiff_(16/10)):rotationz(90):diffuseblink():effectperiod(0.5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(18):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_v tutorial",
		Text="The direction\nof the arrow\nsays which\nPanel\nto step on.",
		InitCommand=function(self) self:x(posX_now):CenterY():addx(SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(23):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_v tutorial",
		Text="For arrows\nfacing Left,\nstep on the\nLeft Panel.",
		InitCommand=function(self) self:x(posX_now):y(SCREEN_CENTER_Y-80*WideScreenDiff()):addx(SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(29):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "arrow",
		InitCommand=function(self) self:x(posX_now-66*WideScreenDiff()):y(SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(WideScreenDiff()):rotationz(0):glowblink():effectperiod(0.5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="PlatformLeft",
		InitCommand=function(self) self:x(posX_now+33*WideScreenDiff()):y(SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(0.8*WideScreenDiff()):rotationx(-20):fov(45):vanishpoint(SCREEN_CENTER_X+210,SCREEN_CENTER_Y+80) end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","underlay/beginner/dance platform"),
			InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","underlay/beginner/panelglow"),
			InitCommand=function(self) self:x(-45):blend(Blend.Add):diffuseblink():effectperiod(0.5):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(30):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
		}
	},
	Def.BitmapText {
		File = "_v tutorial",
		Text="For arrows\nfacing Up,\nstep on the\nUp Panel.",
		InitCommand=function(self) self:x(posX_now):y(SCREEN_CENTER_Y-80*WideScreenDiff()):addx(SCREEN_WIDTH/2):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(35):decelerate(0.5):addx(-SCREEN_WIDTH/2):sleep(5):linear(0.3):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "arrow",
		InitCommand=function(self) self:x(posX_now-66*WideScreenDiff()):y(SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(WideScreenDiff()):rotationz(90):glowblink():effectperiod(0.5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="PlatformUp",
		InitCommand=function(self) self:x(posX_now+33*WideScreenDiff()):y(SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(0.8*WideScreenDiff()):rotationx(-20):fov(45):vanishpoint(SCREEN_CENTER_X+210,SCREEN_CENTER_Y+80) end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","underlay/beginner/dance platform"),
			InitCommand=function(self) self:y(7):diffuse(color("0.6,0.6,0.6,0.8")):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","underlay/beginner/panelglow"),
			InitCommand=function(self) self:y(-45):blend(Blend.Add):diffuseblink():effectperiod(0.5):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(36):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
		}
	},
	Def.BitmapText {
		File = "_v profile",
		InitCommand=function(self) self:x(posX_now):y(SCREEN_HEIGHT/8*7):zoom(0.7*WideScreenDiff()):maxwidth(300) end,
		BeginCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then self:settext("Now playing:\n" ..song:GetDisplayFullTitle().."\nby "..song:GetDisplayArtist()) end
		end
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,1")) end,
		OnCommand=function(self) self:sleep(3.5):linear(0.5):diffusealpha(0) end
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = "instructions "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:Center():cropright(1.3):zoom(SCREEN_WIDTH/self:GetWidth()) end,
			OnCommand=function(self) self:linear(1):cropright(-0.3):sleep(2):decelerate(0.5):zoom(0.7*WideScreenDiff()):y(SCREEN_TOP+40) end
		},
		Def.Sprite {
			Texture = "white instructions "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:Center():cropleft(-0.3):zoom(SCREEN_WIDTH/self:GetWidth()):cropright(1):faderight(0.1):fadeleft(0.1) end,
			OnCommand=function(self) self:linear(1):cropleft(1):cropright(-0.3) end
		}
	},
	loadfile(THEME:GetPathB("ScreenAttract","overlay"))()
}