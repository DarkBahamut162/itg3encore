local player = ...
assert(player,"[_name/default.lua] requires a player to be passed in.")
local iconName = "_icon p"..(player == PLAYER_1 and 1 or 2)

local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("_name","frame"))..{ InitCommand=function(self) self:xy(-272,5) end; };
	LoadFont("_v 26px bold diffuse")..{
		InitCommand=function(self) self:xy(-292,4):zoom(0.5):shadowlength(2):diffuse(PlayerColor(player)) end;
		BeginCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(player) then
				self:settext( GAMESTATE:GetPlayerDisplayName(player) )
			end
		end;
	};
	LoadActor(iconName)..{ InitCommand=function(self) self:xy(-222,4):shadowlength(2) end; };
};

return t;