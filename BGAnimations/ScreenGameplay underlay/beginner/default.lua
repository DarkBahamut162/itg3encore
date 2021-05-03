return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-30);
		Def.ActorFrame{
			LoadActor("light_frame");

			Def.ActorFrame{
				Name="LightColors";
				LoadActor("light_green")..{
					InitCommand=cmd(y,-96;diffusealpha,0;rotationz,0;blend,Blend.Add);
					NoteCrossedMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,1.4;linear,0.2;zoom,1;diffusealpha,0);
				};
				LoadActor("light_yellow")..{
					InitCommand=cmd(y,-32;diffusealpha,0;rotationz,45;blend,Blend.Add);
					NoteWillCrossIn400MsMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.2;zoom,.8;diffusealpha,0);
				};
				LoadActor("light_yellow")..{
					InitCommand=cmd(y,31;diffusealpha,0;rotationz,90;blend,Blend.Add);
					NoteWillCrossIn800MsMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.2;zoom,.8;diffusealpha,0);
				};
				LoadActor("light_red")..{
					InitCommand=cmd(y,95;diffusealpha,0;rotationz,135;blend,Blend.Add);
					NoteWillCrossIn1200MsMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,1.1;linear,0.2;zoom,.8;diffusealpha,0);
				};
			};

			Def.ActorFrame{
				Name="LightDots";
				LoadActor("light_dot")..{
					InitCommand=cmd(diffusealpha,0);
					NoteWillCrossIn400MsMessageCommand=cmd(finishtweening;y,-32;diffusealpha,0.55;linear,0.5;addy,-64;sleep,0.01;diffusealpha,0);
				};
				LoadActor("light_dot")..{
					InitCommand=cmd(diffusealpha,0);
					NoteWillCrossIn800MsMessageCommand=cmd(finishtweening;y,32;diffusealpha,0.55;linear,0.5;addy,-64;sleep,0.01;diffusealpha,0);
				};
				LoadActor("light_dot")..{
					InitCommand=cmd(diffusealpha,0);
					NoteWillCrossIn1200MsMessageCommand=cmd(finishtweening;y,96;diffusealpha,0.55;linear,0.5;addy,-64;sleep,0.01;diffusealpha,0);
				};
			};

			Def.ActorFrame{
				Name="DirectionText";
				InitCommand=cmd(y,-96);

				LoadFont("_r bold shadow 30px")..{
					Text="Left!";
					InitCommand=cmd(diffusealpha,0;maxwidth,70);
					CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.4;linear,0.2;zoom,1;sleep,0.4;diffusealpha,0);
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Left" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=cmd(finishtweening;diffusealpha,0);
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Right";
					InitCommand=cmd(diffusealpha,0;maxwidth,70);
					CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.4;linear,0.2;zoom,1;sleep,0.4;diffusealpha,0);
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Right" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=cmd(finishtweening;diffusealpha,0);
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Up";
					InitCommand=cmd(diffusealpha,0;maxwidth,70);
					CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.4;linear,0.2;zoom,1;sleep,0.4;diffusealpha,0);
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Up" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=cmd(finishtweening;diffusealpha,0);
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Down!";
					InitCommand=cmd(diffusealpha,0;maxwidth,70);
					CrossCommand=cmd(finishtweening;diffusealpha,1;zoom,1.4;linear,0.2;zoom,1;sleep,0.4;diffusealpha,0);
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Down" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=cmd(finishtweening;diffusealpha,0);
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Jump!";
					InitCommand=cmd(diffusealpha,0;maxwidth,70);
					NoteCrossedJumpMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,1.4;linear,0.2;zoom,1;sleep,0.4;diffusealpha,0);
				};
			};
		};
	};

	LoadActor("platforms");
};