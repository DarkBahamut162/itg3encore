local pn = ...
local mask = false
if #GAMESTATE:GetHumanPlayers() == 2 and GetSongFrame(PLAYER_1) ~= GetSongFrame(PLAYER_2) then mask = true end

return Def.ActorFrame{
    Def.Quad{
        Condition=mask,
        OnCommand=function(self) self:x(pn == PLAYER_1 and SCREEN_RIGHT or SCREEN_LEFT):halign(pn == PLAYER_1 and 1 or 0):valign(0):zoomto(SCREEN_WIDTH/2,SCREEN_HEIGHT/2):MaskSource(true) end
    },
    loadfile(THEME:GetPathB("ScreenGameplay","overlay/"..GetSongFrame(pn)))(Update)..{
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