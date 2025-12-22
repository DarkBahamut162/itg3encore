local c,cDl,cDr,cUl,cUr
local player = ...
local rotate = (IsGame("be-mu") or IsGame("po-mu")) and -90 or 90
local reverse = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions():Reverse() ~= 0
if reverse then rotate = rotate * -1 end

local tilt = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions():Tilt()
local tilt_degrees = scale(tilt,-1,1,30,30) % 360
if tilt_degrees > 180 then tilt_degrees = tilt_degrees - (tilt_degrees-180) end
local stretch = 1-(tilt_degrees/180)
local add = math.abs(SCREEN_HEIGHT-SCREEN_HEIGHT/stretch)

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny * WideScreenDiff()

if tilt > 0 then
	currentMini = currentMini * scale(tilt,0,1,1,0.9)
	add = add + math.abs(scale(tilt,0,1,0,-45)/stretch)
else
	currentMini = currentMini * scale(tilt,0,-1,1,0.9)
	add = add + math.abs(scale(tilt,0,-1,0,-20)/stretch)
end

add = add * 2

local filterWidth = GetTrueWidth(player)
local widthZoom = Center1Player() and 1 or WideScreenDiff()

filterWidth = filterWidth * math.min(1,isOutFox(20200600) and NotefieldZoomOutFox() or NotefieldZoom())
currentMini = currentMini * math.min(1,isOutFox(20200600) and NotefieldZoomOutFox() or NotefieldZoom())

local SpeedDowns,SpeedUps,timingData,temp

local totalDelta = 0
local tmpDelta = 0
local SDi = 1
local SUi = 1
local SDa = false
local SUa = false

local function setSpeeds(steps)
	temp = nil
	SDi = 1
	SUi = 1
	SDa = false
	SUa = false
	SpeedUps = {}
	SpeedDowns = {}
	timingData = steps:GetTimingData()

	for v in ivalues(timingData:GetBPMsAndTimes()) do
		local data = split('=', v)
		local numData = {tonumber(data[1]), tonumber(data[2])}
		numData[2] = math.round(numData[2],3)

		if temp then
			if numData[2] - temp < 0 then
				SpeedDowns[#SpeedDowns+1] = checkStopAtBeat(numData[1],timingData)
			elseif numData[2] - temp > 0 then
				SpeedUps[#SpeedUps+1] = checkStopAtBeat(numData[1],timingData)
			end
		end
		temp = numData[2]
	end
end

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1.0/60 and timingData then
		tmpDelta = totalDelta

		local ms = GAMESTATE:GetCurMusicSeconds()
		if getenv("ShowSpeedAssist"..pname(player)) then
			if SpeedDowns[SDi] and SpeedDowns[SDi] - 1 < ms then
				SDa = true
				SDi = SDi + 1
				if not SUa then
					cDl.SpeedDownLeft:stoptweening():cropbottom(0)
					cDr.SpeedDownRight:stoptweening():cropbottom(0)
					cUl.SpeedUpLeft:stoptweening():croptop(0)
					cUr.SpeedUpRight:stoptweening():croptop(0)

					cDl.SpeedDownLeft_:stoptweening():croptop(0)
					cDr.SpeedDownRight_:stoptweening():cropbottom(0)
					cUl.SpeedUpLeft_:stoptweening():croptop(0)
					cUr.SpeedUpRight_:stoptweening():cropbottom(0)
				end
				c.SpeedDown:stoptweening():linear(0.5):diffusealpha(1)
				if SUa then
					cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0.5)
					cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0.5)
					cUl.SpeedUpLeft:stoptweening():linear(0.25):croptop(0.5)
					cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0.5)

					cDl.SpeedDownLeft_:stoptweening():linear(0.25):croptop(0.5)
					cDr.SpeedDownRight_:stoptweening():linear(0.25):cropbottom(0.5)
					cUl.SpeedUpLeft_:stoptweening():linear(0.25):croptop(0.5)
					cUr.SpeedUpRight_:stoptweening():linear(0.25):cropbottom(0.5)
				end
			end
			if SpeedDowns[SDi-1] and SpeedDowns[SDi-1] < ms and SDa then
				SDa = false
				c.SpeedDown:linear(0.5):diffusealpha(0)
				cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0)
				cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0)
				cUl.SpeedUpLeft:stoptweening():linear(0.25):croptop(0)
				cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0)

				cDl.SpeedDownLeft_:stoptweening():linear(0.25):croptop(0)
				cDr.SpeedDownRight_:stoptweening():linear(0.25):cropbottom(0)
				cUl.SpeedUpLeft_:stoptweening():linear(0.25):croptop(0)
				cUr.SpeedUpRight_:stoptweening():linear(0.25):cropbottom(0)
			end
			if SpeedUps[SUi] and SpeedUps[SUi] - 1 < ms then
				SUa = true
				SUi = SUi + 1
				if not SDa then
					cDl.SpeedDownLeft:stoptweening():cropbottom(0)
					cDr.SpeedDownRight:stoptweening():cropbottom(0)
					cUl.SpeedUpLeft:stoptweening():croptop(0)
					cUr.SpeedUpRight:stoptweening():croptop(0)

					cDl.SpeedDownLeft_:stoptweening():croptop(0)
					cDr.SpeedDownRight_:stoptweening():cropbottom(0)
					cUl.SpeedUpLeft_:stoptweening():croptop(0)
					cUr.SpeedUpRight_:stoptweening():cropbottom(0)
				end
				c.SpeedUp:stoptweening():linear(0.5):diffusealpha(1)
				if SDa then
					cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0.5)
					cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0.5)
					cUl.SpeedUpLeft:stoptweening():linear(0.25):croptop(0.5)
					cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0.5)

					cDl.SpeedDownLeft_:stoptweening():linear(0.25):croptop(0.5)
					cDr.SpeedDownRight_:stoptweening():linear(0.25):cropbottom(0.5)
					cUl.SpeedUpLeft_:stoptweening():linear(0.25):croptop(0.5)
					cUr.SpeedUpRight_:stoptweening():linear(0.25):cropbottom(0.5)
				end
			end
			if SpeedUps[SUi-1] and SpeedUps[SUi-1] < ms and SUa then
				SUa = false
				c.SpeedUp:linear(0.5):diffusealpha(0)
				cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0)
				cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0)
				cUl.SpeedUpLeft:stoptweening():linear(0.25):cropbottom(0)
				cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0)

				cDl.SpeedDownLeft_:stoptweening():linear(0.25):croptop(0)
				cDr.SpeedDownRight_:stoptweening():linear(0.25):cropbottom(0)
				cUl.SpeedUpLeft_:stoptweening():linear(0.25):croptop(0)
				cUr.SpeedUpRight_:stoptweening():linear(0.25):cropbottom(0)
			end
		end
	end
