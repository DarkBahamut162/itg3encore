local master = GAMESTATE:GetMasterPlayerNumber()
local percent = isEtterna() and STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetWifeScore() or 0
local grade = GetGradeFromPercent(percent)

return Def.ActorFrame{
	OnCommand = function(self)
		if isOutFox() and VersionDateCheck(20200500) then
			local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(master) or GAMESTATE:GetCurrentSteps(master)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				local lengthFull = string.len(song:GetDisplayFullTitle()) + 3 + string.len(song:GetGroupName())
				local lengthMain = string.len(song:GetDisplayMainTitle()) + 3 + string.len(song:GetGroupName())
				local title = lengthFull < 128 and song:GetDisplayFullTitle() or
							--string.sub(song:GetDisplayFullTitle(),1,122-string.len(song:GetGroupName())) .. "..."
							lengthMain < 128 and song:GetDisplayMainTitle() or string.sub(song:GetDisplayMainTitle(),1,122-string.len(song:GetGroupName())) .. "..."
				local songname = title .. " - " .. song:GetGroupName()
				local Difficulty = ToEnumShortString( StepsOrTrail:GetDifficulty() ) .. " " .. StepsOrTrail:GetMeter()
				local Percentage = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetPercentDancePoints()
				local autoPlayer = getenv("EvalCombo"..pname(master)) and "" or " | AUTOPLAYER"
				local states = Difficulty .. " (".. string.format( "%.2f%%", Percentage*100) .. ")"..autoPlayer
				GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(master))
				GAMESTATE:UpdateDiscordScreenInfo(songname,states,1)
			end
		end
	end,
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))(),
	Def.Sprite {
		Texture = "evaluation banner mask",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+135*WideScreenDiff()):zoom(WideScreenDiff()):zbuffer(true):blend(Blend.NoEffect):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(2.8):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Def.Sprite {
		Texture = "mask",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-200*WideScreenDiff()):y(SCREEN_CENTER_Y+151*WideScreenDiff()):addx(-EvalTweenDistance()):zbuffer(true):blend(Blend.NoEffect):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	},
	Def.Sprite {
		Texture = "mask",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+200*WideScreenDiff()):y(SCREEN_CENTER_Y+151*WideScreenDiff()):addx(EvalTweenDistance()):zbuffer(true):blend(Blend.NoEffect):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
	Def.Sprite {
		Condition=not isDouble() and not isVS(),
		Texture = "light",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-2*WideScreenDiff()):y(SCREEN_CENTER_Y+110-150*WideScreenDiff()):zoom(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(3.5):linear(0.8):diffusealpha(1):diffuseramp():effectperiod(2):effectoffset(0.20):effectclock("beat"):effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFFFF")) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-34*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.Sprite {
			Texture = "modsframe "..(isFinal() and "final" or "normal"),
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
		}
	},
	Def.Sprite {
		Texture = "trapezoid "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-109*WideScreenDiff()):zoom(WideScreenDiff()):shadowlength(2):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(3):linear(0.8):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_v 26px bold shadow",
		InitCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_1) then self:settext(DisplayCustomModifiersText(PLAYER_1)) end self:maxwidth(350):zoom(0.5*WideScreenDiff()):x(SCREEN_CENTER_X-11*WideScreenDiff()):y(SCREEN_CENTER_Y+9*WideScreenDiff()):horizalign(right):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
	Def.BitmapText {
		Condition=not isEtterna(),
		File = "_v 26px bold shadow",
		InitCommand=function(self) if GAMESTATE:IsPlayerEnabled(PLAYER_2) then self:settext(DisplayCustomModifiersText(PLAYER_2)) end self:maxwidth(350):zoom(0.5*WideScreenDiff()):x(SCREEN_CENTER_X+8*WideScreenDiff()):y(SCREEN_CENTER_Y+9*WideScreenDiff()):horizalign(left):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="LabelFrame",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-142*WideScreenDiff()) end,
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Text="JUMPS",
			InitCommand=function(self) self:zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Text="HOLDS",
			InitCommand=function(self) self:y((13*1)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Text="MINES",
			InitCommand=function(self) self:y((13*2)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Text="HANDS",
			InitCommand=function(self) self:y((13*3)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Text="ROLLS",
			InitCommand=function(self) self:y((13*4)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_v 26px bold shadow",
			Text="PEAK COMBO",
			InitCommand=function(self) self:y((13*5)*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.4*WideScreenDiff()):shadowlength(0):diffusebottomedge(color("#BBB9FB")) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.8):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenEvaluation","GraphFrame p1/_base"),
			InitCommand=function(self) self:player(PLAYER_1):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-55*WideScreenDiff()):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")+101*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
		},
		Def.Sprite {
			Condition=not isEtterna(),
			Texture = THEME:GetPathG("ScreenEvaluation","GraphFrame p1/_base"),
			InitCommand=function(self) self:player(PLAYER_2):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+55*WideScreenDiff()):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")+101*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):addx(EvalTweenDistance()) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
			OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
		}
	},
	Def.BitmapText {
		File = "_angel glow",
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-166*WideScreenDiff()):maxwidth(SCREEN_WIDTH/0.7):vertspacing(-10):zoom(0.6*WideScreenDiff()):shadowlength(0):playcommand("Update") end,
		OnCommand=function(self) self:diffusealpha(0):sleep(3):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end,
		UpdateCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				self:settext( GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().."\n"..GAMESTATE:GetCurrentCourse():GetGroupName() )
			else
				local SongOrSteps = checkBMS() and GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()) or GAMESTATE:GetCurrentSong()
				local text = ""
				if SongOrSteps then text = checkBMS() and GetBMSTitle(SongOrSteps) or SongOrSteps:GetDisplayFullTitle() end
				self:settext(text.."\n"..GAMESTATE:GetCurrentSong():GetGroupName())
			end
		end
	},
	Def.ActorFrame{
		Condition=isEtterna(),
		loadfile(THEME:GetPathG("GradeDisplayEval",grade))()..{
			InitCommand=function(self)
				self:player(master):name("Grade" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		},
		Def.Sprite{
			InitCommand=function(self)
				self:player(master):name("LargeBanner"):playcommand("Set")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end,
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local bnpath
				if song then
					bnpath = song:GetBannerPath()
				else
					bnpath = SONGMAN:GetSongGroupBannerPath(SCREENMAN:GetTopScreen():GetMusicWheel():GetSelectedSection())
				end
				if not bnpath or bnpath == "" then bnpath = THEME:GetPathG("Common", "fallback banner") end
				self:scaletoclipped(292,114):LoadBackground(bnpath)
			end,
		},
		loadfile(THEME:GetPathG("ScreenEvaluation","BannerFrame"))()..{
			InitCommand=function(self)
				self:player(master):name("LargeBannerFrame")
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		},
		loadfile(THEME:GetPathG("ScreenEvaluation","GradeFrame " .. PlayerNumberToString(master)))()..{
			InitCommand=function(self)
				self:player(master):name("GradeFrame" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		},
		loadfile(THEME:GetPathG("ScreenEvaluation","GraphFrame " .. PlayerNumberToString(master)))()..{
			InitCommand=function(self)
				self:player(master):name("GraphFrame" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("W1Number" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetTapNoteScores('TapNoteScore_W1'))
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("W2Number" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetTapNoteScores('TapNoteScore_W2'))
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("W3Number" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetTapNoteScores('TapNoteScore_W3'))
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("W4Number" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetTapNoteScores('TapNoteScore_W4'))
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("W5Number" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetTapNoteScores('TapNoteScore_W5'))
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("MissNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersJudgment"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetTapNoteScores('TapNoteScore_Miss'))
			end
		},

		Def.BitmapText{
			Font=THEME:GetPathF("ScreenEvaluation","DetailLineNumber"),
			InitCommand=function(self)
				self:player(master):name("JumpsNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				local actual = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarActual():GetValue( "RadarCategory_Jumps" )
				local possible = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarPossible():GetValue( "RadarCategory_Jumps" )
				self:settextf("%3d/%3d",actual,possible)
			end
		},
		Def.BitmapText{
			Font=THEME:GetPathF("ScreenEvaluation","DetailLineNumber"),
			InitCommand=function(self)
				self:player(master):name("HoldsNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				local actual = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarActual():GetValue( "RadarCategory_Holds" )
				local possible = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarPossible():GetValue( "RadarCategory_Holds" )
				self:settextf("%3d/%3d",actual,possible)
			end
		},
		Def.BitmapText{
			Font=THEME:GetPathF("ScreenEvaluation","DetailLineNumber"),
			InitCommand=function(self)
				self:player(master):name("MinesNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				local actual = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarActual():GetValue( "RadarCategory_Mines" )
				local possible = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarPossible():GetValue( "RadarCategory_Mines" )
				self:settextf("%3d/%3d",actual,possible)
			end
		},
		Def.BitmapText{
			Font=THEME:GetPathF("ScreenEvaluation","DetailLineNumber"),
			InitCommand=function(self)
				self:player(master):name("HandsNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				local actual = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarActual():GetValue( "RadarCategory_Hands" )
				local possible = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarPossible():GetValue( "RadarCategory_Hands" )
				self:settextf("%3d/%3d",actual,possible)
			end
		},
		Def.BitmapText{
			Font=THEME:GetPathF("ScreenEvaluation","DetailLineNumber"),
			InitCommand=function(self)
				self:player(master):name("RollsNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				local actual = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarActual():GetValue( "RadarCategory_Rolls" )
				local possible = STATSMAN:GetCurStageStats():GetPlayerStageStats(master):GetRadarPossible():GetValue( "RadarCategory_Rolls" )
				self:settextf("%3d/%3d",actual,possible)
			end
		},
		Def.RollingNumbers{
			Font=THEME:GetPathF("ScreenEvaluation","JudgmentLineNumber"),
			InitCommand=function(self)
				self:player(master):name("MaxComboNumber" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
				self:Load("RollingNumbersMaxCombo"):targetnumber(STATSMAN:GetCurStageStats():GetPlayerStageStats(master):MaxCombo())
			end
		},

		Def.BitmapText {
			File = "Common normal",
			Text=GAMESTATE:GetPlayerState(master):GetPlayerOptionsString("ModsLevel_Song"),
			InitCommand=function(self)
				self:player(master):name("PlayerOptions" .. PlayerNumberToString(master))
				ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
			end
		}
	},
	loadfile(THEME:GetPathB("ScreenEvaluation","underlay/Score"))(PLAYER_1)..{Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1)},
	loadfile(THEME:GetPathB("ScreenEvaluation","underlay/Score"))(PLAYER_2)..{Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2)}
}