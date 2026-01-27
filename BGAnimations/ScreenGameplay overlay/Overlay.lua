local pn = ...
local mask = false
local iidx = IsGame("beat") or IsGame("be-mu")
if #GAMESTATE:GetHumanPlayers() == 2 then
    if iidx and GetIIDXFrame(PLAYER_1) ~= GetIIDXFrame(PLAYER_2) or GetSongFrame(PLAYER_1) ~= GetSongFrame(PLAYER_2) then mask = true end
end

return Def.ActorFrame{
    Def.Quad{
        Condition=mask,
        OnCommand=function(self) self:x(pn == PLAYER_1 and SCREEN_RIGHT or SCREEN_LEFT):halign(pn == PLAYER_1 and 1 or 0):valign(0):zoomto(SCREEN_WIDTH/2,SCREEN_HEIGHT):MaskSource(true) end
    },
    loadfile(THEME:GetPathB("ScreenGameplay","overlay/"..(iidx and GetIIDXFrame(pn) or GetSongFrame(pn))))(Update)..{
        BeginCommand=function(self) if mask then self:MaskDest() end end
    },
    Def.ActorFrame{
        Condition=not isVS(),
        loadfile(THEME:GetPathG("LifeMeterBar","over/"..GetSongFrame(pn)))(pn)..{
            InitCommand=function(self)
                self:name("Life"..pname(pn))
                ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
            end
        }
    }
}