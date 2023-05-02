local c
local padMax = 234
local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(GAMESTATE:GetMasterPlayerNumber()):GetPlayerOptions(mlevel):Mini()*50) / 100

local style = GAMESTATE:GetCurrentStyle()
local styleType = style:GetStyleType()
local doubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')

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
		if not isTopScreen("ScreenDemonstration2") then
			self:playcommand("UpdateDiscordInfo")
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				if GAMESTATE:GetNumPlayersEnabled() == 1 then
					if isOutFox() and not tobool(LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()),"HasLua")) or not HasLuaCheck() then
						if getenv("RotationNormal"..pname(pn)) then
							if IsGame("be-mu") then
								SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom((853-369+156-156*currentMini)/853):xy(pn == PLAYER_1 and 369-156+156*currentMini or 0,(480-87.75+87.75*currentMini)/4)
							elseif IsGame("po-mu") then
								SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom((853-357+144-144*currentMini)/853):xy(pn == PLAYER_1 and 357-144+144*currentMini or 0,(480-81+81*currentMini)/4)
							end
						elseif getenv("RotationSolo"..pname(pn)) then
							if IsGame("be-mu") then
								SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom((853-582)/853):xy(0,12.5)
								c.PC2:playcommand("BMS")
								c.PC3:playcommand("BMS")
								c.PC4:playcommand("BMS")
								if getenv("ShowStats"..pname(pn)) == 0 then
									c.PC5:playcommand("BMS")
									c.PC6:playcommand("BMS")
								end
							elseif IsGame("po-mu") then
								SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild(""):zoom((853-571)/853):xy(0,0)
								c.PC2:playcommand("PMS")
								c.PC3:playcommand("PMS")
								c.PC4:playcommand("PMS")
								if getenv("ShowStats"..pname(pn)) == 0 then
									c.PC5:playcommand("PMS")
									c.PC6:playcommand("PMS")
								end
							end
						end
					end
				end
				if SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)) and SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField") then
					if getenv("RotationLeft"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField"):rotationz(270)
						if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField"):addx(-SCREEN_WIDTH/2)
						end
					elseif getenv("RotationRight"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField"):rotationz(90)
						if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField"):addx(SCREEN_WIDTH/2)
						end
					elseif getenv("RotationUpsideDown"..pname(pn)) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):GetChild("NoteField"):rotationz(180):addy(20)
					elseif getenv("RotationSolo"..pname(pn)) and not doubles then
						if ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerOneSide" then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):CenterX()
						end
					elseif getenv("RotationNormal"..pname(pn)) and not doubles then
						if pn == PLAYER_2 then
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X+SCREEN_WIDTH/4)
						else
							SCREENMAN:GetTopScreen():GetChild("Player"..pname(pn)):x(SCREEN_CENTER_X-SCREEN_WIDTH/4)
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
		BMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):y(480/3-5) end,
		PMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):y(480/3) end
	},
	Def.ActorProxy{
		Name="PC3",
		BMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):y(480/3*2-10) end,
		PMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):y(480/3*2) end
	},
	Def.ActorProxy{
		Name="PC4",
		BMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(582):y(0) end,
		PMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(571):y(0) end
	},
	Def.ActorProxy{
		Name="PC5",
		BMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(582):y(480/3-5) end,
		PMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(571):y(480/3) end
	},
	Def.ActorProxy{
		Name="PC6",
		BMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(582):y(480/3*2-10) end,
		PMSCommand=function(self) self:SetTarget( SCREENMAN:GetTopScreen():GetChild("SongBackground"):GetChild("") ):x(571):y(480/3*2) end
	}
}