local player = ...
assert( player )

local t = Def.ActorFrame{
	InitCommand=function(self)
		self:zoom(0.5):x( _screen.cx - _screen.w/8 + 60 ):y(80 - 7.5)
		if player == PLAYER_2 then
			self:x( _screen.cx + _screen.w/3.4 + 60 )
		end
	end,
	LoadFont("ScreenGameplay judgment")..{
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			self:settext(glifemeter:GetTotalLives());
			self:y(-5);
			self:valign(1);
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player == player then
				self:settext(params.LivesLeft);
			end;
		end;
	};
	LoadFont("ScreenGameplay judgment")..{
		BeginCommand=function(self)
			self:settext("_");
			self:y(-12);
			self:valign(0.5);
			self:zoomx(2);
		end;
	};
	LoadFont("ScreenGameplay judgment")..{
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			self:settext(glifemeter:GetTotalLives());
			self:y(5);
			self:valign(0);
		end;
	};
};

return t;