local curStage = isEtterna() and "Stage_Event" or GAMESTATE:GetCurrentStage()
local stageNum = curStage:gsub("%D+", "")
local songsPerPlay = isEtterna() and 0 or PREFSMAN:GetPreference("SongsPerPlay")
if stageNum == songsPerPlay then curStage = 'Stage_Final' end
if curStage == "Stage_Final" then stageNum = songsPerPlay end
if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' else
	if not GAMESTATE:IsCourseMode() and not isEtterna() and ThemePrefs.Get("TrueRounds") then
		local before = GetTotalStageCost()
		local current = GetCurrentTrueStageCost()
		local total = before+current
		if total == songsPerPlay then
			curStage = 'Stage_Final'
		elseif before+1 ~= stageNum then
			local add = {
				[1] = "st",
				[2] = "nd",
				[3] = "rd"
			}
			curStage = "Stage_"..(before+1)..(add[(before+1)] and add[(before+1)] or "th")
		end
	end
end
if IsNetSMOnline() then curStage = 'Stage_Online' end

if not isEtterna() and (isOni() or GAMESTATE:IsAnExtraStage()) then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		local noteskin = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):NoteSkin()
		GAMESTATE:ApplyGameCommand('mod,'..noteskin,pn)
	end
end

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	if getenv("Flare"..pname(pn)) and getenv("Flare"..pname(pn)) > 0 then
		if isSurvival(pn) then GAMESTATE:ApplyGameCommand('mod,no lifetime,bar,normal-drain',pn) end
		if isMGD(pn) then GAMESTATE:ApplyGameCommand('mod,no battery,bar,normal-drain',pn) end
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):FailSetting('FailType_Immediate')
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Stage'):FailSetting('FailType_Immediate')
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song'):FailSetting('FailType_Immediate')
		GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Current'):FailSetting('FailType_Immediate')
	end

	if getenv("ShowMods"..pname(pn)) then
		if not GAMESTATE:IsCourseMode() and not isVS() then
			if not HasLuaCheck() then
				setenv("ShowMods"..pname(pn),false)
			end
		end
	end

	setenv("EvalCombo"..pname(pn),true)
	setenv("LastFantastic"..pname(pn),0)
	setenv("LastPerfect"..pname(pn),0)
	setenv("LastGreat"..pname(pn),0)
	setenv("FlareDisplay"..pname(pn),nil)
	setenv("W0"..pname(pn),0)
	setenv("W1"..pname(pn),0)
	setenv("WX"..pname(pn),0)

	if isOpenDDR() then
		setenv("FlareType"..pname(pn),1)
		local po = GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Song')
		local drain = po:DrainSetting()
		if string.find(drain, "Flare") then
			if string.find(drain, "Float") then
				setenv("Flare"..pname(pn),11)
			elseif string.find(drain, "EX") then
				setenv("Flare"..pname(pn),10)
			else
				setenv("Flare"..pname(pn),tonumber(drain:sub(-1)))
			end
		end
	end
end

local showBar = {
	["be-mu"] = true,
	["gddm"] = true,
	["gdgf"] = true,
	["kbx"] = true,
	["po-mu"] = true
}

