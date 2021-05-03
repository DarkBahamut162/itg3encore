local Player = ...
if not Player then error("[ScreenNameEntryTraditional Keyboard] what, you WANT me to randomly assign a player for the keyboard? too bad. I don't feel like dealing with the humorless people who will submit bug reports about it.") end

-- CreateScrollerItem(char,altName)
-- Creates a scroller item for the Keyboard.

-- Params:
-- char			Character to draw
-- altName		Alternate name (optional)
local function CreateScrollerItem(char,altName)
	local textZoom = 0.95
	if altName and (altName == "Back" or altName == "End") then
		textZoom = 1
	end

	if not altName then altName = char end
	return Def.ActorFrame{
		Name="Character_"..altName;
		LoadFont("ScreenNameEntryTraditional entry")..{
			Text=char,
			BeginCommand=cmd(zoom,textZoom;shadowlength,4),
		}
	}
end

-- create scroller items
local KeyboardLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!."
local scrollItems = {}
for c in string.gmatch(KeyboardLetters,".") do
	table.insert(scrollItems, CreateScrollerItem(c))
end
-- don't forget the "leftarrow" and "ok" items too
table.insert(scrollItems, CreateScrollerItem("&leftarrow;","Back"))
table.insert(scrollItems, CreateScrollerItem("&ok;","End"))

local t = Def.ActorFrame{
	Name="KeyboardController"..PlayerNumberToString(Player),

	-- todo: handle wrapping
	KeyboardLeftMessageCommand=function(self,param)
		if param.Player == Player then
			local scroller = self:GetChild("KeyScroller")
			local cur = scroller:GetCurrentItem()

			if cur-1 < 0 then
				cur = scroller:GetNumItems()-1
			else
				cur = cur-1
			end

			scroller:SetCurrentAndDestinationItem(cur)
		end
	end,

	-- todo: handle wrapping
	KeyboardRightMessageCommand=function(self,param)
		if param.Player == Player then
			local scroller = self:GetChild("KeyScroller")
			local cur = scroller:GetCurrentItem()

			if cur+1 > scroller:GetNumItems()-1 then
				cur = 0
			else
				cur = cur+1
			end

			scroller:SetCurrentAndDestinationItem(cur)
		end
	end,

	KeyboardEnterMessageCommand=function(self,param)
		if param.Player == Player then
			local ts = SCREENMAN:GetTopScreen()
			-- check what item we're on; Back and End are options too.
			local scroller = self:GetChild("KeyScroller")

			-- ActorScroller:GetCurrentItem is 0-indexed; Lua tables are 1-indexed.
			local index = scroller:GetCurrentItem()
			if index ~= scroller:GetNumItems() then
				index = index+1
			end

			local i = scrollItems[index]
			local selectedChar = ToEnumShortString(i.Name)

			if selectedChar == "End" then
				ts:Finish(Player)

				self:playcommand("Off")
			elseif selectedChar == "Back" then
				ts:Backspace(Player)
			else
				local ek = ts:EnterKey(Player,selectedChar)
				-- check value of ek in order to something something sounds
			end
		end
	end,

	-- Handle messages fired by ScreenNameEntryTraditional:SelectChar
	SelectKeyMessageCommand=function(self,param)
		if param.PlayerNumber == Player then
			local scroller = self:GetChild("KeyScroller")
			if param.Key == "BACK" then
				scroller:SetCurrentAndDestinationItem(scroller:GetNumItems()-2)
			elseif param.Key == "ENTER" then
				scroller:SetCurrentAndDestinationItem(scroller:GetNumItems()-1)
			end
		end
	end,

	-- scroller
	Def.ActorScroller{
		Name="KeyScroller",
		SecondsPerItem=0.2,
		NumItemsToDraw=5,
		InitCommand=cmd(SetLoop,true),
		TransformFunction=function(self,offset,itemIndex,numItems)
			self:x(offset*40)
		end,
		children = scrollItems,
	},

	LoadActor("cursor")
}

return t
