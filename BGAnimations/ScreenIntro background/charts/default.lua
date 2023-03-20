return Def.ActorFrame{
	Def.ActorFrame{
		Name="ChartList",
		InitCommand=function(self) self:x(SCREEN_RIGHT-20*WideScreenDiff()):y(SCREEN_CENTER_Y-(SCREEN_HEIGHT/12)*WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(16):linear(6):y(SCREEN_CENTER_Y+(SCREEN_HEIGHT/12)*WideScreenDiff()) end,
		LoadFont("_v credit")..{
			InitCommand=function(self) self:settext(GetStepChartFacts()):horizalign(right):zoom(0.8*WideScreenDiff()):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(16.5):linear(0.5):diffusealpha(0.3):linear(3):linear(0.5):diffusealpha(0.0) end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+100):rotationz(3) end,
		OnCommand=function(self) self:sleep(16):linear(6):addx(-10):addy(5) end,
		LoadActor(THEME:GetPathB("ScreenIntro","background/green"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+SCREEN_WIDTH*2):zoomto(SCREEN_WIDTH*1.5,100) end,
			OnCommand=function(self) self:sleep(16):linear(0.5):fadeleft(0.3):faderight(0.3):x(50):linear(4):addx(-100*WideScreenDiff()):accelerate(0.5):addx(-SCREEN_WIDTH*2) end
		},
		LoadActor("charts")..{
			InitCommand=function(self) self:x(-100*WideScreenDiff()):zoom(0.8*WideScreenDiff()):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(16.5):linear(0.3):diffusealpha(1):sleep(4):linear(0.3):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+150) end,
		LoadActor(THEME:GetPathB("ScreenIntro","background/swoosh"))..{
			InitCommand=function(self) self:zoomtowidth(SCREEN_WIDTH):zoomy(-1):y(-10):blend(Blend.Add):cropleft(1):fadeleft(1) end,
			OnCommand=function(self) self:sleep(16):linear(0.5):cropleft(0):fadeleft(0):sleep(4):linear(0.5):diffusealpha(0.0):addx(50*WideScreenDiff()):cropright(1):faderight(1) end
		},
		Def.ActorFrame{
			OnCommand=function(self) self:sleep(16):linear(6):addx(20*WideScreenDiff()) end,
			LoadActor("1500")..{
				InitCommand=function(self) self:x(-75*WideScreenDiff()):y(-80):zoom(WideScreenDiff()):diffusealpha(0) end,
				OnCommand=function(self) self:sleep(16.5):linear(0.5):diffusealpha(1):sleep(4):linear(0.5):diffusealpha(0.0) end
			}
		}
	}
}