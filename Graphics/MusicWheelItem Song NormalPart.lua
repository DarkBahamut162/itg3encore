return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _Song NormalPart"..(isFinal() and "Final" or "Normal")
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
		Def.Sprite{
			Condition=isOutFox(),
			InitCommand=function(self) self:Load( THEME:GetPathB("","_thanks/_outfox/logo") ):xy(120,-12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_1)):effectcolor2(PlayerColorSemi(PLAYER_1)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = false

					if isOutFoxV() then
						isFav = GetPlayerOrMachineProfile(PLAYER_1):SongIsFavorite(params.Song)
					elseif isOutFox() then
						isFav = FindInTable(params.Song, getOFFavorites(PLAYER_1))
					end

					if isFav then
						local spmp = tonumber(VersionDate()) > 20150300 and params.Song:GetPreviewMusicPath() or " "
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		Def.Sprite{
			Condition=ThemePrefs.Get("SLFavorites"),
			InitCommand=function(self) self:Load( THEME:GetPathB("ScreenEndingOkay","overlay/intro/arrow") ):xy(104,-12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_1)):effectcolor2(PlayerColorSemi(PLAYER_1)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = isEtterna() and params.Song:IsFavorited() or FindInTable(params.Song, getSLFavorites(ToEnumShortString(PLAYER_1)))

					if isFav then
						local spmp = tonumber(VersionDate()) > 20150300 and params.Song:GetPreviewMusicPath() or " "
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		}
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
		Def.Sprite{
			Condition=isOutFox(),
			InitCommand=function(self) self:Load( THEME:GetPathB("","_thanks/_outfox/logo") ):xy(120,12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_2)):effectcolor2(PlayerColorSemi(PLAYER_2)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = false

					if isOutFoxV() then
						isFav = GetPlayerOrMachineProfile(PLAYER_2):SongIsFavorite(params.Song)
					elseif isOutFox() then
						isFav = FindInTable(params.Song, getOFFavorites(PLAYER_2))
					end

					if isFav then
						local spmp = tonumber(VersionDate()) > 20150300 and params.Song:GetPreviewMusicPath() or " "
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		Def.Sprite{
			Condition=ThemePrefs.Get("SLFavorites"),
			InitCommand=function(self) self:Load( THEME:GetPathB("ScreenEndingOkay","overlay/intro/arrow") ):xy(104,12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(PlayerColor(PLAYER_2)):effectcolor2(PlayerColorSemi(PLAYER_2)) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = FindInTable(params.Song, getSLFavorites(ToEnumShortString(PLAYER_2)))

					if isFav then
						local spmp = tonumber(VersionDate()) > 20150300 and params.Song:GetPreviewMusicPath() or " "
						self:effectclock(spmp ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		}
	}
}