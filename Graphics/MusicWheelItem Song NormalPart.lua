return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _Song NormalPart"..(isFinal() and "Final" or "Normal")
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
		Def.Sprite{
			Condition=isOutFox(),
			InitCommand=function(self) self:Load( THEME:GetPathB("","_thanks/_outfox/logo") ):xy(120,-12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFDE00FF")):effectcolor2(color("#FFDE0080")) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = false

					if isOutFoxV() then
						isFav = PROFILEMAN:GetProfile(PLAYER_1):SongIsFavorite(params.Song)
					elseif isOutFox() then
						isFav = FindInTable(params.Song, getOFFavorites(ToEnumShortString(PLAYER_1)))
					end

					if isFav then
						self:effectclock(params.Song:GetPreviewMusicPath() ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		Def.Sprite{
			Condition=ThemePrefs.Get("SLFavorites"),
			InitCommand=function(self) self:Load( THEME:GetPathB("ScreenEndingOkay","overlay/intro/arrow") ):xy(104,-12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#FFDE00FF")):effectcolor2(color("#FFDE0080")) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = FindInTable(params.Song, getSLFavorites(ToEnumShortString(PLAYER_1)))

					if isFav then
						self:effectclock(params.Song:GetPreviewMusicPath() ~= "" and "beat" or "timerglobal"):visible(true)
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
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#14FF00FF")):effectcolor2(color("#14FF0080")) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = false

					if isOutFox() then
						isFav = FindInTable(params.Song, getOFFavorites(ToEnumShortString(PLAYER_2)))
					elseif isOutFoxV() then
						isFav = PROFILEMAN:GetProfile(PLAYER_2):SongIsFavorite(params.Song)
					end

					if isFav then
						self:effectclock(params.Song:GetPreviewMusicPath() ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		},
		Def.Sprite{
			Condition=ThemePrefs.Get("SLFavorites"),
			InitCommand=function(self) self:Load( THEME:GetPathB("ScreenEndingOkay","overlay/intro/arrow") ):xy(104,12):setsize(16,16):visible(false) end,
			OnCommand=function(self) self:diffuseshift():effectcolor1(color("#14FF00FF")):effectcolor2(color("#14FF0080")) end,
			SetCommand=function(self,params)
				if params.Song then
					local isFav = FindInTable(params.Song, getSLFavorites(ToEnumShortString(PLAYER_2)))

					if isFav then
						self:effectclock(params.Song:GetPreviewMusicPath() ~= "" and "beat" or "timerglobal"):visible(true)
					else
						self:visible(false)
					end
				end
			end
		}
	}
}