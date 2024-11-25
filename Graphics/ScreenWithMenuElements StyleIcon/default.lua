local style = GAMESTATE:GetCurrentStyle()
local stepsType = split("_",style:GetStepsType())[2]
local players = { PLAYER_1 = false, PLAYER_2 = false }

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	players[pn] = true
end

if GameModeEnabled() and style then
	return Def.ActorFrame{
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenWithMenuElements","StyleIcon/"..stepsType.."/"..GetUserPrefN("StylePosition")),
			InitCommand=function(self) self:addy(-3):shadowcolor(color("#000000")):shadowlengthx(0):shadowlengthy(2):diffusealpha(1/3) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("ScreenWithMenuElements","StyleIcon/"..stepsType.."/"..GetUserPrefN("StylePosition")),
			InitCommand=function(self)
				self:addy(-3):shadowcolor(color("#000000")):shadowlengthx(0):shadowlengthy(2)
				if not players[PLAYER_1] then self:cropleft(0.5) end
				if not players[PLAYER_2] then self:cropright(0.5) end
			end
		}
	}
else
	return Def.Actor{}
end