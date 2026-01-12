local MOD = {}
local CURRENT = {}
local PREVIOUS = {}
local enableOffsets = ThemePrefs.Get("ShowOffset")
local modify = ThemePrefs.Get("ShowGameplaySpeed")
local c

local Overlay = #GAMESTATE:GetHumanPlayers() == 2 and Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/Overlay"))(PLAYER_1),
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/Overlay"))(PLAYER_2)
} or loadfile(THEME:GetPathB("ScreenGameplay","overlay/Overlay"))(GAMESTATE:GetMasterPlayerNumber())

local judgments,offsetdata = {},{}
for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
	judgments[player] = {}
	offsetdata[player] = {}
	for i=1,GAMESTATE:GetCurrentStyle(player):ColumnsPerPlayer() do
		judgments[player][i] = { ProW0=0, ProW1=0, ProW2=0, ProW3=0, ProW4=0, ProW5=0, W0=0, W1=0, W2=0, W3=0, W4=0, W5=0, Miss=0 }
	end
end

local timing = GetTimingDifficulty()
local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
local ctrlHeld = false
local keyboardEnabled = ThemePrefs.Get("KeyboardEnabled")

local InputHandler = function(event)
	if keyboardEnabled then
		if event.type == "InputEventType_FirstPress" then
			if string.find(event.DeviceInput.button,"ctrl") and not ctrlHeld then ctrlHeld = true end
			if ctrlHeld then
				if event.DeviceInput.button == "DeviceButton_r" then
					setenv("Restart",getenv("Restart")+1)
					SCREENMAN:GetTopScreen():SetPrevScreenName(Branch.BeforeGameplay()):begin_backing_out()
				elseif event.DeviceInput.button == "DeviceButton_f" then
					if SCREENMAN:GetTopScreen():GetChild("Debug") then SCREENMAN:GetTopScreen():GetChild("Debug"):visible(false) end
					for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
						STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):FailPlayer()
						SCREENMAN:GetTopScreen():GetChild('Player'..pname(pn)):SetLife(0)
					end
				end
			end
		elseif event.type == "InputEventType_Release" then
			if string.find(event.DeviceInput.button,"ctrl") and ctrlHeld then ctrlHeld = false end
		end
	else
		if event.type == "InputEventType_FirstPress" then
			if event.GameButton == "Select" and not ctrlHeld then ctrlHeld = true end
			if ctrlHeld then
				if event.GameButton == "Start" then
					setenv("Restart",getenv("Restart")+1)
					SCREENMAN:GetTopScreen():SetPrevScreenName(Branch.BeforeGameplay()):begin_backing_out()
				elseif event.GameButton == "Back" then
					if SCREENMAN:GetTopScreen():GetChild("Debug") then SCREENMAN:GetTopScreen():GetChild("Debug"):visible(false) end
					for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
						STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):FailPlayer()
						SCREENMAN:GetTopScreen():GetChild('Player'..pname(pn)):SetLife(0)
					end
				end
			end
		elseif event.type == "InputEventType_Release" then
			if event.GameButton == "Select" and ctrlHeld then ctrlHeld = false end
		end
	end
end

