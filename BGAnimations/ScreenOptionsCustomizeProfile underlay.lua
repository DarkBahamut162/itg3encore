-- Pester Kyzentun for an explanation if you need to customize this screen.
-- Also, this might be rewritten to us a proper customizable lua menu system
-- in the future.

-- Copy this file into your theme, then modify as needed to suit your theme.
-- Each of the things on this list has a comment marking it, so you can
-- quickly find it by searching.
-- Things you will want to change:
-- 1.  The Numpad
-- 2.  The Cursor
-- 3.  The Menu Items
-- 4.  The Menu Values
-- 4.1  The L/R indicators
-- 5.  The Menu Fader

local profile,master,profile_id

if getenv("EditUSBProfile") then
	GAMESTATE:LoadProfiles()
	master = getenv("EditUSBProfile")
	profile = PROFILEMAN:GetProfile(master)
	profile_id = nil
else
	profile = GAMESTATE:GetEditLocalProfile()
	master = GAMESTATE:GetMasterPlayerNumber()
	profile_id = GAMESTATE:GetEditLocalProfileID()
end

-- 1.  The Numpad
-- This is what sets up how the numpad looks.  See Scripts/04 NumPadEntry.lua
-- for a full description of how to customize a NumPad.
-- Note that if you provide a custom prompt actor for the NumPad, it must
-- have a SetCommand because the NumPad is used any time the player needs to
-- enter a number, and the prompt is updated by running its SetCommand.
local number_entry = new_numpad_entry{
	Name = "number_entry",
	InitCommand=function(self) self:diffusealpha(0):xy(_screen.cx, _screen.cy):zoom(WideScreenDiff_(16/10)) end,
	InvalidValueCommand=function(self) SCREENMAN:PlayInvalidSound() end,
	EntryDoneCommand=function(self) SCREENMAN:PlayStartSound() end,
	value_color = PlayerColor(master),
	cursor_draw = "first",
	cursor_color = PlayerDarkColor(master)
}

local function calc_list_pos(value, list)
	for i, entry in ipairs(list) do
		if entry.setting == value then return i end
	end
	return 1
end

local function item_value_to_text(item, value)
	if item.item_type == "bool" then
		if value then
			value = THEME:GetString("ScreenOptionsCustomizeProfile", item.true_text)
		else
			value = THEME:GetString("ScreenOptionsCustomizeProfile", item.false_text)
		end
	elseif item.item_type == "list" then
		local pos = calc_list_pos(value, item.list)
		return item.list[pos].display_name
	end
	return value
end

local char_list = {}

do
	local all_chars = CHARMAN:GetAllCharacters()
	for char in ivalues(char_list) do
		char_list[#char_list+1] = {
			setting = char:GetCharacterID(),
			display_name = char:GetDisplayName()
		}
	end
end

local menu_items = {
	{
		name = "profile",
		question = "Set new profile name",
		get = "GetDisplayName",
		set = "SetDisplayName",
		item_type = "string",
	},{
		name = "highscore",
		question = "Set new highscore name",
		get = "GetLastUsedHighScoreName",
		set = "SetLastUsedHighScoreName",
		item_type = "string",
	},{
		name = "weight",
		get = "GetWeightPounds",
		set = "SetWeightPounds",
		item_type = "number",
		auto_done = 100
	},{
		name = "voomax",
		get = "GetVoomax",
		set = "SetVoomax",
		item_type = "number",
		auto_done = 100
	},{
		name = "birth_year",
		get = "GetBirthYear",
		set = "SetBirthYear",
		item_type = "number",
		auto_done = 1000
	},{
		name = "calorie_calc",
		get = "GetIgnoreStepCountCalories",
		set = "SetIgnoreStepCountCalories",
		item_type = "bool",
		true_text = "use_heart",
		false_text = "use_steps"
	},{
		name = "gender",
		get = "GetIsMale",
		set = "SetIsMale",
		item_type = "bool",
		true_text = "male",
		false_text = "female"
	}
}
if #char_list > 0 then
	menu_items[#menu_items+1] = {
		name = "character",
		get = "GetCharacter",
		set = "SetCharacter",
		item_type = "list",
		list = char_list
	}
end
if isOutFox() and profile_id then
	menu_items[#menu_items+1] = {
		name = "avatimg_edit",
		item_type = "menu",
		get = function()
			local ProfileImage = LoadModule("Config.Load.lua")( "AvatarImage", "/Save/LocalProfiles/"..profile_id.."/OutFoxPrefs.ini" )
			return ProfileImage and string.gsub(ProfileImage, "/Appearance/Avatars/","") or "default"
		end,
		screen_name = "ScreenAvatarImageSelection"
	}
