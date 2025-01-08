return isTopScreen("ScreenDemonstration2") and Def.ActorFrame{
    loadfile(THEME:GetPathG("LifeMeterBar","over/"..GetSongFrame()))()
} or Def.ActorFrame{}