local t = Def.ActorFrame{
	OnCommand=function()
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Song")
			if playeroptions:MMod() then MOD[pn] = "m" CURRENT[pn] = playeroptions:MMod() break end
			if isOutFox(20210200) then if playeroptions:AMod() then MOD[pn] = "a" CURRENT[pn] = playeroptions:AMod() break end end
			if isOutFox(20220300) then if playeroptions:CAMod() then MOD[pn] = "ca" CURRENT[pn] = playeroptions:CAMod() break end end
			if isOutFox(20220900) then if playeroptions:AVMod() then MOD[pn] = "av" CURRENT[pn] = playeroptions:AVMod() break end end
			if playeroptions:XMod() then MOD[pn] = "x" CURRENT[pn] = playeroptions:XMod()*100 end
			if playeroptions:CMod() then MOD[pn] = "c" CURRENT[pn] = playeroptions:CMod() end
		end
	end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	CodeMessageCommand = function(self, params)
		if params.Name == 'SpeedUp' or params.Name == 'SpeedDown' then
			if MOD[params.PlayerNumber] == "a" or MOD[params.PlayerNumber] == "ca" or MOD[params.PlayerNumber] == "av" then
				c["MOD"..(params.PlayerNumber == PLAYER_1 and "1" or "2")]:playcommand("Block")
			else
				PREVIOUS[params.PlayerNumber] = CURRENT[params.PlayerNumber]
				if params.Name == 'SpeedUp' then
					CURRENT[params.PlayerNumber] = CURRENT[params.PlayerNumber] + 25
				elseif params.Name == 'SpeedDown' then
					if CURRENT[params.PlayerNumber] > 25 then CURRENT[params.PlayerNumber] = CURRENT[params.PlayerNumber] - 25 end
				end

				if MOD[params.PlayerNumber] == "x" then
					setX(CURRENT[params.PlayerNumber],params.PlayerNumber)
				elseif MOD[params.PlayerNumber] == "c" then
					setC(CURRENT[params.PlayerNumber],params.PlayerNumber)
				elseif MOD[params.PlayerNumber] == "m" then
					setM(CURRENT[params.PlayerNumber],params.PlayerNumber)
				elseif MOD[params.PlayerNumber] == "a" then
					setA(CURRENT[params.PlayerNumber],params.PlayerNumber)
				elseif MOD[params.PlayerNumber] == "ca" then
					setCA(CURRENT[params.PlayerNumber],params.PlayerNumber)
				elseif MOD[params.PlayerNumber] == "av" then
					setAV(CURRENT[params.PlayerNumber],params.PlayerNumber)
				end

				if PREVIOUS[params.PlayerNumber] ~= CURRENT[params.PlayerNumber] then
					c["MOD"..(params.PlayerNumber == PLAYER_1 and "1" or "2")]:playcommand("Change")
				end
			end
		end
	end,
	Def.ActorFrame{
		Condition=not getenv("Workout"),
		InitCommand = function(self) c = self:GetChildren() end,
		OnCommand=function(self) self:addy(-100):sleep(0.5):decelerate(0.8):addy(100) end,
		OffCommand=function(self) if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end end,
		Def.BitmapText {
			File = "_eurostile normal",
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1) and modify,
			Name="MOD1",
			InitCommand=function(self) self:shadowlength(1):zoom(0.4*WideScreenDiff()):x(THEME:GetMetric("ScreenGameplay","ScoreP1X")):y(THEME:GetMetric("ScreenGameplay","ScoreP1Y")-15*WideScreenDiff()) end,
			OnCommand=function(self) self:settext(CURRENT[PLAYER_1] and "SPEED: " .. (CURRENT[PLAYER_1] / (MOD[PLAYER_1] == "x" and 100 or 1))..MOD[PLAYER_1] or "") if IsGame("pump") then self:addy(33*WideScreenDiff()) end end,
			BlockCommand=function(self)
				self:stoptweening():diffuse(color("1,0,0,1")):diffusealpha(1):settext("This MOD can't be changed while GamePlay"):sleep(1):linear(0.25):diffusealpha(0):queuecommand("TrueChange"):diffuse(color("1,1,1,1"))
			end,
			ChangeCommand=function(self)
				local text = "SPEED CHANGE: " .. (PREVIOUS[PLAYER_1] / (MOD[PLAYER_1] == "x" and 100 or 1))..MOD[PLAYER_1] .. " -> " .. (CURRENT[PLAYER_1] / (MOD[PLAYER_1] == "x" and 100 or 1))..MOD[PLAYER_1]
				self:stoptweening():diffusealpha(1):settext(text):sleep(1):linear(0.25):diffusealpha(0):queuecommand("TrueChange")
			end,
			TrueChangeCommand=function(self)
				local text = "SPEED: " .. (CURRENT[PLAYER_1] / (MOD[PLAYER_1] == "x" and 100 or 1))..MOD[PLAYER_1]
				self:diffusealpha(0):settext(text):linear(0.25):diffusealpha(1)
			end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2) and modify,
			Name="MOD2",
			Text=CURRENT[PLAYER_2] or "?",
			InitCommand=function(self) self:shadowlength(1):zoom(0.4*WideScreenDiff()):x(THEME:GetMetric("ScreenGameplay","ScoreP2X")):y(THEME:GetMetric("ScreenGameplay","ScoreP2Y")-15*WideScreenDiff()) end,
			OnCommand=function(self) self:settext(CURRENT[PLAYER_2] and "SPEED: " .. (CURRENT[PLAYER_2] / (MOD[PLAYER_2] == "x" and 100 or 1))..MOD[PLAYER_2] or "") if IsGame("pump") then self:addy(33*WideScreenDiff()) end end,
			BlockCommand=function(self)
				self:stoptweening():diffuse(color("1,0,0,1")):diffusealpha(1):settext("This MOD can't be changed while GamePlay"):sleep(1):linear(0.25):diffusealpha(0):queuecommand("TrueChange"):diffuse(color("1,1,1,1"))
			end,
			ChangeCommand=function(self)
				local text ="SPEED CHANGE: " .. (PREVIOUS[PLAYER_2] / (MOD[PLAYER_2] == "x" and 100 or 1))..MOD[PLAYER_2] .. " -> " .. (CURRENT[PLAYER_2] / (MOD[PLAYER_2] == "x" and 100 or 1))..MOD[PLAYER_2]
				self:stoptweening():diffusealpha(1):settext(text):sleep(1):linear(0.25):diffusealpha(0):queuecommand("TrueChange")
			end,
			TrueChangeCommand=function(self)
				local text = "SPEED: " .. (CURRENT[PLAYER_2] / (MOD[PLAYER_2] == "x" and 100 or 1))..MOD[PLAYER_2]
				self:diffusealpha(0):settext(text):linear(0.25):diffusealpha(1)
			end
		}
	},
	Overlay,
	Def.ActorFrame{
		Condition=GetSongFrame() ~= "_piupro",
		Name="RaveNames",
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+69*WideScreenDiff()):visible(isVS()) end,
		OnCommand=function(self) self:addy(-100):sleep(0.5):decelerate(0.8):addy(100) end,
		OffCommand=function(self) if not IsGame("pump") then if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end end,
		Def.BitmapText {
			File = "_v 26px bold black",
			InitCommand=function(self) self:x(-254*WideScreenDiff()):zoom(0.55*WideScreenDiff()):shadowlength(0):maxwidth(160) end,
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_1) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
				elseif isVS() then
					self:settext("CPU")
				end
			end
		},
		Def.BitmapText {
			File = "_v 26px bold black",
			InitCommand=function(self) self:x(254*WideScreenDiff()):zoom(0.55*WideScreenDiff()):shadowlength(0):maxwidth(160) end,
			BeginCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_2) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
				elseif isVS() then
					self:settext("CPU")
				end
			end
		}
	},
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,1")) end,
		OnCommand=function(self) self:linear(0.3):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="ScreenStageHoldovers",
		InitCommand=function(self) self:visible(isEtterna("0.55") or not GAMESTATE:IsDemonstration() and not GAMESTATE:IsCourseMode()) end,
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenStageInformation","in/bottom/bar"),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+136*WideScreenDiff()):zoomy(WideScreenDiff()):zoomtowidth(SCREEN_WIDTH):faderight(0.8):fadeleft(0.8) end,
			OnCommand=function(self) self:sleep(2.25):cropright(0):linear(0.6):cropleft(1) end
		},
		Def.ActorFrame{
			Name="InfoP1",
			InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end,
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenStageInformation","in/_left gradient"),
				InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenStageInformation","in/_p1"),
				InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(left) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_r bold 30px",
				Text="Step Artist:",
				InitCommand=function(self) self:x(SCREEN_LEFT+5*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):zoom(0.6*WideScreenDiff()):halign(0):shadowlength(2*WideScreenDiff()) end,
				BeginCommand=function(self)
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and isRegular() or isVS())
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_r bold 30px",
				Name="AuthorText",
				InitCommand=function(self) self:x(SCREEN_LEFT+100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(0):zoom(0.6*WideScreenDiff()) end,
				BeginCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local text = ""
					if song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
						if steps then text = steps:GetAuthorCredit() end
					end
					if text == "" then text = "Unknown" end
					self:settext(text)
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_r bold 30px",
				Name="PlayerName",
				InitCommand=function(self) self:x(SCREEN_LEFT+44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(0):zoom(0.8*WideScreenDiff()) end,
				BeginCommand=function(self)
					if GAMESTATE:IsHumanPlayer(PLAYER_1) then
						self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
					elseif isVS() then
						self:settext("CPU")
					end
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			}
		},
		Def.ActorFrame{
			Condition=not isEtterna("0.65"),
			Name="InfoP2",
			InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end,
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenStageInformation","in/_right gradient"),
				InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("ScreenStageInformation","in/_p2"),
				InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):horizalign(right) end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_r bold 30px",
				Text=":Step Artist",
				InitCommand=function(self) self:x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):zoom(0.6*WideScreenDiff()):halign(1):shadowlength(2*WideScreenDiff()) end,
				BeginCommand=function(self)
					self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and isRegular() or isVS())
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_r bold 30px",
				Name="AuthorText",
				InitCommand=function(self) self:x(SCREEN_RIGHT-100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(1):zoom(0.6*WideScreenDiff()) end,
				BeginCommand=function(self)
					local song = GAMESTATE:GetCurrentSong()
					local text = ""
					if song then
						local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
						if steps then text = steps:GetAuthorCredit() end
					end
					if text == "" then text = "Unknown" end
					self:settext(text)
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "_r bold 30px",
				Name="PlayerName",
				InitCommand=function(self) self:x(SCREEN_RIGHT-44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(1):zoom(0.8*WideScreenDiff()) end,
				BeginCommand=function(self)
					if GAMESTATE:IsHumanPlayer(PLAYER_2) then
						self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
					elseif isVS() then
						self:settext("CPU")
					end
				end,
				OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(0) end
			}
		}
	},
	Def.BitmapText {
		File = "_r bold 30px",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+127*WideScreenDiff()):maxwidth(SCREEN_WIDTH/WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(1) end,
		SetCommand=function(self)
			local SongOrSteps = checkBMS() and GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()) or GAMESTATE:GetCurrentSong()
			local text = ""
			if SongOrSteps then text = checkBMS() and GetBMSTitle(SongOrSteps) or SongOrSteps:GetDisplayFullTitle() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_r bold 30px",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+147*WideScreenDiff()):maxwidth(SCREEN_WIDTH/WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoom(0.4*WideScreenDiff()):diffusealpha(1) end,
		SetCommand=function(self)
			local SongOrSteps = checkBMS() and GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()) or GAMESTATE:GetCurrentSong()
			local text = ""
			if SongOrSteps then text = checkBMS() and GetBMSArtist(SongOrSteps) or SongOrSteps:GetDisplayArtist() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="DemonstrationFrame",
		BeginCommand=function(self) self:visible(not isEtterna("0.55") and GAMESTATE:IsDemonstration() and not isTopScreen('ScreenJukebox')) end,
		Def.Sprite {
			Texture = "_metallic streak",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+43*WideScreenDiff()):zoomtowidth(SCREEN_WIDTH) end,
			OnCommand=function(self) self:diffusealpha(0.9):fadeleft(1):faderight(1) end
		},
		Def.BitmapText {
			File = "_z 36px black",
			Text="DEMO",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+43*WideScreenDiff()):zoom(0.7*WideScreenSemiDiff()) end,
			OnCommand=function(self) self:pulse():effectmagnitude(1.0,0.95,0):effectclock('beat'):effectperiod(1) end
		},
		Def.Sprite {
			Texture = "demonstration gradient",
			InitCommand=function(self) self:FullScreen():diffusealpha(0.8) end
		}
	},
	loadfile(THEME:GetPathB("","_coins"))()..{ InitCommand=function(self) self:visible(not isEtterna() and not GAMESTATE:IsDemonstration()) end },
	JudgmentMessageCommand=function(self, params)
		if not string.find(params.TapNoteScore,"Checkpoint") and not string.find(params.TapNoteScore,"None") and params.TapNoteScore ~= "TapNoteScore_" then
			local player = params.Player
			if params.Notes then
				local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
				local W0 = 0.0135*timingChange[timing]*JudgeScale
				local Wadd = (isOpenDDR() or isEtterna("0.72")) and 0.0000 or PREFSMAN:GetPreference("TimingWindowAdd")
				local faplus = getenv("SetScoreFA"..pname(player))
				W0 = W0 + Wadd
				for i,col in pairs(params.Notes) do
					local tns = ToEnumShortString(col:GetTapNoteResult():GetTapNoteScore())
					local tno = col:GetTapNoteResult():GetTapNoteOffset()
					if tns == "W1" and faplus then tns = math.abs(tno) <= W0 and "W0" or "W1" end
					if tns and tns ~= "" and tns ~= "None" and not string.find(tns,"Mine") then
						judgments[player][i][tns] = judgments[player][i][tns] + 1
					end
				end
				if params.TapNoteOffset and enableOffsets then
					local vStats = STATSMAN:GetCurStageStats():GetPlayerStageStats( player )
					local time = GAMESTATE:IsCourseMode() and vStats:GetAliveSeconds() or GAMESTATE:GetCurMusicSeconds()/GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate()
					local noff = params.TapNoteScore == "TapNoteScore_Miss" and "Miss" or params.TapNoteOffset
					local WX = params.TapNoteScore == "TapNoteScore_W1" and (math.abs(params.TapNoteOffset) <= W0 and "TapNoteScore_W0" or "TapNoteScore_W1" ) or params.TapNoteScore

					offsetdata[player][#offsetdata[player]+1] = { time, noff, faplus and WX or params.TapNoteScore }
				end
			end
		end
	end,
	OffCommand=function(self)
		setenv( "perColJudgeData", judgments )
		if enableOffsets then setenv( "OffsetTable", offsetdata ) end
		local fail = false
		if isStepMania() or isEtterna() or (isOutFox() and not isOutFox(20220200)) then
			local failCounter = 0
			for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
				local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local length = TotalPossibleStepSecondsCurrent(pn)
				local cleared = false
				if isEtterna("0.71") then
					cleared = not STATSMAN:GetCurStageStats():Failed() and GAMESTATE:GetCurMusicSeconds()/GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate() > length
				else
					cleared = not PSS:GetFailed() and PSS:GetAliveSeconds() > length
				end
				if not cleared then failCounter = failCounter + 1 end
			end
			if failCounter == GAMESTATE:GetNumPlayersEnabled() then fail = true end
		else
			fail = STATSMAN:GetCurStageStats():GaveUp()
		end
		if fail then
			for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
				STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):FailPlayer()
				SCREENMAN:GetTopScreen():GetChild('Player'..pname(pn)):SetLife(0)
			end
			MESSAGEMAN:Broadcast("ForceFail")
		end
	end
}

if ThemePrefs.Get("ShowGameplaySeconds") then t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/Time"))() end

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	if isOni() and not isLifeline(pn) or isSurvival(pn) then t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/DeltaSeconds"))(pn) end
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/FCSplash"))(pn)
	if isRegular() or isNonstop() or isLifeline(pn) then t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/Score"))(pn) end
	if (isRegular() or isNonstop() or isLifeline(pn)) and getenv("SetScoreFA"..pname(pn)) then t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/FA"))(pn) end
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/Dynamic"))(pn)
	if getenv("Flare"..pname(pn)) and getenv("Flare"..pname(pn)) > 0 and isRegular() then t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/Flare"))(pn) end
	if getenv("SetPacemakerFail"..pname(pn)) and getenv("SetPacemakerFail"..pname(pn)) > 1 and not isVS() then t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/PacemakerFail"))(pn) end
end

return t