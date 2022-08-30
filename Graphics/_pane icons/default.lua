return Def.ActorFrame{
	LoadActor("_jump")..{
		InitCommand=function(self) self:x(-127+100):y(225+5):shadowlength(2) end,
		OnCommand=function(self) self:decelerate(0.3):y(125+5) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
	},
	LoadActor("_hold")..{
		InitCommand=function(self) self:x(-102+100):y(225+5):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.1):decelerate(0.3):y(125+5) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
	},
	LoadActor("_mine")..{
		InitCommand=function(self) self:x(-77+100):y(225+5):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.2):decelerate(0.3):y(125+5) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
	},
	LoadActor("_hand")..{
		InitCommand=function(self) self:x(-52+100):y(225+5):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.3):decelerate(0.3):y(125+5) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
	},
	LoadActor("_roll")..{
		InitCommand=function(self) self:x(-27+100):y(225+5):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.4):decelerate(0.3):y(125+5) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
	},
	LoadActor("_textmask")..{
		InitCommand=function(self) self:x(-77+100):y(130):zbuffer(true):blend('BlendMode_NoEffect') end
	}
}