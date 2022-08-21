return Def.ActorFrame{
	OnCommand=function(self) self:fov(82):y(-35):x(-259):addx(-40):rotationy(-85):decelerate(0.25):addx(40):rotationy(0):linear(3.15):zoom(1.03):addx(-7):accelerate(0.4):rotationy(30):addx(-10) end;
    Def.ActorFrame{
		Def.Quad{
			OnCommand=function(self) self:horizalign(left):zoomtowidth(518):zoomtoheight(390):diffusetopedge(color("#e2e6ed")):diffusebottomedge(color("#d3d5da")):diffusealpha(0):decelerate(0.4):diffusealpha(0.8):sleep(2.8):accelerate(0.5):diffusealpha(0) end;
		};
	};
};