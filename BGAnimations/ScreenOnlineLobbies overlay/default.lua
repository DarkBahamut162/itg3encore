local active_index = 0
local list_selected = false
local t = nil
local connected = false
local has_error = false
local wait_time = 0
local attempted = false
local input_added = false

local lobbies = {}
local lobby = 0

local mode = "browse"
local joined_active_index = 1
local joined_lobby_code = ""
local joined_lobby_players = {}
local showing_leave_confirm = false
local leave_confirm_index = 0

local create_lobby_password = ""
local join_lobby_password = ""
local join_lobby_code = ""

local password_prompt_mode = "create"
local show_password_in_lobby = false
local showing_password_prompt = false
local password_active_index = 1
local password_char_limit = 19
local password_chars = {
	"&SELECT;","&START;",
	"A","B","C","D","E","F","G","H","I","J","K","L","M",
	"N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
}
local letters = {
	"a","b","c","d","e","f","g","h","i","j","k","l","m",
	"n","o","p","q","r","s","t","u","v","w","x","y","z",
}

local function GetPromptPassword()
	if password_prompt_mode == "join" then
		return join_lobby_password
	end
	return create_lobby_password
end

local function SetPromptPassword(value)
	if password_prompt_mode == "join" then
		join_lobby_password = value
	else
		create_lobby_password = value
	end
end

local hasPassword = false
local passwordHidden = false

function ScreenTextEntry()
	SCREENMAN:AddNewScreenToTop("ScreenTextEntry")
	local question = {
		Question = password_prompt_mode == "join" and "Enter Lobby Password" or "Create Lobby Password (Optional)",
		MaxInputLength = 255,
		OnOK = function(answer)
			answer = answer:upper()
			if password_prompt_mode == "join" then
				join_lobby_password = answer
				MESSAGEMAN:Broadcast("SetStatus",{text="Joining lobby..."})
				MESSAGEMAN:Broadcast("JoinLobby",{code=join_lobby_code,password=join_lobby_password})
				join_lobby_password = ""
			else
				create_lobby_password = answer
				MESSAGEMAN:Broadcast("SetStatus",{text="Creating lobby..."})
				MESSAGEMAN:Broadcast("CreateLobby",{password=create_lobby_password})
			end
		end,
		ValidateAppend = function(answer,append) return FindInTable(append:lower(),letters) ~= nil and answer:len() < password_char_limit end,
		FormatAnswerForDisplay = function(answer) return answer:upper() end
	}
	SCREENMAN:GetTopScreen():Load(question)
	SOUND:PlayMusicPart(THEME:GetPathS("ScreenOnlineLobbies","music"),0,-1,0,0,true,false)
end

