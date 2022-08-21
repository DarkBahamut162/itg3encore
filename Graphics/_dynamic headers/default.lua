local LabelName = ...

-- lua.ReportScriptError("Actuating Dynamic header...")
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
			-- lua.ReportScriptError( ("Call! item is %s"):format( item ) )
			if this.matches[ item ] then
				-- lua.ReportScriptError( ("match! item (%s) is now %s"):format( item, this.matches[ item ] ) )
				return this.matches[ item ]
			end
			-- lua.ReportScriptError( ("no match! item (%s) remains."):format( item ) )
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
			-- :bob():effectmagnitude(0,-80,0)
		end
	}
}