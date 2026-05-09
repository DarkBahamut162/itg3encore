local isWaiting = false
local readyState = {["P1"]=true,["P2"]=true}
local songSelected = false
local startHoldTime = {["P1"]=0,["P2"]=0}
local lastDisconnectCountdown = nil
local scoreScreens = {"ScreenGameplay","ScreenEvaluation"}
local syncLockScreens = {"ScreenSelectMusic","ScreenGameplay","ScreenEvaluation"}
local autoReadyScreens = {"ScreenSelectMusic","ScreenEvaluation"}
local knownDisconnectScreens = {"ScreenTitle","ScreenGameOver","ScreenNameEntryTraditional","ScreenOptionsService","ScreenSummary"}

function IsWaiting() return isWaiting end

local function InputHandler(event)
	if SCREENMAN:GetTopScreen() and isWaiting and event.PlayerNumber then
		local pn = ToEnumShortString(event.PlayerNumber)
		if event.type == "InputEventType_FirstPress" and event.GameButton == "Start" then
			startHoldTime[pn] = GetTimeSinceStart()
			lastDisconnectCountdown = nil
			if string.find(SCREENMAN:GetTopScreen():GetName(),"ScreenGameplay") then
				readyState[pn] = true
				MESSAGEMAN:Broadcast("UpdateMachineState")
			end
		elseif event.type == "InputEventType_Repeat" and event.GameButton == "Start" then
			if startHoldTime[pn] > 0 then
				local holdDuration = GetTimeSinceStart()-startHoldTime[pn]
				local remainingSeconds = math.max(0,5-math.floor(holdDuration))
				if remainingSeconds ~= lastDisconnectCountdown then
					SCREENMAN:SystemMessage("Continue holding &START; for " .. remainingSeconds .. " more seconds to disconnect...")
					lastDisconnectCountdown = remainingSeconds
				end
				if holdDuration >= 5.0 then
					SCREENMAN:SystemMessage("Disconnected from lobby.")
					startHoldTime[pn] = 0
					lastDisconnectCountdown = nil
					isWaiting = false
					if string.find(SCREENMAN:GetTopScreen():GetName(),"ScreenGameplay") then
						SCREENMAN:GetTopScreen():PauseGame(false)
					end
					MESSAGEMAN:Broadcast("DisconnectOnline")
				end
			end
		elseif event.type == "InputEventType_Release" and event.GameButton == "Start" then
			startHoldTime[pn] = 0
			lastDisconnectCountdown = nil
		end
	end

	return false
end

local function CreateRequest(event,data)
	return JsonEncode({event=event,data=data})
end

local function GetMachineState()
	local screen = SCREENMAN:GetTopScreen()
	local screenName = screen and screen:GetName() or "NoScreen"
	local players = {}
	for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if GAMESTATE:IsSideJoined(player) then
			local profileName = "NoName"
			if (PROFILEMAN:IsPersistentProfile(player) and PROFILEMAN:GetProfile(player)) then profileName = PROFILEMAN:GetProfile(player):GetDisplayName() end
			local judgments = nil
			local score = nil
			local exScore = nil
			for screen in ivalues(scoreScreens) do
				if string.find(screenName,screen) then
					judgments = GetJudgmentCounts(player)
					local dance_points = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
					local percent = FormatPercentScore(dance_points):gsub("%%","")
					score = tonumber(percent)
					exScore = CalculateExScore(player)
				end
			end
			local pn = ToEnumShortString(player)
			players[pn] = {
				playerId = pn,
				profileName = profileName,
				screenName=screenName,
				ready=readyState[pn],

				judgments = judgments,
				score = score,
				exScore = exScore,
			}
		end
	end

	return {
		machine = {
			player1=players["P1"],
			player2=players["P2"]
		}
	}
end

