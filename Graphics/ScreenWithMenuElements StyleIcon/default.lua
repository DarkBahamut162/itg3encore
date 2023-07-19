local master_pn = GAMESTATE:GetMasterPlayerNumber()
local st = ""
local state = 0

if GAMESTATE:GetNumPlayersEnabled() == 1 then
	st = "Single"
	state = (master_pn == PLAYER_2) and 1 or 0
else
	st = "Versus"
end

return LoadActor(THEME:GetPathG("ScreenWithMenuElements","StyleIcon/"..st))..{
	InitCommand=function(self) self:animate(false):setstate(state) end
}