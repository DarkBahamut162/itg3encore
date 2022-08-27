local LabelName = ...

local NameCase = setmetatable(
	{
		matches = {
			["ScreenSelectMusic"] = "ScreenSelectMusic",
			["ScreenSelectNumPlayers"] = "ScreenSelectStyle",
			["ScreenEvaluationNormal"] = "ScreenEvaluation",
			["ScreenEvaluationRave"] = "ScreenEvaluation",
			["ScreenEvaluationNonstop"] = "ScreenEvaluation",
			["ScreenEvaluationOni"] = "ScreenEvaluation",
			["ScreenEvaluationSummary"] = "ScreenEvaluation",
			["ScreenOptionsMapping"] = "null",
			["ScreenSetBGFit"] = "null",
			["ScreenOverscanConfig"] = "null",
		}
	},
	{
		__call = function(this,item)
			if this.matches[ item ] then
				return this.matches[ item ]
			end
			return item
		end
	}
)

return Def.ActorFrame{
	Def.Sprite{
		Texture=NameCase(LabelName),
		OnCommand=function(self)
			local texwidth = self:GetWidth()
			self:texcoordvelocity(0.45,0):zoomtowidth(SCREEN_WIDTH)
			:customtexturerect(0,0,SCREEN_WIDTH/texwidth,1):ztest(true)
		end
	}
}