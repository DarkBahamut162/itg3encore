local t = Def.ActorFrame{}
local tOnline = Def.ActorFrame{}
setenv("Restart",0)

if ShowStandardDecoration("StyleIcon") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StyleIcon"))() .. {
		InitCommand=function(self)
			self:name("StyleIcon")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
if ShowStandardDecoration("StageDisplay") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StageDisplay"))() .. {
		InitCommand=function(self)
			self:name("StageDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
if IsNetSMOnline() and ShowStandardDecoration("UserList") then
	tOnline[#tOnline+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "UserList"))() .. {
		InitCommand=function(self)
			self:name("UserList")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
if IsNetSMOnline() and ThemePrefs.Get("ShowGraph") then
	tOnline[#tOnline+1] = loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(GAMESTATE:GetMasterPlayerNumber())..{
		InitCommand=function(self) self:zoom(1/2*WideScreenDiff()):x(SCREEN_CENTER_X+55*WideScreenDiff()):y(SCREEN_CENTER_Y-54*WideScreenDiff()) end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if GAMESTATE:GetCurrentSong() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if GAMESTATE:GetCurrentCourse() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
}
end

local Online = IsNetSMOnline() and Def.ActorFrame{
	loadfile(THEME:GetPathG(Var "LoadingScreen", "ArtistDisplay"..pname(GAMESTATE:GetMasterPlayerNumber())))() .. {
		InitCommand=function(self)
			self:name("ArtistDisplay"..pname(GAMESTATE:GetMasterPlayerNumber()))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	},
	loadfile(THEME:GetPathG(Var "LoadingScreen", "BPMDisplay"..pname(GAMESTATE:GetMasterPlayerNumber())))() .. {
		InitCommand=function(self)
			self:name("BPMDisplay"..pname(GAMESTATE:GetMasterPlayerNumber()))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	},
	loadfile(THEME:GetPathG(Var "LoadingScreen", "SongTime"..pname(GAMESTATE:GetMasterPlayerNumber())))() .. {
		InitCommand=function(self)
			self:name("SongTime"..pname(GAMESTATE:GetMasterPlayerNumber()))
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	},
	tOnline
} or Def.ActorFrame{}
local courseMode = GAMESTATE:IsCourseMode()
local _text = {}
local index = 1
local _switch = THEME:GetMetric("HelpDisplay","TipSwitchTime")
local _start = GetTimeSinceStart()

local HelpDisplay = isEtterna("0.65") and Def.BitmapText {
	File=THEME:GetPathF("HelpDisplay","text"),
	InitCommand=function(self)
		local s = THEME:GetString("ScreenSelectMusic", "HelpSelectText"..(ThemePrefs.Get("SLFavorites") and "WithSL" or ""))
		_text = split("::",s)
		self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5):maxwidth(269):shadowlength(2):queuecommand("Update")
		self:CenterX():zoomx(0.3*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusealpha(0)
	end,
	UpdateCommand=function(self)
		if #_text == 1 then
			self:settext(_text[1])
		else
			local _current = GetTimeSinceStart()
			if _current-_start >= _switch then
				_start = _current
				if #_text == index then index = 1 else index = index + 1 end
			end

			self:settext(_text[index]):sleep(1/60):queuecommand("Update")
		end
	end,
	SelectMenuOpenedMessageCommand=function(self) self:bounceend(0.2):diffusealpha(1):zoomx(0.6*WideScreenDiff()) end,
	SelectMenuClosedMessageCommand=function(self) self:linear(0.2):diffusealpha(0):zoomx(0.3*WideScreenDiff()) end
	} or Def.HelpDisplay {
	File=THEME:GetPathF("HelpDisplay", "text"),
	InitCommand=function(self)
		local s = isOutFox(20230000) and THEME:GetString("ScreenSelectMusic", "HelpSelectTextOutFox"..(ThemePrefs.Get("SLFavorites") and "WithSL" or "")) or THEME:GetString("ScreenSelectMusic", "HelpSelectText"..(ThemePrefs.Get("SLFavorites") and "WithSL" or ""))
		self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
		self:SetTipsColonSeparated(s)
		self:maxwidth(269):shadowlength(2)
		self:CenterX():zoomx(0.3*WideScreenDiff()):zoomy(0.6*WideScreenDiff()):diffusealpha(0)
	end,
	OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5) end,
	OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
	SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.6*WideScreenDiff()) end,
	SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.3*WideScreenDiff()) end
}

