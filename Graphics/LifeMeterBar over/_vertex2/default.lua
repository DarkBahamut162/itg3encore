local pn = ...

return Def.ActorFrame{
    loadfile(THEME:GetPathG("LifeMeterBar","over/_vertex0"))(pn,2)
}