end

return Def.ActorFrame{
	InitCommand=function(self)
		c = self:GetChildren()
		c.SpeedDown:diffusealpha(0)
		c.SpeedUp:diffusealpha(0)
		if GAMESTATE:GetNumPlayersEnabled() == 1 then
			if getenv("Rotation"..pname(player)) == 3 and player == PLAYER_1 then
				self:y(-SCREEN_CENTER_X)
			elseif getenv("Rotation"..pname(player)) == 2 and player == PLAYER_2 then
				self:y(-SCREEN_CENTER_X)
			end
		end
	end,
	OnCommand = function(self)
		if GAMESTATE:IsCourseMode() then
			setSpeeds(GAMESTATE:GetCurrentTrail(player):GetTrailEntry(STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetSongsPassed()):GetSteps())
		else
			setSpeeds(GAMESTATE:GetCurrentSteps(player))
		end
		self:SetUpdateFunction(Update)
	end,
	DoneLoadingNextSongMessageCommand=function(self) self:playcommand("On") end,
	Def.ActorFrame{
		Name="SpeedDown",
		Def.ActorFrame{
			InitCommand=function(self) self:x(-filterWidth/2-8*widthZoom):CenterY():rotationz(rotate):valign(0) end,
			OnCommand=function(self) cDl = self:GetChildren() end,
			Def.Sprite {
				Texture = THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")),
				Name="SpeedDownLeft",
				InitCommand=function(self) self:zoomto((SCREEN_HEIGHT+add)/currentMini,16*widthZoom) end
			},
			Def.Sprite {
				Texture = "SpeedDown",
				Name="SpeedDownLeft_",
				InitCommand=function(self) self:diffusealpha(0.5):zoomto((SCREEN_HEIGHT+add)/currentMini,15*widthZoom):customtexturerect(0,0,((SCREEN_HEIGHT+add)/currentMini)/32,1):texcoordvelocity(10/3,0):rotationz(180) end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(filterWidth/2+8*widthZoom):CenterY():rotationz(rotate):valign(1) end,
			OnCommand=function(self) cDr = self:GetChildren() end,
			Def.Sprite {
				Texture = THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")),
				Name="SpeedDownRight",
				InitCommand=function(self) self:zoomto((SCREEN_HEIGHT+add)/currentMini,-16*widthZoom) end
			},
			Def.Sprite {
				Texture = "SpeedDown",
				Name="SpeedDownRight_",
				InitCommand=function(self) self:diffusealpha(0.5):zoomto((SCREEN_HEIGHT+add)/currentMini,15*widthZoom):customtexturerect(0,0,((SCREEN_HEIGHT+add)/currentMini)/32,1):texcoordvelocity(10/3,0):rotationz(180) end
			}
		}
	},
	Def.ActorFrame{
		Name="SpeedUp",
		Def.ActorFrame{
			InitCommand=function(self) self:x(-filterWidth/2-8*widthZoom):CenterY():rotationz(rotate):valign(0) end,
			OnCommand=function(self) cUl = self:GetChildren() end,
			Def.Sprite {
				Texture = THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")),
				Name="SpeedUpLeft",
				InitCommand=function(self) self:zoomto((SCREEN_HEIGHT+add)/currentMini,16*widthZoom) end
			},
			Def.Sprite {
				Texture = "SpeedUp",
				Name="SpeedUpLeft_",
				InitCommand=function(self) self:diffusealpha(0.5):zoomto((SCREEN_HEIGHT+add)/currentMini,15*widthZoom):customtexturerect(0,0,((SCREEN_HEIGHT+add)/currentMini)/32,1):texcoordvelocity(10/3,0) end
			}
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(filterWidth/2+8*widthZoom):CenterY():rotationz(rotate):valign(1) end,
			OnCommand=function(self) cUr = self:GetChildren() end,
			Def.Sprite {
				Texture = THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")),
				Name="SpeedUpRight",
				InitCommand=function(self) self:zoomto((SCREEN_HEIGHT+add)/currentMini,-16*widthZoom) end
			},
			Def.Sprite {
				Texture = "SpeedUp",
				Name="SpeedUpRight_",
				InitCommand=function(self) self:diffusealpha(0.5):zoomto((SCREEN_HEIGHT+add)/currentMini,15*widthZoom):customtexturerect(0,0,((SCREEN_HEIGHT+add)/currentMini)/32,1):texcoordvelocity(10/3,0) end
			}
		}
	}
}