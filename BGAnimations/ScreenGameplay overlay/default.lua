local MOD = {}
local CURRENT = {}
local PREVIOUS = {}
local enableOffsets = ThemePrefs.Get("ShowOffset")
local modify = ThemePrefs.Get("ShowGameplaySpeed")
local c

local function setX(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):XMod(value/100)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):XMod(value/100)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):XMod(value/100)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):XMod(value/100)
end
local function setC(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):CMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):CMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):CMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):CMod(value)
end
local function setM(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):MMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):MMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):MMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):MMod(value)
end
local function setA(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):AMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):AMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):AMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):AMod(value)
end
local function setAV(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):AVMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):AVMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):AVMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):AVMod(value)
end
local function setCA(value,player)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):CAMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Stage"):CAMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):CAMod(value)
	GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Current"):CAMod(value)
end

local judgments,offsetdata = {},{}
if enableOffsets then
	for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
		judgments[player] = {}
		offsetdata[player] = {}
		for i=1,GAMESTATE:GetCurrentStyle(player):ColumnsPerPlayer() do
			judgments[player][i] = { ProW1=0, ProW2=0, ProW3=0, ProW4=0, ProW5=0, W1=0, W2=0, W3=0, W4=0, W5=0, Miss=0 }
		end
	end
end

local t = Def.ActorFrame{
	OnCommand=function(self)
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred")
			if playeroptions:MMod() then MOD[pn] = "m" CURRENT[pn] = playeroptions:MMod() break end
			if isOutFox() then if playeroptions:AMod() then MOD[pn] = "a" CURRENT[pn] = playeroptions:AMod() break end end
			if isOutFox() then if playeroptions:CAMod() then MOD[pn] = "ca" CURRENT[pn] = playeroptions:CAMod() break end end
			if isOutFox() then if playeroptions:AVMod() then MOD[pn] = "av" CURRENT[pn] = playeroptions:AVMod() break end end
			if playeroptions:XMod() then MOD[pn] = "x" CURRENT[pn] = playeroptions:XMod()*100 end
			if playeroptions:CMod() then MOD[pn] = "c" CURRENT[pn] = playeroptions:CMod() end
		end
	end,
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
			OnCommand=function(self) self:settext(CURRENT[PLAYER_1] and "SPEED: " .. (CURRENT[PLAYER_1] / (MOD[PLAYER_1] == "x" and 100 or 1))..MOD[PLAYER_1] or "") if GetSongFrame() == "_piupro" then self:addy(33*WideScreenDiff()) end end,
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
			OnCommand=function(self) self:settext(CURRENT[PLAYER_2] and "SPEED: " .. (CURRENT[PLAYER_2] / (MOD[PLAYER_2] == "x" and 100 or 1))..MOD[PLAYER_2] or "") if GetSongFrame() == "_piupro" then self:addy(33*WideScreenDiff()) end end,
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
	loadfile(THEME:GetPathB("ScreenGameplay","overlay/"..GetSongFrame()))(),
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
		InitCommand=function(self) self:visible(not GAMESTATE:IsDemonstration() and not GAMESTATE:IsCourseMode()) end,
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
				InitCommand=function(self) self:x(SCREEN_LEFT+100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(0):zoom(0.6*WideScreenDiff()) end,
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
				InitCommand=function(self) self:x(SCREEN_LEFT+44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(0):zoom(0.8*WideScreenDiff()) end,
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
				InitCommand=function(self) self:x(SCREEN_RIGHT-100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(1):zoom(0.6*WideScreenDiff()) end,
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
				InitCommand=function(self) self:x(SCREEN_RIGHT-44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):shadowlength(2*WideScreenDiff()):halign(1):zoom(0.8*WideScreenDiff()) end,
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
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+127*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*7/WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(1) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayFullTitle() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end
	},
	Def.BitmapText {
		File = "_r bold 30px",
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+147*WideScreenDiff()):maxwidth(SCREEN_WIDTH/8*6.8/WideScreenDiff()):shadowlength(2*WideScreenDiff()):zoom(0.4*WideScreenDiff()):diffusealpha(1) end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local text = ""
			if song then text = song:GetDisplayArtist() end
			self:settext(text)
		end,
		OnCommand=function(self) self:playcommand("Set"):sleep(1.5):linear(1):diffusealpha(0) end
	},
	Def.ActorFrame{
		Name="DemonstrationFrame",
		BeginCommand=function(self) self:visible(GAMESTATE:IsDemonstration() and not isTopScreen('ScreenJukebox')) end,
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
	loadfile(THEME:GetPathB("","_coins"))()..{ InitCommand=function(self) self:visible(not GAMESTATE:IsDemonstration()) end },
	JudgmentMessageCommand=function(self, params)
		if params.Player == params.Player and not string.find(params.TapNoteScore,"Checkpoint") and not string.find(params.TapNoteScore,"None") and params.TapNoteScore ~= "TapNoteScore_" and enableOffsets then
			local player = params.Player
			if params.Notes then
				for i,col in pairs(params.Notes) do
					local tns = ToEnumShortString(params.TapNoteScore)
					if tns and tns ~= "" then judgments[player][i][tns] = judgments[player][i][tns] + 1 end
				end
				if params.TapNoteOffset then
					local vStats = STATSMAN:GetCurStageStats():GetPlayerStageStats( player )
					local time = GAMESTATE:IsCourseMode() and vStats:GetAliveSeconds() or GAMESTATE:GetCurMusicSeconds()
					local noff = params.TapNoteScore == "TapNoteScore_Miss" and "Miss" or params.TapNoteOffset
					offsetdata[player][#offsetdata[player]+1] = { time, noff, params.TapNoteScore }
				end
			end
		end
	end,
	OffCommand=function(self)
		if enableOffsets then
			setenv( "perColJudgeData", judgments )
			setenv( "OffsetTable", offsetdata )
		end
	end,
}

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/DeltaSeconds"))(pn)..{ Condition=isOni() and not isLifeline(pn) or isSurvival(pn) }
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/FCSplash"))(pn)
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/Score"))(pn)..{ Condition=isRegular() or isNonstop() or isLifeline(pn) }
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/Dynamic"))(pn)
end

return t