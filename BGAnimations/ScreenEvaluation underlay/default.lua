return Def.ActorFrame{
	OnCommand = function(self)
		if isOutFox() then
			local player = GAMESTATE:GetMasterPlayerNumber()
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepOrTrails = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			if GAMESTATE:GetCurrentSong() then
				local lengthFull = string.len(GAMESTATE:GetCurrentSong():GetDisplayFullTitle()) + 3 + string.len(GAMESTATE:GetCurrentSong():GetGroupName())
				local lengthMain = string.len(GAMESTATE:GetCurrentSong():GetDisplayMainTitle()) + 3 + string.len(GAMESTATE:GetCurrentSong():GetGroupName())
				local title = lengthFull < 128 and GAMESTATE:GetCurrentSong():GetDisplayFullTitle() or
							--string.sub(GAMESTATE:GetCurrentSong():GetDisplayFullTitle(),1,122-string.len(GAMESTATE:GetCurrentSong():GetGroupName())) .. "..."
							lengthMain < 128 and GAMESTATE:GetCurrentSong():GetDisplayMainTitle() or string.sub(GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),1,122-string.len(GAMESTATE:GetCurrentSong():GetGroupName())) .. "..."
				local songname = title .. " - " .. GAMESTATE:GetCurrentSong():GetGroupName()
				local Difficulty = ToEnumShortString( StepOrTrails:GetDifficulty() ) .. " " .. StepOrTrails:GetMeter()
				local Percentage = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
				local states = Difficulty .. " (".. string.format( "%.2f%%", Percentage*100) .. ")"
				GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(player))
				GAMESTATE:UpdateDiscordScreenInfo(songname,states,1)
			end
		end
	end,
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop")),
	LoadActor("evaluation banner mask")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135):zoom(WideScreenDiff()):zbuffer(true):blend(Blend.NoEffect):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(2.8):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	LoadActor("mask")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-200*WideScreenDiff()):y(SCREEN_CENTER_Y+151*WideScreenDiff()):addx(-EvalTweenDistance()):zbuffer(true):blend(Blend.NoEffect):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	},
	LoadActor("mask")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+200*WideScreenDiff()):y(SCREEN_CENTER_Y+151*WideScreenDiff()):addx(EvalTweenDistance()):zbuffer(true):blend(Blend.NoEffect):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
	LoadActor("light")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-2*WideScreenDiff()):y(SCREEN_CENTER_Y+110-150*WideScreenDiff()):zoom(WideScreenDiff()):diffusealpha(0) end,
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
			self:visible(not doubles and not isVS())
		end,
		OnCommand=function(self) self:sleep(3.5):linear(0.8):diffusealpha(1):diffuseramp():effectperiod(2):effectoffset(0.20):effectclock("beat"):effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFFFF")) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-34*WideScreenDiff()):zoom(WideScreenDiff()) end,
		LoadActor("modsframe "..(isFinal() and "final" or "normal"))..{
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
		}
	},
	LoadActor("trapezoid "..(isFinal() and "final" or "normal"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-109*WideScreenDiff()):zoom(WideScreenDiff()):shadowlength(2):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(3):linear(0.8):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	LoadFont("_v 26px bold shadow")..{
		InitCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_1) then self:settext(DisplayCustomModifiersText(PLAYER_1)) end self:maxwidth(350):zoom(0.5*WideScreenDiff()):x(SCREEN_CENTER_X-11*WideScreenDiff()):y(SCREEN_CENTER_Y+9*WideScreenDiff()):horizalign(right):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
	LoadFont("_v 26px bold shadow")..{
		InitCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_2) then self:settext(DisplayCustomModifiersText(PLAYER_2)) end self:maxwidth(350):zoom(0.5*WideScreenDiff()):x(SCREEN_CENTER_X+8*WideScreenDiff()):y(SCREEN_CENTER_Y+9*WideScreenDiff()):horizalign(left):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="LabelFrame",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-142*WideScreenDiff()) end,
		LoadFont("_v 26px bold shadow")..{
			Text="JUMPS",
			InitCommand=function(self) self:zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="HOLDS",
			InitCommand=function(self) self:y((13*1)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="MINES",
			InitCommand=function(self) self:y((13*2)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="HANDS",
			InitCommand=function(self) self:y((13*3)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="ROLLS",
			InitCommand=function(self) self:y((13*4)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		LoadFont("_v 26px bold shadow")..{
			Text="PEAK COMBO",
			InitCommand=function(self) self:y((13*5)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		LoadActor(THEME:GetPathG("ScreenEvaluation","GraphFrame p1/_base"))..{
			InitCommand=function(self) self:player(PLAYER_1):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-55*WideScreenDiff()):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")+101*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		LoadActor(THEME:GetPathG("ScreenEvaluation","GraphFrame p1/_base"))..{
			InitCommand=function(self) self:player(PLAYER_2):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+55*WideScreenDiff()):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")+101*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		}
	},
	LoadFont("_angel glow")..{
		Condition=not isTopScreen("ScreenEvaluationSummary"),
		InitCommand=function(self) self:x(isFinal() and SCREEN_CENTER_X or SCREEN_CENTER_X-300):halign(isFinal() and 0.5 or 0):y(SCREEN_CENTER_Y-166*WideScreenDiff()):maxwidth(isFinal() and 1000 or 700):zoom(0.6*WideScreenDiff()):shadowlength(0):playcommand("Update") end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end,
		UpdateCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			if song then self:settext( song:GetDisplayFullTitle() ) end
			if course then self:settext( course:GetDisplayFullTitle() ) end
		end
	},
	LoadActor("Score",PLAYER_1)..{Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1)},
	LoadActor("Score",PLAYER_2)..{Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2)}
}