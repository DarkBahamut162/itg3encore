return 	Def.ActorFrame {
	Def.SongMeterDisplay {
		StreamWidth=104,
		Stream=Def.Quad { InitCommand=function(self) self:diffusealpha(0) end },
		Tip=Def.Sprite {
			Texture = "SONG_TIP",
			InitCommand=function(self) self:diffuseshift():effectclock('bgm'):effectperiod(2):effectcolor1(1,1,1,1):effectcolor2(1,1,1,.8):y(-5) end,
			OnCommand=function(self) self:addx(42):diffusealpha(0):sleep(.4):linear(.2):diffusealpha(1):decelerate(1):addx(-42) end,
			OffCommand=function(self) self:diffusealpha(1) end
		}
	}
}