local function InputHandler(event)
	if not connected then
		if event.type == "InputEventType_FirstPress" then
			if event.GameButton == "Back" or event.GameButton == "Select" then
				local topScreen = SCREENMAN:GetTopScreen()
				if topScreen then
					topScreen:SetNextScreenName(Branch.TitleScreen())
					topScreen:StartTransitioningScreen("SM_GoToNextScreen")
					SCREENMAN:PlayCancelSound()
				end
			end
		end
		return
	end
	if has_error then
		if event.type == "InputEventType_FirstPress" then
			if event.GameButton == "Start" then
				local topScreen = SCREENMAN:GetTopScreen()
				if topScreen then
					topScreen:SetNextScreenName(SelectMusicOrCourse())
					topScreen:StartTransitioningScreen("SM_GoToNextScreen")
					SCREENMAN:PlayStartSound()
				end
			elseif event.GameButton == "Back" or event.GameButton == "Select" then
				local topScreen = SCREENMAN:GetTopScreen()
				if topScreen then
					topScreen:SetNextScreenName(Branch.TitleScreen())
					topScreen:StartTransitioningScreen("SM_GoToNextScreen")
					SCREENMAN:PlayCancelSound()
				end
			end
		end
		return
	end
	if event.type == "InputEventType_FirstPress" or event.type == "InputEventType_Repeat" then
		if showing_password_prompt then
			if event.GameButton == "MenuRight" then
				password_active_index = password_active_index + 1
				t:GetChild("Prompt"):playcommand("PasswordRefresh")
				SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster","change"))
			elseif event.GameButton == "MenuLeft" then
				password_active_index = password_active_index - 1
				t:GetChild("Prompt"):playcommand("PasswordRefresh")
				SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster","change"))
			elseif event.GameButton == "MenuUp" then
				local selected_char = password_chars[password_active_index]
				if selected_char == "&START;" then
					SCREENMAN:PlayInvalidSound()
				else
					SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster","change"))
					password_active_index = 2
					t:GetChild("Prompt"):playcommand("PasswordRefresh")
				end
			elseif event.GameButton == "MenuDown" then
				local selected_char = password_chars[password_active_index]
				if selected_char == "&SELECT;" then
					SCREENMAN:PlayInvalidSound()
				else
					SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster","change"))
					password_active_index = 1
					t:GetChild("Prompt"):playcommand("PasswordRefresh")
				end
			elseif event.GameButton == "Start" then
				local selected_char = password_chars[password_active_index]
				if selected_char == "&START;" then
					if password_prompt_mode == "join" and join_lobby_code == "" then
						SCREENMAN:PlayCancelSound()
						return
					end
					showing_password_prompt = false
					t:GetChild("Prompt"):playcommand("PasswordOff")
					if password_prompt_mode == "join" then
						MESSAGEMAN:Broadcast("SetStatus",{text="Joining lobby..."})
						MESSAGEMAN:Broadcast("JoinLobby",{code=join_lobby_code,password=join_lobby_password:upper()})
						--join_lobby_password = ""
					else
						MESSAGEMAN:Broadcast("SetStatus",{text="Creating lobby..."})
						MESSAGEMAN:Broadcast("CreateLobby",{password=create_lobby_password:upper()})
					end
					SCREENMAN:PlayStartSound()
				elseif selected_char == "&SELECT;" then
					local password = GetPromptPassword()
					if password:len() > 0 then
						SetPromptPassword(password:sub(1,-2))
						t:GetChild("Prompt"):playcommand("PasswordRefresh")
						SCREENMAN:PlayCancelSound()
					else
						SCREENMAN:PlayInvalidSound()
					end
				else
					local password = GetPromptPassword()
					if password:len() < password_char_limit then
						SetPromptPassword(password .. selected_char)
						if GetPromptPassword():len() >= password_char_limit then password_active_index = 2 end
						t:GetChild("Prompt"):playcommand("PasswordRefresh")
						SCREENMAN:PlayStartSound()
					else
						SCREENMAN:PlayInvalidSound()
					end
				end
			elseif event.DeviceInput.button == "DeviceButton_backspace" then
				local password = GetPromptPassword()
				if password:len() > 0 then
					SetPromptPassword(password:sub(1,-2))
					t:GetChild("Prompt"):playcommand("PasswordRefresh")
					SCREENMAN:PlayCancelSound()
				else
					SCREENMAN:PlayInvalidSound()
				end
			elseif event.GameButton == "Select" or event.GameButton == "Back" then
				showing_password_prompt = false
				t:GetChild("Prompt"):playcommand("PasswordOff")
				SCREENMAN:PlayCancelSound()
			else
				local letter =split("_",event.DeviceInput.button)
				local found = FindInTable(letter[#letter],letters)
				if found then
					local password = GetPromptPassword()
					if password:len() < password_char_limit then
						SetPromptPassword(password..event.DeviceInput.button:sub(-1):upper())
						if GetPromptPassword():len() >= password_char_limit then password_active_index = 2 end
						t:GetChild("Prompt"):playcommand("PasswordRefresh")
						SCREENMAN:PlayStartSound()
					else
						SCREENMAN:PlayInvalidSound()
					end
				end
			end
			return false
		end
	end

	if event.type == "InputEventType_FirstPress" then
		if event.GameButton == "MenuLeft" or event.GameButton == "MenuUp" then
			if showing_leave_confirm then
				leave_confirm_index = (leave_confirm_index - 1) % 2
				if leave_confirm_index == 1 then t:GetChild("Prompt"):GetChild("Cursor"):queuecommand("Yes") else t:GetChild("Prompt"):GetChild("Cursor"):queuecommand("No") end
				SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
			elseif list_selected then
				SOUND:PlayOnce(THEME:GetPathS("ScreenOptions","next"))
				lobby = lobby - 1
			else
				if mode == "joined" then
					joined_active_index = (joined_active_index - 1) % 3
					if joined_active_index == 0 and not hasPassword then joined_active_index = (joined_active_index - 1) % 3 end
				elseif mode == "browse" then
					active_index = (active_index - 1) % 5
				end
				SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster","change"))
			end
			MESSAGEMAN:Broadcast("Change")
		elseif event.GameButton == "MenuRight" or event.GameButton == "MenuDown" then
			if showing_leave_confirm then
				leave_confirm_index = (leave_confirm_index + 1) % 2
				if leave_confirm_index == 1 then t:GetChild("Prompt"):GetChild("Cursor"):queuecommand("Yes") else t:GetChild("Prompt"):GetChild("Cursor"):queuecommand("No") end
				SOUND:PlayOnce(THEME:GetPathS('ScreenPrompt',"change"))
			elseif list_selected then
				SOUND:PlayOnce(THEME:GetPathS("ScreenOptions","next"))
				lobby = lobby + 1
			else
				if mode == "joined" then
					joined_active_index = (joined_active_index + 1) % 3
					if joined_active_index == 0 and not hasPassword then joined_active_index = (joined_active_index + 1) % 3 end
				elseif mode == "browse" then
					active_index = (active_index + 1) % 5
				end
				SOUND:PlayOnce(THEME:GetPathS("ScreenSelectMaster","change"))
			end
			MESSAGEMAN:Broadcast("Change")
		elseif event.GameButton == "Back" or event.GameButton == "Select" then
			if showing_leave_confirm then
				t:GetChild("Prompt"):playcommand("PromptOff")
				showing_leave_confirm = false
				SCREENMAN:PlayCancelSound()
			elseif list_selected then
				list_selected = false
				lobby = 0
				MESSAGEMAN:Broadcast("Change")
				SCREENMAN:PlayCancelSound()
			elseif mode == "joined" then
				leave_confirm_index = 0
				showing_leave_confirm = true
				t:GetChild("Prompt"):GetChild("Cursor"):queuecommand("No")
				t:GetChild("Prompt"):playcommand("PromptOn")
				SCREENMAN:PlayStartSound()
			else
				local topScreen = SCREENMAN:GetTopScreen()
				if topScreen then
					topScreen:SetNextScreenName(Branch.TitleScreen())
					topScreen:StartTransitioningScreen("SM_GoToNextScreen")
					SCREENMAN:PlayCancelSound()
				end
			end
		elseif event.GameButton == "Start" then
			if showing_leave_confirm then
				if leave_confirm_index == 0 then
					SCREENMAN:PlayCancelSound()
				elseif leave_confirm_index == 1 then
					mode = "browse"
					joined_lobby_code = ""
					joined_lobby_players = {}
					MESSAGEMAN:Broadcast("SearchLobby")
					MESSAGEMAN:Broadcast("Change")
					SCREENMAN:PlayStartSound()
				end
				t:GetChild("Prompt"):playcommand("PromptOff")
				showing_leave_confirm = false
			elseif list_selected then
				local current = (lobby % #lobbies)+1
				lobby = 0

				local selected = lobbies[current]
				if not selected then
					SCREENMAN:PlayCancelSound()
					return
				end

				MESSAGEMAN:Broadcast("OnlineLobbyJoinSelected",{code=selected.code,isPasswordProtected=selected.isPasswordProtected,password=(params and params.password) or ""})
				MESSAGEMAN:Broadcast("Change")
				SCREENMAN:PlayStartSound()
			else
				if mode == "browse" then
					if active_index == 0 then
						if #lobbies > 0 then
							list_selected = true
							MESSAGEMAN:Broadcast("Change")
							SCREENMAN:PlayStartSound()
						else
							SCREENMAN:PlayCancelSound()
						end
					elseif active_index == 1 then
						if isITGmaniaOnline() then
							MESSAGEMAN:Broadcast("SetStatus",{text="Searching lobbies..."})
							MESSAGEMAN:Broadcast("SearchLobby")
						else
							connected = false
							has_error = false
							attempted = false
							wait_time = 0
							MESSAGEMAN:Broadcast("SetStatus",{text="Refreshing lobby list..."})
							MESSAGEMAN:Broadcast("Connect")
						end
						SCREENMAN:PlayStartSound()
					elseif active_index == 2 then
						password_prompt_mode = "create"
						create_lobby_password = ""
						show_password_in_lobby = false
						if ThemePrefs.Get("KeyboardEnabled") then
							ScreenTextEntry()
						else
							showing_password_prompt = true
							t:GetChild("Prompt"):playcommand("PasswordOn")
							password_active_index = 3
							t:GetChild("Prompt"):playcommand("PasswordRefresh")
						end
						SCREENMAN:PlayStartSound()
					elseif active_index == 3 then
						local topScreen = SCREENMAN:GetTopScreen()
						if topScreen then
							topScreen:SetNextScreenName(Branch.TitleScreen())
							topScreen:StartTransitioningScreen("SM_GoToNextScreen")
							SCREENMAN:PlayCancelSound()
						end
					elseif active_index == 4 then
						local topScreen = SCREENMAN:GetTopScreen()
						if topScreen then
							topScreen:SetNextScreenName(SelectMusicOrCourse())
							topScreen:StartTransitioningScreen("SM_GoToNextScreen")
							SCREENMAN:PlayStartSound()
						end
					end
				else
					if joined_active_index == 0 then
						show_password_in_lobby = not show_password_in_lobby
						passwordHidden = hasPassword and (not show_password_in_lobby)
						MESSAGEMAN:Broadcast("Change")
						SCREENMAN:PlayStartSound()
					elseif joined_active_index == 1 then
						leave_confirm_index = 0
						showing_leave_confirm = true
						t:GetChild("Prompt"):GetChild("Cursor"):queuecommand("No")
						t:GetChild("Prompt"):playcommand("PromptOn")
						SCREENMAN:PlayStartSound()
					elseif joined_active_index == 2 then
						local topScreen = SCREENMAN:GetTopScreen()
						if topScreen then
							topScreen:SetNextScreenName(SelectMusicOrCourse())
							topScreen:StartTransitioningScreen("SM_GoToNextScreen")
							SCREENMAN:PlayStartSound()
						end
					end
				end
			end
		end
	end
end

return Def.ActorFrame{
	OnCommand=function(self)
		t=self
		self:Center()
		if not input_added and SCREENMAN:GetTopScreen() then
			SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
			input_added = true
		end
		create_lobby_password = ""
		MESSAGEMAN:Broadcast("SetStatus",{text="Initializing online connection..."})
		self:queuecommand("CheckConnect")
	end,
	OffCommand=function(self)
		local onlineHandler = GetOnlineHandlerInstance()
		if onlineHandler and onlineHandler.connected and not onlineHandler.inLobby then MESSAGEMAN:Broadcast("DisconnectOnline") end
	end,
	CheckConnectCommand=function(self)
		local onlineHandler = GetOnlineHandlerInstance()
		if onlineHandler then
			if not attempted and (not onlineHandler.socket or onlineHandler.errorMsg ~= nil) then
				MESSAGEMAN:Broadcast("SetStatus",{text="Connecting to online service..."})
				MESSAGEMAN:Broadcast("ConnectOnline")
				attempted = true
			end

			if not onlineHandler.connected and onlineHandler.errorMsg == nil then
				wait_time = wait_time + 1
				MESSAGEMAN:Broadcast("SetStatus",{text="Connecting to online service... ("..wait_time.."s)"})
				self:sleep(1):queuecommand("CheckConnect")
			else
				self:queuecommand("Display")
			end
		else
			MESSAGEMAN:Broadcast("SetStatus",{text="Initializing online handler..."})
			self:sleep(0.25):queuecommand("CheckConnect")
		end
	end,
	ConnectMessageCommand=function(self) self:queuecommand("CheckConnect") end,
	LobbySearchedMessageCommand=function(self,params)
		lobbies = params and params.lobbies or {}
		MESSAGEMAN:Broadcast("Change")
	end,
	DisplayCommand=function(self)
		local onlineHandler = GetOnlineHandlerInstance()
		if onlineHandler then
			if onlineHandler.connected then
				connected = true
				has_error = false
				MESSAGEMAN:Broadcast("SetStatus",{text="Connected to online service."})
				MESSAGEMAN:Broadcast("SearchLobby")
				MESSAGEMAN:Broadcast("Change")
			end

			if onlineHandler.errorMsg ~= nil then
				connected = false
				has_error = true
				MESSAGEMAN:Broadcast("SetStatus",{text="Error connecting to online service:\n"..onlineHandler.errorMsg.."\nPress &START; to continue to Select Music.\nPress &BACK;/&SELECT; to return to Title Screen."})
			end
		end
	end,
	OnlineLobbyStateMessageCommand=function(self,params)
		hasPassword = create_lobby_password ~= ""
		passwordHidden = hasPassword and (not show_password_in_lobby)
		mode = "joined"
		showing_leave_confirm = false
		list_selected = false
		showing_password_prompt = false
		password_prompt_mode = "create"
		join_lobby_code = ""
		join_lobby_password = ""
		joined_lobby_code = params and params.code or ""
		joined_lobby_players = params and params.players or {}
		joined_active_index = hasPassword and 0 or 1

		self:GetChild("Prompt"):playcommand("PasswordOff")
		MESSAGEMAN:Broadcast("SetStatus",{text=""})
		MESSAGEMAN:Broadcast("Change")
	end,
	OnlineLobbyJoinSelectedMessageCommand=function(self,params)
		if not params or not params.code then
			SCREENMAN:PlayCancelSound()
			return
		end

		join_lobby_code = params.code
		if params.isPasswordProtected then
			password_prompt_mode = "join"
			join_lobby_password = ""
			if ThemePrefs.Get("KeyboardEnabled") then
				ScreenTextEntry()
			else
				showing_password_prompt = true
				self:GetChild("Prompt"):playcommand("PasswordOn")
				password_active_index = 3
				self:GetChild("Prompt"):playcommand("PasswordRefresh")
			end
		else
			showing_password_prompt = false
			self:GetChild("Prompt"):playcommand("PasswordOff")
			MESSAGEMAN:Broadcast("SetStatus",{text="Joining lobby..."})
			MESSAGEMAN:Broadcast("JoinLobby",{code=params.code,password=params.password or ""})
		end
	end,
	OnlineLobbyLeftMessageCommand=function(self,params)
		if params == nil or params.left == nil or params.left then
			showing_leave_confirm = false
			mode = "browse"
			joined_lobby_code = ""
			joined_lobby_players = {}
			MESSAGEMAN:Broadcast("SetStatus",{text="Left lobby."})
		end
	end,
	OnlineResponseStatusMessageCommand=function(self,params)
		if params and params.event == "createLobby" and params.success == false then
			mode = "browse"
			MESSAGEMAN:Broadcast("SetStatus",{text=params.message and ("Create lobby failed:\n"..params.message) or "Create lobby failed."})
		elseif params and params.event == "joinLobby" and params.success == false then
			mode = "browse"
			MESSAGEMAN:Broadcast("SetStatus",{text=params.message and ("Join lobby failed:\n"..params.message) or "Join lobby failed."})
		elseif params and params.event == "leaveLobby" and params.success == false then
			showing_leave_confirm = false
			MESSAGEMAN:Broadcast("SetStatus",{text=params.message and ("Leave lobby failed:\n"..params.message) or "Leave lobby failed."})
		elseif params and params.event == "searchLobby" and params.success == false then
		end
	end,

	Def.ActorFrame{
		Name="List",
		InitCommand=function(self) self:xy(-SCREEN_CENTER_X,-SCREEN_CENTER_Y) end,
		ChangeMessageCommand=function(self)
			if mode == "browse" then
				self:GetChild("Display"):GetChild("Option1"):diffuse(active_index == 1 and color("#FFFFFF") or color("#808080")):settext("Refresh List")
				self:GetChild("Display"):GetChild("Option2"):diffuse(active_index == 2 and color("#FFFFFF") or color("#808080")):settext("Create Lobby")
				self:GetChild("Display"):GetChild("Option3"):diffuse(active_index == 3 and color("#FFFFFF") or color("#808080")):settext("Return to Title Screen")
				self:GetChild("Display"):GetChild("Option4"):diffuse(active_index == 4 and color("#FFFFFF") or color("#808080")):settext("Continue to Select Music")
				self:GetChild("Display"):GetChild("Top"):settext("Available lobbies ("..(#lobbies==0 and "0/0" or ((lobby+1) % #lobbies + 1).."/"..#lobbies)..")")
				self:GetChild("Display"):GetChild("Bottom"):settext("")
				MESSAGEMAN:Broadcast("TriangleOn")
				if #lobbies > 0 then
					MESSAGEMAN:Broadcast("LobbyOff")
					MESSAGEMAN:Broadcast("SearchOn")
				else
					MESSAGEMAN:Broadcast("LobbyOn")
					MESSAGEMAN:Broadcast("SearchOff")
				end
				for i=1,7 do
					local current = ((i-3+lobby-1) % #lobbies)+1
					if #lobbies > 0 then
						local current = ((i-3+lobby-1) % #lobbies)+1
						self:GetChild("Slots"):GetChild("Slot"..i):settext(lobbies[current].code.." ("..lobbies[current].playerCount..(lobbies[current].spectatorCount > 0 and "+"..lobbies[current].spectatorCount or "")..")")
						if lobbies[current].isPasswordProtected then
							self:GetChild("Slots"):GetChild("Slot"..i):diffuse(color("#800000")):stopeffect()
							if i == 4 then
								if list_selected then
									self:GetChild("Slots"):GetChild("Slot"..i):diffuseshift():effectcolor1(color("#FF0000")):effectcolor2(color("#800000"))
								else
									self:GetChild("Slots"):GetChild("Slot"..i):diffuse(color(active_index == 0 and "#FF0000" or "#800000")):stopeffect()
								end
							end
						else
							self:GetChild("Slots"):GetChild("Slot"..i):diffuse(color("#808080")):stopeffect()
							if i == 4 then
								if list_selected then
									self:GetChild("Slots"):GetChild("Slot"..i):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#808080"))
								else
									self:GetChild("Slots"):GetChild("Slot"..i):diffuse(color(active_index == 0 and "#FFFFFF" or "#808080")):stopeffect()
								end
							end
						end
					else
						local text = ""
						if i == 4 and connected then text = "No lobbies found." end
						self:GetChild("Slots"):GetChild("Slot"..i):settext(text):diffuse(active_index == 0 and color("#FFFFFF") or color("#808080")):stopeffect()
					end
				end
			else
				MESSAGEMAN:Broadcast("LobbyOn")
				MESSAGEMAN:Broadcast("SearchOff")
				MESSAGEMAN:Broadcast("TriangleOff")
				self:GetChild("Display"):GetChild("Option1"):diffuse(joined_active_index == 0 and color("#FFFFFF") or color("#808080"))
				self:GetChild("Display"):GetChild("Option2"):diffuse(joined_active_index == 1 and color("#FFFFFF") or color("#808080")):settext("Leave Lobby")
				self:GetChild("Display"):GetChild("Option3"):diffuse(joined_active_index == 2 and color("#FFFFFF") or color("#808080")):settext("Continue to Select Music")
				self:GetChild("Display"):GetChild("Top"):settext("Lobby: "..(joined_lobby_code ~= "" and joined_lobby_code or "(pending)"))
				self:GetChild("Display"):GetChild("Option1"):settext(hasPassword and (passwordHidden and "Show Password" or "Hide Password") or "")
				self:GetChild("Display"):GetChild("Option4"):settext("")
				self:GetChild("Display"):GetChild("Bottom"):settext(hasPassword and "Password: "..(passwordHidden and string.rep("•",create_lobby_password:len()) or create_lobby_password).." ("..create_lobby_password:len()..")" or "")
				for i=1,7 do self:GetChild("Slots"):GetChild("Slot"..i):settext("") end
				local text = ""
				for i,player in ipairs(joined_lobby_players) do
					local profile = player.profileName or player.name or player.playerId or ("Player "..i)
					local ready = player.ready and " &START;" or ""
					text = addToOutput(text,i..". "..profile..ready,"\n")
				end
				self:GetChild("Slots"):GetChild("Slot4"):settext(text):stopeffect():diffuse(color("#FFFFFF"))
			end
		end,
		Def.Quad{
			InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,0.5")) end,
		},
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenOptions","page/lobby page"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()):visible(true) end,
			LobbyOnMessageCommand=function(self) self:visible(true) end,
			LobbyOffMessageCommand=function(self) self:visible(false) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenOptions","page/search page"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()):visible(false) end,
			SearchOnMessageCommand=function(self) self:visible(true) end,
			SearchOffMessageCommand=function(self) self:visible(false) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenOptions","overlay/_frame"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenSelectMusic","Triangle/glow"),
			InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-7*WideScreenDiff()):zoomx(-WideScreenDiff()):halign(0) end,
			TriangleOnMessageCommand=function(self) self:visible(true) end,
			TriangleOffMessageCommand=function(self) self:visible(false) end
		},
		Def.ActorFrame{
			Name="Slots",
			Def.BitmapText {
				Name="Slot1",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-91*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot2",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-63*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot3",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-35*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot4",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-7*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):maxheight(190):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Slot5",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+21*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot6",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+49*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot7",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+77*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			}
		},
		Def.ActorFrame{
			Name="Display",
			Def.BitmapText {
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+147.5*WideScreenDiff(),SCREEN_CENTER_Y-130*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(430):valign(0):shadowlength(0):vertspacing(-3) end,
				SetStatusMessageCommand=function(self,params) self:settext(params.text) end,
			},
			Def.BitmapText {
				Name="Option1",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+147.5*WideScreenDiff(),SCREEN_CENTER_Y-70*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(430):valign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Option2",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+147.5*WideScreenDiff(),SCREEN_CENTER_Y-20*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(430):valign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Option3",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+147.5*WideScreenDiff(),SCREEN_CENTER_Y+30*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(430):valign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Option4",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+147.5*WideScreenDiff(),SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(430):valign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Top",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-119*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Bottom",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+105*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265):halign(0):shadowlength(0):vertspacing(-3) end
			}
		}
	},
	Def.ActorFrame{
		Name="Prompt",
		InitCommand=function(self) self:xy(-SCREEN_CENTER_X,-SCREEN_CENTER_Y) end,
		PromptOnCommand=function(self)
			self:GetChild("BG"):diffusealpha(4/5)
			self:GetChild("Cursor"):diffusealpha(1)
			self:GetChild("Warning"):settext("Disconnect from the current lobby?"):diffusealpha(1)
			self:GetChild("YES"):diffusealpha(1)
			self:GetChild("NO"):diffusealpha(1)
		end,
		PromptOffCommand=function(self)
			self:GetChild("BG"):diffusealpha(0)
			self:GetChild("Cursor"):diffusealpha(0)
			self:GetChild("Warning"):diffusealpha(0)
			self:GetChild("YES"):diffusealpha(0)
			self:GetChild("NO"):diffusealpha(0)
		end,
		PasswordOnCommand=function(self)
			self:GetChild("BG"):diffusealpha(4/5)
			self:GetChild("Warning"):settext(password_prompt_mode == "join" and "Enter Lobby Password" or "Create Lobby Password (Optional)"):diffusealpha(1)
			self:GetChild("Hint"):diffusealpha(1)
			self:playcommand("PasswordRefresh")
			self:GetChild("PasswordSelected"):diffusealpha(1)
			self:GetChild("Password"):diffusealpha(1)
		end,
		PasswordRefreshCommand=function(self)
			local text = ""
			for i=1,5 do
				local current = (password_active_index-1-(3-i)) % #password_chars
				if current < 0 then current = current + #password_chars end
				text = addToOutput(text,password_chars[current+1],"   ")
			end
			self:GetChild("PasswordSelected"):settext(text):AddAttribute(6,{Length=6,Diffuse=color("#FFFFFF")})
			self:GetChild("Password"):settext(GetPromptPassword())
		end,
		PasswordOffCommand=function(self)
			self:GetChild("BG"):diffusealpha(0)
			self:GetChild("Warning"):diffusealpha(0)
			self:GetChild("Hint"):diffusealpha(0)
			self:GetChild("PasswordSelected"):settext(""):diffusealpha(0)
			self:GetChild("Password"):settext(""):diffusealpha(0)
		end,
		Def.Quad{
			Name="BG",
			InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0")):diffusealpha(0) end
		},
		Def.Sprite {
			Name="Cursor",
			Texture = THEME:GetPathG("ScreenPrompt","Cursor"),
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
			YesCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3) end,
			NoCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3) end
		},
        Def.BitmapText {
            File = "_z 36px shadowx",
			Name="Warning",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-SCREEN_CENTER_Y/3*WideScreenDiff()):maxwidth(SCREEN_WIDTH/WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(0) end
		},
        Def.BitmapText {
            File = "_z 36px shadowx",
			Name="Password",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-SCREEN_CENTER_Y/6*WideScreenDiff()):maxwidth(SCREEN_WIDTH/WideScreenDiff()):zoom(0.6*WideScreenDiff()):diffusealpha(0) end
		},
        Def.BitmapText {
            File = "_z 36px shadowx",
			Name="PasswordSelected",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y):zoom(0.6*WideScreenDiff()):maxwidth(SCREEN_WIDTH/WideScreenDiff()):diffuse(color("#808080")):diffusealpha(0) end
		},
		Def.BitmapText{
            File = "_z 36px shadowx",
			Name="Hint",
			Text="Use &MENULEFT;/&MENURIGHT; to pick characters\nPress &START; to select, Press &SELECT; to delete\nSelect &START; to set password, Select &SELECT; to return to Lobby Selection",
			InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(0.3*WideScreenDiff()):diffusealpha(0) end
		},
        Def.BitmapText {
            File = "_r bold 30px",
			Name="YES",
			Text="Yes",
			InitCommand=function(self) self:x(SCREEN_CENTER_X-SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
		},
        Def.BitmapText {
            File = "_r bold 30px",
			Name="NO",
			Text="No",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+SCREEN_CENTER_X/3):y(SCREEN_CENTER_Y+SCREEN_CENTER_Y/3):zoom(WideScreenDiff()):diffusealpha(0) end,
		}
	}
}