InitRotationOptions()

if ThemePrefs.Get("SLFavorites") > 0 then
	for _, id in pairs(PROFILEMAN:GetLocalProfileIDs()) do
		local profile = PROFILEMAN:GetLocalProfile(id)
		local profileDir = PROFILEMAN:LocalProfileIDToDir(id) .. "favorites.txt"
		if FILEMAN:DoesFileExist(profileDir) then
			if ThemePrefs.Get("SLFavorites") == 1 then
				SL2Other(profile:GetGUID(),profileDir)
			elseif ThemePrefs.Get("SLFavorites") == 2 then
				SL2OF(profile,profileDir)
			end
		end
	end
end

return Def.ActorFrame{
	OffCommand=function() if ThemePrefs.Get("SLFavorites") == 1 then SONGMAN:SetPreferredSongs(PROFILEMAN:GetProfile(GAMESTATE:GetMasterPlayerNumber()):GetGUID()) end end,
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+60*0.68*WideScreenDiff()):valign(0):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-60*0.68*WideScreenDiff()):valign(1):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end
	},
	LoadActor(THEME:GetPathB("_statsout","style")),
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor(THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="LOADING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadActor(THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="LOADING...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
		},
		LoadActor(THEME:GetPathG("","_disk "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-120*WideScreenDiff()):CenterY():zoom(WideScreenDiff()) end,
			OnCommand=function(self) self:linear(0.5):zoom(0):rotationz(360) end
		}
	},
	Def.Actor{
		BeginCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(1.5) end
			self:queuecommand("Load")
		end,
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue() end
	}
}