end
menu_items[#menu_items+1] = {
	name = "exit",
	item_type = "exit"
}

local menu_pos = 1
local menu_start = (SCREEN_CENTER_Y-36)*WideScreenSemiDiff_(16/10)
local menu_x = 100*WideScreenDiff_(16/10)
local value_x = SCREEN_RIGHT-500*WideScreenDiff_(16/10)
local fader
local cursor_on_menu = "main"
local menu_item_actors = {}
local menu_values = {}
local list_pos = 0
local active_list = {}
local left_showing = false
local right_showing = false

local function fade_actor_to(actor, alf)
	actor:stoptweening():linear(0.2):diffusealpha(alf)
end

local function update_menu_cursor()
	MESSAGEMAN:Broadcast("UpdateCursor",{ind=menu_pos})
end

local function update_list_cursor()
	local valactor = menu_values[menu_pos]
	valactor:playcommand("Set", {active_list[list_pos].display_name})
	if list_pos > 1 then
		if not left_showing then
			valactor:playcommand("ShowLeft")
			left_showing = true
		end
	else
		if left_showing then
			valactor:playcommand("HideLeft")
			left_showing = false
		end
	end
	if list_pos < #active_list then
		if not right_showing then
			valactor:playcommand("ShowRight")
			right_showing = true
		end
	else
		if right_showing then
			valactor:playcommand("HideRight")
			right_showing = false
		end
	end
end

local function exit_screen(newscreen)
	if newscreen then
		SCREENMAN:GetTopScreen():SetNextScreenName( newscreen )
	else
		if profile_id then
			PROFILEMAN:SaveLocalProfile(profile_id)
		else
			GAMESTATE:SaveProfiles()
			SCREENMAN:GetTopScreen():SetNextScreenName( "ScreenOptionsManageUSBProfiles" )
		end
	end
	SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
	SCREENMAN:PlayStartSound()
end

local update = true

