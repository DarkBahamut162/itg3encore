if getenv("SetScoreFA"..pname(PLAYER_1)) then
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_LEFT_FA"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_RIGHT_MAXCOMBO"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
	}
elseif getenv("IIDXDouble"..pname(PLAYER_1)) then
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_LEFT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_RIGHT_BOTH"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
	}
else
	return Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_LEFT_SCORE"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X-185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end },
		loadfile(THEME:GetPathB("ScreenGameplay","overlay/_10th/_RIGHT_MAXCOMBO"))()..{ InitCommand=function(self) self:x(SCREEN_CENTER_X+185*WideScreenDiff()):y(448):zoom(WideScreenDiff()) end }
	}
end