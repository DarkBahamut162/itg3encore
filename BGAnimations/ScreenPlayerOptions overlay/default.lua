return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y-157*WideScreenDiff()) end,
		loadfile(THEME:GetPathG("_name","badge"))(PLAYER_1)..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+56*WideScreenDiff()):zoom(WideScreenDiff()):addx(-SCREEN_WIDTH):player(PLAYER_1) end,
			OnCommand=function(self) self:sleep(0.25):decelerate(0.3):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-SCREEN_WIDTH) end
		},
		loadfile(THEME:GetPathG("_name","badge"))(PLAYER_2)..{
			Condition=not isEtterna(),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+24*WideScreenDiff()+(WideScreenDiff() < 1 and SCREEN_WIDTH/2 or 320)):zoom(WideScreenDiff()):addx(SCREEN_WIDTH):player(PLAYER_2) end,
			OnCommand=function(self) self:sleep(0.25):decelerate(0.3):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end
		}
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenOptions","overlay/_frame"),
		InitCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(0):zoom(0.7*WideScreenDiff()):bounceend(0.3):diffusealpha(0.7):zoom(WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenOptions","overlay/_frame"),
		InitCommand=function(self) self:Center():blend(Blend.Add) end,
		OnCommand=function(self) self:diffuseblink():effectcolor1(color("0.8,0.8,0.8,0.85")):effectperiod(1):effectoffset(0):effectclock('beat'):diffusealpha(0):zoom(0.7*WideScreenDiff()):bounceend(0.3):diffusealpha(1):zoom(WideScreenDiff()) end,
		OffCommand=function(self) self:diffusealpha(1):accelerate(0.3):diffusealpha(0) end
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():visible(false) end,
		OffCommand=function(self) self:visible(true):diffusealpha(0):linear(0.1):diffusealpha(1):sleep(0.2):linear(0.3):diffusealpha(0) end
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:diffusealpha(1):sleep(0.2):linear(0.4):diffusealpha(0) end,
		OffCommand=function(self) self:visible(false) end
	},
	loadfile(THEME:GetPathB("","_coins"))()
}