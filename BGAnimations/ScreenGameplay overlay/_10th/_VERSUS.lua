local t = Def.ActorFrame{}
if getenv("SetScoreFA"..pname(PLAYER_1)) then
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_LEFT_FA"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
elseif getenv("IIDXDouble"..pname(PLAYER_1)) then
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_LEFT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
else
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_LEFT_SCORE"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
end
if getenv("SetScoreFA"..pname(PLAYER_2)) then
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_RIGHT_FA"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
elseif getenv("IIDXDouble"..pname(PLAYER_2)) then
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_RIGHT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
else
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_RIGHT_SCORE"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
end

return t