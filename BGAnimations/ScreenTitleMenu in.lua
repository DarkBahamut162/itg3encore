setenv("SessionStart",0)
for pn in ivalues({PLAYER_1,PLAYER_2}) do setenv("TimePlayed"..pname(pn),0) end

return Def.Quad{
	InitCommand=function(self) self:FullScreen() end,
	OnCommand=function(self) self:linear(0.3):diffusealpha(0) end
}