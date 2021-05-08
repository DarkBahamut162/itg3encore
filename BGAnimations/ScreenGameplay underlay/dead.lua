return Def.ActorFrame{
	-- single
	Def.ActorFrame{
		Name="DeadSingle";
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			self:visible( styleType ~= "StyleType_OnePlayerTwoSides" and styleType ~= "StyleType_TwoPlayersSharedSides" )
		end;
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == "HealthState_Dead" then
				local dead = self:GetChild("Dead"..ToEnumShortString(param.PlayerNumber))
				dead:playcommand("Show")
			end
		end;
		Def.Quad{
			Name="DeadP1";
			InitCommand=function(self) self:diffuse(color("0,0,0,0.5")):faderight(.3):stretchto(SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_1) end;
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end;
		};
		Def.Quad{
			Name="DeadP2";
			InitCommand=function(self) self:diffuse(color("0,0,0,0.5")):faderight(.3):stretchto(SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM):diffusealpha(0):player(PLAYER_2) end;
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end;
		};
	};

	-- double
	Def.ActorFrame{
		Name="DeadDouble";
		BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			self:visible( styleType == "StyleType_OnePlayerTwoSides" or styleType == "StyleType_TwoPlayersSharedSides" )
		end;
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == "HealthState_Dead" then
				self:RunCommandsOnChildren(self:playcommand("Show"))
			end
		end;
		Def.Quad{
			InitCommand=function(self) self:diffuse(color("0,0,0,0.5")):fadeleft(.2):faderight(.2):FullScreen():diffusealpha(0) end;
			ShowCommand=function(self) self:linear(0.2):diffusealpha(0.5) end;
		};
	};
};