local player = ...
local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(1):GetSong() or GAMESTATE:GetCurrentSong()
local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(1):GetSteps() or GAMESTATE:GetCurrentSteps(player)
local first = tonumber(LoadFromCache(SongOrCourse,StepsOrTrail,"TrueFirstSecond"))
local sleep = math.max(0.001,first-1.55)
local duration = math.min(1,first)

return Def.ActorFrame {
	InitCommand=function(self) if not (IsGame("beat") or IsGame("be-mu")) then self:CenterY() end end,
    Def.Sprite {
		Texture="GR/IIDX 1x9.png",
		Frame0000=0,
		Delay0000=sleep,
		Frame0001=0,
		Delay0001=duration/30,
		Frame0002=1,
		Delay0002=duration/30,
		Frame0003=2,
		Delay0003=duration/30,
		Frame0004=3,
		Delay0004=duration/30,
		Frame0005=4,
		Delay0005=duration/30,
		Frame0006=5,
		Delay0006=duration/30,
		Frame0007=6,
		Delay0007=duration/30,
		Frame0008=7,
		Delay0008=duration/30,
		Frame0009=8,
		Delay0009=1.5,
		InitCommand=function(self) self:loop(0):diffusealpha(0):sleep(sleep):diffusealpha(1):sleep(duration/3*2):linear(duration/3):diffusealpha(0) end
	},
	Def.ActorFrame {
		Def.Sprite {
			Texture="GR/GR1",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(-115):sleep(sleep+(duration/30)*8+(duration/24)*0):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR2",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(-83):sleep(sleep+(duration/30)*8+(duration/24)*1):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR3",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(-51):sleep(sleep+(duration/30)*8+(duration/24)*2):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR4",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(-13):sleep(sleep+(duration/30)*8+(duration/24)*3):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR5",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(19):sleep(sleep+(duration/30)*8+(duration/24)*4):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR6",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(51):sleep(sleep+(duration/30)*8+(duration/24)*5):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR7",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(83):sleep(sleep+(duration/30)*8+(duration/24)*6):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		},
		Def.Sprite {
			Texture="GR/GR8",
			InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0):x(115):sleep(sleep+(duration/30)*8+(duration/24)*7):diffusealpha(1):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		}
	},
	Def.ActorFrame {
		InitCommand=function(self) self:diffuseblink():effectcolor1(color("1,1,1,1")):effectcolor2(color("0,0,0,0")):effectperiod(1/20):effectclock("timerglobal") end,
		Def.Sprite {
			Texture="GR/line",
			InitCommand=function(self) self:diffusealpha(0):y(16):zoomx(0):zoomy(0.5):sleep(sleep):diffusealpha(1):linear((duration/30)*8+(duration/24)*7):zoomx(272):sleep(duration/24):linear(duration/24):diffusealpha(0) end
		}
	}
}