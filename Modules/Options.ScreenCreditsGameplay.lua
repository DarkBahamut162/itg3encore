return function()
	local name = "StepMania Credits"
	if isOutFox() then
		name = "OutFox Credits"
	elseif isITGmania() then
		name = "ITGmania Credits"
	elseif isEtterna() then
		name = "Etterna Credits"
	end
	if GAMESTATE:GetCurrentGame():GetName() == "dance" then
		local Song
		local Songs = SONGMAN:GetSongsInGroup("OutFox")
		if #Songs > 0 then
			for _,song in ipairs(Songs) do
				if string.find(song:GetDisplayMainTitle(), "After The Ending") then Song = song end
			end
		else
			Songs = SONGMAN:GetSongsInGroup("OutFox Serenity Volume 1")
			if #Songs > 0 then
				for _,song in ipairs(Songs) do
					if string.find(song:GetDisplayMainTitle(), "After The Ending") then Song = song end
				end
			end
		end
		if Song then
			GAMESTATE:SetCurrentPlayMode("PlayMode_Regular")
			GAMESTATE:SetCurrentSong(Song)
			GAMESTATE:SetCurrentStyle('versus')
			GAMESTATE:SetCurrentSteps(PLAYER_1,Song:GetAllSteps()[3])
			GAMESTATE:SetCurrentSteps(PLAYER_2,Song:GetAllSteps()[3])

			return "ScreenCreditsGameplay;name,"..name
		else
			return "ScreenCredits;name,"..name
		end
	end
	return "ScreenCredits;name,"..name
end