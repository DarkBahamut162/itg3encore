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

function getFilter(player,filterWidth,filterAlpha)
	local special = false
	if ProductFamily() == "OutFox" and tonumber(split("-",ProductVersion())[1]) >= 0.5 then
		if gameMode == "be-mu" and stepsTypeNumber == 7 then
			stepsTypeNumber = stepsTypeNumber .. pname(player)
			special = true
		elseif gameMode == "po-mu" then
			local pomuREST = split('_', stepsType)[2]
			special = true
			if pomuREST == "Three" then
				stepsTypeNumber = 3
			elseif pomuREST == "Four" then
				stepsTypeNumber = 4
				special = false
			elseif pomuREST == "Five" then
				stepsTypeNumber = 5
			elseif pomuREST == "Seven" then
				stepsTypeNumber = 7
			elseif pomuREST == "Nine" then
				stepsTypeNumber = 9
			end
			stepsTypeNumber = stepsTypeNumber .. "Light"
		end
	end
	if special then
		return LoadActor("/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..stepsTypeNumber)..{
			InitCommand=function(self) self:zoomto(filterWidth,SCREEN_HEIGHT*4):diffusealpha(filterAlpha) end
		}
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
	local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(pNum-1) * currentMini or 64 * 4 * currentMini

	if string.find(style:GetName(),"double") then
		if IsGame("be-mu") then
			filterWidth = filterWidth * 1.8
		elseif IsGame("pump") then
			filterWidth = filterWidth * 1.35
		elseif IsGame("smx") then
			filterWidth = filterWidth * 1.45
		elseif IsGame("po-mu") then
			filterWidth = filterWidth * 1.65
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
		LoadActor("SpeedAssist", player),
		LoadActor("StopAssist", player)
	}
else
	if styleType == "TwoPlayersSharedSides" then
		local player = GAMESTATE:GetMasterPlayerNumber()
		local pNum = player == PLAYER_1 and 1 or 2
		local metricName = "PlayerP".. pNum .."TwoPlayersSharedSidesX"
		filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum))

		local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
		local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
		local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(pNum-1) * currentMini or 64 * 4 * currentMini

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
		for i, player in ipairs(GAMESTATE:GetHumanPlayers()) do
			local pNum = (player == PLAYER_1) and 1 or 2
			filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum))

			local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
			local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
			local filterWidth = isOutFox() and GAMESTATE:GetStyleFieldSize(pNum-1) * currentMini or 64 * 4 * currentMini

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
				Def.Quad{
					Name="Player"..pNum.."Filter",
					InitCommand=function(self) self:zoomto(filterWidth,SCREEN_HEIGHT*4):diffusecolor(filterColor):diffusealpha(filterAlphas[player]) end
				},
				LoadActor("SpeedAssist", player),
				LoadActor("StopAssist", player)
			}
		end
	end
end

return t