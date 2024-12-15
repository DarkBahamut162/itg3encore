if isTopScreen("ScreenDemonstration2") or isTopScreen("ScreenDemonstration") then return Def.ActorFrame{} end

local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local filterColor = color("0.135,0.135,0.135,1")
local filterAlphas = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1,
	Default = 0
}

local t = Def.ActorFrame{}
local style = GAMESTATE:GetCurrentStyle()
local styleType = ToEnumShortString(style:GetStyleType())
local stepsType = ToEnumShortString(style:GetStepsType())
local stepsTypeNumber = tonumber(string.match(stepsType, "%d+"))
local gameMode = GAMESTATE:GetCurrentGame():GetName()
local special = false

function getFilter(player,filterWidth,filterAlpha)
	if filterAlpha == nil then filterAlpha = 0 end
	if not isOutFox() then filterWidth = filterWidth * math.min(1,NotefieldZoom()) end
	if isOutFox() then filterWidth = filterWidth * math.min(1,NotefieldZoomOutFox()) end

	local file = ""
	local pomuREST = ""
	if isOutFoxV() then
		if gameMode == "be-mu" then
			special = true
			if stepsTypeNumber == 5 then
				file = stepsTypeNumber .. " "
			elseif stepsTypeNumber == 6 then
				file = (stepsTypeNumber-1) .. "p"
			elseif stepsTypeNumber == 7 then
				file = stepsTypeNumber .. pname(player)
			end
		elseif gameMode == "po-mu" then
			pomuREST = split('_', stepsType)[2]
			special = true
			if pomuREST == "Three" then
				file = 3
			elseif pomuREST == "Four" then
				file = 4
				special = false
			elseif pomuREST == "Five" then
				file = 5
			elseif pomuREST == "Seven" then
				file = 7
			elseif pomuREST == "Nine" then
				file = 9
			end
			file = file .. "Light"
		end
	end
	if special and FILEMAN:DoesFileExist("/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file) then
		if isDouble() then
			local file2 = (gameMode == "be-mu" and stepsTypeNumber == 7) and "7P2" or file
			local repos = 0
			if gameMode == "be-mu" and stepsTypeNumber == 7 then repos = 30 elseif gameMode == "po-mu" and pomuREST == "Nine" then repos = 15 end
			return Def.ActorFrame{
				Def.Sprite {
					Texture = "/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file,
					InitCommand=function(self) self:x((-filterWidth/4)-repos):zoomto(filterWidth/2,SCREEN_HEIGHT*4):diffusealpha(filterAlpha) end
				},
				Def.Sprite {
					Texture = "/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file2,
					InitCommand=function(self) self:x((filterWidth/4)+repos):zoomto(filterWidth/2,SCREEN_HEIGHT*4):diffusealpha(filterAlpha) end
				}
			}
		else
			return Def.Sprite {
				Texture = "/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file,
				InitCommand=function(self) self:zoomto(filterWidth,SCREEN_HEIGHT*4):diffusealpha(filterAlpha) end
			}
		end
	else
		return Def.Quad{
			InitCommand=function(self) self:zoomto(filterWidth,SCREEN_HEIGHT*4):diffusecolor(filterColor):diffusealpha(filterAlpha) end
		}
	end
end

if numPlayers == 1 then
	local player = GAMESTATE:GetMasterPlayerNumber()
	local filterAlpha = tonumber(getenv("ScreenFilter"..pname(player)))

	local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
	local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
	local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
	currentMini = currentMini * currentTiny
	local filterWidth = style:GetWidth(player) * currentMini

	if getenv("Effect"..pname(player)) == 1 then filterWidth = filterWidth + (30 * currentMini) end

	local pos
	local metricName = string.format("Player%s%sX",pname(player),styleType)
	pos = THEME:GetMetric("ScreenGameplay",metricName)

	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self) self:x(pos):CenterY() end,
		OnCommand=function(self)
			if getenv("Rotation"..pname(player)) == 2 then
				self:rotationz(-90)
				self:y(SCREEN_CENTER_Y)
			elseif getenv("Rotation"..pname(player)) == 3 then
				self:rotationz(90)
				self:y(SCREEN_CENTER_Y)
			elseif getenv("Rotation"..pname(player)) == 4 then
				self:rotationz(180)
				self:y(SCREEN_CENTER_Y)
			elseif getenv("Rotation"..pname(player)) == 5 then
				self:CenterX()
			end

			if getenv("Effect"..pname(player)) == 2 then
				self:spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
			elseif getenv("Effect"..pname(player)) == 3 then
				self:spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
			elseif getenv("Effect"..pname(player)) == 4 then
				self:bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
			elseif getenv("Effect"..pname(player)) == 5 then
				self:pulse():effectclock('beat')
			elseif getenv("Effect"..pname(player)) == 6 then
				self:wag():effectclock('beat')
			end
		end,
		getFilter(player,filterWidth,filterAlpha),
		loadfile(THEME:GetPathB("ScreenGameplay","underlay/SpeedAssist"))(player),
		loadfile(THEME:GetPathB("ScreenGameplay","underlay/StopAssist"))(player)
	}