local keyboardEnabled = ThemePrefs.Get("KeyboardEnabled")
local ctrlHeld = { PLAYER_1 = false, PLAYER_2 = false }
local highscores = { PLAYER_1 = 0, PLAYER_2 = 0 }

local InputHandler = function(event)
	if keyboardEnabled then
		if string.find(event.DeviceInput.button,"ctrl") then
			local pn = string.find(event.DeviceInput.button,"left") and PLAYER_1 or PLAYER_2
			if GAMESTATE:IsHumanPlayer(pn) then
				if event.type == "InputEventType_FirstPress" then
					if not ctrlHeld[pn] and GAMESTATE:GetCurrentSong() then
						MESSAGEMAN:Broadcast("ControlMenuOpened"..pname(pn))
						ctrlHeld[pn] = true
					end
				elseif event.type == "InputEventType_Release" then
					if ctrlHeld[pn] then MESSAGEMAN:Broadcast("ControlMenuClosed"..pname(pn)) end
					ctrlHeld[pn] = false
				end
			end
		end
	else
		if event.PlayerNumber then
			if event.GameButton == "Select" then
				if GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
					if event.type == "InputEventType_FirstPress" then
						if GAMESTATE:GetCurrentSong() and not ctrlHeld[event.PlayerNumber] then
							ctrlHeld[event.PlayerNumber] = true
							MESSAGEMAN:Broadcast("ControlMenuOpened"..pname(event.PlayerNumber))
						end
					elseif event.type == "InputEventType_Release" then
						ctrlHeld[event.PlayerNumber] = false
						MESSAGEMAN:Broadcast("SelectMenuClosed",{Player=event.PlayerNumber})
						MESSAGEMAN:Broadcast("ControlMenuClosed"..pname(event.PlayerNumber))
					end
				end
			end
		end
	end
