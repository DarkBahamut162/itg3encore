local t = Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:diffuse(color("#000000")):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM) end,
		OnCommand=function(self) self:diffusealpha(0):linear(0.5):diffusealpha(1):sleep(0.5) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","_flash"),
		InitCommand=function(self) self:Center():blend(Blend.Add) end,
		OnCommand=function(self) self:zoom(0):diffusealpha(0):rotationz(-20):linear(0.5):zoom(8*GetScreenAspectRatio()):diffusealpha(1):rotationz(40) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("","_flash"),
		InitCommand=function(self) self:Center():blend(Blend.Add) end,
		OnCommand=function(self) self:zoom(0):diffusealpha(0):rotationz(20):linear(0.5):zoom(8*GetScreenAspectRatio()):diffusealpha(1):rotationz(-40) end
	}
}

if GAMESTATE:GetCoinMode() ~= 'CoinMode_Pay' then
	t[#t+1] = Def.Sound {
		File = THEME:GetPathS("Common","coin"),
		StartTransitioningCommand=function(self) self:play() end
	}
end

return t