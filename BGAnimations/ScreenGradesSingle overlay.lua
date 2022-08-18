local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("_grade","list"));

	LoadActor(THEME:GetPathB("_grade","difficulties"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+80) end;
	};
};

local prof = PROFILEMAN:GetMachineProfile();

local stats = {
	{ Difficulty='Difficulty_Easy', },-- 1
	{ Difficulty='Difficulty_Medium', },-- 2
	{ Difficulty='Difficulty_Hard', },-- 3
	{ Difficulty='Difficulty_Challenge', },-- 4
	{ Difficulty='Difficulty_Medium', },-- 5
	{ Difficulty='Difficulty_Hard', },-- 6
	{ Difficulty='Difficulty_Challenge', },-- 7
};

for i=1,4 do
	local nums = Def.ActorFrame{
		Name="NumbersTier"..i;
		InitCommand=function(self) self:y(scale(i+1,1,7,SCREEN_CENTER_Y-130,SCREEN_CENTER_Y+130)) end;
	};
	for s=1,10 do
		local score = LoadFont("_futurist metalic")..{
			InitCommand=function(self) self:x(scale(s,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)):zoom(0.7) end;
			BeginCommand=function(self)
				local tier = string.format('Grade_Tier%02i',s)
				self:settext(prof:GetTotalStepsWithTopGrade('StepsType_Dance_Single',Difficulty[i],tier))
			end;
		};
		table.insert(nums,score)
	end
	table.insert(t,nums)
end
for i=5,6 do
	local nums = Def.ActorFrame{
		Name="NumbersTier"..i;
		InitCommand=function(self) self:y(scale(i+1,1,7,SCREEN_CENTER_Y-130,SCREEN_CENTER_Y+130)) end;
	};
	for s=1,10 do
		local score = LoadFont("_futurist metalic")..{
			InitCommand=function(self) self:x(scale(s,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)):zoom(0.7) end;
			BeginCommand=function(self)
				local tier = string.format('Grade_Tier%02i',s)
				self:settext(prof:GetTotalTrailsWithTopGrade('StepsType_Dance_Single',Difficulty[i],tier))
			end;
		};
		table.insert(nums,score)
	end
	table.insert(t,nums)
end

return t