end
return Def.ActorFrame{
	OnCommand=function(self)
		if getenv("SessionStart") == 0 then setenv("SessionStart",GetTimeSinceStart()) end
		if isOutFox(20200500) then
			GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(GAMESTATE:GetMasterPlayerNumber()))
			local text = ""
			if course then
				text = "Selecting Course"
			else
				if IsNetSMOnline() then
					text = "Selecting Song (Online Mode)"
				elseif GAMESTATE:IsEventMode() then
					text = "Selecting Song (Event Mode)"
				else
					local StageIndex = GAMESTATE:GetCurrentStageIndex()
					text = "Selecting Song (Stage ".. StageIndex+1 .. ")"
				end
			end
			GAMESTATE:UpdateDiscordScreenInfo(text,"",1)
		elseif isEtterna("0.57") then
			updateDiscordStatusForMenus()
		end
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
	end,
	OffCommand = function(self)
		if isOni() then
			for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
				local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
				if playeroptions:MMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:MMod().."m",pn) break end
				if isOutFox(20210200) then if playeroptions:AMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:AMod().."a",pn) break end end
				if isOutFox(20220300) then if playeroptions:CAMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:CAMod().."ca",pn) break end end
				if isOutFox(20220900) then if playeroptions:AVMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:AVMod().."av",pn) break end end
				if playeroptions:XMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:XMod().."x",pn) end
				if playeroptions:CMod() then GAMESTATE:ApplyGameCommand('mod,'..playeroptions:CMod().."c",pn) end
			end
		end
		SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler)
	end,

	Def.ActorFrame{
		Condition=not isEtterna("0.55"),
		Name="HighscoreListP1",
		InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM-100*WideScreenDiff()):addx(-SCREEN_WIDTH):player(PLAYER_1):draworder(-2) end,
		OnCommand=function(self) self:decelerate(0.75):addx(SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(-SCREEN_WIDTH) end,
		ShowCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-(127+15*math.max(0,math.min(highscores[PLAYER_1]-1,10)))*WideScreenDiff()) end,
		HideCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-100*WideScreenDiff()) end,
		ControlMenuOpenedP1MessageCommand=function(self) self:playcommand((courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()) and "Show" or "Hide") end,
		ControlMenuClosedP1MessageCommand=function(self) self:playcommand("Hide") end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode and ctrlHeld[PLAYER_1] then if not GAMESTATE:GetCurrentSong() then self:playcommand("Hide") else self:playcommand("Show") end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode and ctrlHeld[PLAYER_1] then if not GAMESTATE:GetCurrentCourse() then self:playcommand("Hide") else self:playcommand("Show") end end end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenEditMenu","underlay/main"),
			InitCommand=function(self) self:horizalign(right):vertalign(top):xy(300*WideScreenDiff(),-18*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:maxwidth(500):horizalign(left):vertalign(top):x(20*WideScreenDiff()):y(-4*WideScreenDiff()):shadowlength(0.5):zoom(0.5*WideScreenDiff()) end,
			CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentTrailP1ChangedMessageCommand=function(self) if courseMode then self:playcommand("Update") end end,
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local output = ""
				local add = keyboardEnabled and 0 or 1.1
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps then
						--local machine = PROFILEMAN:GetMachineProfile():GetHighScoreList(song,steps):GetHighScores()
						local profile = PROFILEMAN:GetProfile(PLAYER_1):GetHighScoreList(song,steps):GetHighScores()
						highscores[PLAYER_1] = #profile + add
						if #profile == 0 then
							highscores[PLAYER_1] = highscores[PLAYER_1] + add / 1.1
							output = "NO HIGHSCORES"
						else
							for place,highscore in pairs(profile) do
								output = addToOutput(output,"#"..place..": "..string.format("%03.2f%%",highscore:GetPercentDP()*100).." | "..highscore:GetName().." | "..highscore:GetDate(),"\n")
							end
						end
						if ctrlHeld[PLAYER_1] then self:GetParent():stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-(127+15*math.max(0,math.min(highscores[PLAYER_1]-1,9)))*WideScreenDiff()) end
					end
				elseif courseMode then
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
						if trail then
							--local machine = PROFILEMAN:GetMachineProfile():GetHighScoreList(course,trail):GetHighScores()
							local profile = PROFILEMAN:GetProfile(PLAYER_1):GetHighScoreList(course,trail):GetHighScores()
							highscores[PLAYER_1] = #profile + add
							if #profile == 0 then
								output = "NO HIGHSCORES"
							else
								for place,highscore in pairs(profile) do
									output = addToOutput(output,"#"..place..": "..string.format("%03.2f%%",highscore:GetPercentDP()*100).." | "..highscore:GetName().." | "..highscore:GetDate(),"\n")
								end
							end
							if ctrlHeld[PLAYER_1] then self:GetParent():stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-(127+15*math.max(0,math.min(highscores[PLAYER_1]-1,9)))*WideScreenDiff()) end
						end
					end
				else
					self:playcommand("ControlMenuClosedP1Message")
				end

				self:settext(output)
			end
		}
	},

	Def.ActorFrame{
		Condition=not isEtterna("0.55"),
		Name="HighscoreListP2",
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM-100*WideScreenDiff()):addx(SCREEN_WIDTH):player(PLAYER_2):draworder(-2) end,
		OnCommand=function(self) self:decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
		ShowCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-(127+15*math.max(0,math.min(highscores[PLAYER_2]-1,10)))*WideScreenDiff()) end,
		HideCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-100*WideScreenDiff()) end,
		ControlMenuOpenedP2MessageCommand=function(self) self:playcommand((courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()) and "Show" or "Hide") end,
		ControlMenuClosedP2MessageCommand=function(self) self:playcommand("Hide") end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode and ctrlHeld[PLAYER_2] then if not GAMESTATE:GetCurrentSong() then self:playcommand("Hide") else self:playcommand("Show") end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode and ctrlHeld[PLAYER_2] then if not GAMESTATE:GetCurrentCourse() then self:playcommand("Hide") else self:playcommand("Show") end end end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenEditMenu","underlay/main"),
			InitCommand=function(self) self:horizalign(right):vertalign(top):xy(300*WideScreenDiff(),-18*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:maxwidth(500):horizalign(right):vertalign(top):x(-20*WideScreenDiff()):y(-4*WideScreenDiff()):shadowlength(0.5):zoom(0.5*WideScreenDiff()) end,
			CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentTrailP2ChangedMessageCommand=function(self) if courseMode then self:playcommand("Update") end end,
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local output = ""
				local add = keyboardEnabled and 0 or 1.1
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps then
						--local machine = PROFILEMAN:GetMachineProfile():GetHighScoreList(song,steps):GetHighScores()
						local profile = PROFILEMAN:GetProfile(PLAYER_2):GetHighScoreList(song,steps):GetHighScores()
						highscores[PLAYER_2] = #profile + add
						if #profile == 0 then
							highscores[PLAYER_2] = highscores[PLAYER_2] + add / 1.1
							output = "NO HIGHSCORES"
						else
							for place,highscore in pairs(profile) do
								output = addToOutput(output,"#"..place..": "..string.format("%03.2f%%",highscore:GetPercentDP()*100).." | "..highscore:GetName().." | "..highscore:GetDate(),"\n")
							end
						end
						if ctrlHeld[PLAYER_2] then self:GetParent():stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-(127+15*math.max(0,math.min(highscores[PLAYER_2]-1,9)))*WideScreenDiff()) end
					end
				elseif courseMode then
					local course = GAMESTATE:GetCurrentCourse()
					if course then
						local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
						if trail then
							--local machine = PROFILEMAN:GetMachineProfile():GetHighScoreList(course,trail):GetHighScores()
							local profile = PROFILEMAN:GetProfile(PLAYER_2):GetHighScoreList(course,trail):GetHighScores()
							highscores[PLAYER_2] = #profile + add
							if #profile == 0 then
								output = "NO HIGHSCORES"
							else
								for place,highscore in pairs(profile) do
									output = addToOutput(output,"#"..place..": "..string.format("%03.2f%%",highscore:GetPercentDP()*100).." | "..highscore:GetName().." | "..highscore:GetDate(),"\n")
								end
							end
							if ctrlHeld[PLAYER_2] then self:GetParent():stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-(127+15*math.max(0,math.min(highscores[PLAYER_2]-1,9)))*WideScreenDiff()) end
						end
					end
				else
					self:playcommand("ControlMenuClosedP2Message")
				end

				self:settext(output)
			end
		}
	},
	Def.ActorFrame{
		Name="StepArtistP1",
		InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM-109*WideScreenDiff()):addx(-SCREEN_WIDTH):player(PLAYER_1):draworder(-2) end,
		OnCommand=function(self) self:decelerate(0.75):addx(SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(-SCREEN_WIDTH) end,
		ShowCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-127*WideScreenDiff()) end,
		HideCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-109*WideScreenDiff()) end,
		SelectMenuOpenedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				self:playcommand((courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()) and "Show" or "Hide")
			end
		end,
		SelectMenuClosedMessageCommand=function(self) self:playcommand("Hide") end,
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_artist "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:horizalign(left):zoom(0.5*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:maxwidth(350):horizalign(left):x(20*WideScreenDiff()):y(2*WideScreenDiff()):shadowlength(0.5):zoom(0.5*WideScreenDiff()) end,
			CurrentSongChangedMessageCommand=function(self) if not courseMode then if not GAMESTATE:GetCurrentSong() then self:playcommand("SelectMenuClosedMessage") end end end,
			CurrentCourseChangedMessageCommand=function(self) if courseMode then if not GAMESTATE:GetCurrentCourse() then self:playcommand("SelectMenuClosedMessage") end end end,
			CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentTrailP1ChangedMessageCommand=function(self) if courseMode then self:playcommand("Update") end end,
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local output = ""
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps ~= nil then output = steps:GetAuthorCredit() end
				elseif courseMode then
					local trail = GAMESTATE:GetCurrentTrail(PLAYER_1)
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							if not string.find(output,entries[i]:GetSteps():GetAuthorCredit()) then
								output = addToOutput(output,entries[i]:GetSteps():GetAuthorCredit(),", ")
								if string.len(output) >= 50 then output = "Various" break end
							end
						end
					end
				else
					self:playcommand("SelectMenuClosedMessage")
				end

				if output ~= "" then output = "Stepartist: " .. output else output = "Stepartist: Unknown" end

				if string.find(output, "C. Foy") or string.find(output, "Foy") then
					self:diffuseshift():effectclock("beat"):effectcolor1(color("1,0.9,0.9,1")):effectcolor2(color("1,0.75,0.75,1"))
				else
					self:stopeffect()
				end

				self:settext(output)
			end
		}
	},
	Def.ActorFrame{
		Condition=not isEtterna("0.55"),
		Name="StepArtistP2",
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM-109*WideScreenDiff()):addx(SCREEN_WIDTH):player(PLAYER_2):draworder(-2) end,
		OnCommand=function(self) self:decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
		ShowCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-127*WideScreenDiff()) end,
		HideCommand=function(self) self:stoptweening():decelerate(0.3):y(SCREEN_BOTTOM-109*WideScreenDiff()) end,
		SelectMenuOpenedMessageCommand=function(self,param)
			if param.Player == PLAYER_2 then
				self:playcommand((courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()) and "Show" or "Hide")
			end
		end,
		SelectMenuClosedMessageCommand=function(self) self:playcommand("Hide") end,
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_artist "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:horizalign(left):zoomx(-0.5*WideScreenDiff()):zoomy(0.5*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_v 26px bold white",
			InitCommand=function(self) self:maxwidth(350):horizalign(right):x(-20*WideScreenDiff()):y(2*WideScreenDiff()):shadowlength(0.5):zoom(0.5*WideScreenDiff()) end,
			CurrentSongChangedMessageCommand=function(self) if not courseMode then if not GAMESTATE:GetCurrentSong() then self:playcommand("SelectMenuClosedMessage") end end end,
			CurrentCourseChangedMessageCommand=function(self) if courseMode then if not GAMESTATE:GetCurrentCourse() then self:playcommand("SelectMenuClosedMessage") end end end,
			CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Update") end end,
			CurrentTrailP2ChangedMessageCommand=function(self) if courseMode then self:playcommand("Update") end end,
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local output = ""
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps ~= nil then output = steps:GetAuthorCredit() end
				elseif courseMode then
					local trail = GAMESTATE:GetCurrentTrail(PLAYER_2)
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							if not string.find(output,entries[i]:GetSteps():GetAuthorCredit()) then
								output = addToOutput(output,entries[i]:GetSteps():GetAuthorCredit(),", ")
								if string.len(output) >= 50 then output = "Various" break end
							end
						end
					end
				else
					self:playcommand("SelectMenuClosedMessage")
				end

				if output ~= "" then output = "Stepartist: " .. output else output = "Stepartist: Unknown" end

				if string.find(output, "C. Foy") or string.find(output, "Foy") then
					self:diffuseshift():effectclock("beat"):effectcolor1(color("1,0.9,0.9,1")):effectcolor2(color("1,0.75,0.75,1"))
				else
					self:stopeffect()
				end

				self:settext(output)
			end
		}
	},
	Def.ActorFrame{
		Name="Pane",
		InitCommand=function(self) self:draworder(-1) end,
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_ldifficulty "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+12*WideScreenDiff()):y(SCREEN_BOTTOM-8*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):player(PLAYER_1) end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):sleep(0.5):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_ldifficulty "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-12*WideScreenDiff()):y(SCREEN_BOTTOM-8*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(right):vertalign(bottom):player(PLAYER_2) end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):sleep(0.5):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_lbase "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+26*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom) end,
			CurrentStepsP2ChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			CurrentSongChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			RecolorCommand=function(self)
				if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then 
					local step = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if step then self:diffuse(CustomDifficultyToColor(ToEnumShortString(step:GetDifficulty()))) else self:diffuse(color("White")) end
				end
			end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_basewidth "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X-174*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end,
			CurrentStepsP2ChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			CurrentSongChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			RecolorCommand=function(self)
				if GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 then 
					local step = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if step then self:diffuse(CustomDifficultyToColor(ToEnumShortString(step:GetDifficulty()))) else self:diffuse(color("White")) end
				end
			end,
			OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_lbase "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+174*WideScreenDiff()):y(SCREEN_BOTTOM):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(left):vertalign(bottom) end,
			CurrentStepsP1ChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			CurrentStepsChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			CurrentSongChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			RecolorCommand=function(self)
				if GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 then
					local song = GAMESTATE:GetCurrentSong()
					if song then
						local step = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if step then self:diffuse(CustomDifficultyToColor(ToEnumShortString(step:GetDifficulty()))) else self:diffuse(color("White")) end
					else
						self:diffuse(color("White"))
					end
				end
			end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("_pane","elements/_basewidth "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+174*WideScreenDiff()):y(SCREEN_BOTTOM):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2) end,
			CurrentStepsP1ChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			CurrentStepsChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			CurrentSongChangedMessageCommand=function(self) if IsNetSMOnline() then self:queuecommand("Recolor") end end,
			RecolorCommand=function(self)
				if GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 then
					local song = GAMESTATE:GetCurrentSong()
					if song then
						local step = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if step then self:diffuse(CustomDifficultyToColor(ToEnumShortString(step:GetDifficulty()))) else self:diffuse(color("White")) end
					else
						self:diffuse(color("White"))
					end
				end
			end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
		},
		Online
	},
	Def.ActorFrame{
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				local spmp = VersionDateCheck(20150300) and song:GetPreviewMusicPath() or GetPreviewMusicPath(song)
				local effectclock = spmp ~= "" and "beat" or "timerglobal"
				self:RunCommandsRecursively( function(self) self:effectclock(effectclock) end )
			else
				self:RunCommandsRecursively( function(self) self:effectclock("beat") end )
			end
		end,
		Def.ActorFrame{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1) and not isDouble(),
			Name="LightP1",
			Def.Sprite {
				Texture = THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"),
				InitCommand=function(self) self:x(SCREEN_CENTER_X-90*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"),
				InitCommand=function(self) self:x(SCREEN_CENTER_X-146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
			}
		},
		Def.ActorFrame{
			Condition=not isEtterna("0.55") and GAMESTATE:IsPlayerEnabled(PLAYER_2) and not isDouble(),
			Name="LightP2",
			Def.Sprite {
				Texture = THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"),
				InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(left):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"),
				InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
				OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
				OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
			}
		},
		Def.ActorFrame{
			Condition=isDouble(),
			Name="LightDouble",
			Def.ActorFrame{
				Name="LeftSide",
				Def.Sprite {
					Texture = THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"),
					InitCommand=function(self) self:x(SCREEN_CENTER_X-90*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
					OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
					OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
				},
				Def.Sprite {
					Texture = THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"),
					InitCommand=function(self) self:x(SCREEN_CENTER_X-146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
					OnCommand=function(self) self:addx(-SCREEN_WIDTH):decelerate(0.75):addx(SCREEN_WIDTH) end,
					OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(-SCREEN_WIDTH) end
				}
			},
			Def.ActorFrame{
				Name="RightSide",
				Def.Sprite {
					Texture = THEME:GetPathG("_pane elements/_lneon",isFinal() and "final" or "normal"),
					InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()):horizalign(left):vertalign(bottom):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
					OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
					OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
				},
				Def.Sprite {
					Texture = THEME:GetPathG("_pane elements/_neonwidth",isFinal() and "final" or "normal"),
					InitCommand=function(self) self:x(SCREEN_CENTER_X+146*WideScreenDiff()):y(SCREEN_BOTTOM-76*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH/2):diffuseshift():effectcolor1(color("#bed0ff")):effectcolor2(color("#767676")):effectoffset(0):effectclock("beat") end,
					OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
					OffCommand=function(self) self:sleep(0.5):accelerate(0.75):addx(SCREEN_WIDTH) end
				}
			}
		}
	},
	Def.ActorFrame{
		Name="PaneDisplayArea",
		InitCommand=function(self) self:y(SCREEN_BOTTOM-184*WideScreenDiff()):zoom(WideScreenDiff()) end,
		Def.ActorFrame{
			Name="PaneDisplayP1",
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
			InitCommand=function(self) self:x(SCREEN_LEFT+SCREEN_WIDTH/5.415/WideScreenDiff()):player(PLAYER_1) end,
			loadfile(THEME:GetPathG("_pane","icons"))(PLAYER_1),
			loadfile(THEME:GetPathG("_pane","fill"))(PLAYER_1),
			loadfile(THEME:GetPathG("_pane","steps"))(PLAYER_1),
			loadfile(THEME:GetPathG("_pane","numbers"))(PLAYER_1)..{ InitCommand=function(self) self:y(129) end },
			loadfile(THEME:GetPathG("_pane","avatar"))(PLAYER_1),
			loadfile(THEME:GetPathG("_player","scores"))(PLAYER_1),
			loadfile(THEME:GetPathG("_player","steps"))(PLAYER_1)
		},
		Def.ActorFrame{
			Name="PaneDisplayP2",
			Condition=not isEtterna("0.55") and GAMESTATE:IsHumanPlayer(PLAYER_2),
			InitCommand=function(self) self:x(SCREEN_RIGHT/WideScreenDiff()-SCREEN_WIDTH/5.415/WideScreenDiff()):player(PLAYER_2) end,
			loadfile(THEME:GetPathG("_pane","icons"))(PLAYER_2),
			loadfile(THEME:GetPathG("_pane","fill"))(PLAYER_2),
			loadfile(THEME:GetPathG("_pane","steps"))(PLAYER_2),
			loadfile(THEME:GetPathG("_pane","numbers"))(PLAYER_2)..{ InitCommand=function(self) self:y(129) end },
			loadfile(THEME:GetPathG("_pane","avatar"))(PLAYER_2),
			loadfile(THEME:GetPathG("_player","scores"))(PLAYER_2),
			loadfile(THEME:GetPathG("_player","steps"))(PLAYER_2)
		}
	},
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))()..{ InitCommand=function(self) self:ztest(true) end },
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))(),
	t,

	Def.ActorFrame{
		Name="SelButtonMenu",
		InitCommand=function(self) self:y(isFinal() and SCREEN_BOTTOM-54*WideScreenDiff() or SCREEN_BOTTOM-51*WideScreenDiff()):visible(DifficultyChangingAvailable()) end,
		HelpDisplay,
		Def.ActorFrame{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-100*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="&MENULEFT;",
				OnCommand=function(self) self:addy(36*WideScreenDiff()):x(-5*WideScreenDiff()):horizalign(right):zoomx(0.5*WideScreenDiff()):zoomy(0.7*WideScreenDiff()):diffusealpha(0):shadowlength(0) end,
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7*WideScreenDiff()) end,
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5*WideScreenDiff()) end
			},
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="Easier",
				OnCommand=function(self) self:addy(36*WideScreenDiff()):x(0):horizalign(left):zoomx(0.5*WideScreenDiff()):zoomy(0.7*WideScreenDiff()):diffusealpha(0):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock('beat'):effectcolor1(color("#FFFFFF")):effectcolor2(color("#20D020")):shadowlength(0) end,
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7*WideScreenDiff()) end,
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5*WideScreenDiff()) end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+100*WideScreenDiff()) end,
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="Harder",
				OnCommand=function(self) self:addy(36*WideScreenDiff()):x(0):horizalign(right):zoomx(0.5*WideScreenDiff()):zoomy(0.7*WideScreenDiff()):diffusealpha(0):diffuseramp():effectperiod(1):effectoffset(0.20):effectclock('beat'):effectcolor1(color("#FFFFFF")):effectcolor2(color("#E06060")):shadowlength(0) end,
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7*WideScreenDiff()) end,
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5*WideScreenDiff()) end
			},
			Def.BitmapText {
				File = "_v 26px bold black",
				Text="&MENURIGHT;",
				OnCommand=function(self) self:addy(36*WideScreenDiff()):x(15*WideScreenDiff()):zoomx(0.5*WideScreenDiff()):zoomy(0.7*WideScreenDiff()):diffusealpha(0):shadowlength(0) end,
				OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
				SelectMenuOpenedMessageCommand=function(self) self:stoptweening():bounceend(0.2):diffusealpha(1):zoomx(0.7*WideScreenDiff()) end,
				SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.5*WideScreenDiff()) end
			}
		}
	},
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenSelectMusic","OptionsMessage"),
		InitCommand=function(self) self:Center():pause():diffusealpha(0) end,
		ShowPressStartForOptionsCommand=function(self) self:zoom(1.15*WideScreenDiff()):diffusealpha(0):decelerate(0.07):zoom(WideScreenDiff()):diffusealpha(1) end,
		ShowEnteringOptionsCommand=function(self) self:stoptweening():zoomy(0):setstate(1):accelerate(0.07):zoomy(WideScreenDiff()) end,
		HidePressStartForOptionsCommandCommand=function(self) self:stoptweening():linear(0.3):cropleft(1.3) end
	},
	Def.ActorFrame{
		Name="OptionsListBaseP1",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220*WideScreenDiff()):y(SCREEN_CENTER_Y+22*WideScreenDiff()):zoomy(WideScreenDiff()):zoomx(isFinal() and 1.1*WideScreenDiff() or 1*WideScreenDiff()) end,
		Def.Sprite {
			Texture = THEME:GetPathG("options pane",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:diffusealpha(0):zoomx(0.6) end,
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then self:stoptweening():linear(0.2):diffusealpha(1):zoomx(1) end
			end,
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.6) end
			end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("options pane",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0) end,
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then self:stoptweening():diffusealpha(0) end
			end,
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then self:stoptweening():diffusealpha(0) end
			end,
			OptionsListResetMessageCommand=function(self,params)
				if params.Player == PLAYER_1 then self:stoptweening():diffusealpha(1):linear(0.2):diffusealpha(0) end
			end
		}
	},
	Def.ActorFrame{
		Name="OptionsListBaseP2",
		Condition=not isEtterna("0.55"),
		InitCommand=function(self) self:x(SCREEN_CENTER_X+220*WideScreenDiff()):y(SCREEN_CENTER_Y+22*WideScreenDiff()):zoomy(WideScreenDiff()):zoomx(isFinal() and 1.1*WideScreenDiff() or 1*WideScreenDiff()) end,
		Def.Sprite {
			Texture = THEME:GetPathG("options pane",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:zoomx(-1):diffusealpha(0):zoomx(0.6) end,
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then self:stoptweening():linear(0.2):diffusealpha(1):zoomx(1) end
			end,
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then self:stoptweening():linear(0.2):diffusealpha(0):zoomx(0.6) end
			end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("options pane",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:zoomx(-1):blend(Blend.Add):diffusealpha(0) end,
			OptionsListOpenedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then self:stoptweening():diffusealpha(0) end
			end,
			OptionsListClosedMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then self:stoptweening():diffusealpha(0) end
			end,
			OptionsListResetMessageCommand=function(self,params)
				if params.Player == PLAYER_2 then self:stoptweening():diffusealpha(1):linear(0.2):diffusealpha(0) end
			end
		}
	},
	loadfile(THEME:GetPathB("","_coins"))(),
	Def.ActorFrame{
		Condition=ThemePrefs.Get("ShowTime"),
		Def.ActorFrame{
			Name="Session",
			InitCommand=function(self) self:x(isFinal() and SCREEN_CENTER_X-175*WideScreenDiff() or 150*WideScreenDiff()+(SCREEN_WIDTH-450*WideScreenDiff())/2):y(SCREEN_TOP+(isFinal() and 40 or 51)*WideScreenDiff()) end,
			OnCommand=function(self) self:addy(-100):decelerate(0.8):addy(100) end,
			OffCommand=function(self) self:accelerate(0.5):addy(-100) end,
			Def.BitmapText {
				File = "_v 26px bold black",
				InitCommand=function(self) self:zoom(0.5*WideScreenDiff()):playcommand("Set"):halign(isFinal() and 1 or 0.5) end,
				SetCommand=function(self)
					local time = GetTimeSinceStart() - getenv("SessionStart")
					self:settext( string.format('Session Time: %02i:%02i', math.floor(time/60), math.floor(time%60))):sleep(1/6):queuecommand("Set")
				end
			}
		},
		Def.ActorFrame{
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
			Name="TimePlayerP1",
			InitCommand=function(self)
				local adjust = WideScaleFixed(95*WideScreenDiff(),130*WideScreenDiff())
				self:x(SCREEN_CENTER_X-adjust):y(SCREEN_BOTTOM-11*WideScreenDiff())
			end,
			OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.5):addy(100) end,
			Def.BitmapText {
				File = "_v 26px bold black",
				OnCommand=function(self)
					local time = getenv("TimePlayedP1")
					self:settext( string.format('Time Played\n%02i:%02i', math.floor(time/60), math.floor(time%60))):zoom(0.5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):shadowlength(0):halign(1):valign(1):vertspacing(-8)
				end
			}
		},
		Def.ActorFrame{
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
			Name="TimePlayerP2",
			InitCommand=function(self)
				local adjust = WideScaleFixed(95*WideScreenDiff(),130*WideScreenDiff())
				self:x(SCREEN_CENTER_X+adjust):y(SCREEN_BOTTOM-11*WideScreenDiff())
			end,
			OnCommand=function(self) self:addy(100):decelerate(0.6):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.5):addy(100) end,
			Def.BitmapText {
				File = "_v 26px bold black",
				OnCommand=function(self)
					local time = getenv("TimePlayedP2")
					self:settext( string.format('Time Played\n%02i:%02i', math.floor(time/60), math.floor(time%60))):zoom(0.5*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2)):shadowlength(0):halign(0):valign(1):vertspacing(-8)
				end
			}
		}
	}
}