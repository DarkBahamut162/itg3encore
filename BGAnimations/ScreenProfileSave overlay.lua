for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	PROFILEMAN:GetProfile(pn):SetLastUsedHighScoreName(PROFILEMAN:GetProfile(pn):GetDisplayName())
    GAMESTATE:StoreRankingName(pn,PROFILEMAN:GetProfile(pn):GetDisplayName())
end

return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+158*WideScreenDiff()):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-158*WideScreenDiff()):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()) end
	},
	Def.ActorFrame{
		LoadActor("lolhi")..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="LOADING...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
		},
		LoadActor("_disk")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY() end,
			OnCommand=function(self) self:spin():decelerate(0.2):zoom(0):rotationz(360) end
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