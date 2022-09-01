return Def.ActorFrame{
    LoadActor("player pane")..{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
        OnCommand=function(self) self:x(SCREEN_CENTER_X-246):y(SCREEN_CENTER_Y+140):diffusealpha(0.5) end
    },
    LoadActor("player pane")..{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
        OnCommand=function(self) self:x(SCREEN_CENTER_X+246):y(SCREEN_CENTER_Y+140):diffusealpha(0.5) end
    },
    LoadFont("_r bold 30px")..{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
        Text=ScreenEndingGetDisplayName(PLAYER_1),
		OnCommand=function(self) self:x(SCREEN_CENTER_X-246):y(SCREEN_CENTER_Y+100):zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
    },
    LoadFont("_r bold 30px")..{
		Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
        Text=ScreenEndingGetDisplayName(PLAYER_2),
		OnCommand=function(self) self:x(SCREEN_CENTER_X+246):y(SCREEN_CENTER_Y+100):zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
    }
}