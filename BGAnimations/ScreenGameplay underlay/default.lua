local t = Def.ActorFrame{ Name="GameplayUnderlay" }
local stats = false

if getenv("ShowStatsP1") == nil and getenv("ShowStatsP2") == nil then
elseif getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0 or getenv("ShowNoteGraphP1") > 1 or getenv("ShowNoteGraphP2") > 1 then
	stats = true
end

t[#t+1] = Def.ActorFrame{
	LoadActor("ScreenFilter"),
	LoadActor("beginner")..{ Condition=isRegular() and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner' },
	LoadActor("stepstats")..{ Condition=stats },
	LoadActor("danger")..{ Condition=not isOni() and PREFSMAN:GetPreference("ShowDanger") },
	LoadActor("dead")
}

return t