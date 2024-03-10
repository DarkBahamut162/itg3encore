if GAMESTATE:GetCoinMode()=='CoinMode_Free' then
    if PREFSMAN:GetPreference("ShowCaution") then
        return Def.ActorFrame{ LoadActor(THEME:GetPathB("_menu","in")) }
    end
end

return Def.ActorFrame{ LoadActor(THEME:GetPathB("_fade in","normal")) }