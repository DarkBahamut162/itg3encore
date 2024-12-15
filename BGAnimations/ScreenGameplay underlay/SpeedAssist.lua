local c,cDl,cDr,cUl,cUr
local player = ...
local style = GAMESTATE:GetCurrentStyle()
local rotate = (IsGame("be-mu") or IsGame("beat") or IsGame("po-mu")) and -90 or 90
local reverse = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions():Reverse() ~= 0
if reverse then rotate = rotate * -1 end

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny
local filterWidth = style:GetWidth(player) * currentMini
local widthZoom = Center1Player() and 1 or WideScreenDiff()

if not isOutFox() then filterWidth = filterWidth * math.min(1,NotefieldZoom()) end
if isOutFox() then filterWidth = filterWidth * math.min(1,NotefieldZoomOutFox()) end
if getenv("EffectVibrate"..pname(player)) then filterWidth = filterWidth + (30 * currentMini) end

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
					for i=1,31 do
						cDl["SpeedDownLeft"..i]:stoptweening():croptop(0)
						cDr["SpeedDownRight"..i]:stoptweening():cropbottom(0)
						cUl["SpeedUpLeft"..i]:stoptweening():croptop(0)
						cUr["SpeedUpRight"..i]:stoptweening():cropbottom(0)
					end
				end
				c.SpeedDown:stoptweening():linear(0.5):diffusealpha(1)
				if SUa then
					cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0.5)
					cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0.5)
					cUl.SpeedUpLeft:stoptweening():linear(0.25):croptop(0.5)
					cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0.5)
					for i=1,31 do
						cDl["SpeedDownLeft"..i]:stoptweening():linear(0.25):croptop(0.5)
						cDr["SpeedDownRight"..i]:stoptweening():linear(0.25):cropbottom(0.5)
						cUl["SpeedUpLeft"..i]:stoptweening():linear(0.25):croptop(0.5)
						cUr["SpeedUpRight"..i]:stoptweening():linear(0.25):cropbottom(0.5)
					end
				end
			end
			if SpeedDowns[SDi-1] and SpeedDowns[SDi-1] < ms and SDa then
				SDa = false
				c.SpeedDown:linear(0.5):diffusealpha(0)
				cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0)
				cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0)
				cUl.SpeedUpLeft:stoptweening():linear(0.25):croptop(0)
				cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0)
				for i=1,31 do
					cDl["SpeedDownLeft"..i]:stoptweening():linear(0.25):croptop(0)
					cDr["SpeedDownRight"..i]:stoptweening():linear(0.25):cropbottom(0)
					cUl["SpeedUpLeft"..i]:stoptweening():linear(0.25):croptop(0)
					cUr["SpeedUpRight"..i]:stoptweening():linear(0.25):cropbottom(0)
				end
			end
			if SpeedUps[SUi] and SpeedUps[SUi] - 1 < ms then
				SUa = true
				SUi = SUi + 1
				if not SDa then
					cDl.SpeedDownLeft:stoptweening():cropbottom(0)
					cDr.SpeedDownRight:stoptweening():cropbottom(0)
					cUl.SpeedUpLeft:stoptweening():croptop(0)
					cUr.SpeedUpRight:stoptweening():croptop(0)
					for i=1,31 do
						cDl["SpeedDownLeft"..i]:stoptweening():croptop(0)
						cDr["SpeedDownRight"..i]:stoptweening():cropbottom(0)
						cUl["SpeedUpLeft"..i]:stoptweening():croptop(0)
						cUr["SpeedUpRight"..i]:stoptweening():cropbottom(0)
					end
				end
				c.SpeedUp:stoptweening():linear(0.5):diffusealpha(1)
				if SDa then
					cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0.5)
					cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0.5)
					cUl.SpeedUpLeft:stoptweening():linear(0.25):croptop(0.5)
					cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0.5)
					for i=1,31 do
						cDl["SpeedDownLeft"..i]:stoptweening():linear(0.25):croptop(0.5)
						cDr["SpeedDownRight"..i]:stoptweening():linear(0.25):cropbottom(0.5)
						cUl["SpeedUpLeft"..i]:stoptweening():linear(0.25):croptop(0.5)
						cUr["SpeedUpRight"..i]:stoptweening():linear(0.25):cropbottom(0.5)
					end
				end
			end
			if SpeedUps[SUi-1] and SpeedUps[SUi-1] < ms and SUa then
				SUa = false
				c.SpeedUp:linear(0.5):diffusealpha(0)
				cDl.SpeedDownLeft:stoptweening():linear(0.25):cropbottom(0)
				cDr.SpeedDownRight:stoptweening():linear(0.25):cropbottom(0)
				cUl.SpeedUpLeft:stoptweening():linear(0.25):cropbottom(0)
				cUr.SpeedUpRight:stoptweening():linear(0.25):croptop(0)
				for i=1,31 do
					cDl["SpeedDownLeft"..i]:stoptweening():linear(0.25):croptop(0)
					cDr["SpeedDownRight"..i]:stoptweening():linear(0.25):cropbottom(0)
					cUl["SpeedUpLeft"..i]:stoptweening():linear(0.25):croptop(0)
					cUr["SpeedUpRight"..i]:stoptweening():linear(0.25):cropbottom(0)
				end
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
				InitCommand=function(self) self:zoomto(SCREEN_HEIGHT*4,16*widthZoom) end
			},
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft1", InitCommand=function(self) self:x(32*-15):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft2", InitCommand=function(self) self:x(32*-14):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft3", InitCommand=function(self) self:x(32*-13):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft4", InitCommand=function(self) self:x(32*-12):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft5", InitCommand=function(self) self:x(32*-11):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft6", InitCommand=function(self) self:x(32*-10):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft7", InitCommand=function(self) self:x(32*-9):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft8", InitCommand=function(self) self:x(32*-8):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft9", InitCommand=function(self) self:x(32*-7):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft10", InitCommand=function(self) self:x(32*-6):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft11", InitCommand=function(self) self:x(32*-5):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft12", InitCommand=function(self) self:x(32*-4):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft13", InitCommand=function(self) self:x(32*-3):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft14", InitCommand=function(self) self:x(32*-2):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft15", InitCommand=function(self) self:x(32*-1):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft16", InitCommand=function(self) self:x(32*0):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft17", InitCommand=function(self) self:x(32*1):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft18", InitCommand=function(self) self:x(32*2):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft19", InitCommand=function(self) self:x(32*3):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft20", InitCommand=function(self) self:x(32*4):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft21", InitCommand=function(self) self:x(32*5):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft22", InitCommand=function(self) self:x(32*6):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft23", InitCommand=function(self) self:x(32*7):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft24", InitCommand=function(self) self:x(32*8):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft25", InitCommand=function(self) self:x(32*9):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft26", InitCommand=function(self) self:x(32*10):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft27", InitCommand=function(self) self:x(32*11):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft28", InitCommand=function(self) self:x(32*12):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft29", InitCommand=function(self) self:x(32*13):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft30", InitCommand=function(self) self:x(32*14):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownLeft31", InitCommand=function(self) self:x(32*15):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end }
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(filterWidth/2+8*widthZoom):CenterY():rotationz(rotate):valign(1) end,
			OnCommand=function(self) cDr = self:GetChildren() end,
			Def.Sprite {
				Texture = THEME:GetPathG("","lolhi "..(isFinal() and "final" or "normal")),
				Name="SpeedDownRight",
				InitCommand=function(self) self:zoomto(SCREEN_HEIGHT*4,-16*widthZoom) end
			},
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight1", InitCommand=function(self) self:x(32*-15):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight2", InitCommand=function(self) self:x(32*-14):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight3", InitCommand=function(self) self:x(32*-13):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight4", InitCommand=function(self) self:x(32*-12):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight5", InitCommand=function(self) self:x(32*-11):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight6", InitCommand=function(self) self:x(32*-10):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight7", InitCommand=function(self) self:x(32*-9):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight8", InitCommand=function(self) self:x(32*-8):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight9", InitCommand=function(self) self:x(32*-7):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight10", InitCommand=function(self) self:x(32*-6):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight11", InitCommand=function(self) self:x(32*-5):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight12", InitCommand=function(self) self:x(32*-4):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight13", InitCommand=function(self) self:x(32*-3):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight14", InitCommand=function(self) self:x(32*-2):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight15", InitCommand=function(self) self:x(32*-1):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight16", InitCommand=function(self) self:x(32*0):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight17", InitCommand=function(self) self:x(32*1):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight18", InitCommand=function(self) self:x(32*2):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight19", InitCommand=function(self) self:x(32*3):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight20", InitCommand=function(self) self:x(32*4):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight21", InitCommand=function(self) self:x(32*5):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight22", InitCommand=function(self) self:x(32*6):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight23", InitCommand=function(self) self:x(32*7):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight24", InitCommand=function(self) self:x(32*8):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight25", InitCommand=function(self) self:x(32*9):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight26", InitCommand=function(self) self:x(32*10):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight27", InitCommand=function(self) self:x(32*11):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight28", InitCommand=function(self) self:x(32*12):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight29", InitCommand=function(self) self:x(32*13):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight30", InitCommand=function(self) self:x(32*14):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedDown", Name="SpeedDownRight31", InitCommand=function(self) self:x(32*15):diffusealpha(0.5):zoomtoheight(15*widthZoom):rotationz(180):SetAllStateDelays(0.125) end }
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
				InitCommand=function(self) self:zoomto(SCREEN_HEIGHT*4,16*widthZoom) end
			},
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft1", InitCommand=function(self) self:x(32*-15):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft2", InitCommand=function(self) self:x(32*-14):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft3", InitCommand=function(self) self:x(32*-13):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft4", InitCommand=function(self) self:x(32*-12):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft5", InitCommand=function(self) self:x(32*-11):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft6", InitCommand=function(self) self:x(32*-10):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft7", InitCommand=function(self) self:x(32*-9):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft8", InitCommand=function(self) self:x(32*-8):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft9", InitCommand=function(self) self:x(32*-7):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft10", InitCommand=function(self) self:x(32*-6):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft11", InitCommand=function(self) self:x(32*-5):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft12", InitCommand=function(self) self:x(32*-4):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft13", InitCommand=function(self) self:x(32*-3):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft14", InitCommand=function(self) self:x(32*-2):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft15", InitCommand=function(self) self:x(32*-1):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft16", InitCommand=function(self) self:x(32*0):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft17", InitCommand=function(self) self:x(32*1):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft18", InitCommand=function(self) self:x(32*2):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft19", InitCommand=function(self) self:x(32*3):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft20", InitCommand=function(self) self:x(32*4):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft21", InitCommand=function(self) self:x(32*5):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft22", InitCommand=function(self) self:x(32*6):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft23", InitCommand=function(self) self:x(32*7):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft24", InitCommand=function(self) self:x(32*8):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft25", InitCommand=function(self) self:x(32*9):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft26", InitCommand=function(self) self:x(32*10):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft27", InitCommand=function(self) self:x(32*11):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft28", InitCommand=function(self) self:x(32*12):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft29", InitCommand=function(self) self:x(32*13):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft30", InitCommand=function(self) self:x(32*14):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpLeft31", InitCommand=function(self) self:x(32*15):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end }
		},
		Def.ActorFrame{
			InitCommand=function(self) self:x(filterWidth/2+8*widthZoom):CenterY():rotationz(rotate):valign(1) end,
			OnCommand=function(self) cUr = self:GetChildren() end,
			Def.Sprite {
				Texture = THEME:GetPathG("","profile "..(isFinal() and "final" or "normal")),
				Name="SpeedUpRight",
				InitCommand=function(self) self:zoomto(SCREEN_HEIGHT*4,-16*widthZoom) end
			},
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight1", InitCommand=function(self) self:x(32*-15):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight2", InitCommand=function(self) self:x(32*-14):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight3", InitCommand=function(self) self:x(32*-13):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight4", InitCommand=function(self) self:x(32*-12):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight5", InitCommand=function(self) self:x(32*-11):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight6", InitCommand=function(self) self:x(32*-10):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight7", InitCommand=function(self) self:x(32*-9):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight8", InitCommand=function(self) self:x(32*-8):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight9", InitCommand=function(self) self:x(32*-7):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight10", InitCommand=function(self) self:x(32*-6):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight11", InitCommand=function(self) self:x(32*-5):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight12", InitCommand=function(self) self:x(32*-4):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight13", InitCommand=function(self) self:x(32*-3):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight14", InitCommand=function(self) self:x(32*-2):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight15", InitCommand=function(self) self:x(32*-1):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight16", InitCommand=function(self) self:x(32*0):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight17", InitCommand=function(self) self:x(32*1):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight18", InitCommand=function(self) self:x(32*2):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight19", InitCommand=function(self) self:x(32*3):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight20", InitCommand=function(self) self:x(32*4):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight21", InitCommand=function(self) self:x(32*5):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight22", InitCommand=function(self) self:x(32*6):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight23", InitCommand=function(self) self:x(32*7):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight24", InitCommand=function(self) self:x(32*8):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight25", InitCommand=function(self) self:x(32*9):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight26", InitCommand=function(self) self:x(32*10):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight27", InitCommand=function(self) self:x(32*11):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight28", InitCommand=function(self) self:x(32*12):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight29", InitCommand=function(self) self:x(32*13):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight30", InitCommand=function(self) self:x(32*14):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end },
			Def.Sprite { Texture = "SpeedUp", Name="SpeedUpRight31", InitCommand=function(self) self:x(32*15):diffusealpha(0.5):zoomtoheight(15*widthZoom):SetAllStateDelays(0.125) end }
		}
	}
}