local function input(event)
	local pn = event.PlayerNumber
	if not pn then return false end
	if event.type == "InputEventType_Release" then return false end
	local button = event.GameButton
	if cursor_on_menu == "main" then
		if button == "Start" then
			local item= menu_items[menu_pos]
			if item.item_type == "bool" then
				local value = not profile[item.get](profile)
				menu_values[menu_pos]:playcommand("Set", {item_value_to_text(item, value)})
				profile[item.set](profile, value)
				MESSAGEMAN:Broadcast("Change")
			elseif item.item_type == "number" then
				update = false
				if isOutFoxV() or not isOutFox() then
					SCREENMAN:AddNewScreenToTop("ScreenTextEntry")
					local question = {
						Question = "Insert new value for "..string.gsub(" "..item.name, "%W%l", string.upper):sub(2),
						MaxInputLength = string.len(""..item.auto_done),
						InitialAnswer = profile[item.get](profile) == 0 and "" or profile[item.get](profile),
						OnOK = function(answer)
							if answer == "" then answer = "0" end
							profile[item.set](profile, answer)
							menu_values[menu_pos]:playcommand("Set", {item_value_to_text(item, answer)})
							update = true
						end,
						ValidateAppend = function(answer,append)
							return not ((answer == "" or answer == "0") and append == "0") and tonumber(append) ~= nil
						end,
						OnCancel = function()
							update = true
							SCREENMAN:PlayInvalidSound()
						end,
						FormatAnswerForDisplay = function(answer)
							return answer == "" and 0 or tonumber(answer)
						end
					}
					SCREENMAN:GetTopScreen():Load(question)
				else
					fade_actor_to(fader, .8)
					fade_actor_to(number_entry.container, 1)
					number_entry.value = profile[item.get](profile)
					number_entry.value_actor:playcommand("Set", {number_entry.value})
					number_entry.auto_done_value = item.auto_done
					number_entry.max_value = item.max
					number_entry:update_cursor(number_entry.cursor_start)
					number_entry.prompt_actor:playcommand("Set", {THEME:GetString("ScreenOptionsCustomizeProfile", item.name)})
					cursor_on_menu = "numpad"
				end
				SCREENMAN:PlayStartSound()
			elseif item.item_type == "string" then
				update = false
				SCREENMAN:AddNewScreenToTop("ScreenTextEntry")
				local question = {
					Question = item.question,
					MaxInputLength = 255,
					InitialAnswer = profile[item.get](profile),
					OnOK = function(answer)
						profile[item.set](profile, answer)
						if item.name == "profile" then MESSAGEMAN:Broadcast("ChangeProfile") end
						menu_values[menu_pos]:playcommand("Set", {item_value_to_text(item, answer)})
						update = true
					end,
					OnCancel = function()
						update = true
						SCREENMAN:PlayInvalidSound()
					end
				}
				SCREENMAN:GetTopScreen():Load(question)
				SCREENMAN:PlayStartSound()
			elseif item.item_type == "list" then
				cursor_on_menu = "list"
				active_list = menu_items[menu_pos].list
				list_pos = calc_list_pos(profile[menu_items[menu_pos].get](profile), active_list)
				update_list_cursor()
			elseif item.item_type == "menu" then
				exit_screen( item.screen_name )
			elseif item.item_type == "exit" then
				exit_screen()
			end
		elseif button == "Back" then
			exit_screen()
		else
			if button == "MenuLeft" or button == "MenuUp" then
				if menu_pos > 1 then
					menu_pos = menu_pos - 1
					update_menu_cursor()
					MESSAGEMAN:Broadcast("Next")
				else
					SCREENMAN:PlayInvalidSound()
				end
			elseif button == "MenuRight" or button == "MenuDown" then
				if menu_pos < #menu_items then
					menu_pos = menu_pos + 1
					update_menu_cursor()
					MESSAGEMAN:Broadcast("Next")
				else
					SCREENMAN:PlayInvalidSound()
				end
			end
		end
	elseif cursor_on_menu == "numpad" then
		local done= number_entry:handle_input(button)
		if done or button == "Back" then
			local item= menu_items[menu_pos]
			if button ~= "Back" then
				profile[item.set](profile, number_entry.value)
				menu_values[menu_pos]:playcommand("Set", {item_value_to_text(item, number_entry.value)})
			else
				update = true
				SCREENMAN:PlayCancelSound()
			end
			fade_actor_to(fader, 0)
			fade_actor_to(number_entry.container, 0)
			cursor_on_menu = "main"
		elseif button == "Start" then
			update = true
			MESSAGEMAN:Broadcast("Change")
		elseif button == "MenuLeft" or button == "MenuUp" or button == "MenuRight" or button == "MenuDown" then
			MESSAGEMAN:Broadcast("Next")
		end
	elseif cursor_on_menu == "list" then
		if button == "MenuLeft" or button == "MenuUp" then
			if list_pos > 1 then list_pos = list_pos - 1 end
			update_list_cursor()
			menu_values[menu_pos]:playcommand("PressLeft")
		elseif button == "MenuRight" or button == "MenuDown" then
			if list_pos < #active_list then list_pos = list_pos + 1 end
			update_list_cursor()
			menu_values[menu_pos]:playcommand("PressRight")
		elseif button == "Start" or button == "Back" then
			if button ~= "Back" then
				profile[menu_items[menu_pos].set](profile, active_list[list_pos].setting)
			end
			local valactor = menu_values[menu_pos]
			left_showing = false
			right_showing = false
			valactor:playcommand("HideLeft")
			valactor:playcommand("HideRight")
			cursor_on_menu = "main"
		end
	end
end
local delta = 0
local mouseEnabled = ThemePrefs.Get("MouseEnabled")
local args = {
	Def.Actor{
		OnCommand=function()
			MESSAGEMAN:Broadcast("UpdateCursor",{ind=1})
			SCREENMAN:GetTopScreen():AddInputCallback(input)
		end,
		MouseWheelUpMessageCommand=function()
			if mouseEnabled and GetTimeSinceStart() - delta > 1/60 and update then
				delta = GetTimeSinceStart()
				if menu_pos > 1 then
					menu_pos = menu_pos - 1
					update_menu_cursor()
					MESSAGEMAN:Broadcast("Next")
				else
					SCREENMAN:PlayInvalidSound()
				end
			end
		end,
		MouseWheelDownMessageCommand=function()
			if mouseEnabled and GetTimeSinceStart() - delta > 1/60 and update then
				delta = GetTimeSinceStart()
				if menu_pos < #menu_items then
					menu_pos = menu_pos + 1
					update_menu_cursor()
					MESSAGEMAN:Broadcast("Next")
				else
					SCREENMAN:PlayInvalidSound()
				end
			end
		end,
		OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(input) end
	}
}

-- Note that the "character" item in the menu only shows up if there are
-- characters to choose from.  You might want to adjust positioning for that.
local itemspacing = 56/2