local function OrderPlayers(data,localScreenName)
	local updatedData = {
		players = {},
		aux = {
			allInSameScreen = true,
			anyInGameplay = false,
			allPlayersReady = true
		}
	}
	updatedData.songInfo = data.songInfo
	local firstScreen = localScreenName
	for player in ivalues(data.players) do
		if firstScreen == nil then firstScreen = player.screenName end
		if player.screenName ~= firstScreen then updatedData.aux.allInSameScreen = false end
		if string.find(player.screenName,"ScreenGameplay") then updatedData.aux.anyInGameplay = true end
		if not player.ready then updatedData.aux.allPlayersReady = false end
		for screen in ivalues(scoreScreens) do
			if string.find(player.screenName,screen) then
				updatedData.players[#updatedData.players+1] = player
				break
			end
		end
	end
	table.sort(updatedData.players,function(a,b)
		if a.exScore == nil then return false end
		if b.exScore == nil then return true end
		return a.exScore > b.exScore
	end)
	for player in ivalues(data.players) do
		if firstScreen == nil then firstScreen = player.screenName end
		if player.screenName ~= firstScreen then updatedData.aux.allInSameScreen = false end
		if string.find(player.screenName,"ScreenGameplay") then updatedData.aux.anyInGameplay = true end
		if not player.ready then updatedData.aux.allPlayersReady = false end
		local inScoreScreen = false
		for screen in ivalues(scoreScreens) do
			if string.find(player.screenName,screen) then
				inScoreScreen = true
				break
			end
		end
		if not inScoreScreen then updatedData.players[#updatedData.players+1] = player end
	end

	return updatedData
end

local function DisplayLobbyState(data,actor)
	local screen = SCREENMAN:GetTopScreen()
	local screenName = screen and screen:GetName() or "NoScreen"
	local updatedData = OrderPlayers(data,screenName)
	local lines = {}
	if isWaiting then
		local readyToUnlock = false
		if string.find(screenName,"ScreenGameplay") then
			readyToUnlock = updatedData.aux.allInSameScreen and updatedData.aux.allPlayersReady
		elseif string.find(screenName,"ScreenEvaluation") then
			readyToUnlock = not updatedData.aux.anyInGameplay
		elseif string.find(screenName,"ScreenEvaluation") or string.find(screenName,"ScreenSelectMusic") then
			readyToUnlock = updatedData.aux.allInSameScreen
		else
			readyToUnlock = updatedData.aux.allPlayersReady
		end
		if string.find(screenName,"ScreenSelectMusic") and data.songInfo ~= nil then
			local anyInEval = false
			for _, player in ipairs(updatedData.players) do
				if string.find(screenName,"ScreenEvaluation") then
					anyInEval = true
					break
				end
			end
			if not anyInEval then readyToUnlock = true end
		end
		if readyToUnlock then
			isWaiting = false
			for player in ivalues(PlayerNumber) do SCREENMAN:set_input_redirected(player,false) end
			if string.find(screenName,"ScreenGameplay") then SCREENMAN:GetTopScreen():PauseGame(false) end
		else
			lines[#lines+1] = "Waiting for players to sync screens...\n"
			if string.find(screenName,"ScreenGameplay") then lines[#lines+1] = "Press &START; to ready up!\n" end
		end
	end
	for i, player in ipairs(updatedData.players) do
		local displayedScreen = player.screenName ~= "NoScreen" and player.screenName:gsub("Screen","") or "Transitioning"
		local readyText = ""
		if string.find(screenName,"ScreenGameplay") and not updatedData.aux.allPlayersReady then readyText =" ["..(player.ready and "Ready" or "Waiting").."]" end
		local playerAndScreen = i..'. '..player.profileName..readyText
		if screenName ~= player.screenName then playerAndScreen = playerAndScreen.." - in "..displayedScreen end
		lines[#lines+1] = playerAndScreen
		for scoreScreen in ivalues(scoreScreens) do
			if string.find(player.screenName,scoreScreen) then
				local score = (player.score ~= nil and player.score) or 0
				local exScore = (player.exScore ~= nil and player.exScore) or 0
				local scoreStr = string.format("%.2f",score).."%"
				local exScoreStr = string.format("%.2f",exScore).."%"
				lines[#lines+1] = "    "..scoreStr.." - "..exScoreStr.." EX"
				break
			end
		end
		lines[#lines+1] = ""
	end
	if data.songInfo ~= nil then
		if not songSelected then
			local topScreen = SCREENMAN:GetTopScreen()
			if topScreen and string.find(topScreen:GetName(),"ScreenSelectMusic") then
				local SongOrCourse = GAMESTATE:IsCourseMode() and SONGMAN:FindCourse(data.songInfo.songPath) or SONGMAN:FindSong(data.songInfo.songPath)
				local wheel = topScreen:GetMusicWheel()
				if not SongOrCourse and data.songInfo.songPath:split("/")[2] then
					if GAMESTATE:IsCourseMode() then
						SongOrCourse = SONGMAN:FindCourse(data.songInfo.songPath:split("/")[2])
					else
						SongOrCourse = SONGMAN:FindSong(data.songInfo.songPath:split("/")[2])
					end
				end
				if SongOrCourse and wheel then
					if GAMESTATE:IsCourseMode() then wheel:SelectCourse(SongOrCourse) else wheel:SelectSong(SongOrCourse) end
					wheel:Move(1)
					wheel:Move(-1)
					wheel:Move(0)
				end
			end
		else
			if string.find(screenName,"ScreenSelectMusic") then
				local pack = data.songInfo.songPath:split("/")[1] or "Unknown"
				local title = data.songInfo.title
				local artist = data.songInfo.artist
				local difficulty = data.songInfo.difficulty:split("_")[2]
				local maxLength = 30
				if #pack > maxLength then pack = string.sub(pack,1,maxLength) .. "..." end
				if #title > maxLength then title = string.sub(title,1,maxLength) .. "..." end
				if #artist > maxLength then artist = string.sub(artist,1,maxLength) .. "..." end
				lines[#lines+1] = "Pack: "..pack
				lines[#lines+1] = "Title: "..title
				lines[#lines+1] = "Artist: "..artist
				lines[#lines+1] = "Difficulty: "..difficulty
			end
		end
	end
	songSelected = (data.songInfo ~= nil)
	actor:GetChild("Display"):playcommand("UpdateText",{text=table.concat(lines,"\n")})
end

local function HandleResponse(response,actor)
	MESSAGEMAN:Broadcast("SetStatus",{text=""})
	local event = response.event
	local data = response.data
	if event == "lobbyState" then
		actor.inLobby = true
		DisplayLobbyState(data,actor)
		MESSAGEMAN:Broadcast("OnlineLobbyState",data or {})
	elseif event == "lobbySearched" then
		MESSAGEMAN:Broadcast("LobbySearched",{lobbies=data and data.lobbies or {}})
	elseif event == "lobbyLeft" then
		actor.inLobby = false
		MESSAGEMAN:Broadcast("OnlineLobbyLeft",data or {})
	elseif event == "clientDisconnected" then
		actor.inLobby = false
		MESSAGEMAN:Broadcast("OnlineClientDisconnected",data or {})
	elseif event == "responseStatus" then
		MESSAGEMAN:Broadcast("OnlineResponseStatus",data or {})
	end
end

local onlineHandler = nil
local onlineHandlerInstance = nil
local onlineHandlerShuttingDown = false

function isITGmaniaOnline()
	if isITGmania() then
		local onlineHandler = GetOnlineHandlerInstance()
		if onlineHandler and onlineHandler.connected then return onlineHandler.connected end
	end
	return false
end

function GetOnlineHandlerInstance() return onlineHandlerInstance end
function CreateOnlineHandler() 
	if onlineHandler == nil then
		onlineHandler = Def.ActorFrame{
			Name="OnlineWebsocketHandler",
			InitCommand=function(self)
				onlineHandlerInstance = self
				onlineHandlerShuttingDown = false
				self.socket = nil
				self.connected = false
				self.inLobby = false
				self.errorMsg = nil
			end,
			OffCommand=function(self)
				onlineHandlerShuttingDown = true
				if self.socket ~= nil then
					self.socket:Close()
					self.socket = nil
				end
				self.connected = false
				self.inLobby = false
				self.errorMsg = nil
				local display = self:GetChild("Display")
				if display then display:GetChild("Text"):settext("") end
				if onlineHandlerInstance == self then onlineHandlerInstance = nil end
			end,
			ConnectOnlineMessageCommand=function(self)
				if self.socket == nil or self.errorMsg ~= nil then
					onlineHandlerShuttingDown = false
					self.socket = NETWORK:WebSocket{
						url="ws://syncservice.groovestats.com:1337",
						pingInterval=15,
						handshakeTimeout=15,
						automaticReconnect=true,
						onMessage=function(msg)
							if onlineHandlerShuttingDown then return end
							local msgType = ToEnumShortString(msg.type)
							if msgType == "Open" then
								self.connected = true
								self.inLobby = false
								self.errorMsg = nil
								self:GetChild("Display"):visible(true)
							elseif msgType == "Message" then
								local response = JsonDecode(msg.data)
								HandleResponse(response,self)
							elseif msgType == "Close" then
								self.inLobby = false
								MESSAGEMAN:Broadcast("DisconnectOnline")
								self:GetChild("Display"):GetChild("Text"):settext("")
								self:GetChild("Display"):visible(false)
							elseif msgType == "Error" then
								self.inLobby = false
								self.errorMsg = msg.reason
								self:GetChild("Display"):GetChild("Text"):settext("")
								self:GetChild("Display"):visible(false)
							end
						end
					}
				end
			end,
			ScreenChangedMessageCommand=function(self)
				if self.connected and self.socket ~= nil then
					if not self.inLobby then return end
					local screen = SCREENMAN:GetTopScreen()
					local screenName = screen and screen:GetName() or "NoScreen"
					for screen in ivalues(knownDisconnectScreens) do
						if string.find(screenName,screen) then
							MESSAGEMAN:Broadcast("DisconnectOnline")
							return
						end
					end
					for screen in ivalues(syncLockScreens) do
						if string.find(screenName,screen) then
							isWaiting = true
							for player in ivalues(PlayerNumber) do SCREENMAN:set_input_redirected(player, true) end
						end
					end
					for screen in ivalues(autoReadyScreens) do
						if string.find(screenName,screen) then
							for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
								local pn = ToEnumShortString(player)
								readyState[pn] = true
							end
						end
					end
					if string.find(screenName,"ScreenGameplay") then
						for player in ivalues(GAMESTATE:GetEnabledPlayers()) do
							local pn = ToEnumShortString(player)
							readyState[pn] = false
						end
						SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
						SCREENMAN:GetTopScreen():PauseGame(true)
					elseif isWaiting then
						SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
					end
					MESSAGEMAN:Broadcast("UpdateMachineState")
				end
			end,
			PlayerJoinedMessageCommand=function(self)
				if self.connected and self.socket ~= nil and self.inLobby then	
					local request = CreateRequest("updateMachine",GetMachineState())
					self.socket:Send(request)
				end
			end,
			PlayerUnjoinedMessageCommand=function(self)
				if self.connected and self.socket ~= nil and self.inLobby then	
					local request = CreateRequest("updateMachine",GetMachineState())
					self.socket:Send(request)
				end
			end,
			UpdateMachineStateMessageCommand=function(self)
				if self.connected and self.socket ~= nil and self.inLobby then	
					local request = CreateRequest("updateMachine",GetMachineState())
					self.socket:Send(request)
				end
			end,
			SongSelectedMessageCommand=function(self)
				if self.connected and self.socket ~= nil and self.inLobby then
					local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
					local songPath = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseDir() or  SongOrCourse:GetSongDir()
					songPath = songPath:sub(8,#songPath-1)
					local artist = ""
					local length = 0
					local difficulty = ""
					if GAMESTATE:IsCourseMode() then
						local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
						if trail then
							local artists = trail:GetArtists()
							difficulty = trail:GetDifficulty()
							length = TrailUtil.GetTotalSeconds(trail)
							for i=1,#artists do
								if not string.find(artist,artists[i]) then
									artist = addToOutput(artist,artists[i],", ")
									if string.len(artist) >= 60 then
										artist = "Various Artists"
										break
									end
								end
							end
						end
					else
						difficulty = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()):GetDifficulty()
						artist = SongOrCourse:GetDisplayArtist()
						length = SongOrCourse:MusicLengthSeconds()
					end
					local data = {
						songInfo = {
							songPath=songPath,
							title=SongOrCourse:GetDisplayFullTitle(),
							artist=artist,
							difficulty=difficulty,
							songLength=length
						}
					}
					local request = CreateRequest("selectSong",data)
					local ret = self.socket:Send(request)
				end
			end,
			JoinLobbyMessageCommand=function(self,params)
				if self.connected and self.socket ~= nil then
					self.inLobby = false
					local data = GetMachineState()
					data.code = params.code and params.code
					data.password = params.password and params.password or ""
					local request = CreateRequest("joinLobby",data)
					self.socket:Send(request)
				end
			end,
			CreateLobbyMessageCommand=function(self,params)
				if self.connected and self.socket ~= nil then
					self.inLobby = false
					local data = GetMachineState()
					data.password = params.password and params.password or ""
					local request = CreateRequest("createLobby",data)
					self.socket:Send(request)
				end
			end,
			SearchLobbyMessageCommand=function(self)
				if self.connected and self.socket ~= nil then
					local request = CreateRequest("searchLobby",{})
					self.socket:Send(request)
				end
			end,
			LeaveLobbyMessageCommand=function(self)
				if self.connected and self.socket ~= nil then
					local request = CreateRequest("leaveLobby",{})
					self.socket:Send(request)
				end
			end,
			DisconnectOnlineMessageCommand=function(self)
				onlineHandlerShuttingDown = true
				isWaiting = false
				if self.socket ~= nil then self.socket:Close() end
				for player in ivalues(PlayerNumber) do SCREENMAN:set_input_redirected(player, false) end
				self.connected = false
				self.inLobby = false
				self.socket = nil
				self:GetChild("Display"):GetChild("Text"):settext("")
				self:GetChild("Display"):visible(false)
			end,
			Def.ActorFrame{
				Name="Display",
				InitCommand=function(self)
					self:visible(false)
					local width = -(SCREEN_WIDTH / 3)
					local LEFT = width/2
					self:xy(LEFT,_screen.cy)
				end,
				DisconnectOnlineMessageCommand=function(self) self:playcommand("Init") end,
				UpdateTextCommand=function(self,params)
					local screen = SCREENMAN:GetTopScreen()
					local screenName = screen and screen:GetName() or "NoScreen"
					local bg = self:GetChild("Background")
					local width = 200
					local height = SCREEN_HEIGHT
					local LEFT = width/2
					local RIGHT = SCREEN_WIDTH - width/2
					local CENTER = _screen.cx
					if string.find(screenName,"ScreenSelectMusic") then
						self:xy(LEFT,_screen.cy)
						bg:zoomto(width,height)
					elseif string.find(screenName,"ScreenEvaluation") or string.find(screenName,"ScreenGameplay") then
						local p1Joined = GAMESTATE:IsSideJoined("PlayerNumber_P1")
						local p2Joined = GAMESTATE:IsSideJoined("PlayerNumber_P2")
						if p1Joined and p2Joined then
							self:xy(CENTER,_screen.cy)
							bg:zoomto(width,height)
						elseif p1Joined then
							self:xy(RIGHT,_screen.cy)
							bg:zoomto(width,height)
						elseif p2Joined then
							self:xy(LEFT,_screen.cy)
							bg:zoomto(width,height)
						end
					elseif string.find(screenName,"ScreenOnlineLobbies") then
						bg:zoomto(0,0)
					end
					self:GetChild("Text"):playcommand("Resize",{width=width,height=height,text=params.text})
				end,
				Def.Quad{
					Name="Background",
					InitCommand=function(self) self:zoomto(SCREEN_WIDTH/3,SCREEN_HEIGHT):diffuse(0,0,0,0.5) end
				},
				Def.BitmapText{
					Font = "Common Normal",
					Name="Text",
					Text="",
					InitCommand=function(self) self:diffuse(Color.Yellow) end,
					ResizeCommand=function(self,params)
						self:settext(params.text)
						for zoomVal=1.0,0.1,-0.05 do
							self:zoom(zoomVal)
							self:settext(params.text)
							if self:GetWidth() * zoomVal <= params.width then break end
						end
					end
				}
			}
		}
	end

	return onlineHandler
end