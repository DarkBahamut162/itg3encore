return Def.ActorFrame{
	Def.Sprite {
		Texture = "ScreenEvaluation _BannerFrame"..(isFinal() and "Final" or "Normal"),
		InitCommand=function(self)
			if ThemePrefs.Get("Recolor") then 
				if GAMESTATE:GetNumPlayersEnabled() == 1 or isDouble() then
					local diff = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber()):GetDifficulty()
					self:diffuse((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff)) or CustomDifficultyToColor(ToEnumShortString(diff)))
				else
					local diff1 = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()
					local diff2 = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()
					self:diffuseupperleft((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff1)) or CustomDifficultyToColor(ToEnumShortString(diff1)))
					self:diffuselowerleft((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff1)) or CustomDifficultyToColor(ToEnumShortString(diff1)))
					self:diffuseupperright((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff2)) or CustomDifficultyToColor(ToEnumShortString(diff2)))
					self:diffuselowerright((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff2)) or CustomDifficultyToColor(ToEnumShortString(diff2)))
				end
			end
		end,
		ChangeDisplayedFeatMessageCommand=function(self,param)
			if ThemePrefs.Get("Recolor") then 
				if GAMESTATE:IsCourseMode() then
					if GAMESTATE:GetNumPlayersEnabled() == 1 or isDouble() then
						local diff = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber()):GetDifficulty()
						self:diffuse((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff)) or CustomDifficultyToColor(ToEnumShortString(diff)))
					else
						local diff1 = GAMESTATE:GetCurrentTrail(PLAYER_1):GetDifficulty()
						local diff2 = GAMESTATE:GetCurrentTrail(PLAYER_2):GetDifficulty()
						self:diffuseupperleft((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff1)) or CustomDifficultyToColor(ToEnumShortString(diff1)))
						self:diffuselowerleft((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff1)) or CustomDifficultyToColor(ToEnumShortString(diff1)))
						self:diffuseupperright((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff2)) or CustomDifficultyToColor(ToEnumShortString(diff2)))
						self:diffuselowerright((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff2)) or CustomDifficultyToColor(ToEnumShortString(diff2)))
					end
				else
					local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
					local playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
					if GAMESTATE:GetNumPlayersEnabled() == 1 or isDouble() then
						local playerSS = playedSS:GetPlayerStageStats(param.Player)
						local steps = playerSS:GetPlayedSteps()[1]
						local diff = steps:GetDifficulty()
						self:diffuse((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff)) or CustomDifficultyToColor(ToEnumShortString(diff)))
					else
						local playerSS1 = playedSS:GetPlayerStageStats(PLAYER_1)
						local playerSS2 = playedSS:GetPlayerStageStats(PLAYER_2)
						local steps1 = playerSS1:GetPlayedSteps()[1]
						local steps2 = playerSS2:GetPlayedSteps()[1]
						local diff1 = steps1:GetDifficulty()
						local diff2 = steps2:GetDifficulty()
						self:diffuseupperleft((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff1)) or CustomDifficultyToColor(ToEnumShortString(diff1)))
						self:diffuselowerleft((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff1)) or CustomDifficultyToColor(ToEnumShortString(diff1)))
						self:diffuseupperright((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff2)) or CustomDifficultyToColor(ToEnumShortString(diff2)))
						self:diffuselowerright((IsGame("be-mu") or IsGame("beat")) and CustomIIDXDifficultyToColor(ToEnumShortString(diff2)) or CustomDifficultyToColor(ToEnumShortString(diff2)))
					end
				end
			end
		end
	}
}