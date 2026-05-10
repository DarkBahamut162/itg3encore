local selecting = false
local selection = {}
local selected = 0
local searching = false
local search = ""
local change = { PLAYER_1 = false, PLAYER_2 = false }
local specialHeld = false
local baselink = "https://stepmaniaonline.net/download/pack/"
local reload = false

local InputHandler = function(event)
	if selecting then
		if string.find(event.DeviceInput.button,"shift") then
			if event.type == "InputEventType_FirstPress" then
				if not specialHeld then specialHeld = true end
			elseif event.type == "InputEventType_Release" then
				if specialHeld then specialHeld = false end
			end
		end
		if event.type == "InputEventType_FirstPress" then
			if event.DeviceInput.button == "DeviceButton_s" or event.DeviceInput.button == "DeviceButton_f" then
				if not specialHeld then return end 
				SCREENMAN:PlayStartSound()
				SCREENMAN:AddNewScreenToTop("ScreenTextEntry")
				selection = {}
				local question = {
					Question = "What should be searched?",
					MaxInputLength = 255,
					OnOK = function(answer)
						search = answer
						for pack in ivalues(PackList) do
							if string.find(string.lower(pack[2]),answer) then
								table.insert(selection,pack)
							end
						end
						if #selection == 0 then
							selection = PackList
							SCREENMAN:SystemMessage("No Packs Found!")
							SCREENMAN:PlayCancelSound()
						else
							table.sort(selection, function(a, b)
								return a[2]:lower() < b[2]:lower()
							end)
							searching = true
						end
						selected = 0
						MESSAGEMAN:Broadcast("Change")
					end,
					Validate = function(answer,errorOut)
						if answer == "" then return false, "Must Contain Text!" else return true, "" end
					end,
					OnCancel = function() selection = PackList SCREENMAN:PlayCancelSound() end
				}
				SCREENMAN:GetTopScreen():Load(question)
			end
		end
		if event.type == "InputEventType_FirstPress" or event.type == "InputEventType_Repeat" then
			if event.GameButton == "MenuLeft" or event.GameButton == "MenuUp" then
				SOUND:PlayOnce( THEME:GetPathS("ScreenOptions","next") )
				selected = selected - 1
				MESSAGEMAN:Broadcast("Change")
			elseif event.GameButton == "MenuRight" or event.GameButton == "MenuDown" then
				SOUND:PlayOnce( THEME:GetPathS("ScreenOptions","next") )
				selected = selected + 1
				MESSAGEMAN:Broadcast("Change")
			elseif event.GameButton == "Back" then
				if searching then
					searching = false
					selection = PackList
					MESSAGEMAN:Broadcast("Change")
					SCREENMAN:PlayCancelSound()
				else
					selecting = false
					if reload then
						SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
						SCREENMAN:PlayStartSound()
					else
						SCREENMAN:GetTopScreen():Cancel()
					end
				end
			elseif event.GameButton == "Start" then
				local current = (selected % #selection)+1
				if FindInTable(selection[current][2],FILEMAN:GetDirListing("/Songs/")) then selection[current][9] = true end
				if not selection[current][9] then
					selecting = false
					SCREENMAN:PlayStartSound()
					local url = baselink..selection[current][1].."/"
					NETWORK:HttpRequest{
						url=url,
						downloadFile=selection[current][1]..".zip",
						onProgress=function(currentBytes,totalBytes) MESSAGEMAN:Broadcast("Download",{currentBytes=currentBytes,totalBytes=totalBytes}) end,
						onResponse=function(response)
							if response.error ~= nil then
								MESSAGEMAN:Broadcast("Error",{Error=response.errorMessage})
								return
							end
							if response.statusCode == 200 then
								if response.headers["Content-Type"] == "application/zip" then
									if not FILEMAN:Unzip("/Downloads/"..selection[current][1]..".zip","/Songs/") then
										SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
										MESSAGEMAN:Broadcast("DownloadError")
									else
										MESSAGEMAN:Broadcast("DownloadDone")
										reload = true
										selection[current][9] = true
									end
								else
									SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
									MESSAGEMAN:Broadcast("DownloadNoZip")
								end
							else
								SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
								MESSAGEMAN:Broadcast("NetworkError",{Code=response.statusCode})
							end
							selecting = true
						end
					}
				else
					MESSAGEMAN:Broadcast("AlreadyDownloaded")
					SOUND:PlayOnce( THEME:GetPathS( 'Common', "invalid" ) )
				end
			end
		end
	end
end

return Def.ActorFrame{
	OnCommand=function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
		if #PackList == 0 then
			NETWORK:HttpRequest{
				url="https://stepmaniaonline.net/api/packs",
				onProgress=function(currentBytes,totalBytes) MESSAGEMAN:Broadcast("Percent",{currentBytes=currentBytes,totalBytes=totalBytes}) end,
				onResponse=function(response)
					if response.error ~= nil then
						MESSAGEMAN:Broadcast("Error",{Error=response.errorMessage})
						return
					end
					local output = split("\n",response.body)
					local lines = 0
					for line in ivalues(output) do
						local splits = split(", ",line)
						for i,single in ipairs(splits) do
							if single:sub(1,1) == '"' then
								if single:sub(2,2) == '/' then
									splits[i] = single:sub(0,-0)
								else
									splits[i] = single:sub(2,-2)
								end
							end
						end
						lines = lines + 1
						if lines == 1 then
							PackListHeader = splits
						else
							if #PackListHeader == #splits then PackList[#PackList+1] = splits end
						end
					end
					selection = PackList
					MESSAGEMAN:Broadcast("Change")
					selecting = true
				end
			}
		else
			selection = PackList
			MESSAGEMAN:Broadcast("Change")
			selecting = true
		end
	end,
	OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback(InputHandler) end,
	Def.ActorFrame{
		Name="Slots",
		ChangeMessageCommand=function(self)
			for i=1,9 do
				local current = ((i-4+selected-1) % #selection)+1
				self:GetChild("Slots"):GetChild("Slot"..i):settext(selection[current] and selection[current][2] or "???")
			end

			local display = (selected % #selection)+1

			self:GetChild("Slots"):GetChild("DownloadName"):settext("")
			self:GetChild("Slots"):GetChild("DownloadValue"):settext("")
			self:GetChild("Slots"):GetChild("ResultName"):settext("Result:")
			self:GetChild("Slots"):GetChild("ResultValue"):settext(display.."/"..#selection)
			self:GetChild("Slots"):GetChild("Value0"):settext(selection[display][1])
			self:GetChild("Slots"):GetChild("Value1"):settext(selection[display][2])
			self:GetChild("Slots"):GetChild("Value2"):settext(selection[display][3])
			self:GetChild("Slots"):GetChild("Value3"):settext(selection[display][4].."Bytes ("..math.round(selection[display][4]/1024/1024,2).."MB)")
			self:GetChild("Slots"):GetChild("Value4"):settext(selection[display][5])
			self:GetChild("Slots"):GetChild("Value5"):settext(selection[display][6])
			self:GetChild("Slots"):GetChild("Value6"):settext(selection[display][7])
			self:GetChild("Slots"):GetChild("ValueName0"):settext(PackListHeader[1])
			self:GetChild("Slots"):GetChild("ValueName1"):settext(PackListHeader[2])
			self:GetChild("Slots"):GetChild("ValueName2"):settext(PackListHeader[3])
			self:GetChild("Slots"):GetChild("ValueName3"):settext(PackListHeader[4])
			self:GetChild("Slots"):GetChild("ValueName4"):settext(PackListHeader[5])
			self:GetChild("Slots"):GetChild("ValueName5"):settext(PackListHeader[6])
			self:GetChild("Slots"):GetChild("ValueName6"):settext(PackListHeader[7])
		end,
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenOptions","page/search page"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenOptions","overlay/_frame"),
			InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenSelectMusic","Triangle/glow"),
			InitCommand=function(self) self:xy(SCREEN_CENTER_X-272,SCREEN_CENTER_Y-7):zoomx(-1):halign(0) end
		},
		Def.ActorFrame{
			Name="Slots",
			Def.BitmapText {
				File = "_v 26px bold white",
				Text="Packlist:",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y-130*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				File = "_v 26px bold white",
				Text="Stepmania Online",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y-130*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ResultName",
				File = "_v 26px bold white",
				Text="Loading:",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y-110*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ResultValue",
				File = "_v 26px bold white",
				Text="0%",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y-110*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end,
				PercentMessageCommand=function(self,param) self:settext(math.floor((param.currentBytes/param.totalBytes)*100).."%") end
			},
			Def.BitmapText {
				Name="DownloadName",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y-90*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end,
				DownloadMessageCommand=function(self,param) self:settext("Download:") end
			},
			Def.BitmapText {
				Name="DownloadValue",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y-90*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end,
				ErrorMessageCommand=function(self,param) self:settext(param.Error) end,
				DownloadMessageCommand=function(self,param) self:settext(math.round((param.currentBytes/param.totalBytes)*100,2).."%") end,
				DownloadDoneMessageCommand=function(self) self:settext("Done!") end,
				DownloadErrorMessageCommand=function(self) self:settext("Failed to Unzip!") end,
				DownloadNoZipMessageCommand=function(self) self:settext("Download is not a Zip!") end,
				NetworkErrorMessageCommand=function(self,param) self:settext("Network Error "..param.Code) end,
				AlreadyDownloadedMessageCommand=function(self) self:settext("Pack is already downloaded!") end
			},
			Def.BitmapText {
				Name="ValueName0",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y-20*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value0",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y-20*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ValueName1",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value1",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ValueName2",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y+20*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value2",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y+20*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ValueName3",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y+40*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value3",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y+40*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ValueName4",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y+60*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value4",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y+60*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ValueName5",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value5",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y+80*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="ValueName6",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+7.5*WideScreenDiff(),SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(100*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Value6",
				File = "_v 26px bold white",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X+77.5*WideScreenDiff(),SCREEN_CENTER_Y+100*WideScreenDiff()):zoom(2/3*WideScreenDiff()):maxwidth(320*WideScreenDiff()):valign(0):halign(0):shadowlength(0):vertspacing(-3) end
			},
			Def.BitmapText {
				Name="Slot1",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-119*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot2",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-91*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot3",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-63*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot4",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-35*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot5",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y-7*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3) end,
				OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#808080")) end
			},
			Def.BitmapText {
				Name="Slot6",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+21*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot7",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+49*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot8",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+77*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			},
			Def.BitmapText {
				Name="Slot9",
				File = "_v 26px bold white",
				Text="Loading...",
				InitCommand=function(self) self:xy(SCREEN_CENTER_X-272*WideScreenDiff(),SCREEN_CENTER_Y+105*WideScreenDiff()):zoom(WideScreenDiff()):maxwidth(265*WideScreenDiff()):halign(0):shadowlength(0):vertspacing(-3):diffuse(color(".5,.5,.5,1")) end
			}
		}
	}
}