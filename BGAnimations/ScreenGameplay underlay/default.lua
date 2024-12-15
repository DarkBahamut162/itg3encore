local t = Def.ActorFrame{ Name="GameplayUnderlay" }
local stats = false

for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	if (getenv("ShowStats"..pname(pn)) and getenv("ShowStats"..pname(pn)) > 0) or (getenv("ShowNoteGraph"..pname(pn)) and getenv("ShowNoteGraph"..pname(pn)) > 0) then
		stats = true
	end
end

t[#t+1] = Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/ScreenFilter"))(),
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/beginner"))()..{ Condition=isRegular() and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner' },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats"))()..{ Condition=stats },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/danger"))()..{ Condition=not isOni() and PREFSMAN:GetPreference("ShowDanger") },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/dead"))()
}

return t