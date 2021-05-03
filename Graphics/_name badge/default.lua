local player = ...
assert(player,"[_name/default.lua] requires a player to be passed in.")
local iconName = "_icon p"..(player == PLAYER_1 and 1 or 2)

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_name","frame"))..{ InitCommand=cmd(xy,-272,5); };
	LoadFont("_v 26px bold diffuse")..{
		InitCommand=cmd(xy,-292,4;zoom,0.5;shadowlength,2;diffuse,PlayerColor(player));
		BeginCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(player) then
				self:settext( GAMESTATE:GetPlayerDisplayName(player) )
			end
		end;
	};
	LoadActor(iconName)..{ InitCommand=cmd(xy,-222,4;shadowlength,2); };
};

return t;