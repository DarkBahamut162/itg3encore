local Player = ...
if not Player then error("[ScreenNameEntryTraditional Keyboard] what, you WANT me to randomly assign a player for the keyboard? too bad. I don't feel like dealing with the humorless people who will submit bug reports about it.") end

local function CreateScrollerItem(char,altName)
	local textZoom = 0.95
	if altName and (altName == "Back" or altName == "End") then textZoom = 1 end
	if not altName then altName = char end
	return Def.ActorFrame{
		Name="Character_"..altName,
		Def.BitmapText {
			File = "ScreenNameEntryTraditional entry",
			Text=char,
			BeginCommand=function(self) self:zoom(textZoom):shadowlength(4) end
		}
	}
end

local KeyboardLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!."
local scrollItems = {}

for c in string.gmatch(KeyboardLetters,".") do scrollItems[#scrollItems+1] = CreateScrollerItem(c) end

scrollItems[#scrollItems+1] = CreateScrollerItem("&leftarrow;","Back")
scrollItems[#scrollItems+1] = CreateScrollerItem("&ok;","End")

return Def.ActorFrame{
	Name="KeyboardController"..PlayerNumberToString(Player),
	KeyboardLeftMessageCommand=function(self,param)
		if param.Player == Player then
			local scroller = self:GetChild("KeyScroller")
			local cur = scroller:GetCurrentItem()

			if cur-1 < 0 then cur = scroller:GetNumItems()-1 else cur = cur-1 end

			scroller:SetCurrentAndDestinationItem(cur)
			SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "change" ) )
		end
	end,
	KeyboardRightMessageCommand=function(self,param)
		if param.Player == Player then
			local scroller = self:GetChild("KeyScroller")
			local cur = scroller:GetCurrentItem()

			if cur+1 > scroller:GetNumItems()-1 then cur = 0 else cur = cur+1 end

			scroller:SetCurrentAndDestinationItem(cur)
			SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "change" ) )
		end
	end,
	KeyboardEnterMessageCommand=function(self,param)
		if param.Player == Player then
			local ts = SCREENMAN:GetTopScreen()
			local scroller = self:GetChild("KeyScroller")
			local index = scroller:GetCurrentItem()

			if index ~= scroller:GetNumItems() then index = index+1 end

			local i = scrollItems[index]
			local selectedChar = ToEnumShortString(i.Name)
			local maxChars = THEME:GetMetric("ScreenNameEntryTraditional","MaxRankingNameLength")
			local selected = getenv("HighScoreName"..pname(Player))

			if selectedChar == "End" then
				if string.len(selected) > 0 then
					PROFILEMAN:GetProfile(Player):SetLastUsedHighScoreName(selected)
					GAMESTATE:StoreRankingName(Player,selected)
					ts:Finish(Player)
					self:playcommand("Off")
					MESSAGEMAN:Broadcast("EntryFinished",{Player=Player})
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
				else
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "invalid" ) )
				end
			elseif selectedChar == "Back" then
				if string.len(selected) > 0 then
					setenv("HighScoreName"..pname(Player),selected:sub(1,-2))
					MESSAGEMAN:Broadcast("EntryChanged",{Player=Player})
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
				else
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "invalid" ) )
				end
			else
				if string.len(selected) < maxChars then
					if string.len(selected) == maxChars - 1 then
						scroller:SetCurrentAndDestinationItem(scroller:GetNumItems()-1)
					end
					selected = selected .. selectedChar
					setenv("HighScoreName"..pname(Player),selected)
					MESSAGEMAN:Broadcast("EntryChanged",{Player=Player})
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
				else
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "invalid" ) )
				end
			end
		end
	end,
	KeyboardBackMessageCommand=function(self,param)
		if param.Player == Player then
			local selected = getenv("HighScoreName"..pname(Player))
			local scroller = self:GetChild("KeyScroller")
			if string.len(selected) > 0 then
				scroller:SetCurrentAndDestinationItem(scroller:GetNumItems()-2)
				setenv("HighScoreName"..pname(Player),selected:sub(1,-2))
				MESSAGEMAN:Broadcast("EntryChanged",{Player=Player})
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
			else
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "invalid" ) )
			end
		end
	end,
	Def.ActorScroller{
		Name="KeyScroller",
		SecondsPerItem=0.2,
		NumItemsToDraw=5,
		InitCommand=function(self) self:SetLoop(true) end,
		TransformFunction=function(self,offset,itemIndex,numItems) self:x(offset*40) end,
		children = scrollItems
	},
	Def.Sprite {
		Texture = "cursor "..(isFinal() and "final" or "normal")
	}
}