return Def.ActorFrame{
	Def.ActorFrame{
		Name="DangerP1";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_1 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(cmd(playcommand,"Show"))
					else
						self:RunCommandsOnChildren(cmd(playcommand,"Hide"))
					end
				end
			end;
			LoadActor(THEME:GetPathB("_shared","danger/single"))..{
				InitCommand=cmd(faderight,.1;fadeleft,.1;fadetop,.1;fadebottom,.1;stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM;diffusealpha,0;);
				ShowCommand=cmd(linear,.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,0,0,0.3");effectcolor2,color("1,0,0,0.8"));
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			Def.Quad{
				InitCommand=cmd(faderight,.1;stretchto,SCREEN_LEFT,SCREEN_TOP,SCREEN_CENTER_X,SCREEN_BOTTOM;diffusealpha,0;);
				ShowCommand=cmd(linear,.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,0,0,0.3");effectcolor2,color("1,0,0,0.8"));
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor(THEME:GetPathB("_shared","danger/_danger text"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+140;diffusealpha,0;);
				ShowCommand=cmd(linear,.3;diffusealpha,1;);
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor(THEME:GetPathB("_shared","danger/_danger glow"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+140;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;);
				ShowCommand=cmd(sleep,0.5;linear,0.7;cropleft,1;cropright,-0.3;sleep,0.8;queuecommand,"Show");
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
		};
		--[[
		Def.ActorFrame{
			Name="Double";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(bDoubles)
			end;
			LoadActor(THEME:GetPathB("_shared","danger/double"))..{
				InitCommand=cmd();
			};
			Def.Quad{
				InitCommand=cmd();
			};
			LoadActor(THEME:GetPathB("_shared","danger/_danger text"))..{
				InitCommand=cmd();
			};
			LoadActor(THEME:GetPathB("_shared","danger/_danger glow"))..{
				InitCommand=cmd();
			};
		};
		--]]
	};
	Def.ActorFrame{
		Name="DangerP2";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
				local style = GAMESTATE:GetCurrentStyle()
				local styleType = style:GetStyleType()
				local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
			HealthStateChangedMessageCommand=function(self, param)
				if param.PlayerNumber == PLAYER_2 then
					if param.HealthState == "HealthState_Danger" then
						self:RunCommandsOnChildren(cmd(playcommand,"Show"))
					else
						self:RunCommandsOnChildren(cmd(playcommand,"Hide"))
					end
				end
			end;
			LoadActor(THEME:GetPathB("_shared","danger/single"))..{
				InitCommand=cmd(faderight,.1;fadeleft,.1;fadetop,.1;fadebottom,.1;stretchto,SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffusealpha,0;);
				ShowCommand=cmd(linear,.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,0,0,0.3");effectcolor2,color("1,0,0,0.8"));
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			Def.Quad{
				InitCommand=cmd(faderight,.1;stretchto,SCREEN_CENTER_X,SCREEN_TOP,SCREEN_RIGHT,SCREEN_BOTTOM;diffusealpha,0;);
				ShowCommand=cmd(linear,.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,0,0,0.3");effectcolor2,color("1,0,0,0.8"));
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor(THEME:GetPathB("_shared","danger/_danger text"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+140;diffusealpha,0;);
				ShowCommand=cmd(linear,.3;diffusealpha,1;);
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
			LoadActor(THEME:GetPathB("_shared","danger/_danger glow"))..{
				InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+140;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;);
				ShowCommand=cmd(sleep,0.5;linear,0.7;cropleft,1;cropright,-0.3;sleep,0.8;queuecommand,"Show");
				HideCommand=cmd(stopeffect;stoptweening;linear,.5;diffusealpha,0);
			};
		};
	};
};