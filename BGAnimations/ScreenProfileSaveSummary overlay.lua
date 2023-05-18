return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+60*0.68*WideScreenDiff()):valign(0):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-60*0.68*WideScreenDiff()):valign(1):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end
	},
	LoadActor(THEME:GetPathG("","profile"))..{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadFont("_z 36px shadowx")..{
			Text="SAVING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathB("_statsout","summary"))
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadFont("_z 36px shadowx")..{
			Text="SAVING MACHINE STATS...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
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