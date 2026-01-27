return (isTopScreen("ScreenDemonstration2") and not AnyIIDXFrame()) and Def.ActorFrame{
    loadfile(THEME:GetPathG("LifeMeterBar","over/"..GetSongFrame()))()
} or Def.ActorFrame{}