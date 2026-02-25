return Def.Sprite{
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():GetName():match("ScreenEdit") then
			if IsGame("po-mu") or IsGame("popn") then
				self:Load(THEME:GetPathG("HoldJudgment/_pop","1x2"))
			elseif IsGame("be-mu") or IsGame("beat") then
				self:Load(THEME:GetPathG("HoldJudgment/_iidx","1x2"))
			else
				self:Load(THEME:GetPathG("HoldJudgment/_itg3","1x2"))
			end
		elseif self:GetParent() and self:GetParent():GetParent() then
			if IsGame("po-mu") or IsGame("popn") then
				self:Load(THEME:GetPathG("HoldJudgment/_pop","1x2"))
			elseif IsGame("be-mu") or IsGame("beat") then
				self:Load(THEME:GetPathG("HoldJudgment/_iidx","1x2"))
			else
				local pn = self:GetParent():GetParent():GetName():gsub("Player", "")
				self:Load(THEME:GetPathG("HoldJudgment/"..(getenv("HoldJudgment"..pn) or "_itg3"),"1x2"))
			end
		end
	end
}
