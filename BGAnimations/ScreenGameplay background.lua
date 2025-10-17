local c
local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(GAMESTATE:GetMasterPlayerNumber()):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(GAMESTATE:GetMasterPlayerNumber()):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny
local style = GAMESTATE:GetCurrentStyle()

local function xS() return SCREEN_WIDTH*0.25+style:GetWidth(GAMESTATE:GetMasterPlayerNumber())/2*currentMini end
local function zoomS() return (SCREEN_WIDTH-xS())/SCREEN_WIDTH end
local function xM() return SCREEN_CENTER_X+style:GetWidth(GAMESTATE:GetMasterPlayerNumber())/2*currentMini end
local function zoomM() return (SCREEN_WIDTH-xM())/SCREEN_WIDTH end

return Def.ActorFrame {
	Name="YOU_WISH_YOU_WERE_PLAYING_BEATMANIA_RIGHT_NOW",
	UpdateDiscordInfoCommand=function()
		if isOutFox(20200500) then
			local song = GAMESTATE:GetCurrentSong()
			if song then
				local player = GAMESTATE:GetMasterPlayerNumber()
				local lengthFull = string.len(song:GetDisplayFullTitle()) + 3 + string.len(song:GetGroupName())
				local lengthMain = string.len(song:GetDisplayMainTitle()) + 3 + string.len(song:GetGroupName())
				local title = lengthFull < 128 and song:GetDisplayFullTitle() or
							--string.sub(song:GetDisplayFullTitle(),1,122-string.len(song:GetGroupName())) .. "..."
							lengthMain < 128 and song:GetDisplayMainTitle() or string.sub(song:GetDisplayMainTitle(),1,122-string.len(song:GetGroupName())) .. "..."
				local songname = title .. " - " .. song:GetGroupName()
				local state = GAMESTATE:IsDemonstration() and "Watching Song" or "Playing Song"
				GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(player))
				local stats = STATSMAN:GetCurStageStats()
				if not stats then return end
				local courselength = function()
					if not isPlayMode("PlayMode_Endless") then
						return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().. " (Song ".. stats:GetPlayerStageStats( player ):GetSongsPassed()+1 .. " of ".. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() ..")" or ""
					end
					return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().. " (Song ".. stats:GetPlayerStageStats( player ):GetSongsPassed()+1 .. ")" or ""
				end
				GAMESTATE:UpdateDiscordSongPlaying(GAMESTATE:IsCourseMode() and courselength() or state,songname,(song:GetLastSecond() - GAMESTATE:GetCurMusicSeconds())/math.round(GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate(),1))
			end
		elseif isEtterna("0.57") then
			updateDiscordStatus(false)
		end
	end,
	InitCommand = function(self) c = self:GetChildren() end,
	OnCommand=function(self)
		if not isTopScreen("ScreenDemonstration") and not isTopScreen("ScreenDemonstration2") and not isTopScreen("ScreenJukebox") and not isTopScreen("ScreenCreditsGameplay") then
			self:playcommand("UpdateDiscordInfo")
			for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
				if GAMESTATE:GetNumPlayersEnabled() == 1 and not isDouble() and (IsGame("be-mu") or IsGame("beat") or IsGame("po-mu") or IsGame("popn")) then
					if not HasLuaCheck() then
						if getenv("Rotation"..pname(pn)) == 1 or getenv("Rotation"..pname(pn)) == 4 then
							SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom(zoomS()):xy(pn == PLAYER_1 and xS() or 0,SCREEN_CENTER_Y-SCREEN_CENTER_Y*zoomS())
						elseif getenv("Rotation"..pname(pn)) == 5 then
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
					local rotationZ = 0
					local posX = SCREEN_CENTER_X
					if getenv("Rotation"..pname(pn)) == 2 then
						rotationZ = 270
						if pn == PLAYER_1 then
							posX = SCREEN_CENTER_X-SCREEN_WIDTH/4
						elseif pn == PLAYER_2 then
							posX = SCREEN_CENTER_X-SCREEN_WIDTH/4
						end
					elseif getenv("Rotation"..pname(pn)) == 3 then
						rotationZ = 90
						if pn == PLAYER_1 then
							posX = SCREEN_CENTER_X+SCREEN_WIDTH/4
						elseif pn == PLAYER_2 then
							posX = SCREEN_CENTER_X+SCREEN_WIDTH/4
						end
					elseif getenv("Rotation"..pname(pn)) == 4 then
						rotationZ = 180
						if pn == PLAYER_1 then
							posX = SCREEN_CENTER_X-SCREEN_WIDTH/4
						elseif pn == PLAYER_2 then
							posX = SCREEN_CENTER_X+SCREEN_WIDTH/4
						end
					elseif getenv("Rotation"..pname(pn)) == 5 and not isDouble() then
						if ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerOneSide" then
							posX = SCREEN_CENTER_X
						end
					elseif getenv("Rotation"..pname(pn)) == 1 and not isDouble() then
						if pn == PLAYER_1 then
							posX = SCREEN_CENTER_X-SCREEN_WIDTH/4
						elseif pn == PLAYER_2 then
							posX = SCREEN_CENTER_X+SCREEN_WIDTH/4
						end
					end
					
					SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):rotationz(rotationZ)
					SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(posX)

					local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
					local currentMini = 1-math.round(GAMESTATE:GetPlayerState(pn):GetPlayerOptions(mlevel):Mini()*50) / 100

					if getenv("Effect"..pname(pn)) == 1 then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):vibrate():effectmagnitude(20*currentMini,20*currentMini,20*currentMini)
					elseif getenv("Effect"..pname(pn)) == 2 then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
					elseif getenv("Effect"..pname(pn)) == 3 then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
					elseif getenv("Effect"..pname(pn)) == 4 then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
					elseif getenv("Effect"..pname(pn)) == 5 then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):pulse():effectclock('beat')
					elseif getenv("Effect"..pname(pn)) == 6 then
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