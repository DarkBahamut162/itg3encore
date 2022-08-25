local t = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:x(-30):y(scale(1,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10)) end;

		LoadFont("_eurostile normal")..{
			Text="Actual";
			InitCommand=function(self) self:x(scale(1,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100)):zoom(0.5) end;
		};
		LoadFont("_eurostile normal")..{
			Text="Possible";
			InitCommand=function(self) self:x(scale(2,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100)):zoom(0.5) end;
		};
		LoadFont("_eurostile normal")..{
			Text="Star Complete";
			InitCommand=function(self) self:x(scale(3,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100)):zoom(0.5) end;
		};
	};

	LoadActor(THEME:GetPathB("_summary","difficulties"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+110) end;
	};
};

local types = { "Actual","Possible","PercentComplete" };
local prof = PROFILEMAN:GetMachineProfile()
local diffs = { nil, 'Difficulty_Easy', 'Difficulty_Medium', 'Difficulty_Hard', 'Difficulty_Challenge', 'Difficulty_Medium', 'Difficulty_Hard', }
for i=1,3 do
	local thing = Def.ActorFrame{
		InitCommand=function(self) self:x(scale(i,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100)) end;
	};
	for n=2,7 do
		local diff
		local num = LoadFont("_eurostile normal")..{
			InitCommand=function(self) self:y(scale(n,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10)):zoom(0.6):halign(1) end;
			BeginCommand=function(self)
				local val, text
				if types[i] == "Actual" then
					if n > 5 then
						val = prof:GetCoursesActual('StepsType_Dance_Double',diffs[n])
					else
						val = prof:GetSongsActual('StepsType_Dance_Double',diffs[n])
					end
					text = string.format("%5.2f",val)
				elseif types[i] == "Possible" then
					if n > 5 then
						val = prof:GetCoursesPossible('StepsType_Dance_Double',diffs[n])
					else
						val = prof:GetSongsPossible('StepsType_Dance_Double',diffs[n])
					end
					text = string.format("%5.2f",val)
				elseif types[i] == "PercentComplete" then
					if n > 5 then
						val = GetSongsPercentComplete('StepsType_Dance_Double',diffs[n])
					else
						val = GetSongsPercentComplete('StepsType_Dance_Double',diffs[n])
					end
					text = FormatPercentScore(val)
				end
				self:settext(text)
			end;
		};
		thing[#thing+1] = num;
	end
	t[#t+1] = thing;
end

local shortGrade = ToEnumShortString( GetGradeFromPercent(GetTotalPercentComplete('StepsType_Dance_Double')) )

local totals = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:y(SCREEN_CENTER_Y+70) end;
		LoadFont("_eurostile normal")..{
			Text="Total Actual";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-260):y(-24):horizalign(left):zoom(0.6) end;
		};
		LoadFont("_r bold numbers")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+106):y(-24):horizalign(right):zoom(0.7) end;
			BeginCommand=function(self)
				local val = 0
				for i=1,6 do
					if i > 4 then
						val = val + prof:GetCoursesActual('StepsType_Dance_Double',diffs[i+1])
					else
						val = val + prof:GetSongsActual('StepsType_Dance_Double',diffs[i+1])
					end
				end
				self:settext(string.format("%5.2f",val))
			end;
		};

		LoadFont("_eurostile normal")..{
			Text="Total Possible";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-260):y(-4):horizalign(left):zoom(0.6) end;
		};
		LoadFont("_r bold numbers")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+106):y(-4):horizalign(right):zoom(0.7) end;
			BeginCommand=function(self)
				local val = 0
				for i=1,6 do
					if i > 4 then
						val = val + prof:GetCoursesPossible('StepsType_Dance_Double',diffs[i+1])
					else
						val = val + prof:GetSongsPossible('StepsType_Dance_Double',diffs[i+1])
					end
				end
				self:settext(string.format("%5.2f",val))
			end;
		};

		LoadFont("_eurostile normal")..{
			Text="Star Complete";
			InitCommand=function(self) self:x(SCREEN_CENTER_X-260):y(20):horizalign(left):zoom(0.8) end;
		};
		LoadFont("_r bold numbers")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+136):y(20):horizalign(right) end;
			BeginCommand=function(self)
				local val = GetTotalPercentComplete('StepsType_Dance_Double')
				self:settext(FormatPercentScore(val))

				if val >= 1 then
					self:diffuseshift()
				end;
				self:effectcolor1(color("0.5,0.7,1,1"));
			end;
		};
		LoadActor( THEME:GetPathG("GradeDisplayEval",shortGrade) )..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+200):y(0):zoom(0.9) end;
		};
	};
};
t[#t+1] = totals;

return t;