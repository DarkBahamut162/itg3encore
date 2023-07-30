local c
local padMax = 234
local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(GAMESTATE:GetMasterPlayerNumber()):GetPlayerOptions(mlevel):Mini()*50) / 100

local style = GAMESTATE:GetCurrentStyle()
local styleType = style:GetStyleType()
local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')

local function width(style)
	if IsGame("be-mu") then
		if style == 1 then
			return 240
		elseif style == 2 then
			return 272
		else
			return 304
		end
	else
		if style == 1 then
			return 96
		elseif style == 2 then
			return 128
		elseif style == 3 then
			return 160
		elseif style == 4 then
			return 224
		else
			return 288
		end
	end
end

local function xS() return SCREEN_WIDTH*0.25+width(GetUserPrefN("StylePosition"))/2*currentMini end
local function zoomS() return (SCREEN_WIDTH-xS())/SCREEN_WIDTH end
local function xM() return SCREEN_CENTER_X+width(GetUserPrefN("StylePosition"))/2*currentMini end
local function zoomM() return (SCREEN_WIDTH-xM())/SCREEN_WIDTH end

return Def.ActorFrame {
	Name="YOU_WISH_YOU_WERE_PLAYING_BEATMANIA_RIGHT_NOW",
	UpdateDiscordInfoCommand=function()
		local player = GAMESTATE:GetMasterPlayerNumber()
		if GAMESTATE:GetCurrentSong() and isOutFox() then
			local lengthFull = string.len(GAMESTATE:GetCurrentSong():GetDisplayFullTitle()) + 3 + string.len(GAMESTATE:GetCurrentSong():GetGroupName())
			local lengthMain = string.len(GAMESTATE:GetCurrentSong():GetDisplayMainTitle()) + 3 + string.len(GAMESTATE:GetCurrentSong():GetGroupName())
			local title = lengthFull < 128 and GAMESTATE:GetCurrentSong():GetDisplayFullTitle() or
						--string.sub(GAMESTATE:GetCurrentSong():GetDisplayFullTitle(),1,122-string.len(GAMESTATE:GetCurrentSong():GetGroupName())) .. "..."
						lengthMain < 128 and GAMESTATE:GetCurrentSong():GetDisplayMainTitle() or string.sub(GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),1,122-string.len(GAMESTATE:GetCurrentSong():GetGroupName())) .. "..."
			local songname = title .. " - " .. GAMESTATE:GetCurrentSong():GetGroupName()
			local state = GAMESTATE:IsDemonstration() and "Watching Song" or "Playing Song"
			GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(player))
			local stats = STATSMAN:GetCurStageStats()
			if not stats then return end
			local courselength = function()
				if GAMESTATE:IsCourseMode() then
					if not isPlayMode("PlayMode_Endless") then
						return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().. " (Song ".. stats:GetPlayerStageStats( player ):GetSongsPassed()+1 .. " of ".. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() ..")" or ""
					end
					return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().. " (Song ".. stats:GetPlayerStageStats( player ):GetSongsPassed()+1 .. ")" or ""
				end
			end
			GAMESTATE:UpdateDiscordSongPlaying(GAMESTATE:IsCourseMode() and courselength() or state,songname,(GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurMusicSeconds())/GAMESTATE:GetSongOptionsObject('ModsLevel_Song'):MusicRate())
		end
	end,
	InitCommand = function(self) c = self:GetChildren() end,
	OnCommand=function(self)
		if not isTopScreen("ScreenDemonstration2") and not isTopScreen("ScreenJukebox") then
			self:playcommand("UpdateDiscordInfo")
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				if GAMESTATE:GetNumPlayersEnabled() == 1 and not doubles and (IsGame("be-mu") or IsGame("po-mu")) then
					if isOutFox() and not tobool(LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()),"HasLua")) or not HasLuaCheck() then
						if getenv("RotationNormal"..pname(pn)) or getenv("RotationUpsideDown"..pname(pn)) then
							SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom(zoomS()):xy(pn == PLAYER_1 and xS() or 0,SCREEN_CENTER_Y-SCREEN_CENTER_Y*zoomS())
						elseif getenv("RotationSolo"..pname(pn)) then
							SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom(zoomM())
							if zoomM() < 1/3 then c.PC2:playcommand("MULTI") end
							c.PC3:playcommand("MULTI")
							c.PC4:playcommand("MULTI")
							if getenv("ShowStats"..pname(pn)) == 0 then
								c.PC6:playcommand("MULTI")
								if zoomM() < 1/3 then c.PC5:playcommand("MULTI") end
							end
						end
					end
				end
				if SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)) and SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField") then
					if getenv("RotationLeft"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):rotationz(270)
						if pn == PLAYER_1 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X-SCREEN_WIDTH/4)
						elseif pn == PLAYER_2 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X-SCREEN_WIDTH/4)
						end
					elseif getenv("RotationRight"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):rotationz(90)
						if pn == PLAYER_1 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X+SCREEN_WIDTH/4)
						elseif pn == PLAYER_2 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X+SCREEN_WIDTH/4)
						end
					elseif getenv("RotationUpsideDown"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):rotationz(180)
						if pn == PLAYER_1 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X-SCREEN_WIDTH/4)
						elseif pn == PLAYER_2 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X+SCREEN_WIDTH/4)
						end
					elseif getenv("RotationSolo"..pname(pn)) and not doubles then
						if ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerOneSide" then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):CenterX()
						end
					elseif getenv("RotationNormal"..pname(pn)) and not doubles then
						if pn == PLAYER_1 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X-SCREEN_WIDTH/4)
						elseif pn == PLAYER_2 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X+SCREEN_WIDTH/4)
						end
					end

					local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
					local currentMini = 1-math.round(GAMESTATE:GetPlayerState(pn):GetPlayerOptions(mlevel):Mini()*50) / 100

					if getenv("EffectVibrate"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):vibrate():effectmagnitude(20*currentMini,20*currentMini,20*currentMini)
					elseif getenv("EffectSpin"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
					elseif getenv("EffectSpinReverse"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
					elseif getenv("EffectBounce"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
					elseif getenv("EffectPulse"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):pulse():effectclock('beat')
					elseif getenv("EffectWag"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):wag():effectclock('beat')
					end
				end
			end
		end
	end,
	DoneLoadingNextSongMessageCommand=function(self) self:playcommand("On") end,
	Def.ActorProxy{
		Name="PC2",
		MULTICommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):y(SCREEN_HEIGHT/3) end,
	},
	Def.ActorProxy{
		Name="PC3",
		MULTICommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):y(SCREEN_HEIGHT/3*2) end
	},
	Def.ActorProxy{
		Name="PC4",
		MULTICommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(xM()):y(0) end
	},
	Def.ActorProxy{
		Name="PC5",
		MULTICommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(xM()):y(SCREEN_HEIGHT/3) end
	},
	Def.ActorProxy{
		Name="PC6",
		MULTICommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(xM()):y(SCREEN_HEIGHT/3*2) end
	}
}