if not inSessionProfileSwitch then
    return Def.ActorFrame{ loadfile(THEME:GetPathB("_fade out","normal"))() }
end

return Def.ActorFrame{ loadfile(THEME:GetPathB("_prompt in","normal"))() }