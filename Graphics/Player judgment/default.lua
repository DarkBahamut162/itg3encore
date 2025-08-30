local player = Var "Player"

return Def.ActorFrame{
	loadfile(THEME:GetPathG("Player","judgment/IIDX"))(player)..{Condition=IsGame("be-mu") or IsGame("beat")},
	loadfile(THEME:GetPathG("Player","judgment/ITG"))(player)..{Condition=not (IsGame("be-mu") or IsGame("beat"))}
}