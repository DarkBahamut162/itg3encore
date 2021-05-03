local numPlayers = GAMESTATE:GetNumPlayersEnabled()

local statObject
if numPlayers == 1 then
	-- check for doubles
	local style = GAMESTATE:GetCurrentStyle()
	if style:GetStyleType() == 'StyleType_OnePlayerTwoSides' then
		statObject = "double"
	else
		statObject = "single"
	end
elseif numPlayers == 2 then
	statObject = "versus"
end

return Def.ActorFrame{
	LoadActor(statObject)..{
		InitCommand=cmd(visible,not GAMESTATE:IsDemonstration() and not GAMESTATE:IsCourseMode());
	};
};