local selectHeld = { PLAYER_1 = false, PLAYER_2 = false }
local insideFavorites = false
local changed = false
local outfoxed = false
local active = ThemePrefs.Get("SLFavorites")
local courseMode = GAMESTATE:IsCourseMode()
local showGraph = ThemePrefs.Get("ShowGraph")

local function reloadPreferredSortSM()
	SCREENMAN:SystemMessage("Force-Reload Favorites/Preferred SortOrder")
	local screen = SCREENMAN:GetTopScreen()
	screen:SetNextScreenName(SelectMusicOrCourse())
	screen:StartTransitioningScreen("SM_GoToNextScreen")
end

local function updateFavorites()
	if insideFavorites then
		if not isITGmania() and changed then reloadPreferredSortSM() end
		SCREENMAN:GetTopScreen():GetMusicWheel():ChangeSort(isEtterna() and "SortOrder_Favorites" or "SortOrder_Preferred")
	else
		local screen = SCREENMAN:GetTopScreen()
		screen:GetMusicWheel():Move(1)
		screen:GetMusicWheel():Move(-1)
		screen:GetMusicWheel():Move(0)
	end
end

local MOD = {}
local CURRENT = {}
local PREVIOUS = {}
local enableMOD = ThemePrefs.Get("ShowMODDisplay")

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end
	if event.type == "InputEventType_FirstPress" then
		if (event.GameButton == "MenuUp" or event.GameButton == "Up") and selectHeld[event.PlayerNumber] then
			if GAMESTATE:GetCurrentSong() then
				if isOutFox() then
					if not isOutFoxV() then setOFFavorites(event.PlayerNumber) end
					outfoxed = true
				elseif isEtterna() then
					SCREENMAN:GetTopScreen():ToggleCurrentFavorite()
					changed = true
					if insideFavorites then updateFavorites() end
				elseif active then
					if PROFILEMAN:IsPersistentProfile(event.PlayerNumber) then
						changed = true
						addOrRemoveFavorite(event.PlayerNumber) updateFavorites()
					end
				end
			end
		elseif (event.GameButton == "MenuDown" or event.GameButton == "Down") and selectHeld[event.PlayerNumber] and isOutFox() and active then
			if GAMESTATE:GetCurrentSong() and PROFILEMAN:IsPersistentProfile(event.PlayerNumber) then
				changed = true
				addOrRemoveFavorite(event.PlayerNumber)
				updateFavorites()
			end
		elseif (event.GameButton == "EffectDown" or event.GameButton == "EffectUp") and not selectHeld[event.PlayerNumber] then
			if enableMOD then
				PREVIOUS[event.PlayerNumber] = CURRENT[event.PlayerNumber]
				if event.GameButton == 'EffectUp' then
					CURRENT[event.PlayerNumber] = CURRENT[event.PlayerNumber] + 25
				elseif event.GameButton == 'EffectDown' then
					if CURRENT[event.PlayerNumber] > 25 then CURRENT[event.PlayerNumber] = CURRENT[event.PlayerNumber] - 25 end
				end

				if MOD[event.PlayerNumber] == "x" then
					setX(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "c" then
					setC(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "m" then
					setM(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "a" then
					setA(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "ca" then
					setCA(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "av" then
					setAV(CURRENT[event.PlayerNumber],event.PlayerNumber)
				end
				if PREVIOUS[event.PlayerNumber] ~= CURRENT[event.PlayerNumber] then MESSAGEMAN:Broadcast("RateChanged") end
			end
		elseif (event.GameButton == "EffectDown" or event.GameButton == "EffectUp") and selectHeld[event.PlayerNumber] then
			if enableMOD then
				if event.GameButton == 'EffectDown' then
					if MOD[event.PlayerNumber] == "x" then
						MOD[event.PlayerNumber] = "av"
					elseif MOD[event.PlayerNumber] == "c" then
						MOD[event.PlayerNumber] = "x"
					elseif MOD[event.PlayerNumber] == "m" then
						MOD[event.PlayerNumber] = "c"
					elseif MOD[event.PlayerNumber] == "a" then
						MOD[event.PlayerNumber] = "m"
					elseif MOD[event.PlayerNumber] == "ca" then
						MOD[event.PlayerNumber] = "a"
					elseif MOD[event.PlayerNumber] == "av" then
						MOD[event.PlayerNumber] = "ca"
					end
				elseif event.GameButton == 'EffectUp' then
					if MOD[event.PlayerNumber] == "x" then
						MOD[event.PlayerNumber] = "c"
					elseif MOD[event.PlayerNumber] == "c" then
						MOD[event.PlayerNumber] = "m"
					elseif MOD[event.PlayerNumber] == "m" then
						MOD[event.PlayerNumber] = "a"
					elseif MOD[event.PlayerNumber] == "a" then
						MOD[event.PlayerNumber] = "ca"
					elseif MOD[event.PlayerNumber] == "ca" then
						MOD[event.PlayerNumber] = "av"
					elseif MOD[event.PlayerNumber] == "av" then
						MOD[event.PlayerNumber] = "x"
					end
				end

				if MOD[event.PlayerNumber] == "x" then
					setX(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "c" then
					setC(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "m" then
					setM(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "a" then
					setA(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "ca" then
					setCA(CURRENT[event.PlayerNumber],event.PlayerNumber)
				elseif MOD[event.PlayerNumber] == "av" then
					setAV(CURRENT[event.PlayerNumber],event.PlayerNumber)
				end
				if PREVIOUS[event.PlayerNumber] ~= CURRENT[event.PlayerNumber] then MESSAGEMAN:Broadcast("RateChanged") end
			end
		elseif event.GameButton == "Select" and not selectHeld[event.PlayerNumber] then
			selectHeld[event.PlayerNumber] = true
		end
	elseif event.type == "InputEventType_Release" and event.GameButton == "Select" and selectHeld[event.PlayerNumber] then
		selectHeld[event.PlayerNumber] = false
	end
end

local graphs = showGraph and (#GAMESTATE:GetHumanPlayers() == 1 and loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(GAMESTATE:GetMasterPlayerNumber())..{
		InitCommand=function(self) self:zoomx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -1/3*WideScreenDiff() or 1/3*WideScreenDiff()):zoomy(1/3*WideScreenDiff())
			if IsUsingWideScreen() then
				self:x(SCREEN_CENTER_X+256):addy(SCREEN_CENTER_Y*1.15)
			elseif GetScreenAspectRatio() <= 1 then
				self:x(SCREEN_CENTER_X+152*WideScreenDiff()):addy(SCREEN_CENTER_Y+70*WideScreenDiff()):rotationz(90)
			end
		end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if GAMESTATE:GetCurrentSong() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if GAMESTATE:GetCurrentCourse() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
} or Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(PLAYER_2)..{
			InitCommand=function(self) self:zoom(1/3*WideScreenDiff()):zoomy(1/3*WideScreenDiff())
				if IsUsingWideScreen() then
					self:x(SCREEN_CENTER_X+288):addy(SCREEN_CENTER_Y*1.15)
				elseif GetScreenAspectRatio() <= 1 then
					self:x(SCREEN_CENTER_X+224*WideScreenDiff()):addy(SCREEN_CENTER_Y+70*WideScreenDiff()):rotationz(90)
				end
			end,
			CurrentSongChangedMessageCommand=function(self) if not courseMode then if GAMESTATE:GetCurrentSong() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
			CurrentCourseChangedMessageCommand=function(self) if courseMode then if GAMESTATE:GetCurrentCourse() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
			OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
	},
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/graph"))(PLAYER_1)..{
		InitCommand=function(self) self:zoom(-1/3*WideScreenDiff()):zoomy(1/3*WideScreenDiff())
			if IsUsingWideScreen() then
				self:x(SCREEN_CENTER_X+256):addy(SCREEN_CENTER_Y*1.15)
			elseif GetScreenAspectRatio() <= 1 then
				self:x(SCREEN_CENTER_X+80*WideScreenDiff()):addy(SCREEN_CENTER_Y+70*WideScreenDiff()):rotationz(90)
			end
		end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then if GAMESTATE:GetCurrentSong() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then if GAMESTATE:GetCurrentCourse() then self:diffusealpha(1) else self:diffusealpha(0) end end end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
	}
}) or Def.ActorFrame{}

return Def.ActorFrame{
    InitCommand=function() if ((isOutFox() and not isOutFoxV()) or active) and not isEtterna() then generateFavoritesForMusicWheel() end end,
	OnCommand=function()
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
			local playeroptions = GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Song")
			if playeroptions:MMod() then MOD[pn] = "m" CURRENT[pn] = playeroptions:MMod() break end
			if isOutFox() then if playeroptions:AMod() then MOD[pn] = "a" CURRENT[pn] = playeroptions:AMod() break end end
			if isOutFox() and VersionDateCheck(20220300) then if playeroptions:CAMod() then MOD[pn] = "ca" CURRENT[pn] = playeroptions:CAMod() break end end
			if isOutFox() and VersionDateCheck(20220900) then if playeroptions:AVMod() then MOD[pn] = "av" CURRENT[pn] = playeroptions:AVMod() break end end
			if playeroptions:XMod() then MOD[pn] = "x" CURRENT[pn] = playeroptions:XMod()*100 end
			if playeroptions:CMod() then MOD[pn] = "c" CURRENT[pn] = playeroptions:CMod() end
		end
		if (isOutFox() and not isOutFoxV()) or active or enableMOD then SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end
	end,
	OffCommand=function() if (isOutFox() and not isOutFoxV()) or active or enableMOD then SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end end,
	SortOrderChangedMessageCommand=function(self)
		local s = GAMESTATE:GetSortOrder()
		if s ~= nil then
			if SortOrderToLocalizedString(s) == "Preferred" or SortOrderToLocalizedString(s) == "Favorites" then
				if not isITGmania() and changed and not outfoxed then reloadPreferredSortSM() end
				insideFavorites = true
				outfoxed = false
				changed = false
			else insideFavorites = false end
		end
	end,
	Def.Sprite {
		Texture = "mask",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+139.5*WideScreenDiff()):y(SCREEN_CENTER_Y-16*WideScreenDiff()):zoom(WideScreenDiff()):z(2):zwrite(true):blend(Blend.NoEffect) end,
		OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end
	},
	graphs..{
		Condition=not courseMode and (IsUsingWideScreen() or GetScreenAspectRatio() <= 1),
	}
}