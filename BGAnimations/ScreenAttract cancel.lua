local t = Def.ActorFrame{};

t[#t+1] = Def.Quad{
		InitCommand=function(self) self:diffuse(color("#000000")):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM) end;
		OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1):sleep(0.5) end;
	};
t[#t+1] = LoadActor("updatecoin") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):blend("BlendMode_Add") end;
		OnCommand=function(self) self:zoom(0):diffusealpha(0):rotationz(-20):linear(0.5):zoom(18):diffusealpha(1):rotationz(150) end;
	};
t[#t+1] = LoadActor("updatecoin") .. {
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y):blend("BlendMode_Add") end;
		OnCommand=function(self) self:zoom(0):diffusealpha(0):rotationz(20):linear(0.5):zoom(18):diffusealpha(1):rotationz(-70) end;
	};
if GAMESTATE:GetCoinMode() ~= 'CoinMode_Pay' then
t[#t+1] = LoadActor(THEME:GetPathS("Common","coin")) .. {
		StartTransitioningCommand=function(self) self:play() end;
	};
end;

return t;