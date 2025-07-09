local t = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:x(-30*WideScreenDiff()):y(scale(1,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end,
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Actual",
			InitCommand=function(self) self:x(scale(1,1,3,SCREEN_LEFT+300*WideScreenDiff(),SCREEN_RIGHT-100*WideScreenDiff())):zoom(0.5*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Possible",
			InitCommand=function(self) self:x(scale(2,1,3,SCREEN_LEFT+300*WideScreenDiff(),SCREEN_RIGHT-100*WideScreenDiff())):zoom(0.5*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Star Complete",
			InitCommand=function(self) self:x(scale(3,1,3,SCREEN_LEFT+300*WideScreenDiff(),SCREEN_RIGHT-100*WideScreenDiff())):zoom(0.5*WideScreenDiff()) end
		}
	},
	loadfile(THEME:GetPathB("_summary","difficulties"))()..{
		InitCommand=function(self) self:x(SCREEN_LEFT+110*WideScreenDiff()) end
	}
}

local types = { "Actual","Possible","PercentComplete" }
local prof = PROFILEMAN:GetMachineProfile()
local diffs = { nil, 'Difficulty_Easy', 'Difficulty_Medium', 'Difficulty_Hard', 'Difficulty_Challenge', 'Difficulty_Medium', 'Difficulty_Hard' }
for i=1,3 do
	local thing = Def.ActorFrame{
		InitCommand=function(self) self:x(scale(i,1,3,SCREEN_LEFT+300*WideScreenDiff(),SCREEN_RIGHT-100*WideScreenDiff())) end
	}
	for n=2,isEtterna() and 5 or 7 do
		local num = Def.BitmapText {
			File = "_eurostile normal",
			InitCommand=function(self) self:y(scale(n,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())):zoom(0.6*WideScreenDiff()):halign(1) end,
			BeginCommand=function(self)
				local val, text
				if types[i] == "Actual" then
					if n > 5 then
						val = prof:GetCoursesActual(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[n])
					else
						val = prof:GetSongsActual(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[n])
					end
					text = string.format("%5.2f",val)
				elseif types[i] == "Possible" then
					if n > 5 then
						val = prof:GetCoursesPossible(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[n])
					else
						val = prof:GetSongsPossible(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[n])
					end
					text = string.format("%5.2f",val)
				elseif types[i] == "PercentComplete" then
					if n > 5 then
						val = prof:GetCoursesPercentComplete(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[n])
					else
						val = prof:GetSongsPercentComplete(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[n])
					end
					if val ~= val then val = 0 end
					text = FormatPercentScore(val)
				end
				self:settext(text)
			end
		}
		thing[#thing+1] = num
	end
	t[#t+1] = thing
end

local shortGrade = GetGradeFromPercent(GetTotalPercentComplete(prof,StepsTypeDouble()[GetUserPrefN("StylePosition")]))

local totals = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y+70*WideScreenDiff()) end,
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Total Actual",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-260*WideScreenDiff()):y(-24*WideScreenDiff()):horizalign(left):zoom(0.6*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_r bold numbers",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+106*WideScreenDiff()):y(-24*WideScreenDiff()):horizalign(right):zoom(0.7*WideScreenDiff()) end,
			BeginCommand=function(self)
				local val = 0
				for i=2,isEtterna() and 5 or 7 do
					if i > 5 then
						val = val + prof:GetCoursesActual(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[i])
					else
						val = val + prof:GetSongsActual(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[i])
					end
				end
				self:settext(string.format("%5.2f",val))
			end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Total Possible",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-260*WideScreenDiff()):y(-4*WideScreenDiff()):horizalign(left):zoom(0.6*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_r bold numbers",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+106*WideScreenDiff()):y(-4*WideScreenDiff()):horizalign(right):zoom(0.7*WideScreenDiff()) end,
			BeginCommand=function(self)
				local val = 0
				for i=2,isEtterna() and 5 or 7 do
					if i > 5 then
						val = val + prof:GetCoursesPossible(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[i])
					else
						val = val + prof:GetSongsPossible(StepsTypeDouble()[GetUserPrefN("StylePosition")],diffs[i])
					end
				end
				self:settext(string.format("%5.2f",val))
			end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="Star Complete",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-260*WideScreenDiff()):y(20*WideScreenDiff()):horizalign(left):zoom(0.8*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_r bold numbers",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+136*WideScreenDiff()):y(20*WideScreenDiff()):horizalign(right):zoom(WideScreenDiff()) end,
			BeginCommand=function(self)
				local val = GetTotalPercentComplete(prof,StepsTypeDouble()[GetUserPrefN("StylePosition")])
				if val ~= val then val = 0 end
				self:settext(FormatPercentScore(val))

				if val >= 1 then
					self:diffuseshift()
				end
				self:effectcolor1(color("0.5,0.7,1,1"))
			end
		},
		loadfile( THEME:GetPathG("GradeDisplayEval",shortGrade) )()..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+200*WideScreenDiff()):y(0):zoom(0.9*WideScreenDiff()) end
		}
	}
}
t[#t+1] = totals

return t