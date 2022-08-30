local color1 = color("#00EAFF")
local color2 = color("FFFFFF00")
local vertexOn = false

if GAMESTATE:GetCurrentSong() then
	if GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove/VerTex') then vertexOn = true color1 = color("0,1,0,1") end
	if GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 2/VerTex²') then vertexOn = true color1 = color("1,0,0,1") end
	if GAMESTATE:GetCurrentSong() == SONGMAN:FindSong('In The Groove 3/VerTex^3') then vertexOn = true color1 = color("1,0,1,1") end
end

return Def.ActorFrame{
	Def.ActorFrame{
		Name="VertexLights",
		LoadActor("light")..{
			InitCommand=function(self) self:blend(Blend.Add):addx(-146):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color1):effectcolor2(color2):effectclock('beat'):effectperiod(4) end
		},
		LoadActor("light")..{
			InitCommand=function(self) self:blend(Blend.Add):addx(-164):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color1):effectcolor2(color2):effectclock('beat'):effectperiod(4) end
		}
	},

	LoadActor("base")..{ InitCommand=function(self) self:addx(-5) if vertexOn then self:diffusecolor(color1) end end },
	LoadActor("streak")..{
		InitCommand=function(self) self:addx(-155):addx(-100) if vertexOn then self:diffusecolor(color1) end end,
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addx(100) end
	},
	LoadActor("streak")..{
		InitCommand=function(self) self:addx(-174):addx(-100) if vertexOn then self:diffusecolor(color1) end end,
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addx(100) end
	},
	LoadActor("glow2")..{
		InitCommand=function(self) self:blend(Blend.Add):addx(-5):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(1.8):decelerate(0.3):diffusealpha(1):sleep(0.2):accelerate(0.6):diffusealpha(0):queuecommand("Destroy") end,
		DestroyCommand=function(self) self:visible(false) end
	}
}