InitRotationOptions()

if isOutFoxV043() and ThemePrefs.Get("SLFavorites") > 0 then
	for id in ivalues(PROFILEMAN:GetLocalProfileIDs()) do
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

local profile_slot = {
	[PLAYER_1] = "ProfileSlot_Player1",
	[PLAYER_2] = "ProfileSlot_Player2"
}

return Def.ActorFrame{
	OffCommand=function()
		if ((isOutFoxV() and ThemePrefs.Get("SLFavorites") > 0) or isITGmania()) and hasSL() then
			local SLfav = PROFILEMAN:GetProfileDir(profile_slot[GAMESTATE:GetMasterPlayerNumber()]) .. "favorites.txt"
			if isOutFoxV043() and ThemePrefs.Get("SLFavorites") == 1 then
				SONGMAN:SetPreferredSongs(PROFILEMAN:GetProfile(GAMESTATE:GetMasterPlayerNumber()):GetGUID())
			elseif isOutFoxV() and ThemePrefs.Get("SLFavorites") == 2 then
				SL2OF(PROFILEMAN:GetProfile(GAMESTATE:GetMasterPlayerNumber()),SLfav)
			elseif isITGmania() then
				if FILEMAN:DoesFileExist(SLfav) then SONGMAN:SetPreferredSongs(SLfav,true) end
			end
		end
	end,
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+60*0.68*WideScreenDiff()):valign(0):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-60*0.68*WideScreenDiff()):valign(1):diffuse(color("#000000FF")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT) end
	},
	loadfile(THEME:GetPathB("_statsout","style"))(),
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		Def.Sprite {
			Texture = THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Text="LOADING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		Def.Sprite {
			Texture = THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")),
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68*WideScreenDiff()) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Text="LOADING...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()) end
		},
		Def.Sprite {
			Texture = THEME:GetPathG("","_disk "..(isFinal() and "final" or "normal")),
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