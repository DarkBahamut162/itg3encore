return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheelItem _Song NormalPart"..(isFinal() and "Final" or "Normal"),
		SetMessageCommand=function(self,params)
			if isOutFoxV() and params.Song then
				local isFav = {PLAYER_1 = false, PLAYER_2 = false}

				for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
					if not isFav[pn] then 
						isFav[pn] = PROFILEMAN:GetProfile(pn):SongIsFavorite(params.Song)
					end
				end

				if isFav[PLAYER_1] or isFav[PLAYER_2] then
					self:diffuseshift():effectcolor1(color(isFav[PLAYER_1] and "#FFDE00" or "#FFFFFF")):effectcolor2(color(isFav[PLAYER_2] and "#14FF00" or "#FFFFFF")):effectclock(params.Song:GetPreviewMusicPath() ~= "" and "beat" or "timerglobal")
				else
					self:stopeffect()
				end
			end
		end
	}
}