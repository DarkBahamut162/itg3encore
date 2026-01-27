local t = Def.ActorFrame{}

if getenv("IIDXDouble"..pname(PLAYER_1)) then
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_gold/_LEFT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
else
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_gold/_LEFT_SCORE"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
end
if getenv("IIDXDouble"..pname(PLAYER_2)) then
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_gold/_RIGHT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
else
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_gold/_RIGHT_SCORE"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
end

return t