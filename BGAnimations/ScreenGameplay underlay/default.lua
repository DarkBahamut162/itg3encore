local t = Def.ActorFrame{ Name="GameplayUnderlay" }
local stats = false

if getenv("ShowStatsP1") == nil and getenv("ShowStatsP2") == nil then
elseif getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0 or getenv("ShowNoteGraphP1") > 1 or getenv("ShowNoteGraphP2") > 1 then
	stats = true
end

t[#t+1] = Def.ActorFrame{
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/ScreenFilter"))(),
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/beginner"))()..{ Condition=isRegular() and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner' },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats"))()..{ Condition=stats },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/danger"))()..{ Condition=not isOni() and PREFSMAN:GetPreference("ShowDanger") },
	loadfile(THEME:GetPathB("ScreenGameplay","underlay/dead"))()
}

return t