return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+15) end;
		Def.ActorFrame{
			LoadActor("light_frame");

			Def.ActorFrame{
				Name="LightColors";
				LoadActor("light_green")..{
					InitCommand=function(self) self:y(-96):diffusealpha(0):rotationz(0):blend(Blend.Add) end;
					NoteCrossedMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):diffusealpha(0) end;
				};
				LoadActor("light_yellow")..{
					InitCommand=function(self) self:y(-32):diffusealpha(0):rotationz(45):blend(Blend.Add) end;
					NoteWillCrossIn400MsMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(0.8):diffusealpha(0) end;
				};
				LoadActor("light_yellow")..{
					InitCommand=function(self) self:y(31):diffusealpha(0):rotationz(90):blend(Blend.Add) end;
					NoteWillCrossIn800MsMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(0.8):diffusealpha(0) end;
				};
				LoadActor("light_red")..{
					InitCommand=function(self) self:y(95):diffusealpha(0):rotationz(135):blend(Blend.Add) end;
					NoteWillCrossIn1200MsMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(0.8):diffusealpha(0) end;
				};
			};

			Def.ActorFrame{
				Name="LightDots";
				LoadActor("light_dot")..{
					InitCommand=function(self) self:diffusealpha(0) end;
					NoteWillCrossIn400MsMessageCommand=function(self) self:finishtweening():y(-32):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0) end;
				};
				LoadActor("light_dot")..{
					InitCommand=function(self) self:diffusealpha(0) end;
					NoteWillCrossIn800MsMessageCommand=function(self) self:finishtweening():y(32):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0) end;
				};
				LoadActor("light_dot")..{
					InitCommand=function(self) self:diffusealpha(0) end;
					NoteWillCrossIn1200MsMessageCommand=function(self) self:finishtweening():y(96):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0) end;
				};
			};

			Def.ActorFrame{
				Name="DirectionText";
				InitCommand=function(self) self:y(-96) end;

				LoadFont("_r bold shadow 30px")..{
					Text="Left!";
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end;
					CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end;
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Left" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(0) end;
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Right";
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end;
					CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end;
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Right" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(0) end;
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Up";
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end;
					CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end;
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Up" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(0) end;
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Down!";
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end;
					CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end;
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName == "Down" then
							self:playcommand("Cross");
						end
					end;
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(0) end;
				};
				LoadFont("_r bold shadow 30px")..{
					Text="Jump!";
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end;
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end;
				};
			};
		};
	};

	LoadActor("platforms");
};