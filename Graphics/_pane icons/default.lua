local player = ...
assert(player,"[Graphics/_pane icons] player required")

local bpm,stop,delay,warp,scroll,speed,fake,attack,jump,hold,mine,hand,roll = false,false,false,false,false,false,false,false,false,false,false,false,false
local stream,voltage,air,freeze,chaos = 0,0,0,0,0
local song,course

return Def.ActorFrame{
	InitCommand=function(self) self:y(-1) if IsUsingWideScreen() and isOutFox() then self:x(player == PLAYER_1 and 48 or -48) end end,
	CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
	CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end,
	["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
	["CurrentTrail".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
	SetCommand=function(self)
		song,course = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentCourse()
		bpm,stop,delay,warp,scroll,speed,fake,attack,jump,hold,mine,hand,roll = false,false,false,false,false,false,false,false,false,false,false,false,false
		stream,voltage,air,freeze,chaos = 0,0,0,0,0
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
				local totalSeconds = isOutFox() and LoadFromCache(step,"TrueLastSecond") - LoadFromCache(step,"TrueFirstSecond") or 0
				local avg_bps_OLD = song:GetLastBeat() / song:MusicLengthSeconds()
				local avg_bps_NEW = isOutFox() and LoadModule("Config.Load.lua")("TrueLastBeat",getStepCacheFile(step)) / totalSeconds or 0
				stream = rv:GetValue('RadarCategory_Stream')
				if isOutFox() then stream = stream * song:MusicLengthSeconds() / totalSeconds end
				voltage = rv:GetValue('RadarCategory_Voltage')
				if isOutFox() then voltage = voltage / avg_bps_OLD * avg_bps_NEW end
				air = rv:GetValue('RadarCategory_Air')
				if isOutFox() then air = air * song:MusicLengthSeconds() / totalSeconds end
				freeze = rv:GetValue('RadarCategory_Freeze')
				if isOutFox() then freeze = freeze * song:MusicLengthSeconds() / totalSeconds end
				chaos = rv:GetValue('RadarCategory_Chaos')
				if isOutFox() then chaos = chaos * song:MusicLengthSeconds() / totalSeconds end
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
				stream = rv:GetValue('RadarCategory_Stream')
				voltage = rv:GetValue('RadarCategory_Voltage')
				air = rv:GetValue('RadarCategory_Air')
				freeze = rv:GetValue('RadarCategory_Freeze')
				chaos = rv:GetValue('RadarCategory_Chaos')
				if IsCourseSecret() then stream,voltage,air,freeze,chaos = 0,0,0,0,0 end
			end
		end
		self:RunCommandsOnChildren(function(self) self:playcommand("Set") end)
	end,
	Def.ActorFrame{
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*0):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.4):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if bpm then self:diffuse(color("#00C0FF")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="BPM",
			InitCommand=function(self) self:x(-32+15.666*0):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.4):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if bpm then self:diffuse(color("#00FFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*1):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.45):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if stop then self:diffuse(color("#FF0000")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="S",
			InitCommand=function(self) self:x(-32+15.666*1):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.45):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if stop then self:diffuse(color("#FF0000")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*2):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.5):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if delay then self:diffuse(color("#0000FF")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="D",
			InitCommand=function(self) self:x(-32+15.666*2):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.5):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if delay then self:diffuse(color("#0000FF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*3):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.55):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if warp then self:diffuse(color("#C000FF")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="W",
			InitCommand=function(self) self:x(-32+15.666*3):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.55):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if warp then self:diffuse(color("#C000FF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*4):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.6):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if scroll then self:diffuse(color("#00FF00")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="SC",
			InitCommand=function(self) self:x(-32+15.666*4):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.6):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if scroll then self:diffuse(color("#00FF00")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*5):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.65):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if speed then self:diffuse(color("#FF8000")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="SP",
			InitCommand=function(self) self:x(-32+15.666*5):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.65):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if speed then self:diffuse(color("#FF8000")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*6):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.7):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if fake then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="F",
			InitCommand=function(self) self:x(-32+15.666*6):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.7):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if fake then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_null")..{
			InitCommand=function(self) self:x(-32+15.666*7):y(145):shadowlength(1):zoom(0.6) end,
			OnCommand=function(self) self:addy(100):sleep(0.75):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if attack then self:diffuse(color("#FFFF00")) else self:diffuse(color("#808080")) end end
		},
		LoadFont("_z bold gray 36px")..{
			Text="A",
			InitCommand=function(self) self:x(-32+15.666*7):y(145):shadowlength(1):zoom(0.2):maxwidth(60) end,
			OnCommand=function(self) self:addy(100):sleep(0.75):decelerate(0.3):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if attack then self:diffuse(color("#FFFF00")) else self:diffuse(color("#808080")) end end
		}
	},
	Def.ActorFrame{
		LoadActor("_long")..{
			InitCommand=function(self) self:x(-39+25*0):y(114):shadowlength(1):halign(0) end,
			OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.7):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if stream > 0 then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_long")..{
			InitCommand=function(self) self:x(-39+25*1):y(114):shadowlength(1):halign(0) end,
			OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.7):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if voltage > 0 then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_long")..{
			InitCommand=function(self) self:x(-39+25*2):y(114):shadowlength(1):halign(0) end,
			OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.7):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if air > 0 then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_long")..{
			InitCommand=function(self) self:x(-39+25*3):y(114):shadowlength(1):halign(0) end,
			OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.7):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if freeze > 0 then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_long")..{
			InitCommand=function(self) self:x(-39+25*4):y(114):shadowlength(1):halign(0) end,
			OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_CENTER_X or SCREEN_CENTER_X):sleep(0.7):decelerate(0.3):addx(player == PLAYER_1 and SCREEN_CENTER_X or -SCREEN_CENTER_X) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if chaos > 0 then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		Def.Quad{
			Name="STREAM",
			InitCommand=function(self) self:x(-37+25*0):y(114):halign(0):zoomto(20,4):diffuse(color("#FF0000")):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.9):decelerate(0.3):diffusealpha(1):playcommand("Set") end,
			SetCommand=function(self)
				self:decelerate(0.1):zoomx(math.min(stream,1)*20)
				if stream > 1 and voltage > 1 and air > 1 and freeze > 1 and chaos > 1 then
					self:stopeffect():rainbow():effectclock('beat')
				elseif stream > 1 then
					self:stopeffect():diffuseramp():effectcolor1(color("#800000")):effectcolor2(color("#FF0000")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				else
					self:stopeffect()
				end
			end,
			CurrentSongChangedMessageCommand=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentTrail".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
		},
		Def.Quad{
			Name="VOLTAGE",
			InitCommand=function(self) self:x(-37+25*1):y(114):halign(0):zoomto(20,4):diffuse(color("#FFFF00")):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.9):decelerate(0.3):diffusealpha(1):playcommand("Set") end,
			SetCommand=function(self)
				self:decelerate(0.1):zoomx(math.min(voltage,1)*20)
				if stream > 1 and voltage > 1 and air > 1 and freeze > 1 and chaos > 1 then
					self:stopeffect():rainbow():effectclock('beat')
				elseif voltage > 1 then
					self:stopeffect():diffuseramp():effectcolor1(color("#808000")):effectcolor2(color("#FFFF00")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				else
					self:stopeffect()
				end
			end,
			CurrentSongChangedMessageCommand=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentTrail".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
		},
		Def.Quad{
			Name="AIR",
			InitCommand=function(self) self:x(-37+25*2):y(114):halign(0):zoomto(20,4):diffuse(color("#00FFFF")):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.9):decelerate(0.3):diffusealpha(1):playcommand("Set") end,
			SetCommand=function(self)
				self:decelerate(0.1):zoomx(math.min(air,1)*20)
				if stream > 1 and voltage > 1 and air > 1 and freeze > 1 and chaos > 1 then
					self:stopeffect():rainbow():effectclock('beat')
				elseif air > 1 then
					self:stopeffect():diffuseramp():effectcolor1(color("#008080")):effectcolor2(color("#00FFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				else
					self:stopeffect()
				end
			end,
			CurrentSongChangedMessageCommand=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentTrail".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
		},
		Def.Quad{
			Name="FREEZE",
			InitCommand=function(self) self:x(-37+25*3):y(114):halign(0):zoomto(20,4):diffuse(color("#FFFFFF")):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.9):decelerate(0.3):diffusealpha(1):playcommand("Set") end,
			SetCommand=function(self)
				self:decelerate(0.1):zoomx(math.min(freeze,1)*20)
				if stream > 1 and voltage > 1 and air > 1 and freeze > 1 and chaos > 1 then
					self:stopeffect():rainbow():effectclock('beat')
				elseif freeze > 1 then
					self:stopeffect():diffuseramp():effectcolor1(color("#808080")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				else
					self:stopeffect()
				end
			end,
			CurrentSongChangedMessageCommand=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentTrail".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
		},
		Def.Quad{
			Name="CHAOS",
			InitCommand=function(self) self:x(-37+25*4):y(114):halign(0):zoomto(20,4):diffuse(color("#FF00FF")):blend(Blend.Add) end,
			OnCommand=function(self) self:diffusealpha(0):sleep(0.9):decelerate(0.3):diffusealpha(1):playcommand("Set") end,
			SetCommand=function(self)
				self:decelerate(0.1):zoomx(math.min(chaos,1)*20)
				if stream > 1 and voltage > 1 and air > 1 and freeze > 1 and chaos > 1 then
					self:stopeffect():rainbow():effectclock('beat')
				elseif chaos > 1 then
					self:stopeffect():diffuseramp():effectcolor1(color("#800080")):effectcolor2(color("#FF00FF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
				else
					self:stopeffect()
				end
			end,
			CurrentSongChangedMessageCommand=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentSteps".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			["CurrentTrail".. ToEnumShortString(player) .."ChangedMessageCommand"]=function(self) self:stoptweening():playcommand("Set") end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end
		},
		LoadFont("_z bold gray 36px")..{
			InitCommand=function(self) self:x(-27+25*0):y(113):shadowlength(1):zoom(0.2):diffusealpha(0):maxwidth(120) end,
			SetCommand=function(self) self:settextf("%i%%",stream*100) end,
			SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
			SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		},
		LoadFont("_z bold gray 36px")..{
			InitCommand=function(self) self:x(-27+25*1):y(113):shadowlength(1):zoom(0.2):diffusealpha(0):maxwidth(120) end,
			SetCommand=function(self) self:settextf("%i%%",voltage*100) end,
			SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
			SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		},
		LoadFont("_z bold gray 36px")..{
			InitCommand=function(self) self:x(-27+25*2):y(113):shadowlength(1):zoom(0.2):diffusealpha(0):maxwidth(120) end,
			SetCommand=function(self) self:settextf("%i%%",air*100) end,
			SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
			SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		},
		LoadFont("_z bold gray 36px")..{
			InitCommand=function(self) self:x(-27+25*3):y(113):shadowlength(1):zoom(0.2):diffusealpha(0):maxwidth(120) end,
			SetCommand=function(self) self:settextf("%i%%",freeze*100) end,
			SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
			SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		},
		LoadFont("_z bold gray 36px")..{
			InitCommand=function(self) self:x(-27+25*4):y(113):shadowlength(1):zoom(0.2):diffusealpha(0):maxwidth(120) end,
			SetCommand=function(self) self:settextf("%i%%",chaos*100) end,
			SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end,
			SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end,
		}
	},
	Def.ActorFrame{
		LoadActor("_jump")..{
			InitCommand=function(self) self:x(-27+25*0):y(230):shadowlength(2) end,
			OnCommand=function(self) self:decelerate(0.3):y(130) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if jump then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_hold")..{
			InitCommand=function(self) self:x(-27+25*1):y(230):shadowlength(2) end,
			OnCommand=function(self) self:sleep(0.1):decelerate(0.3):y(130) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if hold then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_mine")..{
			InitCommand=function(self) self:x(-27+25*2):y(230):shadowlength(2) end,
			OnCommand=function(self) self:sleep(0.2):decelerate(0.3):y(130) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if mine then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_hand")..{
			InitCommand=function(self) self:x(-27+25*3):y(230):shadowlength(2) end,
			OnCommand=function(self) self:sleep(0.3):decelerate(0.3):y(130) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if hand then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_roll")..{
			InitCommand=function(self) self:x(-27+25*4):y(230):shadowlength(2) end,
			OnCommand=function(self) self:sleep(0.4):decelerate(0.3):y(130) end,
			OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end,
			SetCommand=function(self) if roll then self:diffuse(color("#FFFFFF")) else self:diffuse(color("#808080")) end end
		},
		LoadActor("_textmask")..{
			InitCommand=function(self) self:x(-27+25*2):y(130):zbuffer(true):blend(Blend.NoEffect) end
		}
	}
}