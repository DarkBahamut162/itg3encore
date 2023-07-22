local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("_grade","list")),
	LoadActor(THEME:GetPathB("_grade","difficulties"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+80*WideScreenDiff()) end
	}
}

local prof = PROFILEMAN:GetMachineProfile()
local diffs = { nil, 'Difficulty_Easy', 'Difficulty_Medium', 'Difficulty_Hard', 'Difficulty_Challenge', 'Difficulty_Medium', 'Difficulty_Hard' }

for i=2,7 do
	local nums = Def.ActorFrame{
		Name="NumbersTier"..i,
		InitCommand=function(self) self:y(scale(i,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	}
	for s=1,10 do
		local score = LoadFont("_futurist metalic")..{
			InitCommand=function(self) self:x(scale(s,1,10,SCREEN_LEFT+160*WideScreenDiff(),SCREEN_RIGHT-50*WideScreenDiff())):zoom(0.7*WideScreenDiff()) end,
			BeginCommand=function(self)
				local tier = string.format('Grade_Tier%02i',s)
				if i > 5 then
					self:settext(prof:GetTotalTrailsWithTopGrade(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[i],tier))
				else
					self:settext(prof:GetTotalStepsWithTopGrade(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[i],tier))
				end
			end
		}
		nums[#nums+1] = score
	end
	t[#t+1] = nums
end

return t