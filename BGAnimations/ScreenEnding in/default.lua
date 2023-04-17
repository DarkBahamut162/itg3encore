return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+158):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end,
		OnCommand=function(self) self:sleep(0):linear(0.2):diffusealpha(0):zoomtoheight(SCREEN_HEIGHT/1.5) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-158):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end,
		OnCommand=function(self) self:sleep(0):linear(0.2):diffusealpha(0):zoomtoheight(SCREEN_HEIGHT/1.5) end
	},
	LoadActor(THEME:GetPathB("","profile"))..{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end,
		OnCommand=function(self) self:linear(0.5):zoomy(0) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadFont("_z 36px shadowx")..{
			Text="SAVING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7) end,
			OnCommand=function(self) self:diffusealpha(1):linear(0.3):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadFont("_z 36px shadowx")..{
			Text="SAVING MACHINE STATS...",
			InitCommand=function(self) self:Center():zoom(0.7) end,
			OnCommand=function(self) self:diffusealpha(1):linear(0.3):diffusealpha(0) end
		}
	}
}