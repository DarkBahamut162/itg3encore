return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+158):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end,
		OnCommand=function(self) self:sleep(0):linear(0.2):diffusealpha(0):zoomtoheight(SCREEN_HEIGHT/1.5) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-158):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end,
		OnCommand=function(self) self:sleep(0):linear(0.2):diffusealpha(0):zoomtoheight(SCREEN_HEIGHT/1.5) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor(THEME:GetPathB("","profile"))..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end,
			OnCommand=function(self) self:linear(0.5):zoomy(0) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="SAVING MACHINE STATS...",
			InitCommand=function(self) self:Center():zoom(0.7) end,
			OnCommand=function(self) self:diffusealpha(1):linear(0.3):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("_statsout","ending"))
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor(THEME:GetPathB("","lolhi"))..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end,
			OnCommand=function(self) self:linear(0.5):zoomy(0) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="SAVING PROFILES...",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+42):CenterY():zoom(0.75) end,
			OnCommand=function(self) self:diffusealpha(1):linear(0.3):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("","_disk"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-120):CenterY():diffusealpha(1) end,
			OnCommand=function(self) self:spin():diffusealpha(0) end
		}
	}
}