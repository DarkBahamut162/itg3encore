return Def.ActorFrame{
	Def.Sprite {
		Texture = "b1",
		InitCommand=function(self) self:Center() end,
		OnCommand=function(self) self:diffusealpha(0):sleep(5):zoomtowidth(SCREEN_WIDTH*2):zoomtoheight(SCREEN_HEIGHT*2):linear(10):diffusealpha(1):zoomtowidth(SCREEN_WIDTH*1.9):zoomtoheight(SCREEN_HEIGHT*1.9):linear(70):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):linear(5):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "masktest",
		InitCommand=function(self) self:Center():zoomtoheight(SCREEN_HEIGHT):zoomtowidth(SCREEN_WIDTH):blend(Blend.NoEffect):zwrite(1) end,
		OnCommand=function(self) self:diffusealpha(1):sleep(5):zoomtowidth(SCREEN_WIDTH*2):zoomtoheight(SCREEN_HEIGHT*2):linear(10):diffusealpha(1):zoomtowidth(SCREEN_WIDTH*1.9):zoomtoheight(SCREEN_HEIGHT*1.9):linear(70):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):linear(5):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "865_jumpback",
		InitCommand=function(self) self:blend(Blend.Add):Center():zoomtoheight(SCREEN_HEIGHT):zoomtowidth(SCREEN_WIDTH):ztest(1) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(10):zoomtowidth(SCREEN_WIDTH*2):zoomtoheight(SCREEN_HEIGHT*2):linear(5):diffusealpha(0.2):zoomtowidth(SCREEN_WIDTH*1.9):zoomtoheight(SCREEN_HEIGHT*1.9):linear(70):zoomtowidth(SCREEN_WIDTH):zoomtoheight(SCREEN_HEIGHT):linear(5):diffusealpha(0) end
	}
}