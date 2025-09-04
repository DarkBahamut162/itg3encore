local t = Def.ActorFrame{
	InitCommand=function(self) self:runcommandsonleaves(function(child) child:ztest(true) end) end,
	Def.ActorFrame{
		OffCommand=function(self) self:stoptweening():linear(0.5):diffusealpha(0) end,
		Def.Sprite {
			Texture = "_course frame "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:zoom(WideScreenDiff()) end
		},
		Def.Banner{
			InitCommand=function(self) self:x(-276*WideScreenDiff()):halign(0):scaletoclipped(128*WideScreenDiff(),40*WideScreenDiff()):diffusealpha(0.5):fadeleft(0.25):faderight(0.25) end,
			SetCommand=function(self, params)
				if params.Course then
					self:LoadFromCourse( params.Course )
				end
			end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:x(-292*WideScreenDiff()):halign(0):zoom(0.6*WideScreenDiff()):shadowlength(1):wrapwidthpixels(264):maxwidth(264):maxheight(58) end,
			SetCommand=function(self, params)
				if params.Course then
					self:settext( params.Course:GetDisplayFullTitle() )
				end
			end
		}
	}
}

local c
local Scores = Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() self:x(188*WideScreenDiff()) end,
	OffCommand=function(self) self:stoptweening():linear(0.5):diffusealpha(0) end
}

for i=1,4 do
	Scores[#Scores+1] = Def.BitmapText {
		File = "_v 26px bold black",
		Name="Name"..i,
		InitCommand=function(self) self:x(scale(i,1,4,-48*WideScreenDiff(),240*WideScreenDiff())):y(-8*WideScreenDiff()):zoomx(0.875*WideScreenDiff()):zoomy(0.625*WideScreenDiff()):maxwidth(100) end
	}
	Scores[#Scores+1] = Def.BitmapText {
		File = "_futurist numbers metallic",
		Name="Score"..i,
		InitCommand=function(self) self:x(scale(i,1,4,-48*WideScreenDiff(),240*WideScreenDiff())):y(10*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.75*WideScreenDiff()) end
	}
end

Scores.SetCommand=function(self,param)
	local profile = PROFILEMAN:GetMachineProfile()
	for name, child in pairs(c) do child:visible(false) end
	local sel = param.Course
	if not sel then return end

	for i, item in pairs(param.Entries) do
		if item then
			local hsl = profile:GetHighScoreList(sel, item)
			local hs = hsl and hsl:GetHighScores()
			local hss = param.Course:GetCourseType() == "CourseType_Survival"

			assert(c["Name"..i])
			assert(c["Score"..i])

			c["Name"..i]:visible(true)
			c["Score"..i]:visible(true)
			if hs and #hs > 0 then
				c["Name"..i]:settext( hs[1]:GetName() )
				if hss then
					c["Score"..i]:settext( FormatPercentScore( hs[1]:GetPercentDP() ) .. " " .. SecondsToMSSMsMs( hs[1]:GetSurvivalSeconds() ) )
				else
					c["Score"..i]:settext( FormatPercentScore( hs[1]:GetPercentDP() ) )
				end
			else
				c["Name"..i]:settext( "-----" )
				if hss then
					c["Score"..i]:settext( FormatPercentScore( 0 ) .. " " .. SecondsToMSSMsMs( 0 ) )
				else
					c["Score"..i]:settext( FormatPercentScore( 0 ) )
				end
			end
		end
	end
end

t[#t+1] = Scores

return t