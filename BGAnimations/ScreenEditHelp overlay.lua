local t = Def.ActorFrame{
    OnCommand=function(self) SCREENMAN:GetTopScreen():AddInputCallback( LoadModule("Lua.InputSystem.lua")(self) ) end,
    ExitScreenCommand=function(self) SCREENMAN:GetTopScreen():StartTransitioningScreen( "SM_GoToNextScreen", 0 ) end,
    StartCommand=function(self) self:playcommand("ExitScreen") end,
    BackCommand=function(self) self:playcommand("ExitScreen") end
}

local NumColumns = GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()
local buttons = {
    Home=THEME:GetString("DeviceButton","Home"),
    End=THEME:GetString("DeviceButton","End"),
    Up=THEME:GetString("DeviceButton","Up"),
    Down=THEME:GetString("DeviceButton","Down"),
    Space=THEME:GetString("DeviceButton","Space"),
    Shift=THEME:GetString("DeviceButton","Shift"),
    Ctrl=THEME:GetString("DeviceButton","Ctrl"),
    Alt=THEME:GetString("DeviceButton","Alt"),
    Insert=THEME:GetString("DeviceButton","Insert"),
    Delete=THEME:GetString("DeviceButton","Delete"),
    PgUp=THEME:GetString("DeviceButton","PgUp"),
    PgDn=THEME:GetString("DeviceButton","PgDn"),
    Backslash=THEME:GetString("DeviceButton","Backslash"),
    Tab=THEME:GetString("DeviceButton","Tab"),
}
local HelpLines = {
    -- Name, Button 1, Button 2 [optional], Needs to be held or alternative (on is held)
    {"Move cursor",					                    buttons.Up,buttons.Down},
	{"Place Note",					                    1,NumColumns},
    {"Jump measure",					                buttons.PgUp,buttons.PgDn},
    {"Select region",					                buttons.Shift,buttons.Up.."/"..buttons.Down,true},
    {"Jump to first/last beat",			                buttons.Home,buttons.End},
	{"Jump to end of song",			                	buttons.Shift,buttons.End,true},
    {"Change zoom",					                    buttons.Ctrl,buttons.Up.."/"..buttons.Down,true},
    {"Play",						                    "P"},
    {"Play current beat to end",			            buttons.Shift,"P",true},
    {"Play whole song",				                    buttons.Ctrl,"P",true},
    {"Record",						                    buttons.Ctrl,"R", true},
	{"Go to beat",						               	"G"},
    {"Set selection",					                buttons.Tab},
    -- from new editor
    {"Preview from current beat",				        buttons.Space},
    {"Next/prev steps of same StepsType",		        "F5","F6"},
    {"Decrease/increase BPM at cur beat",		        "F7","F8"},
    {"Decrease/increase stop at cur beat",		        "F9","F10"},
    {"Decrease/increase delay at cur beat",		        buttons.Shift,"F9", true},
    {"Decrease/increase music offset",			        "F11","F12"},
    {"Decrease/increase sample music start",		    "[","]"},
    {"Decrease/increase sample music length",		    "{","}"},
    {"Play sample music",				                "L"},
    {"Add/Edit Background Change",			            "B [1]",buttons.Shift.."+".."B [2]"},
    {"Add/Edit Foreground Change",                      buttons.Alt,"B", true},
    {"Insert beat and shift down",			            buttons.Insert},
    {"Shift BPM changes and stops down one beat",	    buttons.Ctrl,buttons.Insert, true},
    {"Delete beat and shift up",			            buttons.Delete},
    {"Shift BPM changes and stops up one beat",	        buttons.Ctrl,buttons.Delete, true},
    {"Cycle between tap notes",			                "N","M"},
    {"Add to/remove from right half",			        buttons.Alt,"[1 / ".. NumColumns .."]", true},
    {"Switch Timing",					                "T"},
    {"Switch player (Routine only)",			        buttons.Backslash.." ( / )"},
}

t[#t+1] = Def.Quad{
    OnCommand=function(self) self:stretchto(SCREEN_WIDTH,SCREEN_HEIGHT,0,0):diffuse(Color.Black):diffusealpha(0.8) end
}

local textzoom = 0.6 * (SCREEN_HEIGHT/480) * WideScreenDiff()

for k,v in ipairs( HelpLines ) do
    local HelpLine = Def.ActorFrame{
        OnCommand=function(self) self:y(SAFE_HEIGHT-6+((14*(SCREEN_HEIGHT/480))*(k-1))) end
    }

    HelpLine[#HelpLine+1] = Def.BitmapText{ Font="Common Normal",
        Text=THEME:GetString("EditHelpDescription",v[1]),
        OnCommand=function(self) self:halign(0):x( SAFE_WIDTH ):zoom(textzoom) end
    }

    HelpLine[#HelpLine+1] = Def.BitmapText{ Name="Button1", Font="Common Normal", Text=v[2],
        OnCommand=function(self) self:halign(1):x( (SCREEN_RIGHT-SAFE_WIDTH)-80 ):zoom(textzoom) end
    }
    
    if v[3] then
        local CombineOrLine = v[4] and " + " or " / "
        HelpLine[#HelpLine+1] = Def.BitmapText{ Font="Common Normal", Name="Button2", Text=CombineOrLine..v[3],
            OnCommand=function(self) self:halign(0):x((SCREEN_RIGHT-SAFE_WIDTH)-80):zoom(textzoom) end
        }
    end

    t[#t+1] = HelpLine
end

return t