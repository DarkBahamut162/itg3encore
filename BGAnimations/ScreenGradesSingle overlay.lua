local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("_grade","list")),
	LoadActor(THEME:GetPathB("_grade","difficulties"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+80) end
	}
}

local prof = PROFILEMAN:GetMachineProfile()

local stats = {
	{ Difficulty='Difficulty_Easy' },
	{ Difficulty='Difficulty_Medium' },
	{ Difficulty='Difficulty_Hard' },
	{ Difficulty='Difficulty_Challenge' },
	{ Difficulty='Difficulty_Medium' },
	{ Difficulty='Difficulty_Hard' },
	{ Difficulty='Difficulty_Challenge' }
}

for i=1,4 do
	local nums = Def.ActorFrame{
		Name="NumbersTier"..i,
		InitCommand=function(self) self:y(scale(i+1,1,7,SCREEN_CENTER_Y-130,SCREEN_CENTER_Y+130)) end
	}
	for s=1,10 do
		local score = LoadFont("_futurist metalic")..{
			InitCommand=function(self) self:x(scale(s,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)):zoom(0.7) end,
			BeginCommand=function(self)
				local tier = string.format('Grade_Tier%02i',s)
				self:settext(prof:GetTotalStepsWithTopGrade('StepsType_Dance_Single',Difficulty[i],tier))
			end
		}
		nums[#nums+1] = score
	end
	t[#t+1] = nums
end
for i=5,6 do
	local nums = Def.ActorFrame{
		Name="NumbersTier"..i,
		InitCommand=function(self) self:y(scale(i+1,1,7,SCREEN_CENTER_Y-130,SCREEN_CENTER_Y+130)) end
	}
	for s=1,10 do
		local score = LoadFont("_futurist metalic")..{
			InitCommand=function(self) self:x(scale(s,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)):zoom(0.7) end,
			BeginCommand=function(self)
				local tier = string.format('Grade_Tier%02i',s)
				self:settext(prof:GetTotalTrailsWithTopGrade('StepsType_Dance_Single',Difficulty[i],tier))
			end
		}
		nums[#nums+1] = score
	end
	t[#t+1] = nums
end

return t