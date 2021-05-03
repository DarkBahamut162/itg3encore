local t = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(x,-30;y,scale(1,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););

		LoadFont("_eurostile normal")..{
			Text="Actual";
			InitCommand=cmd(x,scale(1,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100);zoom,.5;);
		};
		LoadFont("_eurostile normal")..{
			Text="Possible";
			InitCommand=cmd(x,scale(2,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100);zoom,.5;);
		};
		LoadFont("_eurostile normal")..{
			Text="Star Complete";
			InitCommand=cmd(x,scale(3,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100);zoom,.5;);
		};
	};

	LoadActor(THEME:GetPathB("_summary","difficulties"))..{
		InitCommand=cmd(x,SCREEN_LEFT+110);
	};
};

local types = { "Actual","Possible","PercentComplete" };
local prof = PROFILEMAN:GetMachineProfile()
local diffs = { nil, 'Difficulty_Easy', 'Difficulty_Medium', 'Difficulty_Hard', 'Difficulty_Challenge', 'Difficulty_Medium', 'Difficulty_Hard', }
for i=1,3 do
	local thing = Def.ActorFrame{
		InitCommand=cmd(x,scale(i,1,3,SCREEN_LEFT+300,SCREEN_RIGHT-100));
	};
	for n=2,7 do
		local diff
		local num = LoadFont("_eurostile normal")..{
			InitCommand=cmd(y,scale(n,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10);zoom,.6;halign,1;);
			BeginCommand=function(self)
				--set real numbers here
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
		table.insert(thing,num)
	end
	table.insert(t,thing)
end

local shortGrade = ToEnumShortString( GetGradeFromPercent(GetTotalPercentComplete('StepsType_Dance_Double')) )

local totals = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_CENTER_Y+70);
		LoadFont("_eurostile normal")..{
			Text="Total Actual";
			InitCommand=cmd(x,SCREEN_CENTER_X-260;y,-24;horizalign,left;zoom,0.6);
		};
		LoadFont("_r bold numbers")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+106;y,-24;horizalign,right;zoom,0.7);
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
			InitCommand=cmd(x,SCREEN_CENTER_X-260;y,-4;horizalign,left;zoom,0.6);
		};
		LoadFont("_r bold numbers")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+106;y,-4;horizalign,right;zoom,0.7);
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
			InitCommand=cmd(x,SCREEN_CENTER_X-260;y,20;horizalign,left;zoom,0.8);
		};
		LoadFont("_r bold numbers")..{
			InitCommand=cmd(x,SCREEN_CENTER_X+136;y,20;horizalign,right;);
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
			InitCommand=cmd(x,SCREEN_CENTER_X+200;y,0;zoom,0.9);
		};
	};
};
table.insert(t,totals)

-- extra crap!

return t;