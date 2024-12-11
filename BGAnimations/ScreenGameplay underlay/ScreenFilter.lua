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
local doubles = (styleType == 'OnePlayerTwoSides' or styleType == 'TwoPlayersSharedSides')

function getFilter(player,filterWidth,filterAlpha)
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
		if doubles then
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
	local pNum = (player == PLAYER_1) and 1 or 2
	local filterAlpha = tonumber(getenv("ScreenFilterP"..pNum))

	local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
	local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
	local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(player) * currentMini or style:GetWidth(player) * currentMini

	if string.find(style:GetName(),"double") then
		if IsGame("be-mu") or IsGame("beat") then
			if stepsTypeNumber == 5 then
				filterWidth = filterWidth * 1.3
			elseif stepsTypeNumber == 6 then
				filterWidth = filterWidth * 1.5
			elseif stepsTypeNumber == 7 then
				filterWidth = filterWidth * 1.625
			end
		elseif IsGame("pump") then
			filterWidth = filterWidth * 1.35
		elseif IsGame("smx") then
			filterWidth = filterWidth * 1.45
		elseif IsGame("po-mu") then
			filterWidth = filterWidth * 1.575
		elseif IsGame("techno") then
			filterWidth = filterWidth * 1.8375
		else
			filterWidth = filterWidth * 1.4
		end
	end
	if getenv("EffectVibrateP"..pNum) then filterWidth = filterWidth + (30 * currentMini) end

	local pos
	local metricName = string.format("PlayerP%i%sX",pNum,styleType)
	pos = THEME:GetMetric("ScreenGameplay",metricName)

	t[#t+1] = Def.ActorFrame{
		InitCommand=function(self) self:x(pos):CenterY() end,
		OnCommand=function(self)
			if getenv("RotationLeftP"..pNum) then
				self:rotationz(-90)
				self:y(SCREEN_CENTER_Y)
			elseif getenv("RotationRightP"..pNum) then
				self:rotationz(90)
				self:y(SCREEN_CENTER_Y)
			elseif getenv("RotationUpsideDownP"..pNum) then
				self:rotationz(180)
				self:y(SCREEN_CENTER_Y)
			elseif getenv("RotationSoloP"..pNum) then
				self:CenterX()
			end

			if getenv("EffectVibrateP"..pNum) then
			elseif getenv("EffectSpinP"..pNum) then
				self:spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
			elseif getenv("EffectSpinReverseP"..pNum) then
				self:spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
			elseif getenv("EffectBounceP"..pNum) then
				self:bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
			elseif getenv("EffectPulseP"..pNum) then
				self:pulse():effectclock('beat')
			elseif getenv("EffectWagP"..pNum) then
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
		local pNum = player == PLAYER_1 and 1 or 2
		local metricName = "PlayerP".. pNum .."TwoPlayersSharedSidesX"
		filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum))

		local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
		local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
		local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(player) * currentMini or style:GetWidth(player) * currentMini

		if getenv("EffectVibrateP"..pNum) then filterWidth = filterWidth + (30 * currentMini) end

		t[#t+1] = Def.Quad{
			Name="RoutineFilter",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay",metricName)):CenterY():zoomto(filterWidth,SCREEN_HEIGHT*4):diffusecolor(filterColor):diffusealpha(filterAlphas[player]) end,
			OnCommand=function(self)
				if getenv("RotationLeftP"..pNum) then
					self:rotationz(-90):y(SCREEN_CENTER_Y+8)
				elseif getenv("RotationRightP"..pNum) then
					self:rotationz(90):y(SCREEN_CENTER_Y+8)
				elseif getenv("RotationUpsideDownP"..pNum) then
					self:y(SCREEN_CENTER_Y+20)
				end

				if getenv("EffectVibrateP"..pNum) then
				elseif getenv("EffectSpinP"..pNum) then
					self:spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
				elseif getenv("EffectSpinReverseP"..pNum) then
					self:spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
				elseif getenv("EffectBounceP"..pNum) then
					self:bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
				elseif getenv("EffectPulseP"..pNum) then
					self:pulse():effectclock('beat')
				elseif getenv("EffectWagP"..pNum) then
					self:wag():effectclock('beat')
				end
			end
		}
	else
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			local pNum = (player == PLAYER_1) and 1 or 2
			filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum))

			local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
			local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
			local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(player) * currentMini or style:GetWidth(player) * currentMini

			if getenv("EffectVibrateP"..pNum) then filterWidth = filterWidth + (30 * currentMini) end

			local metricName = string.format("PlayerP%i%sX",pNum,styleType)
			local pos = THEME:GetMetric("ScreenGameplay",metricName)

			t[#t+1] = Def.ActorFrame{
				InitCommand=function(self) self:x(pos):CenterY() end,
				OnCommand=function(self)
					if getenv("RotationLeftP"..pNum) then
						self:rotationz(-90)
						self:y(SCREEN_CENTER_Y+10)
					elseif getenv("RotationRightP"..pNum) then
						self:rotationz(90)
						self:y(SCREEN_CENTER_Y+10)
					elseif getenv("RotationUpsideDownP"..pNum) then
						self:y(0)
					end
		
					if getenv("EffectVibrateP"..pNum) then
					elseif getenv("EffectSpinP"..pNum) then
						self:spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
					elseif getenv("EffectSpinReverseP"..pNum) then
						self:spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
					elseif getenv("EffectBounceP"..pNum) then
						self:bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
					elseif getenv("EffectPulseP"..pNum) then
						self:pulse():effectclock('beat')
					elseif getenv("EffectWagP"..pNum) then
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