for i, item in ipairs(menu_items) do
	local item_y = menu_start + ((i-1) * itemspacing)
	-- 3.  The Menu Items
	-- This creates the actor that will be used to show each item on the menu.
	local menuitemnew
	if item.get then
		local value_text = type(item.get) == "string" and item_value_to_text(item, profile[item.get](profile)) or item.get()
		-- 4.  The Menu Values
		-- Each of the values needs to have a SetCommand so it can be updated
		-- when the player changes it.
		-- And ActorFrame is used because values for list items need to have
		-- left/right indicators for when the player is making a choice.
		local value_args = {
			Name = "value_" .. item.name,
			InitCommand=function(self)
				-- Note that the ActorFrame is being added to the list menu_values
				-- so it can be easily fetched and updated when the value changes.
				menu_values[i] = self
				self:x(value_x):diffusealpha(0):linear(0.2):diffusealpha(1)
			end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end,
			Def.BitmapText{
				Name = "val",
				Font = "Common Normal",
				Text = value_text,
				InitCommand=function(self) self:diffuse(Color.White):zoom(0.75*WideScreenDiff_(16/10)):horizalign(left) end,
				SetCommand=function(self, param) self:settext(param[1]) end
			}
		}
		if item.item_type == "list" then
			-- 4.1  The L/R indicators
			-- The L/R indicators are there to tell the player when there is a
			-- choice to the left or right of the choice they are on.
			-- Note that they are placed inside the ActorFrame for the value, so
			-- when commands are played on the ActorFrame, they are played for the
			-- indicators too.
			-- The commands are ShowLeft, HideLeft, PressLeft, and the same for
			-- Right.
			-- Note that the right indicator has a SetCommand so it sees when the
			-- value changes and checks the new width to position itself.
			-- Show/Hide is only played when the indicator changes state.
			-- Command execution order: Set, Show/Hide (if change occurred), Press
			value_args[#value_args+1] = Def.ActorMultiVertex{
				InitCommand= function(self)
					self:SetVertices{
						{{-5, 0, 0}, Color.White},
						{{0, -10, 0}, Color.White},
						{{0, 10, 0}, Color.White}
					}:SetDrawState{Mode = "DrawMode_Triangles"}:x(-8):visible(false):playcommand("Set", {value_text})
				end,
				ShowLeftCommand=function(self) self:visible(true) end,
				HideLeftCommand=function(self) self:visible(false) end,
				PressLeftCommand=function(self) self:stoptweening():linear(0.2):zoom(2):linear(0.2):zoom(1) end
			}
			value_args[#value_args+1] = Def.ActorMultiVertex{
				InitCommand=function(self)
					self:SetVertices{
						{{5, 0, 0}, Color.White},
						{{0, -10, 0}, Color.White},
						{{0, 10, 0}, Color.White}
					}:SetDrawState{Mode = "DrawMode_Triangles"}:visible(false)
				end,
				SetCommand=function(self)
					local valw = self:GetParent():GetChild("val"):GetWidth()
					self:x(valw+8)
				end,
				ShowRightCommand=function(self) self:visible(true) end,
				HideRightCommand=function(self) self:visible(false) end,
				PressRightCommand=function(self) self:stoptweening():linear(0.2):zoom(2):linear(0.2):zoom(1) end
			}
		end
		menuitemnew = Def.ActorFrame(value_args)
	end

	args[#args+1] = Def.ActorFrame{
		InitCommand=function(self) self:y(item_y) end,
		UpdateCursorMessageCommand=function(self) self:stoptweening():smooth(0.2):y( menu_pos > 8 and item_y-(itemspacing*(menu_pos-8)) or item_y ) end,
		Def.Quad{
			OnCommand=function(self) self:x( 0 ):halign(0):zoomto( SCREEN_WIDTH, itemspacing-2 ):diffusealpha(0):linear(0.2):diffuse( color("#00000076") ) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		Def.ActorFrame{
			InitCommand=function(self) self:diffusealpha(0) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end,
			UpdateCursorMessageCommand=function(self,param) self:stoptweening():linear(0.16):diffusealpha(param.ind == i and 1 or 0) end,
			Def.Quad {
				InitCommand=function(self)
					self:x(0):faderight( 0.5 ):zoomto(SCREEN_WIDTH, 2 ):halign(0):vertalign(top):y(-itemspacing/2):diffuse(PlayerColor(master)):diffuseleftedge(ColorLightTone(PlayerColor(master)))
				end
			},
			Def.Quad {
				InitCommand=function(self)
					self:x(0):faderight( 0.5 ):zoomto(SCREEN_WIDTH, 2 ):halign(0):vertalign(bottom):y(itemspacing/2):diffuse(ColorLightTone(PlayerColor(master))):diffuseleftedge(PlayerColor(master))
				end
			}
		},

		Def.BitmapText{
			Name = "menu_" .. item.name,
			Font = "Common Normal",
			Text = THEME:GetString("ScreenOptionsCustomizeProfile", item.name),
			InitCommand=function(self)
				-- Note that the item adds itself to the list menu_item_actors.  This
				-- is so that when the cursor is moved, the appropriate item can be
				-- easily fetched for positioning and sizing the cursor.
				-- Note the ActorFrames have a width of 1 unless you set it, so when
				-- you change this from an BitmapText to a ActorFrame, you will have
				-- to make the FitCommand of your cursor look at the children.
				menu_item_actors[i] = self
				self:x(value_x-16):diffuse(Color.White):horizalign(right):zoom(0.75*WideScreenDiff_(16/10)):diffusealpha(0):linear(0.2):diffusealpha(1)
			end,
			UpdateCursorMessageCommand=function(self,param) self:stoptweening():linear(0.16):diffusealpha(param.ind == i and 1 or 0.6) end,
			OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
		},
		menuitemnew
	}
end

local AvI = (isOutFox() and profile_id) and LoadModule("Config.Load.lua")( "AvatarImage", "/Save/LocalProfiles/"..profile_id.."/OutFoxPrefs.ini" ) or false
local ProfileImage = AvI and AvI or THEME:GetPathG("UserProfile","generic icon")

args[#args+1] = Def.ActorFrame{
    Name = "InfoFrame",
	InitCommand=function(self) self:zoom(WideScreenDiff_(16/10)):addy(-6) end,
    OnCommand=function(self) self:diffusealpha(0):addy(-20):decelerate(0.2):addy(20):diffusealpha(1) end,
    OffCommand=function(self) self:accelerate(0.2):addy(-20):diffusealpha(0) end,
	Def.Quad{
		OnCommand=function(self) self:xy( 0,136 ):halign(0):zoomto( SCREEN_WIDTH/WideScreenDiff_(16/10), itemspacing*4 ):diffusealpha(0):linear(0.2):diffuse( color("#00000076") ) end,
		OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
    Def.Sprite{
		Condition=isOutFox(),
        InitCommand=function(self) self:Load( ProfileImage ):visible(profile_id ~= nil) end,
        OnCommand=function(self) self:xy( 38, 136 ):halign(0):setsize(96,96) end
    },
	Def.BitmapText{
		Font = "Common Normal",
		Text = (profile_id and "" or "USB ").."Profile: "..profile:GetDisplayName(),
		OnCommand=function(self) self:xy( (isOutFox() and profile_id) and 150 or 50, 100 ):halign(0):shadowlength(3) end,
		ChangeProfileMessageCommand=function(self) self:settext("Profile: "..profile:GetDisplayName()) end
	},
	Def.BitmapText{
		Font = "Common Normal",
		Text = "GUID: "..profile:GetGUID(),
		OnCommand=function(self) self:xy( (isOutFox() and profile_id) and 150 or 50, 136 ):halign(0):shadowlength(3) end
	},
	Def.BitmapText{
		Font = "Common Normal",
		Text = Screen.String("TotalTime").. ": "..SecondsToHHMMSS(profile:GetTotalGameplaySeconds()),
		OnCommand=function(self) self:xy( (isOutFox() and profile_id) and 150 or 50, 172 ):halign(0):shadowlength(3) end
	}
}

-- 5.  The Menu Fader
-- This is just something to tell the player that the menu is no longer
-- active because they are interacting with the numpad.
-- Default is to just fade this in over the top of the menu.  If you want
-- something different, change the places in the input function that call
-- fade_actor_to to do what you want with the fader.
args[#args+1]= Def.Quad{
	Name = "fader",
	InitCommand=function(self)
		fader = self
		self:setsize( SCREEN_WIDTH ,SCREEN_HEIGHT):Center(menu_x-10, menu_start-12):diffuse(Color.Black):diffusealpha(0)
	end
}

args[#args+1] = Def.Sound{
	File = THEME:GetPathS("ScreenOptions","change"),
	IsAction = true,
	ChangeMessageCommand=function(self) self:play() end
}

args[#args+1] = Def.Sound{
	File = THEME:GetPathS("ScreenOptions","next"),
	IsAction = true,
	NextMessageCommand=function(self) self:play() end
}

args[#args+1] = loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))()
args[#args+1] = loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))()
args[#args+1] = loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_expandtop"))()
args[#args+1] = number_entry:create_actors()

return Def.ActorFrame(args)
