return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+158):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-158):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor("lolhi")..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="SAVING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7) end
		},
		LoadActor(THEME:GetPathB("_statsout","ending"))
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor("profile")..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="SAVING MACHINE STATS...",
			InitCommand=function(self) self:Center():zoom(0.7) end
		}
	},
	Def.Actor{
		BeginCommand=function(self)
			if GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() then self:sleep(8) else self:sleep(1.5) end
			self:queuecommand("Load")
		end,
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
	}
}