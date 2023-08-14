return Def.ActorFrame{
	LoadActor(THEME:GetPathG("","_bar"))..{
		InitCommand=function(self) self:x(22):diffusealpha(0):sleep(0.1):linear(0.3):diffusealpha(1) end,
		OnCommand=function(self) self:diffuseshift():effectcolor1(color("#0000CC")):effectcolor2(color("#ffffff")):effectoffset(0):effectclock('beat') end,
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end
	},
	LoadActor("p2a "..(isFinal() and "final" or "normal"))..{
		InitCommand=function(self) self:x(158):diffusealpha(0) end,
		OnCommand=function(self) self:linear(0.4):diffusealpha(1):bounce():effectmagnitude(3,0,0):effectperiod(1.0):effectoffset(0.2):effectclock("beat") end
	}
}