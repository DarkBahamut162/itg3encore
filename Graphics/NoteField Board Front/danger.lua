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

local width = isDouble() and SCREEN_WIDTH or SCREEN_CENTER_Y

return Def.ActorFrame{
	Def.ActorFrame{
		OnCommand=function(self) if getenv("Flare"..pname(player)) == 11 then self:visible(false) end end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == player then
				if param.Level == 1 then self:visible(true) end
			end
		end,
		Def.ActorFrame{
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == player then
					if param.HealthState == Health.Danger then
						self:RunCommandsOnChildren(function(self) self:playcommand("Show") end)
					else
						self:RunCommandsOnChildren(function(self) self:playcommand("Hide") end)
					end
				end
			end,
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/double"),
				InitCommand=function(self) self:cropleft(0.25):cropright(0.25):faderight(0.1):fadeleft(0.1):fadetop(0.1):fadebottom(0.1):stretchto(-width,(SCREEN_TOP-add)/currentMini,width,(SCREEN_HEIGHT+add)/currentMini):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Quad{
				InitCommand=function(self) self:cropleft(0.25):cropright(0.25):faderight(0.1):fadeleft(0.1):stretchto(-width,(SCREEN_TOP-add)/currentMini,width,(SCREEN_HEIGHT+add)/currentMini):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("1,0,0,0.3")):effectcolor2(color("1,0,0,0.8")) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger text "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:y(SCREEN_CENTER_Y+140):diffusealpha(0) end,
				ShowCommand=function(self) self:linear(0.3):diffusealpha(1) end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			},
			Def.Sprite {
				Texture = THEME:GetPathB("_shared","danger/_danger glow "..(isFinal() and "final" or "normal")),
				InitCommand=function(self) self:y(SCREEN_CENTER_Y+140):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1) end,
				ShowCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.5):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.8):queuecommand("Show") end,
				HideCommand=function(self) self:stopeffect():stoptweening():linear(0.5):diffusealpha(0) end
			}
		}
	}
}