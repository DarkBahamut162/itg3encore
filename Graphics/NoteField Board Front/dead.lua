local player = ...

local tilt = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions():Tilt()
local tilt_degrees = scale(tilt,-1,1,30,30) % 360
if tilt_degrees > 180 then tilt_degrees = tilt_degrees - (tilt_degrees-180) end
local stretch = 1-(tilt_degrees/180)
local add = math.abs(SCREEN_HEIGHT-SCREEN_HEIGHT/stretch)

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny * WideScreenDiff()

if tilt > 0 then
	currentMini = currentMini * scale(tilt,0,1,1,0.9)
	add = add + math.abs(scale(tilt,0,1,0,-45)/stretch)
else
	currentMini = currentMini * scale(tilt,0,-1,1,0.9)
	add = add + math.abs(scale(tilt,0,-1,0,-20)/stretch)
end

local width = isDouble() and SCREEN_WIDTH or SCREEN_CENTER_X
if IsGame("beat") or IsGame("be-mu") then
	add = add + SCREEN_HEIGHT
	width = width * 2
end

return Def.ActorFrame{
	Def.ActorFrame{
		HealthStateChangedMessageCommand=function(self, param)
			if param.PlayerNumber == player then
				if param.HealthState == Health.Dead then
					self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
				end
			end
		end,
		Def.Quad{
			InitCommand=function(self) self:cropleft(0.25):cropright(0.25):diffuse(color("0,0,0,0.5")):fadeleft(0.2):faderight(0.2):stretchto(-width,(SCREEN_TOP-add)/currentMini,width,(SCREEN_BOTTOM+add)/currentMini):diffusealpha(0) end,
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end
		}
	}
}