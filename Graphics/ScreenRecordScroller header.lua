return Def.ActorFrame{
	LoadFont("_z bold 19px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220*WideScreenDiff()):y(SCREEN_TOP+24*WideScreenDiff()):zoom(0.8*WideScreenDiff()):diffusealpha(0) end,
		BeginCommand=function(self)
			local highScoresType = THEME:GetMetric(Var "LoadingScreen","HighScoresType")
			self:settext( THEME:GetString("HighScoresType",ToEnumShortString(highScoresType)) )
			if ToEnumShortString(highScoresType) == "AllSteps" then
				self:diffuse(color("#00FF0000"))
			elseif ToEnumShortString(highScoresType) == "NonstopCourses" then
				self:diffuse(color("#FF000000"))
			elseif ToEnumShortString(highScoresType) == "SurvivalCourses" then
				self:diffuse(color("#0000FF00"))
			end
		end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(0) end
	},
	LoadFont("_z bold 19px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220*WideScreenDiff()):y(SCREEN_TOP+40*WideScreenDiff()):zoom(0.7*WideScreenDiff()):diffusealpha(0) end,
		BeginCommand=function(self)
			local stepsType = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
			self:settext( THEME:GetString("StepsType",ToEnumShortString(stepsType) ) )
		end,
		OnCommand=function(self) self:linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(0) end
	}
}