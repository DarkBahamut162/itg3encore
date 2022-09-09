return Def.ActorFrame{
    Def.ActorFrame{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_1),
        LoadActor("player pane")..{
            OnCommand=function(self) self:x(SCREEN_CENTER_X-246):y(SCREEN_CENTER_Y+140):diffusealpha(0.5) end
        },
        LoadFont("_r bold 30px")..{
            Text=ScreenEndingGetDisplayName(PLAYER_1),
            OnCommand=function(self) self:x(SCREEN_CENTER_X-246):y(SCREEN_CENTER_Y+100):zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_1)) end
        },
        LoadActor(THEME:GetPathG('ScreenEnding', 'card p1'))..{
            Condition=HumanAndProfile(PLAYER_1),
            InitCommand=function(self) self:x(SCREEN_CENTER_X-248):y(SCREEN_CENTER_Y+162) end
        }
    },
    Def.ActorFrame{
        Condition=GAMESTATE:IsHumanPlayer(PLAYER_2),
        LoadActor("player pane")..{
            OnCommand=function(self) self:x(SCREEN_CENTER_X+246):y(SCREEN_CENTER_Y+140):diffusealpha(0.5) end
        },
        LoadFont("_r bold 30px")..{
            Text=ScreenEndingGetDisplayName(PLAYER_2),
            OnCommand=function(self) self:x(SCREEN_CENTER_X+246):y(SCREEN_CENTER_Y+100):zoom(0.7):shadowlength(2):diffuse(PlayerColor(PLAYER_2)) end
        },
        LoadActor(THEME:GetPathG('ScreenEnding', 'card p2'))..{
            Condition=HumanAndProfile(PLAYER_2),
            InitCommand=function(self) self:x(SCREEN_CENTER_X+248):y(SCREEN_CENTER_Y+162) end
        }
    }
}