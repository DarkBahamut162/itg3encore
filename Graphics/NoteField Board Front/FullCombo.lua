local player = ...

return Def.ActorFrame {
	InitCommand=function(self) if not (IsGame("beat") or IsGame("be-mu")) then self:CenterY() end end,
	OffCommand=function(self) if PlayerFullComboed(player) then self:queuecommand("CheckScore") end end,
	CheckScoreCommand=function(self)
		local fct = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
		if fct:FullComboOfScore('TapNoteScore_W1') then
			self:visible(true)
		elseif fct:FullComboOfScore('TapNoteScore_W2') then
			self:visible(true)
		elseif fct:FullComboOfScore('TapNoteScore_W3') then
			self:visible(true)
		else
			self:visible(false)
		end
	end,
	Def.ActorFrame {
		InitCommand=function(self) self:diffusealpha(0):x(-126):y(-24) end,
		OffCommand=function(self) self:sleep(0.55):linear(0.15):diffusealpha(1):x(-44):linear(1):x(-12):linear(0.15):diffusealpha(0):x(154) end,
		Def.Sprite {
			Texture="FC/F1"
		},
		Def.Sprite {
			Texture="FC/F2",
			InitCommand=function(self) self:blend(Blend.Add):diffuseblink():effectcolor1(color("1,1,1,0.5")):effectcolor2(color("0,0,0,0")):effectperiod(1/30):effectclock("timerglobal") end
		},
		Def.Sprite {
			Texture="FC/F3",
			OffCommand=function(self) self:cropleft(-0.1):cropright(1):sleep(0.866):linear(0.133):cropleft(1):cropright(-0.1) end
		}
	},
	Def.ActorFrame {
		InitCommand=function(self) self:diffusealpha(0):x(116):y(24) end,
		OffCommand=function(self) self:sleep(0.55):linear(0.15):diffusealpha(1):x(34):linear(1):x(2):linear(0.15):diffusealpha(0):x(-164) end,
		Def.Sprite {
			Texture="FC/C1"
		},
		Def.Sprite {
			Texture="FC/C2",
			InitCommand=function(self) self:blend(Blend.Add):diffuseblink():effectcolor1(color("1,1,1,0.5")):effectcolor2(color("0,0,0,0")):effectperiod(1/30):effectclock("timerglobal") end
		},
		Def.Sprite {
			Texture="FC/C3",
			OffCommand=function(self) self:cropleft(-0.1):cropright(1):sleep(1):linear(0.166):cropleft(1):cropright(-0.1) end
		}
	},
	--loadfile(THEME:GetPathG("NoteField","Board Front/FC/Default"))()
}