else
	if styleType == "TwoPlayersSharedSides" then
		local player = GAMESTATE:GetMasterPlayerNumber()
		local metricName = "Player".. pname(player) .."TwoPlayersSharedSidesX"
		filterAlphas[player] = tonumber(getenv("ScreenFilter"..pname(player)))

		local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
		local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
		local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
		currentMini = currentMini * currentTiny
		local filterWidth = style:GetWidth(player) * currentMini

		if getenv("Effect"..pname(player)) == 1 then filterWidth = filterWidth + (30 * currentMini) end

		t[#t+1] = Def.Quad{
			Name="RoutineFilter",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay",metricName)):CenterY():zoomto(filterWidth,SCREEN_HEIGHT*4):diffusecolor(filterColor):diffusealpha(filterAlphas[player]) end,
			OnCommand=function(self)
				if getenv("Rotation"..pname(player)) == 2 then
					self:rotationz(-90):y(SCREEN_CENTER_Y+8)
				elseif getenv("Rotation"..pname(player)) == 3 then
					self:rotationz(90):y(SCREEN_CENTER_Y+8)
				elseif getenv("Rotation"..pname(player)) == 4 then
					self:y(SCREEN_CENTER_Y+20)
				end

				if getenv("Effect"..pname(player)) == 2 then
					self:spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
				elseif getenv("Effect"..pname(player)) == 3 then
					self:spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
				elseif getenv("Effect"..pname(player)) == 4 then
					self:bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
				elseif getenv("Effect"..pname(player)) == 5 then
					self:pulse():effectclock('beat')
				elseif getenv("Effect"..pname(player)) == 6 then
					self:wag():effectclock('beat')
				end
			end
		}
	else
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			filterAlphas[player] = tonumber(getenv("ScreenFilter"..pname(player)))

			local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
			local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
			local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
			currentMini = currentMini * currentTiny
			local filterWidth = style:GetWidth(player) * currentMini

			if getenv("Effect"..pname(player)) == 1 then filterWidth = filterWidth + (30 * currentMini) end

			local metricName = string.format("Player%s%sX",pname(player),styleType)
			local pos = THEME:GetMetric("ScreenGameplay",metricName)

			t[#t+1] = Def.ActorFrame{
				InitCommand=function(self) self:x(pos):CenterY() end,
				OnCommand=function(self)
					if getenv("Rotation"..pname(player)) == 2 then
						self:rotationz(-90)
						self:y(SCREEN_CENTER_Y+10)
					elseif getenv("Rotation"..pname(player)) == 3 then
						self:rotationz(90)
						self:y(SCREEN_CENTER_Y+10)
					elseif getenv("Rotation"..pname(player)) == 4 then
						self:y(0)
					end
		
					if getenv("Effect"..pname(player)) == 2 then
						self:spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
					elseif getenv("Effect"..pname(player)) == 3 then
						self:spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
					elseif getenv("Effect"..pname(player)) == 4 then
						self:bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
					elseif getenv("Effect"..pname(player)) == 5 then
						self:pulse():effectclock('beat')
					elseif getenv("Effect"..pname(player)) == 6 then
						self:wag():effectclock('beat')
					end
				end,
				getFilter(player,filterWidth,filterAlphas[player]),
				loadfile(THEME:GetPathB("ScreenGameplay","underlay/SpeedAssist"))(player),
				loadfile(THEME:GetPathB("ScreenGameplay","underlay/StopAssist"))(player)
			}
		end
	end
end

return t