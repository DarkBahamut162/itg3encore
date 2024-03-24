return Def.ActorFrame{
	LoadActor("MusicWheelItem _Song NormalPart"..(isFinal() and "Final" or "Normal"))..{
		SetMessageCommand=function(self,params)
			if isOutFoxV() and params.Song then
				local isFav = false

				for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
					if not isFav then 
						isFav = PROFILEMAN:GetProfile(pn):SongIsFavorite(params.Song)
					end
				end

				if isFav then
					self:diffuseshift():effectcolor1(color("#FFFF00")):effectcolor2(color("#FFFFFF")):effectclock("beat")
				else
					self:stopeffect()
				end
			end
		end
	}
}