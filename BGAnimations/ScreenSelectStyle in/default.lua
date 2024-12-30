if GAMESTATE:GetCoinMode()=='CoinMode_Home' then
    return Def.ActorFrame{ loadfile(THEME:GetPathB("_fade in","normal"))() }
end

return Def.ActorFrame{ loadfile(THEME:GetPathB("_menu","in"))() }