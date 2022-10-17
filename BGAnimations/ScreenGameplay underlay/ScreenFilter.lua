if Var "LoadingScreen" == "ScreenDemonstration2" then return Def.ActorFrame{} end

local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local padding = 4*2
local arrowWidth = 64
local filterColor = color("0.135,0.135,0.135,1")
local filterAlphas = {
	PlayerNumber_P1 = 1,
	PlayerNumber_P2 = 1,
	Default = 0
}

local t = Def.ActorFrame{}
local style = GAMESTATE:GetCurrentStyle()
local cols = style:ColumnsPerPlayer()
local styleType = ToEnumShortString(style:GetStyleType())
local filterWidth = (arrowWidth * cols)

if numPlayers == 1 then
	local player = GAMESTATE:GetMasterPlayerNumber()
	local pNum = (player == PLAYER_1) and 1 or 2
	local filterAlpha = tonumber(getenv("ScreenFilterP"..pNum))

	local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
	local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
	filterWidth = (filterWidth + padding) * currentMini

	if getenv("EffectVibrateP"..pNum) then
		filterWidth = filterWidth + (30 * currentMini)
	end

	local pos
	local metricName = string.format("PlayerP%i%sX",pNum,styleType)
	pos = THEME:GetMetric("ScreenGameplay",metricName)
	t[#t+1] = Def.Quad{
		Name="SinglePlayerFilter",
		InitCommand=function(self) self:x(pos):CenterY():zoomto(filterWidth,SCREEN_HEIGHT*3):diffusecolor(filterColor):diffusealpha(filterAlpha) end,
		OnCommand=function(self)
			if getenv("RotationLeftP"..pNum) then
				self:rotationz(90):y(SCREEN_CENTER_Y+8)
			elseif getenv("RotationRightP"..pNum) then
				self:rotationz(90):y(SCREEN_CENTER_Y+8)
			elseif getenv("RotationUpsideDownP"..pNum) then
				self:y(SCREEN_CENTER_Y+20)
			elseif getenv("RotationSoloP"..pNum) then
				self:CenterX()
			end

			if getenv("EffectVibrateP"..pNum) then
			elseif getenv("EffectSpinP"..pNum) then
				self:spin()
				self:effectclock('beat')
				self:effectmagnitude(0,0,45*currentMini)
			elseif getenv("EffectSpinReverseP"..pNum) then
				self:spin()
				self:effectclock('beat')
				self:effectmagnitude(0,0,-45*currentMini)
			elseif getenv("EffectBounceP"..pNum) then
				self:bob()
				self:effectclock('beat')
				self:effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
			elseif getenv("EffectPulseP"..pNum) then
				self:pulse()
				self:effectclock('beat')
			elseif getenv("EffectWagP"..pNum) then
				self:wag()
				self:effectclock('beat')
			end
		end
	}
else
	if styleType == "TwoPlayersSharedSides" then
		local player = GAMESTATE:GetMasterPlayerNumber()
		local pNum = player == PLAYER_1 and 1 or 2
		local metricName = "PlayerP".. pNum .."TwoPlayersSharedSidesX"
		filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum))

		local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
		local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
		filterWidth = (filterWidth + padding) * currentMini

		if getenv("EffectVibrateP"..pNum) then
			filterWidth = filterWidth + (30 * currentMini)
		end

		t[#t+1] = Def.Quad{
			Name="RoutineFilter",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay",metricName)):CenterY():zoomto(filterWidth,SCREEN_HEIGHT*3):diffusecolor(filterColor):diffusealpha(filterAlphas[player]) end,
			OnCommand=function(self)
				if getenv("RotationLeftP"..pNum) then
					self:rotationz(90):y(SCREEN_CENTER_Y+8)
				elseif getenv("RotationRightP"..pNum) then
					self:rotationz(90):y(SCREEN_CENTER_Y+8)
				elseif getenv("RotationUpsideDownP"..pNum) then
					self:y(SCREEN_CENTER_Y+20)
				end

				if getenv("EffectVibrateP"..pNum) then
				elseif getenv("EffectSpinP"..pNum) then
					self:spin()
					self:effectclock('beat')
					self:effectmagnitude(0,0,45*currentMini)
				elseif getenv("EffectSpinReverseP"..pNum) then
					self:spin()
					self:effectclock('beat')
					self:effectmagnitude(0,0,-45*currentMini)
				elseif getenv("EffectBounceP"..pNum) then
					self:bob()
					self:effectclock('beat')
					self:effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
				elseif getenv("EffectPulseP"..pNum) then
					self:pulse()
					self:effectclock('beat')
				elseif getenv("EffectWagP"..pNum) then
					self:wag()
					self:effectclock('beat')
				end
			end
		}
	else
		for i, player in ipairs(PlayerNumber) do
			local filterWidth = (arrowWidth * cols)
			local pNum = (player == PLAYER_1) and 1 or 2
			filterAlphas[player] = tonumber(getenv("ScreenFilterP"..pNum))

			local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
			local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
			filterWidth = (filterWidth + padding) * currentMini

			if getenv("EffectVibrateP"..pNum) then
				filterWidth = filterWidth + (30 * currentMini)
			end

			local metricName = string.format("PlayerP%i%sX",pNum,styleType)
			local pos = THEME:GetMetric("ScreenGameplay",metricName)
			t[#t+1] = Def.Quad{
				Name="Player"..pNum.."Filter",
				InitCommand=function(self) self:x(pos):CenterY():zoomto(filterWidth,SCREEN_HEIGHT*3):diffusecolor(filterColor):diffusealpha(filterAlphas[player] or 0.5) end,
				OnCommand=function(self)
					if getenv("RotationLeftP"..pNum) then
						self:rotationz(90):y(SCREEN_CENTER_Y+8)
					elseif getenv("RotationRightP"..pNum) then
						self:rotationz(90):y(SCREEN_CENTER_Y+8)
					elseif getenv("RotationUpsideDownP"..pNum) then
						self:y(SCREEN_CENTER_Y+20)
					end

					if getenv("EffectVibrateP"..pNum) then
					elseif getenv("EffectSpinP"..pNum) then
						self:spin()
						self:effectclock('beat')
						self:effectmagnitude(0,0,45*currentMini)
					elseif getenv("EffectSpinReverseP"..pNum) then
						self:spin()
						self:effectclock('beat')
						self:effectmagnitude(0,0,-45*currentMini)
					elseif getenv("EffectBounceP"..pNum) then
						self:bob()
						self:effectclock('beat')
						self:effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
					elseif getenv("EffectPulseP"..pNum) then
						self:pulse()
						self:effectclock('beat')
					elseif getenv("EffectWagP"..pNum) then
						self:wag()
						self:effectclock('beat')
					end
				end
			}
		end
	end
end

return t