return Def.ActorFrame{
	InitCommand=function()
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			if isMGD(pn) then
				local lives = GetLives(pn)
				if GAMESTATE:IsCourseMode() then
					if not isOni() then
						if isOutFoxV() then
							GAMESTATE:ApplyGameCommand('mod,'..lives.." lives",pn)
						else
							GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):BatteryLives(lives)
						end
					end
				else
					if isOutFoxV() then
						GAMESTATE:ApplyGameCommand('mod,'..lives.." lives",pn)
					else
						GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Preferred'):BatteryLives(lives)
					end
				end
			end
		end
	end,
	Def.Quad{
		OnCommand=function(self) self:FullScreen():diffusecolor(Color.Black) end
	},
	loadfile(THEME:GetPathB("ScreenStageInformation","in/top"))(),
	loadfile(THEME:GetPathB("ScreenStageInformation","in/bottom"))(),
	Def.Sprite {
		Texture = "highlight",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+5*WideScreenDiff()):y(SCREEN_CENTER_Y+60*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):decelerate(0.2):diffusealpha(1) end
	},
	Def.ActorFrame{
		Name="P1Frame",
		InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1)) end,
		Def.Sprite {
			Texture = "_left gradient",
			InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):halign(0) end
		},
		Def.Sprite {
			Texture = "_p1",
			InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):halign(0) end
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Text="Step Artist:",
			InitCommand=function(self) self:x(SCREEN_LEFT+5*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):zoom(0.6*WideScreenDiff()):halign(0):shadowlength(2) end,
			BeginCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_1) and isRegular() or isVS()) end
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Name="AuthorText",
			InitCommand=function(self) self:x(SCREEN_LEFT+100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2):halign(0):zoom(0.6*WideScreenDiff()) end,
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local text = ""
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_1)
					if steps then text = steps:GetAuthorCredit() end
				end
				if text == "" then text = "Unknown" end
				self:settext(text)
			end,
			OnCommand=function(self) self:playcommand("Set") end
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Name="PlayerName",
			InitCommand=function(self) self:x(SCREEN_LEFT+44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2):halign(0):zoom(0.8*WideScreenDiff()) end,
			SetCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_1) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_1))
				elseif isVS() then
					self:settext("CPU")
				end
			end,
			OnCommand=function(self) self:playcommand("Set") end
		}
	},
	Def.ActorFrame{
		Condition=not isEtterna(),
		Name="P2Frame",
		InitCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2)) end,
		Def.Sprite {
			Texture = "_right gradient",
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):halign(1) end
		},
		Def.Sprite {
			Texture = "_p2",
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+130*WideScreenDiff()):zoom(WideScreenDiff()):halign(1) end
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Text=":Step Artist",
			InitCommand=function(self) self:x(SCREEN_RIGHT-5*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):zoom(0.6*WideScreenDiff()):halign(1):shadowlength(2) end,
			BeginCommand=function(self) self:visible(GAMESTATE:IsPlayerEnabled(PLAYER_2) and isRegular() or isVS()) end
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Name="AuthorText",
			InitCommand=function(self) self:x(SCREEN_RIGHT-100*WideScreenDiff()):y(SCREEN_CENTER_Y+152*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2):halign(1):zoom(0.6*WideScreenDiff()) end,
			SetCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local text = ""
				if song then
					local steps = GAMESTATE:GetCurrentSteps(PLAYER_2)
					if steps then text = steps:GetAuthorCredit() end
				end
				if text == "" then text = "Unknown" end
				self:settext(text)
			end,
			OnCommand=function(self) self:playcommand("Set") end
		},
		Def.BitmapText {
			File = "_r bold 30px",
			Name="PlayerName",
			InitCommand=function(self) self:x(SCREEN_RIGHT-44*WideScreenDiff()):y(SCREEN_CENTER_Y+122*WideScreenDiff()):maxwidth(SCREEN_WIDTH/4.25/WideScreenDiff()):shadowlength(2):halign(1):zoom(0.8*WideScreenDiff()) end,
			SetCommand=function(self)
				if GAMESTATE:IsHumanPlayer(PLAYER_2) then
					self:settext(GetDisplayNameFromProfileOrMemoryCard(PLAYER_2))
				elseif isVS() then
					self:settext("CPU")
				end
			end,
			OnCommand=function(self) self:playcommand("Set") end
		}
	},
	Def.ActorFrame{
		Name="StageText",
		Condition=isEtterna() or not GAMESTATE:IsCourseMode() and not (GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/Training1/')),
		InitCommand=function(self) self:CenterX() end,
		Def.ActorFrame{
			Name="Main",
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+60*WideScreenDiff()):zoom(WideScreenDiff()) end,
			Def.Sprite {
				Texture = THEME:GetPathG("_gameplay","stage "..ToEnumShortString(curStage)),
				InitCommand=function(self) self:cropright(1.3) end,
				OnCommand=function(self) self:sleep(0.22):linear(1):cropright(-0.3) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("_white","gameplay stage "..ToEnumShortString(curStage)),
				InitCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				OnCommand=function(self) self:sleep(0.22):linear(1):cropleft(1):cropright(-0.3) end
			}
		},
		Def.ActorFrame{
			Name="Reflect",
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+86*WideScreenDiff()) end,
			Def.Sprite {
				Texture = THEME:GetPathG("_gameplay","stage "..ToEnumShortString(curStage)),
				InitCommand=function(self) self:rotationz(180):zoomx(-1*WideScreenDiff()):diffusealpha(0.6):fadetop(2):cropright(1.3) end,
				OnCommand=function(self) self:linear(1.225):cropright(-0.3) end
			}
		}
	},
	Def.ActorFrame{
		Name="Tutorial",
		InitCommand=function(self) self:CenterX() end,
		Condition=not isEtterna() and not GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/Training1/'),
		Def.BitmapText {
			File = "_big blue glow",
			Text="Welcome to the::tutorial program",
			OnCommand=function(self) self:y(SCREEN_CENTER_Y-112):diffusealpha(0):zoom(4*WideScreenDiff()):sleep(0.0):linear(0.3):diffusealpha(1):zoom(WideScreenDiff()) end
		}
	},
	Def.ActorFrame{
		Name="CourseText",
		Condition=GAMESTATE:IsCourseMode(),
		InitCommand=function(self) self:CenterX() end,
		Def.ActorFrame{
			Name="Main",
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+60*WideScreenDiff()):zoom(WideScreenDiff()) end,
			Def.Sprite {
				Texture = THEME:GetPathG("_gameplay","course song 1"),
				InitCommand=function(self) self:cropright(1.3) end,
				OnCommand=function(self) self:sleep(0.07):linear(1):cropright(-0.3) end
			},
			Def.Sprite {
				Texture = THEME:GetPathG("_white","gameplay course song 1"),
				InitCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				OnCommand=function(self) self:sleep(0.07):linear(1):cropleft(1):cropright(-0.3) end
			}
		},
		Def.ActorFrame{
			Name="Reflect",
			InitCommand=function(self) self:y(SCREEN_CENTER_Y+86) end,
			Def.Sprite {
				Texture = THEME:GetPathG("_gameplay","course song 1"),
				InitCommand=function(self) self:rotationz(180):zoomx(-1*WideScreenDiff()):diffusealpha(0.6):fadetop(2):cropright(1.3) end,
				OnCommand=function(self) self:linear(1.225):cropright(-0.3) end
			}
		}
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","blueflare"),
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+12.5):blend(Blend.Add):draworder(115) end,
		OnCommand=function(self) self:zoomx(15*WideScreenDiff()):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4/WideScreenDiff()):linear(1):zoomtoheight(0):diffusealpha(0.0) end
	},
	Def.Sprite {
		Texture = "shot",
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end,
		OnCommand=function(self) self:CenterY():zoomx(-2*WideScreenDiff()):zoomy(4*WideScreenDiff()):diffusealpha(1):CenterX():linear(0.9):diffusealpha(0):zoomy(0):x(SCREEN_CENTER_X-250*WideScreenDiff()) end
	},
	Def.Sprite {
		Texture = "shot",
		InitCommand=function(self) self:diffusealpha(0):blend(Blend.Add) end,
		OnCommand=function(self) self:CenterY():zoomx(2*WideScreenDiff()):zoomy(4*WideScreenDiff()):diffusealpha(1):CenterX():linear(0.9):diffusealpha(0):zoomy(0):x(SCREEN_CENTER_X+250*WideScreenDiff()) end
	},
	Def.ActorFrame{
		Condition=showBar[GAMESTATE:GetCurrentGame():GetName()],
		Def.Quad{
			InitCommand=function(self) self:stretchto(0,SCREEN_CENTER_Y+104*WideScreenDiff(),SCREEN_WIDTH,SCREEN_CENTER_Y+168*WideScreenDiff()):diffusecolor(Color.White):blend(Blend.Add) end,
			OnCommand=function(self) self:cropright(1):faderight(0.8):fadeleft(0.8) end,
			LoadingKeysoundMessageCommand=function(self,params)
				if params.File ~= "" then self:cropright(1-params.Percent/100) end
			end
		},
		Def.BitmapText {
			File = "_z bold 19px",
			InitCommand=function(self)  self:CenterX():y(SCREEN_CENTER_Y+192*WideScreenDiff()):vertspacing(-13*WideScreenDiff()):valign(1):zoom(0.5*WideScreenDiff()):maxwidth(SCREEN_WIDTH*2) end,
			LoadingKeysoundMessageCommand=function(self,params)
				if params.File ~= "" then self:settext(Basename(params.File).."\n"..string.format("%.0f", params.Percent).."%") end
			end
		}
	},
	SOUND:PlayOnce( THEME:GetPathS( '', "_ok" ) )
}