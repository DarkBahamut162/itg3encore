return Def.ActorFrame{
	Def.Sprite {
		Texture = "kung_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*0):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "kung_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*0):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "jason_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*1):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "jason_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*1):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "dom_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4*WideScreenDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*2):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "dom_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*2):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "rain_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenSemiDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*3):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "rain_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*3):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "nevets_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*4):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "nevets_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*4):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "phrek_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*5):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "phrek_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*5):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "jbean_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*6):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "jbean_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*6):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "kyle_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*7):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "kyle_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*7):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "foy_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*8):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "foy_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*8):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "mj_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*9):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "mj_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*9):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "ryan_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3/WideScreenSemiDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*10):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "ryan_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*10):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "derek_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*11):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "derek_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*11):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "novus_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*12):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "novus_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*12):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "eric_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*13):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "eric_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*13):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
	Def.Sprite {
		Texture = "link_pic",
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3/WideScreenSemiDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*14):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
	Def.Sprite {
		Texture = "link_name",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*14):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	}
}