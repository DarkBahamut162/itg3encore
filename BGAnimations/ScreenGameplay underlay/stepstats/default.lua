local numPlayers = GAMESTATE:GetNumPlayersEnabled()
local statObject = "single"

if isTopScreen('ScreenJukebox') then return Def.ActorFrame{} end

if numPlayers == 1 then
	if isDouble() or
	(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and (getenv("RotationP1") == 3 or (getenv("ShowStatsSizeP1") == 2 and getenv("ShowStatsP1") > 0))) or
	(GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 and (getenv("RotationP2") == 2 or (getenv("ShowStatsSizeP2") == 2 and getenv("ShowStatsP2") > 0))) then
		statObject = "double"
	else
		statObject = "single"
	end
elseif numPlayers == 2 then
	statObject = "versus"
end

return Def.ActorFrame{ loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/"..statObject))() }