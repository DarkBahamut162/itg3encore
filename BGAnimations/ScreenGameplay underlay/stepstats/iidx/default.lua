if isTopScreen('ScreenJukebox') then return Def.ActorFrame{} end

local t = Def.ActorFrame{}

for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = loadfile(THEME:GetPathB("ScreenGameplay","underlay/stepstats/iidx/single"))(pn)
end

return t