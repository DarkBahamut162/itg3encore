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
		end
	}
}