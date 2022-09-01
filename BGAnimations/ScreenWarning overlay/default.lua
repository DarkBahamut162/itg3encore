local coinMode = GAMESTATE:GetCoinMode()

local platformType
if coinMode == 'CoinMode_Home' then platformType = "home"
else platformType = "arcade"
end

return Def.ActorFrame{
	LoadActor(platformType)..{
		InitCommand=function(self) self:rotationx(5) end
	},
	LoadActor(THEME:GetPathB("","lolhi"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-130):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):zoom(0.5) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:linear(1):cropleft(-0.3):zoom(1.6):linear(7):zoom(1.2) end,
		OffCommand=function(self) self:stoptweening():linear(0.5):cropright(1.3):zoom(0.5) end
	},
	LoadActor(THEME:GetPathB("_red2","streak"))..{
		InitCommand=function(self) self:diffusealpha(0):zoom(0.5):CenterX():y(SCREEN_CENTER_Y-132):zoom(2.25):sleep(0.8):accelerate(0.8):diffusealpha(1):sleep(0.7):decelerate(0.8):diffusealpha(0) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:linear(1):cropleft(-0.3):zoom(1.6):linear(7):zoom(1.2) end,
		OffCommand=function(self) self:stoptweening():linear(0.5):cropright(1.3):zoom(0.5) end
	},
	LoadActor("extreme motions")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+40):y(SCREEN_CENTER_Y-130):zoom(0.91):diffusealpha(0) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:sleep(0.50):linear(0.25):diffusealpha(1):zoom(0.9):linear(3.5):zoom(0.83):sleep(0):accelerate(0.3):diffusealpha(0):zoom(0.8) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH*1.5) end
	},
	LoadActor("be careful")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+40):y(SCREEN_CENTER_Y-130):zoom(0.905):diffusealpha(0) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:sleep(4.3):linear(0.25):diffusealpha(1):zoom(0.9):linear(4.5):zoom(0.8):accelerate(0.5):addx(SCREEN_WIDTH) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH*1.5) end
	},
	LoadActor("exclamation normal")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-240):y(SCREEN_CENTER_Y-130):glow(color("1,1,1,1")):addx(-SCREEN_WIDTH*.5) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:sleep(0.5):decelerate(0.5):addx(SCREEN_WIDTH*.5):glowshift():effectclock("beat"):effectoffset(1):effectperiod(2):sleep(8.2):accelerate(0.5):addx(-SCREEN_WIDTH) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end
	},
	LoadActor("cyan_arrow")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+450) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:sleep(0.5):decelerate(0.4):addy(-350):decelerate(8.5):addy(-30) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.2):y(SCREEN_TOP-100) end
	},
	LoadActor("caution_txt")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+45):y(SCREEN_CENTER_Y+110):addx(SCREEN_WIDTH/1.2) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:sleep(0.5):decelerate(0.4):addx(-SCREEN_WIDTH/1.2):decelerate(9):addx(-40) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.2):x(-SCREEN_LEFT-150) end
	},
	LoadActor(THEME:GetPathB("_join","overlay"))
}