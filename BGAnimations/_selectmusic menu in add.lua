local check = USBCheck()

return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,1")) end,
		OnCommand=function(self) self:linear(0.2):diffusealpha(0) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() and not check,
		LoadActor(THEME:GetPathG("","profile"))..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):zoomy(0.0) setenv("USBCheck",true) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="LOADING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):diffuse(color("0,0,0,0")) end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() or (GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() and check),
		LoadActor(THEME:GetPathG("","lolhi"))..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):zoomy(0.0) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="LOADING...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.2):diffuse(color("0,0,0,0")) end
		}
	}
}
