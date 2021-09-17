return Def.ActorFrame{
	OnCommand=function(self)
		self:x( SCREEN_CENTER_X )
		self:y( SCREEN_CENTER_Y)
	end;

	Def.ActorFrame{
		Condition=GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave';
		Def.ActorFrame{
			Name="PlayerP1";
			InitCommand=function(self) self:x(SCREEN_LEFT+20-SCREEN_WIDTH/2):addx(-100) end;
			BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1) and getenv("StatsDisplayP1") or false) end;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(-100) end;

			LoadActor("s_bg")..{
				InitCommand=function(self) self:vertalign(bottom):y(-111+1):zoomx(1) end;
			};
			LoadActor("s_bar_fantastic")..{
				InitCommand=function(self) self:vertalign(bottom):x(10):y(-111):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_1 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("s_bar_excellent")..{
				InitCommand=function(self) self:vertalign(bottom):y(-111):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_1 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("s_bar_other")..{
				InitCommand=function(self) self:vertalign(bottom):x(-10):y(-111):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_1 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					end
				end;
			};
		};

		Def.ActorFrame{
			Name="PlayerP2";
			InitCommand=function(self) self:x(SCREEN_RIGHT-20-SCREEN_WIDTH/2):addx(100) end;
			BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2) and getenv("StatsDisplayP2") or false) end;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(-100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(100) end;

			LoadActor("s_bg")..{
				InitCommand=function(self) self:vertalign(bottom):y(-111+1):zoomx(-1) end;
			};
			LoadActor("s_bar_fantastic")..{
				InitCommand=function(self) self:vertalign(bottom):x(-10):y(-111):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_2 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("s_bar_excellent")..{
				InitCommand=function(self) self:vertalign(bottom):y(-111):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_2 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("s_bar_other")..{
				InitCommand=function(self) self:vertalign(bottom):x(10):y(-111):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_2 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					end
				end;
			};
		};
	};

	Def.ActorFrame{
		Condition=GAMESTATE:GetPlayMode() == 'PlayMode_Rave';
		Def.ActorFrame{
			Name="PlayerP1";
			InitCommand=function(self) self:x(SCREEN_LEFT+20-SCREEN_WIDTH/2):addx(-100) end;
			BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1)) end;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(-100) end;
	
			LoadActor("d_bg")..{
				InitCommand=function(self) self:zoomx(-1) end;
			};
			LoadActor("d_bar_fantastic")..{
				InitCommand=function(self) self:vertalign(bottom):x(4):y(164):zoomx(4.66/14):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_1 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("d_bar_excellent")..{
				InitCommand=function(self) self:vertalign(bottom):y(164):zoomx(4.66/14):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_1 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("d_bar_other")..{
				InitCommand=function(self) self:vertalign(bottom):x(-4):y(164):zoomx(4.66/14):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_1 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_1):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					end
				end;
			};
		};

		Def.ActorFrame{
			Name="PlayerP2";
			InitCommand=function(self) self:x(SCREEN_RIGHT-20-SCREEN_WIDTH/2):addx(100) end;
			BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2)) end;
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(-100) end;
			OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(100) end;
	
			LoadActor("d_bg");
			LoadActor("d_bar_fantastic")..{
				InitCommand=function(self) self:vertalign(bottom):x(-4):y(164):zoomx(4.66/14):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_2 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
							self:zoomy(w1Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("d_bar_excellent")..{
				InitCommand=function(self) self:vertalign(bottom):y(164):zoomx(4.66/14):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_2 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
							self:zoomy(w2Notes/TotalSteps)
						end
					end
				end;
			};
			LoadActor("d_bar_other")..{
				InitCommand=function(self) self:vertalign(bottom):x(4):y(164):zoomx(4.66/14):zoomy(0) end;
				StepMessageCommand=function(self,p)
					if p.PlayerNumber == PLAYER_2 then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							local TotalSteps = trail:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds');
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					elseif song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then
							local TotalSteps = steps:GetRadarValues(PLAYER_2):GetValue('RadarCategory_TapsAndHolds')
							local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
							local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
							otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
							self:zoomy(otherNotes/TotalSteps)
						end
					end
				end;
			};
		};
	};

	Def.ActorFrame{
		Name="Labels";
		InitCommand=function(self) self:y(GAMESTATE:GetPlayMode() == 'PlayMode_Rave' and -10 or 0):addy(-100) end;
		BeginCommand=function(self) self:visible(getenv("StatsDisplayP1") or getenv("StatsDisplayP2") or false) end;
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end;
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#b2f9ff")):settext("F") end;
		};
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#ffe2bd")):settext("E") end;
		};
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.5):horizalign(center):diffuse(color("#c9fb9f")):settext("D") end;
		};
	};

	Def.ActorFrame{
		Name="NumbersP1";
		InitCommand=function(self) self:y(GAMESTATE:GetPlayMode() == 'PlayMode_Rave' and -10 or 0):addy(-100) end;
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_1) and getenv("StatsDisplayP1") or false) end;
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end;
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
		StepMessageCommand=function(self,p)
			if p.PlayerNumber == PLAYER_1 then
				self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end);
			end
		end;
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/4.5):horizalign(right):settext("0") end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
				local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
				self:settext(w1Notes)
			end;
		};
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(right):settext("0") end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
				local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
				self:settext(w2Notes)
			end;
		};
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:x(-8):y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/7):horizalign(right):settext("0") end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
				local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
				otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
				otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
				self:settext(otherNotes)
			end;
		};
	};

	Def.ActorFrame{
		Name="NumbersP2";
		InitCommand=function(self) self:y(GAMESTATE:GetPlayMode() == 'PlayMode_Rave' and -10 or 0):addy(-100) end;
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(PLAYER_2) and getenv("StatsDisplayP2") or false) end;
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end;
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addy(-100) end;
		StepMessageCommand=function(self,p)
			if p.PlayerNumber == PLAYER_2 then
				self:RunCommandsOnChildren(function(self) self:queuecommand("Update") end);
			end
		end;
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*0-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/4.5):horizalign(left):settext("0") end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
				local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
				self:settext(w1Notes)
			end;
		};
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*1-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/5):horizalign(left):settext("0") end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
				local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
				self:settext(w2Notes)
			end;
		};
		LoadFont("ScreenGameplay judgment")..{
			InitCommand=function(self) self:x(8):y(SCREEN_TOP+92+15*2-SCREEN_HEIGHT/2):zoom(0.6):maxwidth(SCREEN_WIDTH/7):horizalign(left):settext("0") end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2)
				local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
				otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
				otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
				self:settext(otherNotes)
			end;
		};
	};
};