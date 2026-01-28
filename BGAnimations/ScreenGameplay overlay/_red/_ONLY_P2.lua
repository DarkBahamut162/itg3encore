if getenv("SetScoreFA"..pname(PLAYER_2)) then
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_LEFT_MAXCOMBO"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_RIGHT_FA"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
	}
elseif getenv("IIDXDouble"..pname(PLAYER_2)) then
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_LEFT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_RIGHT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
	}
else
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_LEFT_MAXCOMBO"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_red/_RIGHT_SCORE"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
	}
end