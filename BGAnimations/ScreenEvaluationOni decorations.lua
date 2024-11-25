return Def.ActorFrame{
	LoadFallbackB(),
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and GAMESTATE:GetCurrentCourse(PLAYER_1):GetCourseEntry(0):GetGainSeconds() > 0,
		InitCommand=function(self) self:x(SCREEN_CENTER_X-156*WideScreenDiff()):y(SCREEN_CENTER_Y-60*WideScreenDiff()):draworder(101):zoom(2.5*WideScreenDiff()) end,
		OnCommand=function(self) self:addx(-EvalTweenDistance()):decelerate(0.5):addx(EvalTweenDistance()):sleep(2.5):decelerate(0.5):zoom(WideScreenDiff()):x(SCREEN_CENTER_X-56*WideScreenDiff()):y(SCREEN_CENTER_Y+48*WideScreenDiff()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end,
		Def.BitmapText {
			File = "_r bold shadow 30px",
			InitCommand=function(self) self:shadowlength(0):y(-10):horizalign(left):x(-40):zoom(0.6):skewx(-0.18):diffusebottomedge(color("#1F15E9")):settext("Total Time:") end
		},
		Def.BitmapText {
			File = "_r bold shadow 30px",
			InitCommand=function(self) local s=SecondsToMSSMsMs( STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetSurvivalSeconds() ) self:settext(s) end,
			OnCommand=function(self) self:shadowlength(0):x(10):y(10):zoom(0.8):diffusebottomedge(0.7,0.7,0.7,1) end
		}
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2) and GAMESTATE:GetCurrentCourse(PLAYER_2):GetCourseEntry(0):GetGainSeconds() > 0,
		InitCommand=function(self) self:x(SCREEN_CENTER_X+156*WideScreenDiff()):y(SCREEN_CENTER_Y-60*WideScreenDiff()):draworder(101):zoom(2.5*WideScreenDiff()) end,
		OnCommand=function(self) self:addx(EvalTweenDistance()):decelerate(0.5):addx(-EvalTweenDistance()):sleep(2.5):decelerate(0.5):zoom(WideScreenDiff()):x(SCREEN_CENTER_X+56*WideScreenDiff()):y(SCREEN_CENTER_Y+48*WideScreenDiff()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end,
		Def.BitmapText {
			File = "_r bold shadow 30px",
			InitCommand=function(self) self:shadowlength(0):y(-10):horizalign(left):x(-40):zoom(0.6):skewx(-0.18):diffusebottomedge(color("#1F15E9")):settext("Total Time:") end
		},
		Def.BitmapText {
			File = "_r bold shadow 30px",
			InitCommand=function(self) local s=SecondsToMSSMsMs( STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetSurvivalSeconds() ) self:settext(s) end,
			OnCommand=function(self) self:shadowlength(0):x(10):y(10):zoom(0.8):diffusebottomedge(0.7,0.7,0.7,1) end
		}
	}
}