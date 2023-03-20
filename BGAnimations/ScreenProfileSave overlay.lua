for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	PROFILEMAN:GetProfile(pn):SetLastUsedHighScoreName(PROFILEMAN:GetProfile(pn):GetDisplayName())
    GAMESTATE:StoreRankingName(pn,PROFILEMAN:GetProfile(pn):GetDisplayName())
end

GAMESTATE:SaveProfiles()

return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+158*WideScreenDiff()):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-158*WideScreenDiff()):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()) end
	},
	LoadActor("_disk")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY() end,
		OnCommand=function(self) self:spin():decelerate(0.2):addx(-56*WideScreenDiff()):zoom(0):rotationz(360) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor("profile")..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="SAVING MACHINE STATS...",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+42*WideScreenDiff()):CenterY():zoom(0.7*WideScreenDiff()):diffusealpha(0) end,
			OnCommand=function(self)
				if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(1):linear(0.25):diffusealpha(1) end
			end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor("lolhi")..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="SAVING PROFILES...",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+42*WideScreenDiff()):CenterY():zoom(0.75*WideScreenDiff()) end,
			OnCommand=function(self)
				if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(1):linear(0.25):diffusealpha(0) end
			end
		}
	},
	Def.Actor{
		BeginCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(1.5) end
			self:queuecommand("Load")
		end,
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
	}
}