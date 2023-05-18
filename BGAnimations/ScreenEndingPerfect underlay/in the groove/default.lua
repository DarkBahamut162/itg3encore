	return Def.ActorFrame{
		Def.ActorFrame{
			OnCommand=function(self) self:x(SCREEN_CENTER_X-20*WideScreenDiff()):y(SCREEN_CENTER_Y-80*WideScreenDiff()):zoom(WideScreenDiff()):sleep(1.5):linear(9):addx(40*WideScreenDiff()) end,
			LoadActor("thanks")..{
				OnCommand=function(self) self:diffusealpha(0):sleep(1.5):linear(3):diffusealpha(1):sleep(3):linear(3):diffusealpha(0) end
			}
		},
		LoadActor("in")..{
			InitCommand=function(self) self:zoom(0.8*WideScreenDiff()):x(SCREEN_CENTER_X-50*WideScreenDiff()):y(SCREEN_CENTER_Y-20*WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3.2):linear(2.5):diffusealpha(1):sleep(4):linear(3):diffusealpha(0) end
		},
		LoadActor("the")..{
			InitCommand=function(self) self:zoom(0.8*WideScreenDiff()):x(SCREEN_CENTER_X+45*WideScreenDiff()):y(SCREEN_CENTER_Y-20*WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3.4):linear(2.5):diffusealpha(1):sleep(3.8):linear(3):diffusealpha(0) end
		},
		LoadActor("groove")..{
			InitCommand=function(self) self:zoom(0.8*WideScreenDiff()):x(SCREEN_CENTER_X+100*WideScreenDiff()):y(SCREEN_CENTER_Y+55*WideScreenDiff()) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3.6):linear(2.5):diffusealpha(1):sleep(3.6):linear(3):diffusealpha(0) end
		}
	}