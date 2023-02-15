local t = Def.ActorFrame{ Name="GameplayUnderlay" }
local stats = false

if getenv("ShowStatsP1") == nil and getenv("ShowStatsP2") == nil then
elseif getenv("ShowStatsP1") > 0 or getenv("ShowStatsP2") > 0 then
	stats = true
end

t[#t+1] = Def.ActorFrame{
	LoadActor("ScreenFilter"),
	LoadActor("beginner")..{ Condition=isPlayMode('PlayMode_Regular') and GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner' and IsGame("dance") },
	LoadActor("stepstats")..{ Condition=stats },
	LoadActor("danger")..{ Condition=not isOni() },
	LoadActor("dead")
}
if isGamePlay() then
	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		t[#t+1] = LoadActor("DeltaSeconds", player)..{ Condition=isOni() and not isLifeline(player) }
		t[#t+1] = LoadActor("Score", player)..{ Condition=not isOni() or isLifeline(player) }
	end
end

return t