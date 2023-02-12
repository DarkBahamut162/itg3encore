if GAMESTATE:GetCoinMode()=='CoinMode_Free' then
    return Def.ActorFrame{ LoadActor(THEME:GetPathB("_menu","in")) }
elseif GAMESTATE:GetCoinMode()=='CoinMode_Home' then
    return Def.ActorFrame{ LoadActor(THEME:GetPathB("_fade in","normal")) }
end