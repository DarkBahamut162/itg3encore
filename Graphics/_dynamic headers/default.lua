local LabelName = ...
local NameCase = setmetatable(
	{
		matches = {
			["ScreenEvaluationNormal"] = "ScreenEvaluation",
			["ScreenEvaluationRave"] = "ScreenEvaluation",
			["ScreenEvaluationNonstop"] = "ScreenEvaluation",
			["ScreenEvaluationOni"] = "ScreenEvaluation",
			["ScreenEvaluationWorkout"] = "ScreenEvaluation",
			["ScreenEvaluationCourseWorkout"] = "ScreenEvaluation",
			["ScreenPlayerOptions"] = "ScreenPlayerOptions",
			["ScreenPlayerOptionsRestricted"] = "ScreenPlayerOptions",
			["ScreenSelectCourse"] = "ScreenSelectCourse",
			["ScreenSelectMusic"] = "ScreenSelectMusic",
			["ScreenSelectNumPlayers"] = "ScreenSelectStyle",
			["ScreenSelectPlayMode"] = "ScreenSelectPlayMode",
			["ScreenSelectStyle"] = "ScreenSelectStyle",
			["ScreenSelectStyleWorkout"] = "ScreenSelectStyle"
		}
	},
	{
		__call = function(this,item)
			if this.matches[ item ] then
				return this.matches[ item ]
			end
			return "null"
		end
	}
)

return Def.ActorFrame{
	Def.Sprite{
		Texture=NameCase(LabelName),
		OnCommand=function(self)
			local texwidth = self:GetWidth()
			self:texcoordvelocity(0.45,0):zoomtowidth(SCREEN_WIDTH/WideScreenDiff())
			:customtexturerect(0,0,SCREEN_WIDTH/texwidth/WideScreenDiff(),1):ztest(true)
		end
	}
}