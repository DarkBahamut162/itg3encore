return Def.ActorFrame{
    LoadActor("kung_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*0):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("kung_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*0):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("jason_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*1):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("jason_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*1):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("dom_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4*WideScreenDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*2):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("dom_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*2):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("rain_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenSemiDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*3):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("rain_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*3):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("nevets_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*4):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("nevets_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*4):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("phrek_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*5):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("phrek_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*5):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("jbean_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*6):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("jbean_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*6):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("kyle_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*7):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("kyle_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*7):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("foy_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*8):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("foy_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*8):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("mj_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*9):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("mj_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*9):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("ryan_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3/WideScreenSemiDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*10):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("ryan_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*10):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("derek_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*11):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("derek_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*11):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("novus_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*12):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("novus_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*12):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("eric_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/4):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*13):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("eric_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*13):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	},
    LoadActor("link_pic")..{
		InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+SCREEN_WIDTH/3/WideScreenSemiDiff()):y(SCREEN_BOTTOM):vertalign(bottom) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(23.17+4.426*14):addx(SCREEN_WIDTH/2):decelerate(0.5):addx(-SCREEN_WIDTH/2):diffusealpha(1):linear(2.926):addx(-9):linear(1):diffusealpha(0):addx(-3) end
	},
    LoadActor("link_name")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_WIDTH/2.1):y(SCREEN_BOTTOM-100):zoom(WideScreenDiff()):horizalign(right) end,
		OnCommand=function(self) self:addx(-SCREEN_WIDTH*2):sleep(23.17+4.426*14):decelerate(0.5):addx(SCREEN_WIDTH*2):linear(2.926):addx(9):linear(1):diffusealpha(0):addx(3) end
	}
}