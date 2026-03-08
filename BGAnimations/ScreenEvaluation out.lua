if getenv("Restarting") then
    setenv("Restarting",false)
    return loadfile(THEME:GetPathB("_fade out","normal"))()
else
    return loadfile(THEME:GetPathB("_menu","out"))()
end