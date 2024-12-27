local initialLoad = false

return Def.ActorFrame{
	OnCommand=function(self) self:addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end,
	Def.ActorFrame{
		Name="Frame",
		Def.Sprite {
			Texture = "frame "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-18*WideScreenDiff()):zoom(WideScreenDiff()) end
		},
		Def.ActorFrame{
			Def.Sprite {
				Texture = "border red",
				InitCommand=function(self) self:x(SCREEN_CENTER_X+140*WideScreenDiff()):y(SCREEN_CENTER_Y-18*WideScreenDiff()):zoom(WideScreenDiff()) end,
				OnCommand=function(self) self:playcommand("Blink") end,
				BlinkCommand=function(self)
					self:diffuseshift():effectcolor1(color("#00000000")):effectcolor2(color("#00000000"))
					local song = GAMESTATE:GetCurrentSong()
					if song then
						local spmp = song:GetPreviewMusicPath()
						local effectclock = spmp ~= "" and "beat" or "timerglobal"
						if song:GetFirstSecond() <= 1 then
							self:effectcolor1(color("#FFFFFFFF")):effectclock(effectclock):effectcolor2(color("#FFFFFFFF"))
						elseif song:GetFirstSecond() <= 2 then
							self:effectcolor1(color("#FFFFFFFF")):effectclock(effectclock):effectcolor2(color("#FFFFFF80"))
						else
							self:effectcolor1(color("#00000000")):effectclock(effectclock):effectcolor2(color("#00000000"))
						end
					end
				end,
				CurrentSongChangedMessageCommand=function(self) self:playcommand("Blink") end
			}
		},
		Def.Sprite {
			Texture = "flare",
			InitCommand=function(self) self:x(SCREEN_CENTER_X+142*WideScreenDiff()):y(SCREEN_CENTER_Y-18*WideScreenDiff()):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0) end,
			RefreshCommand=function(self) self:stoptweening(5):zoom(WideScreenDiff()):diffusealpha(1):sleep(0.1):accelerate(0.2):zoom(1.2*WideScreenDiff()):diffusealpha(0) end,
			CurrentSongChangedMessageCommand=function(self) if initialLoad then self:playcommand("Refresh") else initialLoad = true end end
		}
	}
}