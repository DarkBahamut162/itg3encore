local Player = ...
if not Player then error("[ScreenNameEntryTraditional Keyboard] what, you WANT me to randomly assign a player for the keyboard? too bad. I don't feel like dealing with the humorless people who will submit bug reports about it.") end

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
			BeginCommand=function(self) self:zoom(textZoom):shadowlength(4) end;
		}
	}
end

local KeyboardLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!."
local scrollItems = {}
for c in string.gmatch(KeyboardLetters,".") do
	scrollItems[#scrollItems+1] = CreateScrollerItem(c);
end

scrollItems[#scrollItems+1] = CreateScrollerItem("&leftarrow;","Back");
scrollItems[#scrollItems+1] = CreateScrollerItem("&ok;","End");

return Def.ActorFrame{
	Name="KeyboardController"..PlayerNumberToString(Player),
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
			SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "change" ) )
		end
	end,
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
			SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "change" ) )
		end
	end,

	KeyboardEnterMessageCommand=function(self,param)
		if param.Player == Player then
			local ts = SCREENMAN:GetTopScreen()
			local scroller = self:GetChild("KeyScroller")
			local index = scroller:GetCurrentItem()
			if index ~= scroller:GetNumItems() then
				index = index+1
			end

			local i = scrollItems[index]
			local selectedChar = ToEnumShortString(i.Name)

			if selectedChar == "End" then
				ts:Finish(Player)
				self:playcommand("Off")
				SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
			elseif selectedChar == "Back" then
				if ts:Backspace(Player) then
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
				else
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "invalid" ) )
				end
			else
				if ts:EnterKey(Player,selectedChar) then
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "key" ) )
				else
					SOUND:PlayOnce( THEME:GetPathS( 'ScreenNameEntryTraditional', "invalid" ) )
				end
			end
		end
	end,
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

	Def.ActorScroller{
		Name="KeyScroller",
		SecondsPerItem=0.2,
		NumItemsToDraw=5,
		InitCommand=function(self) self:SetLoop(true) end;
		TransformFunction=function(self,offset,itemIndex,numItems)
			self:x(offset*40)
		end,
		children = scrollItems,
	},

	LoadActor("cursor")
}