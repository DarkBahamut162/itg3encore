local ColumnStepsType1 = THEME:GetMetric(Var "LoadingScreen","ColumnStepsType1")
local stepsType = THEME:GetString("StepsType",ToEnumShortString(ColumnStepsType1))

return Def.ActorFrame{
	LoadFont("_z bold 19px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220):y(SCREEN_TOP+24):zoom(0.8):diffusealpha(0) end,
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
		OnCommand=function(self) if stepsType == "Single" then self:sleep(0.5):linear(0.5) end self:diffusealpha(1) end,
		OffCommand=function(self) if stepsType == "Double" then self:linear(0.5):diffusealpha(0) end end
	},
	LoadFont("_z bold 19px")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220):y(SCREEN_TOP+40):zoom(0.7):diffusealpha(0) end,
		BeginCommand=function(self) self:settext( stepsType ) end,
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.5):diffusealpha(0) end
	}
}