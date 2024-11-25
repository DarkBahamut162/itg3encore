return Def.ActorFrame{
	InitCommand=function(self) self:y(scale(1,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end,
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier01"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(1,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier02"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(2,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier03"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(3,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier04"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(4,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier05"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(5,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier06"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(6,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier07"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(7,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier08"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(8,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier09"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(9,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end },
	loadfile(THEME:GetPathG("GradeDisplayEval","Tier10"))()..{ InitCommand=function(self) self:zoom(0.45*WideScreenDiff()):x(scale(10,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())) end }
}