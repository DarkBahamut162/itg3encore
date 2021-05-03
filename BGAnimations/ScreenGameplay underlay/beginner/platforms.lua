local pm = GAMESTATE:GetPlayMode()

return Def.ActorFrame{
	Def.ActorFrame{
		Name="PlatformP1";
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+40;zoom,1.2;rotationx,-20;fov,45;vanishpoint,SCREEN_CENTER_X-160,SCREEN_CENTER_Y+40);
		BeginCommand=function(self)
			local isHuman = GAMESTATE:IsHumanPlayer(PLAYER_1)
			local stepsDiff = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()
			self:visible(isHuman and stepsDiff=='Difficulty_Beginner' and pm == 'PlayMode_Regular')
		end;
		LoadActor("_platform")..{ InitCommand=cmd(y,7;diffuse,color("0.6,0.6,0.6,0.8")); };
		LoadActor("panelglow")..{
			InitCommand=cmd(x,-45;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Left" then self:playcommand("Cross"); end
			end;
		};
		LoadActor("panelglow")..{
			InitCommand=cmd(x,46;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Right" then self:playcommand("Cross"); end
			end;
		};
		LoadActor("panelglow")..{
			InitCommand=cmd(y,-45;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Up" then self:playcommand("Cross"); end
			end;
		};
		LoadActor("panelglow")..{
			InitCommand=cmd(y,45;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Down" then self:playcommand("Cross"); end
			end;
		};
	};

	Def.ActorFrame{
		Name="PlatformP2";
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH/4;y,SCREEN_CENTER_Y+40;zoom,1.2;rotationx,-20;fov,45;vanishpoint,SCREEN_CENTER_X+160,SCREEN_CENTER_Y+40);
		BeginCommand=function(self)
			local isHuman = GAMESTATE:IsHumanPlayer(PLAYER_2)
			local stepsDiff = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()
			self:visible(isHuman and stepsDiff=='Difficulty_Beginner' and pm == 'PlayMode_Regular')
		end;
		LoadActor("_platform")..{ InitCommand=cmd(y,7;diffuse,color("0.6,0.6,0.6,0.8")); };
		LoadActor("panelglow")..{
			InitCommand=cmd(x,-45;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Left" then self:playcommand("Cross"); end
			end;
		};
		LoadActor("panelglow")..{
			InitCommand=cmd(x,46;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Right" then self:playcommand("Cross"); end
			end;
		};
		LoadActor("panelglow")..{
			InitCommand=cmd(y,-45;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Up" then self:playcommand("Cross"); end
			end;
		};
		LoadActor("panelglow")..{
			InitCommand=cmd(y,45;diffusealpha,0;blend,Blend.Add);
			CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.4;zoom,1;diffusealpha,0);
			NoteCrossedMessageCommand=function(self,param)
				if param.ButtonName == "Down" then self:playcommand("Cross"); end
			end;
		};
	};
};