local curitem = 1
local profile_location = "Save/LocalProfiles/".. GAMESTATE:GetEditLocalProfileID() .."/OutFoxPrefs.ini"
local maximum_array_size = math.floor( SCREEN_WIDTH / 96 / 0.75)
local img_cache = LoadModule("Profile.GetAvatarImageArray.lua")()
local imgsave = LoadModule("Config.Load.lua")("AvatarImage", profile_location ) or THEME:GetPathG("UserProfile","generic icon")
local yarrayamm = (#img_cache / maximum_array_size)
local menu_start = SCREEN_CENTER_Y*WideScreenSemiDiff()
local spacingyscale = 14
local spacingxscale = 71.6
local lastX = 0
local lastY = 0
local curX = 0
local curY = 0
local delta = 0

local t = Def.ActorFrame{
    ChangeItemsMessageCommand=function(self,param)
        local c = param.item
        local Sel = self:GetChild("Selector")
        local CImg = self:GetChild("InfoFrame"):GetChild("CurImage")
        local CTex = self:GetChild("InfoFrame"):GetChild("CurText")

        lastX = curX
        lastY = curY

        curX = 50*WideScreenSemiDiff()+math.mod( c-1, maximum_array_size )*spacingxscale
        curY = menu_start+(
            math.mod( c > maximum_array_size*6 and maximum_array_size*5 or c-1, maximum_array_size*6)
            -
            math.mod( c > maximum_array_size*6 and maximum_array_size*5 or c-1, maximum_array_size)
        )*spacingyscale

        Sel:stoptweening():decelerate(0.1):xy(curX,curY)
        CImg:Load( img_cache[c][2] ):setsize(96,96)
        CTex:settext( string.gsub( img_cache[c][1], ".png", "" ) )
        if lastX ~= curX or lastY ~= curY then
            MESSAGEMAN:Broadcast("Next")
        end
    end
}

local ImgGrid = Def.ActorFrame{
    ScrollGridMessageCommand=function(self,param) self:stoptweening():decelerate(0.2):y( -80*(param.tileoffset-5) ) end
}

if #img_cache > 0 then
    for i,v in pairs( img_cache ) do
        -- Look if we have an existing image with the listing.
        if imgsave and tostring(imgsave) == v[2] then curitem = i end
        ImgGrid[#ImgGrid+1] = Def.ActorFrame{
            OnCommand=function(self)
                self:xy( 50*WideScreenSemiDiff()+math.mod( i-1, maximum_array_size )*spacingxscale,
                menu_start+( math.mod(i-1, maximum_array_size*yarrayamm)-math.mod(i-1, maximum_array_size) )*spacingyscale )
            end,
            Def.Sprite{
                Texture = v[2],
                OnCommand=function(self) self:setsize(64,64):diffusealpha(0):addy(20):sleep(0.004*i):decelerate(0.1):addy(-20):diffusealpha(1) end,
                OffCommand=function(self) self:stoptweening():sleep( 0.004*i):accelerate(0.1):addy(20):diffusealpha(0) end,
            },
        }
    end
    t[#t+1] = ImgGrid
end

t[#t+1] = Def.Quad{
    Name = "Selector",
    Condition = #img_cache > 0,
    OnCommand=function(self)
        self:zoomto(64,64):diffuseshift():effectcolor1( color("#FFFFFF99") ):effectcolor2( color("#FFFFFF00") ):xy(
            50*WideScreenSemiDiff()+math.mod( curitem-1, maximum_array_size )*spacingxscale,
            menu_start+( math.mod(curitem-1, maximum_array_size*yarrayamm)-math.mod(curitem-1, maximum_array_size) )*spacingyscale
        ):diffusealpha(0):sleep(0.24):linear(0.1):diffusealpha(1)
    end,
    OffCommand=function(self) self:linear(0.2):diffusealpha(0) end
}

t[#t+1] = Def.ActorFrame{
    Name = "InfoFrame",
    InitCommand=function(self) self:zoom(WideScreenDiff()) end,
    OnCommand=function(self) self:diffusealpha(0):addy(-20):decelerate(0.2):addy(20):diffusealpha(1) end,
    OffCommand=function(self) self:accelerate(0.2):addy(-20):diffusealpha(0) end,
    Def.BitmapText{
        Font = "Common Normal",
        InitCommand=function(self) self:settext( "Before" ) end,
        OnCommand=function(self) self:xy( 38, 136-60 ):zoom(0.75):halign(0) end
    },
    Def.Sprite{
        Name = "SetImage",
        InitCommand=function(self) self:Load( imgsave ) end,
        OnCommand=function(self) self:xy( 38, 136 ):halign(0):setsize(96,96) end
    },
    Def.BitmapText{
        Font = "Common Normal",
        InitCommand=function(self) self:settext( "=>" ) end,
        OnCommand=function(self) self:xy( 48+96, 136 ):zoom(0.75):halign(0) end
    },
    Def.BitmapText{
        Font = "Common Normal",
        InitCommand=function(self) self:settext( "After" ) end,
        OnCommand=function(self) self:xy( 38+140, 136-60 ):zoom(0.75):halign(0) end
    },
    Def.Sprite{
        Condition = #img_cache > 0,
        Name = "CurImage",
        InitCommand=function(self) self:Load( img_cache[curitem][2] ) end,
        OnCommand=function(self) self:xy( 38+140, 136 ):halign(0):setsize(96,96) end
    },
    Def.BitmapText{
        Condition = #img_cache > 0,
        Name = "CurText",
        Font = "Common Normal",
        InitCommand=function(self) self:settext( string.gsub( img_cache[curitem][1], ".(^)", "" ) ) end,
        OnCommand=function(self) self:xy( 50+236, 136 ):zoom(0.75):halign(0) end
    }
}

t[#t+1] = Def.BitmapText{
    Condition = #img_cache < 1,
    Name = "CurText",
    Font = "Common Normal",
    Text = "There are no avatars loaded on your Appearance folder.\nGo to Appearance/Avatars and drop some images in.",
    OnCommand=function(self) self:xy(SCREEN_CENTER_X,SCREEN_CENTER_Y):zoom(WideScreenDiff()) end
}

local ChangeInput = function(offset)
    curitem = curitem + offset
    if curitem < 1 then curitem = 1 end
    if curitem > #img_cache then curitem = #img_cache end
    MESSAGEMAN:Broadcast("ChangeItems",{item=curitem})
    MESSAGEMAN:Broadcast("ScrollGrid",{tileoffset=curitem > maximum_array_size*6 and math.floor( (curitem-1)/maximum_array_size) or 5 })
end

local Inputs = {
    ["MenuLeft"] = function() ChangeInput(-1) end,
    ["MenuDown"] = function() ChangeInput(maximum_array_size) end,
    ["MenuUp"] = function() ChangeInput(-maximum_array_size) end,
    ["MenuRight"] = function() ChangeInput(1) end,
    ["Start"] = function()
        if #img_cache > 0 then
            LoadModule("Config.Save.lua")( "AvatarImage", img_cache[curitem][2], profile_location )
        end
        SCREENMAN:PlayStartSound()
        SCREENMAN:GetTopScreen():StartTransitioningScreen( "SM_GoToNextScreen", 0 )
    end,
    ["Back"] = function()
        SCREENMAN:PlayCancelSound()
        SCREENMAN:GetTopScreen():StartTransitioningScreen( "SM_GoToPrevScreen", 0 )
    end
}

local Controller = function(event)
    if event.type == "InputEventType_FirstPress" then
        if Inputs[event.GameButton] then
            Inputs[event.GameButton]()
        end
    end
end

t.OnCommand=function() SCREENMAN:GetTopScreen():AddInputCallback( Controller ) end
t.OffCommand=function() SCREENMAN:GetTopScreen():RemoveInputCallback( Controller ) end
t.MouseWheelUpMessageCommand=function()
    if GetTimeSinceStart() - delta > 1/60 then
        delta = GetTimeSinceStart()
        ChangeInput(-1)
    end
end
t.MouseWheelDownMessageCommand=function()
    if GetTimeSinceStart() - delta > 1/60 then
        delta = GetTimeSinceStart()
        ChangeInput(1)
    end
end

t[#t+1] = Def.Sound{
	File = THEME:GetPathS("ScreenOptions","change"),
	IsAction = true,
	ChangeMessageCommand=function(self) self:play() end
}

t[#t+1] = Def.Sound{
	File = THEME:GetPathS("ScreenOptions","next"),
	IsAction = true,
	NextMessageCommand=function(self) self:play() end
}

return t