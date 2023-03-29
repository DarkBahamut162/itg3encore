local mask = GAMESTATE:IsCourseMode() and "_course banner mask" or "_banner mask"

return Def.ActorFrame{
	LoadActor(mask)..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+139.5*WideScreenDiff()):y(SCREEN_CENTER_Y-16*WideScreenDiff()):zoom(WideScreenDiff()):z(2):zwrite(true):blend(Blend.NoEffect) end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
	}
}