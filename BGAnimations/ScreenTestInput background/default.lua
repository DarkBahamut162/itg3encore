
local InputHandler = function( event )
	if event.PlayerNumber and event.button then
		if event.type == "InputEventType_FirstPress" then
			MESSAGEMAN:Broadcast( pname(event.PlayerNumber)..event.button.."On" )
		elseif event.type == "InputEventType_Release" then
			MESSAGEMAN:Broadcast( pname(event.PlayerNumber)..event.button.."Off" )
		end
	end

	return false
end

return Def.ActorFrame{
	OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback( InputHandler ) end,
	OffCommand=function(self) SCREENMAN:GetTopScreen():RemoveInputCallback( InputHandler ) end,
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenWithMenuElements background/CJ112",isFinal() and "Final" or "Normal"),
		InitCommand=function(self) self:FullScreen() end
	},
	Def.ActorFrame{
		OnCommand=function(self) self:x(SCREEN_CENTER_X-180*WideScreenDiff()):CenterY():zoom(WideScreenDiff()) end,
		Def.Sprite {
			Texture = "floor"
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(0):y(-70) end,
			P1UpOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1UpOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(0):y(50) end,
			P1DownOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1DownOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(-60):y(-10) end,
			P1LeftOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1LeftOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(60):y(-10) end,
			P1RightOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1RightOffMessageCommand=function(self) self:diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:x(SCREEN_CENTER_X+180*WideScreenDiff()):CenterY():zoom(WideScreenDiff()) end,
		Def.Sprite {
			Texture = "floor"
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(0):y(-70) end,
			P2UpOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2UpOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "red",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(0):y(50) end,
			P2DownOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2DownOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(-60):y(-10) end,
			P2LeftOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2LeftOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "blue",
			InitCommand=function(self) self:diffusealpha(0) end,
			OnCommand=function(self) self:x(60):y(-10) end,
			P2RightOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2RightOffMessageCommand=function(self) self:diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:x(SCREEN_CENTER_X-20*WideScreenDiff()):y(SCREEN_CENTER_Y-72*WideScreenDiff()):zoom(0.6*WideScreenDiff()) end,
		Def.Sprite {
			Texture = "start button",
			InitCommand=function(self) self:y(-30) end
		},
		Def.Sprite {
			Texture = "select button",
			InitCommand=function(self) self:y(30) end
		},
		Def.Sprite {
			Texture = "right button",
			InitCommand=function(self) self:x(70) end 
		},
		Def.Sprite {
			Texture = "right button",
			InitCommand=function(self) self:x(-70):zoomx(-1) end
		},
		Def.Sprite {
			Texture = "start glow",
			InitCommand=function(self) self:y(-30):blend(Blend.Add):diffusealpha(0) end,
			P1StartOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1StartOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "select glow",
			InitCommand=function(self) self:y(30):blend(Blend.Add):diffusealpha(0) end,
			P1SelectOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1SelectOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "right glow",
			InitCommand=function(self) self:x(70):blend(Blend.Add):diffusealpha(0) end,
			P1MenuRightOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1MenuRightOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "right glow",
			InitCommand=function(self) self:x(-70):zoomx(-1):blend(Blend.Add):diffusealpha(0) end,
			P1MenuLeftOnMessageCommand=function(self) self:diffusealpha(1) end,
			P1MenuLeftOffMessageCommand=function(self) self:diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		OnCommand=function(self) self:x(SCREEN_CENTER_X+20*WideScreenDiff()):y(SCREEN_CENTER_Y+72*WideScreenDiff()):zoom(0.6*WideScreenDiff()) end,
		Def.Sprite {
			Texture = "start button",
			InitCommand=function(self) self:y(-30) end
		},
		Def.Sprite {
			Texture = "select button",
			InitCommand=function(self) self:y(30) end
		},
		Def.Sprite {
			Texture = "right button",
			InitCommand=function(self) self:x(70) end
		},
		Def.Sprite {
			Texture = "right button",
			InitCommand=function(self) self:x(-70):zoomx(-1) end
		},
		Def.Sprite {
			Texture = "start glow",
			InitCommand=function(self) self:y(-30):blend(Blend.Add):diffusealpha(0) end,
			P2StartOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2StartOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "select glow",
			InitCommand=function(self) self:y(30):blend(Blend.Add):diffusealpha(0) end,
			P2SelectOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2SelectOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "right glow",
			InitCommand=function(self) self:x(70):blend(Blend.Add):diffusealpha(0) end,
			P2MenuRightOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2MenuRightOffMessageCommand=function(self) self:diffusealpha(0) end
		},
		Def.Sprite {
			Texture = "right glow",
			InitCommand=function(self) self:x(-70):zoomx(-1):blend(Blend.Add):diffusealpha(0) end,
			P2MenuLeftOnMessageCommand=function(self) self:diffusealpha(1) end,
			P2MenuLeftOffMessageCommand=function(self) self:diffusealpha(0) end
		}
	}
}