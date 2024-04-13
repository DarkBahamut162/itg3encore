return Def.ActorFrame{
	BeginCommand=function() InitOptions() end,
	Def.ActorFrame{
		Condition=isScreenTitle(),
		LoadActor(THEME:GetPathB("ScreenEndingNormal","overlay/p1gradient"))..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_TOP+63*WideScreenDiff()):halign(1):valign(0):zoomtoheight(SCREEN_HEIGHT):addx(150*WideScreenDiff()) end,
			OnCommand=function(self) self:sleep(0.8):decelerate(0.2):addx(-150*WideScreenDiff()) end
		}
	}
}