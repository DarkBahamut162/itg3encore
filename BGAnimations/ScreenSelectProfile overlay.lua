local selected
local playerReady

if GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() then
	GAMESTATE:LoadProfiles()
end

function LoadCard(cColor)
	return Def.ActorFrame {
		Def.Sprite {
			Texture = THEME:GetPathG("frame","base"),
			InitCommand=function(self) self:diffuse(cColor):zoomy(0.5) end
		}
	}
end

local XML = { [PLAYER_1] = nil, [PLAYER_2] = nil }

function LoadProfile(Player,path)
	local xml = LoadXML(path)
	xml = split("\n",xml)
	for i=1,#xml do
		if xml[i]:match("^<") and xml[i]:match("</%w+>$") then
			local key, value = xml[i]:match("<(%w+)>(.-)</%w+>")
			if key and value then
				if not XML[Player] then XML[Player] = {} end
				XML[Player][key] = value
			end
		end
	end
end

function LoadPlayerStuff(Player)
	return Def.ActorFrame {
		Def.ActorFrame {
			Name = 'JoinFrame',
			LoadCard(PlayerColor(Player)),
			Def.BitmapText {
				File = "_r bold shadow 30px",
				Text="Press &START; to join",
				InitCommand=function(self) self:maxwidth(200):shadowlength(1) end,
				OnCommand=function(self) self:diffuseshift():effectcolor1(Color('White')):effectcolor2(color("0.5,0.5,0.5")) end
			}
		},
		Def.ActorFrame {
			Name = 'BigFrame',
			LoadCard(PlayerColor(Player)),
			Def.Sprite {
				Name="Background",
				Texture = THEME:GetPathG("frame","background"),
				InitCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(Player)):effectcolor2(PlayerColorSemi(Player)):zoomy(0.5):diffusealpha(0.5) end
			},
			Def.Sprite {
				Name="Left",
				Texture = THEME:GetPathG("frame","left"),
				InitCommand=function(self) self:diffuse(PlayerColor(Player)):diffusealpha(0):zoomy(0.5) end,
				["Left"..pname(Player).."MessageCommand"]=function(self) self:finishtweening():diffusealpha(1):decelerate(0.25):diffusealpha(0) end
			},
			Def.Sprite {
				Name="Right",
				Texture = THEME:GetPathG("frame","right"),
				InitCommand=function(self) self:diffuse(PlayerColor(Player)):diffusealpha(0):zoomy(0.5) end,
				["Right"..pname(Player).."MessageCommand"]=function(self) self:finishtweening():diffusealpha(1):decelerate(0.25):diffusealpha(0) end
			},
			Def.BitmapText {
				File = "Common Normal",
				Text = "Selecting...",
				InitCommand=function(self) self:maxwidth(200):y(-140):shadowlength(1):zoom(1/3) end,
				["Selected"..pname(Player).."MessageCommand"]=function(self) self:settext("Selected") end,
				["Unselected"..pname(Player).."MessageCommand"]=function(self) self:settext("Selecting...") end
			},
			Def.ActorFrame {
				InitCommand=function(self) self:y(-90) end,
				Def.Sprite {
					Name="Avatar",
					Texture = THEME:GetPathG("UserProfile","generic icon"),
					InitCommand=function(self) self:setsize(72,72) end,
					OnCommand=function(self) self:queuecommand("CheckAvatar") end,
					["Left"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("CheckAvatar") end,
					["Right"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("CheckAvatar") end,
					CheckAvatarCommand=function(self)
						local index = SCREENMAN:GetTopScreen():GetProfileIndex(Player)
						if index > 0 then
							local id = PROFILEMAN:GetLocalProfileIDFromIndex(index-1)
							local outfox = "/Save/LocalProfiles/"..id.."/OutFoxPrefs.ini"
							local avatar = LoadModule("Config.Load.lua")("AvatarImage",outfox)
							if avatar then
								self:Load(avatar):setsize(72,72)
							else
								local dir = "/Save/LocalProfiles/"..id
								local path = ActorUtil.ResolvePath(dir.."/avatar",1,true) or ActorUtil.ResolvePath(dir.."/profile picture",1,true)
								if path and ActorUtil.GetFileType(path) == "FileType_Bitmap" then
									self:Load(path):setsize(72,72)
								else
									self:Load(THEME:GetPathG("UserProfile","generic icon")):setsize(72,72)
								end
							end
						elseif index == 0 then
								local add = PREFSMAN:GetPreference("MemoryCardProfileSubdir")
								local dir = "@mc"..(Player == PLAYER_1 and "1" or "2").."/"..add
								local path = ActorUtil.ResolvePath(dir.."/avatar",1,true) or ActorUtil.ResolvePath(dir.."/profile picture",1,true)
								if path and ActorUtil.GetFileType(path) == "FileType_Bitmap" then
									self:Load(path):setsize(72,72)
								else
									self:Load(THEME:GetPathG("UserProfile","generic icon")):setsize(72,72)
								end
						else
							self:Load(THEME:GetPathG("UserProfile","generic icon")):setsize(72,72)
						end
					end
				},
				Def.Sprite {
					Name="Frame",
					Texture = THEME:GetPathG("_pane avatar/border",isFinal() and "final" or "normal")
				}
			},
			Def.ActorFrame {
				OnCommand=function(self) self:queuecommand("Update") end,
				["Left"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("Update") end,
				["Right"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("Update") end,
				UpdateCommand=function(self)
					local index = SCREENMAN:GetTopScreen():GetProfileIndex(Player)
					local values = ""
					local numbers = ""
					if index > 0 then
						local profile = PROFILEMAN:GetLocalProfileFromIndex(index-1)
						local num = profile:GetNumTotalSongsPlayed()
						values = addToOutput(values,"Song"..(num==1 and "" or "s").." Played","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalTapsAndHolds()
						values = addToOutput(values,"Tap"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalJumps()
						values = addToOutput(values,"Jump"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalHands()
						values = addToOutput(values,"Hand"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalHolds()
						values = addToOutput(values,"Hold"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalRolls()
						values = addToOutput(values,"Roll"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalLifts()
						values = addToOutput(values,"Lift"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = profile:GetTotalMines()
						values = addToOutput(values,"Mine"..(num==1 and "" or "s").." Caught","\n")
						numbers = addToOutput(numbers,num,"\n")
					elseif index == 0 then
						local add = PREFSMAN:GetPreference("MemoryCardProfileSubdir")
						if not XML[Player] then
							local path = "@mc"..(Player == PLAYER_1 and "1" or "2").."/"..add.."/Stats.xml"
							if FILEMAN:DoesFileExist(path) then
								LoadProfile(Player,path)
							end
						end
						local num = tonumber(XML[Player] and XML[Player].NumTotalSongsPlayed or 0)
						values = addToOutput(values,"Song"..(num==1 and "" or "s").." Played","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalTapsAndHolds or 0)
						values = addToOutput(values,"Tap"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalJumps or 0)
						values = addToOutput(values,"Jump"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalHands or 0)
						values = addToOutput(values,"Hand"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalHolds or 0)
						values = addToOutput(values,"Hold"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalRolls or 0)
						values = addToOutput(values,"Roll"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalLifts or 0)
						values = addToOutput(values,"Lift"..(num==1 and "" or "s").." Performed","\n")
						numbers = addToOutput(numbers,num,"\n")
						num = tonumber(XML[Player] and XML[Player].TotalMines or 0)
						values = addToOutput(values,"Mine"..(num==1 and "" or "s").." Caught","\n")
						numbers = addToOutput(numbers,num,"\n")
					end
					self:GetChild("Values"):settext(values)
					self:GetChild("Numbers"):settext(numbers)
				end,
				Def.BitmapText {
					Name = "Values",
					File = "Common Normal",
					InitCommand=function(self) self:x(-30):y(80):shadowlength(1):maxwidth(260):maxheight(250):zoom(0.5):halign(0):vertspacing(-6) end
				},
				Def.BitmapText {
					Name = "Numbers",
					File = "Common Normal",
					InitCommand=function(self) self:x(-35):y(80):shadowlength(1):maxwidth(130):maxheight(250):zoom(0.5):halign(1):vertspacing(-6) end
				}
			},
			Def.BitmapText {
				File = "Common Normal",
				InitCommand=function(self) self:y(-30):shadowlength(1):maxwidth(400):maxheight(60):zoomx(1/3):zoomy(0.5) end,
				OnCommand=function(self) self:queuecommand("Update") end,
				["Left"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("Update") end,
				["Right"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("Update") end,
				UpdateCommand=function(self)
					local index = SCREENMAN:GetTopScreen():GetProfileIndex(Player)
					local output = ""
					if index > 0 then
						local profile = PROFILEMAN:GetLocalProfileFromIndex(index-1)
						local num = profile:GetTotalSessions()
						output = addToOutput(output,num.." Session"..(num==1 and "" or "s").." Played","\n")
						num = profile:GetTotalGameplaySeconds()
						output = addToOutput(output,TotalTime(num).." (Gameplay)","\n")
						num = profile:GetTotalSessionSeconds()
						output = addToOutput(output,TotalTime(num).." (Session)","\n")
					elseif index == 0 then
						local add = PREFSMAN:GetPreference("MemoryCardProfileSubdir")
						if not XML[Player] then
							local path = "@mc"..(Player == PLAYER_1 and "1" or "2").."/"..add.."/Stats.xml"
							if FILEMAN:DoesFileExist(path) then
								LoadProfile(Player,path)
							end
						end
						local num = tonumber(XML[Player] and XML[Player].TotalSessions or 0)
						output = addToOutput(output,num.." Session"..(num==1 and "" or "s").." Played","\n")
						num = tonumber(XML[Player] and XML[Player].TotalGameplaySeconds or 0)
						output = addToOutput(output,TotalTime(num).." (Gameplay)","\n")
						num = tonumber(XML[Player] and XML[Player].TotalSessionSeconds or 0)
						output = addToOutput(output,TotalTime(num).." (Session)","\n")
					end
					self:settext(output)
				end
			},
			Def.BitmapText {
				File = "Common Normal",
				InitCommand=function(self) self:y(160):shadowlength(1):maxwidth(200) end,
				OnCommand=function(self) self:queuecommand("Update") end,
				["Left"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("Update") end,
				["Right"..pname(Player).."MessageCommand"]=function(self) self:queuecommand("Update") end,
				UpdateCommand=function(self)
					local selection = ""
					local memoryCheck = MEMCARDMAN:GetCardState(Player) == 'MemoryCardState_none' and 1 or 0
					for i=memoryCheck,PROFILEMAN:GetNumLocalProfiles() do
						selection = addToOutput(selection,i == 0 and "·" or "•","")
					end
					self:settext(selection):ClearAttributes()

					local index = SCREENMAN:GetTopScreen():GetProfileIndex(Player)
					if index >= 0 then
						self:AddAttribute(index-memoryCheck, {
							Length = 1,
							Diffuse = PlayerColor(Player)
						})
					end
				end
			}
		},
		Def.BitmapText {
			File = "_r bold shadow 30px",
			Name = 'SelectedProfileText',
			InitCommand=function(self) self:y(0):maxwidth(200):shadowlength(1) end
		}
	}
end

function UpdateInternal3(self,Player)
	local pn = (Player == PLAYER_1) and 1 or 2
	local frame = self:GetChild(string.format('P%uFrame',pn))
	local seltext = frame:GetChild('SelectedProfileText')
	local joinframe = frame:GetChild('JoinFrame')
	local bigframe = frame:GetChild('BigFrame')

	if GAMESTATE:IsHumanPlayer(Player) then
		frame:visible(true)
		joinframe:visible(false)
		bigframe:visible(true)
		seltext:visible(true):y(0)
		local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player)
		if ind > 0 then
			seltext:settext(PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetDisplayName())
		elseif ind == 0 then
			local name = ""
			local add = PREFSMAN:GetPreference("MemoryCardProfileSubdir")
			local path = "@mc"..(Player == PLAYER_1 and "1" or "2").."/"..add.."/Editable.ini"
			if FILEMAN:DoesFileExist(path) then
				local file = IniFile.ReadFile(path)
				if file.Editable.DisplayName then name = file.Editable.DisplayName end
			end
			if name == "" then name = "NoName" end
			seltext:settext(name)
		else
			if SCREENMAN:GetTopScreen():SetProfileIndex(Player,1) then
				self:queuecommand('UpdateInternal2')
			else
				joinframe:visible(true)
				bigframe:visible(false)
				seltext:settext('No profile'):y(32)
			end
		end
	else
		joinframe:visible(true)
		seltext:visible(false)
		bigframe:visible(false)
	end
end

local InputHandler =function(event)
	if not event.PlayerNumber then return end
	if event.type == "InputEventType_FirstPress" then
		if GAMESTATE:IsHumanPlayer(event.PlayerNumber) then
			if event.GameButton == "MenuLeft" or event.GameButton == "MenuUp" or event.GameButton == "Left" or event.GameButton == "Up" or event.GameButton == "UpLeft" or event.GameButton == "DownLeft" then
				if playerReady and playerReady == event.PlayerNumber then return end
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(event.PlayerNumber)
				local memoryCheck = MEMCARDMAN:GetCardState(event.PlayerNumber) ~= 'MemoryCardState_none'
				if ind > (memoryCheck and 0 or 1) then
					if SCREENMAN:GetTopScreen():SetProfileIndex(event.PlayerNumber,ind-1) then
						MESSAGEMAN:Broadcast("DirectionButton")
						MESSAGEMAN:Broadcast("Left"..pname(event.PlayerNumber))
					end
				end
			elseif event.GameButton == "MenuRight" or event.GameButton == "MenuDown" or event.GameButton == "Right" or event.GameButton == "Down" or event.GameButton == "UpRight" or event.GameButton == "DownRight" then
				if playerReady and playerReady == event.PlayerNumber then return end
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(event.PlayerNumber)
				local memoryCheck = MEMCARDMAN:GetCardState(event.PlayerNumber) ~= 'MemoryCardState_none'
				if ind >= 0 or memoryCheck then
					if SCREENMAN:GetTopScreen():SetProfileIndex(event.PlayerNumber,ind+1) then
						MESSAGEMAN:Broadcast("DirectionButton")
						MESSAGEMAN:Broadcast("Right"..pname(event.PlayerNumber))
					end
				end
			elseif event.GameButton == "Start" or event.GameButton == "Center" then
				if not selected then
					MESSAGEMAN:Broadcast("Selected"..pname(event.PlayerNumber))
					selected = SCREENMAN:GetTopScreen():GetProfileIndex(event.PlayerNumber)
					playerReady = event.PlayerNumber
				elseif selected and selected == SCREENMAN:GetTopScreen():GetProfileIndex(event.PlayerNumber) then
					if playerReady and playerReady == event.PlayerNumber then
						if GAMESTATE:GetNumPlayersEnabled()==2 then return end
					else
						SOUND:PlayOnce( THEME:GetPathS( 'MemoryCardManager', "error" ) )
						return
					end
				end
				MESSAGEMAN:Broadcast("StartButton")
				SCREENMAN:GetTopScreen():Finish()
			elseif event.GameButton == "Back" then
				if playerReady and playerReady == event.PlayerNumber then
					MESSAGEMAN:Broadcast("Unselected"..pname(event.PlayerNumber))
					playerReady = nil
					selected = nil
				end
				MESSAGEMAN:Broadcast("BackButton")
				SCREENMAN:GetTopScreen():SetProfileIndex(event.PlayerNumber,-2)
			end
		else
			if event.GameButton == "Start" or event.GameButton == "Center" then
				MESSAGEMAN:Broadcast("StartButton")
				MESSAGEMAN:Broadcast("Left"..pname(event.PlayerNumber))
				MESSAGEMAN:Broadcast("Right"..pname(event.PlayerNumber))
				SCREENMAN:GetTopScreen():SetProfileIndex(event.PlayerNumber,-1)
			elseif event.GameButton == "Back" then
				if GAMESTATE:GetNumPlayersEnabled()==0 then
					SCREENMAN:GetTopScreen():Cancel()
				end
			end
		end
	end
end

return Def.ActorFrame {
	StorageDevicesChangedMessageCommand=function(self) self:queuecommand('UpdateInternal2') end,
	PlayerJoinedMessageCommand=function(self) self:queuecommand('UpdateInternal2') end,
	PlayerUnjoinedMessageCommand=function(self) self:queuecommand('UpdateInternal2') end,
	DirectionButtonMessageCommand=function(self) self:queuecommand('UpdateInternal2') end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
		self:queuecommand('UpdateInternal2')
	end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	UpdateInternal2Command=function(self)
		UpdateInternal3(self,PLAYER_1)
		UpdateInternal3(self,PLAYER_2)
	end,
	children = {
		Def.ActorFrame {
			Name = 'P1Frame',
			InitCommand=function(self) self:x(SCREEN_CENTER_X-160):y(SCREEN_CENTER_Y) end,
			OnCommand=function(self) self:zoom(0):bounceend(0.35):zoom(1) end,
			OffCommand=function(self) self:bouncebegin(0.35):zoom(0) end,
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then self:zoom(1.15):bounceend(0.175):zoom(1.0) end
			end,
			children = LoadPlayerStuff(PLAYER_1)
		},
		Def.ActorFrame {
			Name = 'P2Frame',
			InitCommand=function(self) self:x(SCREEN_CENTER_X+160):y(SCREEN_CENTER_Y) end,
			OnCommand=function(self) self:zoom(0):bounceend(0.35):zoom(1) end,
			OffCommand=function(self) self:bouncebegin(0.35):zoom(0) end,
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then self:zoom(1.15):bounceend(0.175):zoom(1.0) end
			end,
			children = LoadPlayerStuff(PLAYER_2)
		},
		Def.Sound {
			File = THEME:GetPathS("Common","start"),
			StartButtonMessageCommand=function(self) self:play() end
		},
		Def.Sound {
			File = THEME:GetPathS("Common","cancel"),
			BackButtonMessageCommand=function(self) self:play() end
		},
		Def.Sound {
			File = THEME:GetPathS("Common","value"),
			DirectionButtonMessageCommand=function(self) self:play() end
		}
	}
}