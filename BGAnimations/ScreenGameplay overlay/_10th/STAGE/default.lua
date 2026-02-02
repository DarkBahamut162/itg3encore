local StageToFrame = {
	Stage_1st		= 0,
	Stage_2nd		= 1,
	Stage_3rd		= 2,
	Stage_4th		= 3,
	Stage_5th		= 4,
	Stage_6th		= 5,
	Stage_Next		= 6,
	Stage_Final		= 7,
	Stage_Extra1	= 8,
	Stage_Extra2	= 9,
	Stage_Nonstop	= 10,
	Stage_Oni		= 11,
	Stage_Endless	= 12,
	Stage_Event		= 13,
	Stage_Demo		= 14
}

return Def.ActorFrame{
	Def.Sprite {
		Texture = "_stage",
		InitCommand=function(self) self:x(203*WideScreenDiff()):y(480):zoomy(WideScreenDiff()):zoomx(0.9*WideScreenDiff()):animate(false):setstate(StageToFrame[GAMESTATE:GetCurrentStage()]):addy(WideScreenDiff()*-14):croptop(1):sleep(2.45):linear(0.35):addy(WideScreenDiff()*14):croptop(0):playcommand("Animate") end,
		AnimateCommand=function(self) self:x(203*WideScreenDiff()):y(480):sleep(2):linear(0.35):addy(WideScreenDiff()*14):cropbottom(1):sleep(0):sleep(2.8):croptop(1):cropbottom(0):sleep(0.1):addy(WideScreenDiff()*-28):linear(0.35):addy(WideScreenDiff()*14):croptop(0):queuecommand("Animate") end
	},
	Def.ActorFrame{
		Def.BitmapText {
			File=THEME:GetPathF("_iidx/Difficulty", "Normal"),
			Text="ITG3ENCORE",
			InitCommand=function(self) self:maxwidth(70):diffuse(color("#28C8F8")):diffusetopedge(color("#D0F8F8")):diffusealpha(2):zoom(0.9*WideScreenDiff()):queuecommand("Animate") end,
			AnimateCommand=function(self) self:x(203*WideScreenDiff()):y(480):sleep(2):linear(0.35):cropleft(1):sleep(0):sleep(2.8):cropright(1):cropleft(0):sleep(0.1):linear(0.35):cropright(0):queuecommand("Animate") end
		}
	}
}
