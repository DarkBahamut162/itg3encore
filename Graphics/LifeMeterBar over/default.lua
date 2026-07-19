if isTopScreen('ScreenGameplaySyncMachine') then return Def.ActorFrame{} end
return (isTopScreen("ScreenDemonstration2") and not AnyIIDXFrame()) and Def.ActorFrame{
    loadfile(THEME:GetPathG("LifeMeterBar","over/"..GetSongFrame()))()
} or Def.ActorFrame{}