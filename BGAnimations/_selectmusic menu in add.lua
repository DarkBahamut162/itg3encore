local check = USBCheck()

function MemoryCheck()
	if isEtterna() then return false else return GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() end
end

return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,1")) end,
		OnCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		Condition=MemoryCheck() and not check,
		Def.Sprite {
			Texture = THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):zoomy(0.0) setenv("USBCheck",true) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Text="LOADING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):diffuse(color("0,0,0,0")) end
		}
	},
	Def.ActorFrame{
		Condition=not MemoryCheck() or (MemoryCheck() and check),
		Def.Sprite {
			Texture = THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):zoomy(0.0) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Text="LOADING...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):diffuse(color("0,0,0,0")) end
		}
	}
}
