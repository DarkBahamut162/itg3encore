local player = ...
assert(player,"[Graphics/_pane icons] player required")

local bpm,stop,delay,warp,scroll,speed,fake,attack,jump,hold,mine,hand,roll = false,false,false,false,false,false,false,false,false,false,false,false,false
local song,course

return Def.ActorFrame{
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
	CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end,
	CurrentStepsP1ChangedMessageCommand=function(self) if player == PLAYER_1 then self:playcommand("Set") end end,
	CurrentTrailP1ChangedMessageCommand=function(self) if player == PLAYER_1 then self:playcommand("Set") end end,
	CurrentStepsP2ChangedMessageCommand=function(self) if player == PLAYER_2 then self:playcommand("Set") end end,
	CurrentTrailP2ChangedMessageCommand=function(self) if player == PLAYER_2 then self:playcommand("Set") end end,
	SetCommand=function(self)
		song,course = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentCourse()
		bpm,stop,delay,warp,scroll,speed,fake,attack,jump,hold,mine,hand,roll = false,false,false,false,false,false,false,false,false,false,false,false,false
		if song then
			local step = GAMESTATE:GetCurrentSteps(player)
			if step then
				local timingData = step:GetTimingData()
				if timingData:HasBPMChanges() then bpm = true end
				if timingData:HasStops() then stop = true end
				if timingData:HasDelays() then delay = true end
				if timingData:HasWarps() then warp = true  end
				if timingData:HasScrollChanges() then scroll = true end
				if timingData:HasSpeedChanges() then speed = true end
				if timingData:HasFakes() then fake = true end
				if step:HasAttacks() then attack = true end

				local rv = step:GetRadarValues(player)
				jump = rv:GetValue('RadarCategory_Jumps') > 0
				hold = rv:GetValue('RadarCategory_Holds') > 0
				mine = rv:GetValue('RadarCategory_Mines') > 0
				hand = rv:GetValue('RadarCategory_Hands') > 0
				roll = rv:GetValue('RadarCategory_Rolls') > 0
			end
		elseif course then
			local trail = GAMESTATE:GetCurrentTrail(player)
			if trail then
				for entry in ivalues(trail:GetTrailEntries()) do
					local step = entry:GetSteps()
					local timingData = step:GetTimingData()
					if timingData:HasBPMChanges() then bpm = true end
					if timingData:HasStops() then stop = true end
					if timingData:HasDelays() then delay = true end
					if timingData:HasWarps() then warp = true  end
					if timingData:HasScrollChanges() then scroll = true end
					if timingData:HasSpeedChanges() then speed = true end
					if timingData:HasFakes() then fake = true end
					if step:HasAttacks() then attack = true end
				end

				local rv = trail:GetRadarValues(player)
				jump = rv:GetValue('RadarCategory_Jumps') > 0
				hold = rv:GetValue('RadarCategory_Holds') > 0
				mine = rv:GetValue('RadarCategory_Mines') > 0
				hand = rv:GetValue('RadarCategory_Hands') > 0
				roll = rv:GetValue('RadarCategory_Rolls') > 0
			end
		end
		self:RunCommandsOnChildren(function(self) self:playcommand("Set") end)
	end,
	LoadActor("_jump")..{
		InitCommand=function(self) self:x(-27+25*0):y(230):shadowlength(2) end,
		OnCommand=function(self) self:decelerate(0.3):y(130) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if jump then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_hold")..{
		InitCommand=function(self) self:x(-27+25*1):y(230):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.1):decelerate(0.3):y(130) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if hold then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_mine")..{
		InitCommand=function(self) self:x(-27+25*2):y(230):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.2):decelerate(0.3):y(130) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if mine then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_hand")..{
		InitCommand=function(self) self:x(-27+25*3):y(230):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.3):decelerate(0.3):y(130) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if hand then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_roll")..{
		InitCommand=function(self) self:x(-27+25*4):y(230):shadowlength(2) end,
		OnCommand=function(self) self:sleep(0.4):decelerate(0.3):y(130) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if roll then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_textmask")..{
		InitCommand=function(self) self:x(-27+25*2):y(130):zbuffer(true):blend(Blend.NoEffect) end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*0):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.4):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if bpm then self:diffuse(color("#00C0FF")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="BPM",
		InitCommand=function(self) self:x(100+12*0):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(48) end,
		OnCommand=function(self) self:sleep(0.4):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if bpm then self:diffuse(color("#00FFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*1):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.5):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if stop then self:diffuse(color("#FF0000")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="S",
		InitCommand=function(self) self:x(100+12*1):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(48) end,
		OnCommand=function(self) self:sleep(0.5):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if stop then self:diffuse(color("#FF0000")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*2):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.6):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if delay then self:diffuse(color("#0000FF")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="D",
		InitCommand=function(self) self:x(100+12*2):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(48) end,
		OnCommand=function(self) self:sleep(0.6):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if delay then self:diffuse(color("#0000FF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*3):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.7):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if warp then self:diffuse(color("#C000FF")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="W",
		InitCommand=function(self) self:x(100+12*3):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(48) end,
		OnCommand=function(self) self:sleep(0.7):decelerate(0.3):y(130-6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if warp then self:diffuse(color("#C000FF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*0):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.45):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if scroll then self:diffuse(color("#00FF00")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="SC",
		InitCommand=function(self) self:x(100+12*0):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(49) end,
		OnCommand=function(self) self:sleep(0.45):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if scroll then self:diffuse(color("#00FF00")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*1):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.55):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if speed then self:diffuse(color("#FF8000")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="SP",
		InitCommand=function(self) self:x(100+12*1):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(49) end,
		OnCommand=function(self) self:sleep(0.55):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if speed then self:diffuse(color("#FF8000")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*2):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.65):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if fake then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="F",
		InitCommand=function(self) self:x(100+12*2):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(48) end,
		OnCommand=function(self) self:sleep(0.65):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if fake then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
	},
	LoadActor("_null")..{
		InitCommand=function(self) self:x(100+12*3):y(230):shadowlength(1):zoom(0.5) end,
		OnCommand=function(self) self:sleep(0.75):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if attack then self:diffuse(color("#FFFF00")) else self:diffuse(color("#808080")) end end
	},
	LoadFont("_z bold gray 36px")..{
		Text="A",
		InitCommand=function(self) self:x(100+12*3):y(230):shadowlength(1):halign(0.5):zoom(0.2):maxwidth(48) end,
		OnCommand=function(self) self:sleep(0.75):decelerate(0.3):y(130+6) end,
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
		SetCommand=function(self) if attack then self:diffuse(color("#FFFF00")) else self:diffuse(color("#808080")) end end
	}
}