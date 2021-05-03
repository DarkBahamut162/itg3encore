local style = GAMESTATE:GetCurrentStyle();
if style then
	local master_pn = GAMESTATE:GetMasterPlayerNumber();
	local st = style:GetName();
	local state = 0;

	if st == "Single" then
		state = (master_pn == PLAYER_2) and 1 or 0
	end;

	return LoadActor(THEME:GetPathG("ScreenWithMenuElements","StyleIcon/"..st))..{
		InitCommand=cmd(animate,false;setstate,state);
	};
else
	return Def.Actor {};
end
