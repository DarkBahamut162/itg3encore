local posX = SCREEN_CENTER_X
if GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and getenv("RotationSoloP1") then
	posX = SCREEN_CENTER_X-SCREEN_WIDTH/4/WideScreenSemiDiff()
elseif GAMESTATE:GetMasterPlayerNumber() == PLAYER_2 and getenv("RotationSoloP2") then
	posX = SCREEN_CENTER_X+SCREEN_WIDTH/4/WideScreenSemiDiff()
end

return Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=function(self) self:x(posX):y(SCREEN_CENTER_Y+15):zoom(WideScreenDiff()) end,
		Def.ActorFrame{
			Def.Sprite {
				Texture = "light_frame"
			},
			Def.ActorFrame{
				Name="LightColors",
				Def.Sprite {
					Texture = "light_green",
					InitCommand=function(self) self:y(-96):diffusealpha(0):rotationz(0):blend(Blend.Add) end,
					NoteCrossedMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):diffusealpha(0) end
				},
				Def.Sprite {
					Texture = "light_yellow",
					InitCommand=function(self) self:y(-32):diffusealpha(0):rotationz(45):blend(Blend.Add) end,
					NoteWillCrossIn400MsMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(0.8):diffusealpha(0) end
				},
				Def.Sprite {
					Texture = "light_yellow",
					InitCommand=function(self) self:y(31):diffusealpha(0):rotationz(90):blend(Blend.Add) end,
					NoteWillCrossIn800MsMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(0.8):diffusealpha(0) end
				},
				Def.Sprite {
					Texture = "light_red",
					InitCommand=function(self) self:y(95):diffusealpha(0):rotationz(135):blend(Blend.Add) end,
					NoteWillCrossIn1200MsMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.1):linear(0.2):zoom(0.8):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="LightDots",
				Def.Sprite {
					Texture = "light_dot",
					InitCommand=function(self) self:diffusealpha(0) end,
					NoteWillCrossIn400MsMessageCommand=function(self) self:finishtweening():y(-32):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0) end
				},
				Def.Sprite {
					Texture = "light_dot",
					InitCommand=function(self) self:diffusealpha(0) end,
					NoteWillCrossIn800MsMessageCommand=function(self) self:finishtweening():y(32):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0) end
				},
				Def.Sprite {
					Texture = "light_dot",
					InitCommand=function(self) self:diffusealpha(0) end,
					NoteWillCrossIn1200MsMessageCommand=function(self) self:finishtweening():y(96):diffusealpha(0.55):linear(0.5):addy(-64):sleep(0.01):diffusealpha(0) end
				}
			},
			Def.ActorFrame{
				Name="DirectionText",
				InitCommand=function(self) self:y(-96) end,
				Def.BitmapText {
					File = "_r bold shadow 30px",
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end,
					CrossCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end,
					NoteCrossedMessageCommand=function(self,param)
						if param.ButtonName then
							local button = param.ButtonName
							self:settext(button.."!"):playcommand("Cross")
						end
					end,
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(0) end
				},
				Def.BitmapText {
					File = "_r bold shadow 30px",
					Text="Jump!",
					InitCommand=function(self) self:diffusealpha(0):maxwidth(70) end,
					NoteCrossedMessageCommand=function(self) self:finishtweening():diffusealpha(0) end,
					NoteCrossedJumpMessageCommand=function(self) self:finishtweening():diffusealpha(1):zoom(1.4):linear(0.2):zoom(1):sleep(0.4):diffusealpha(0) end
				}
			}
		}
	},
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/beginner/platforms"))()
}