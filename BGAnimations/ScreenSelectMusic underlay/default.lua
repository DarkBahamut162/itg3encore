local selectHeld = { PLAYER_1 = false, PLAYER_2 = false }
local insideFavorites = false
local changed = false
local outfoxed = false
local active = ThemePrefs.Get("SLFavorites")

local function reloadPreferredSortSM()
	SCREENMAN:SystemMessage("Force-Reload Favorites/Preferred SortOrder")
	local screen = SCREENMAN:GetTopScreen()
	screen:SetNextScreenName(SelectMusicOrCourse())
	screen:StartTransitioningScreen("SM_GoToNextScreen")
end

local function updateFavorites()
	if insideFavorites then
		if not isITGmania() and changed then reloadPreferredSortSM() end
		SCREENMAN:GetTopScreen():GetMusicWheel():ChangeSort("SortOrder_Preferred")
	else
		local screen = SCREENMAN:GetTopScreen()
		screen:GetMusicWheel():Move(1)
		screen:GetMusicWheel():Move(-1)
		screen:GetMusicWheel():Move(0)
	end
end

local InputHandler = function(event)
	if not event.PlayerNumber or not event.button then return false end
	if event.type == "InputEventType_FirstPress" then
		if (event.GameButton == "MenuUp" or event.GameButton == "Up") and selectHeld[event.PlayerNumber] then
			if GAMESTATE:GetCurrentSong() then
				if isOutFox() then
					if not isOutFoxV() then setOFFavorites(event.PlayerNumber) end
					outfoxed = true
				else
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
		elseif event.GameButton == "Select" and not selectHeld[event.PlayerNumber] then
			selectHeld[event.PlayerNumber] = true
		end
	elseif event.type == "InputEventType_Release" and event.GameButton == "Select" and selectHeld[event.PlayerNumber] then
		selectHeld[event.PlayerNumber] = false
	end
end

return Def.ActorFrame{
    InitCommand=function() if (isOutFox() and not isOutFoxV()) or active then generateFavoritesForMusicWheel() end end,
	OnCommand=function(self) if (isOutFox() and not isOutFoxV()) or active then SCREENMAN:GetTopScreen():AddInputCallback(InputHandler) end end,
	OffCommand=function(self) if (isOutFox() and not isOutFoxV()) or active then SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end end,
	SortOrderChangedMessageCommand=function(self)
		local s = GAMESTATE:GetSortOrder()
		if s ~= nil then
			if SortOrderToLocalizedString(s) == "Preferred" then
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
	}
}