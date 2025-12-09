local t = Def.ActorFrame{ Name="GameplayUnderlay" }
local stats = false

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if (getenv("ShowStats"..pname(pn)) and getenv("ShowStats"..pname(pn)) > 0) or (getenv("PlayerNoteGraph"..pname(pn)) and getenv("PlayerNoteGraph"..pname(pn)) > 1) then
		stats = true
	end
end

local beginnerHelper = PREFSMAN:PreferenceExists("ShowBeginnerHelper") and tobool(PREFSMAN:GetPreference("ShowBeginnerHelper")) or false

t[#t+1] = Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/beginner"))()..{ Condition=beginnerHelper and isRegular() and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner' },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats"))()..{ Condition=stats }
}

return t