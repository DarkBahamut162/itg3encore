local player = ...
local t = Def.ActorFrame{}
if not GAMESTATE:IsHumanPlayer(player) or isTopScreen("ScreenDemonstration2") or isTopScreen("ScreenDemonstration") then return t end

local tilt = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions():Tilt()
local tilt_degrees = scale(tilt,-1,1,30,30) % 360
if tilt_degrees > 180 then tilt_degrees = tilt_degrees - (tilt_degrees-180) end
local stretch = 1-(tilt_degrees/180)
local add = math.abs(SCREEN_HEIGHT-SCREEN_HEIGHT/stretch)*2

local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
local currentMini = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Mini()*50) / 100
local currentTiny = 1-math.round(GAMESTATE:GetPlayerState(player):GetPlayerOptions(mlevel):Tiny()*50) / 100
currentMini = currentMini * currentTiny * WideScreenDiff()

local style = GAMESTATE:GetCurrentStyle()

if tilt > 0 then
	currentMini = currentMini * scale(tilt,0,1,1,0.9)
	add = add + math.abs(scale(tilt,0,1,0,-45)/stretch)
else
	currentMini = currentMini * scale(tilt,0,-1,1,0.9)
	add = add + math.abs(scale(tilt,0,-1,0,-20)/stretch)
end

function getFilter(player,filterWidth,filterAlpha)
	local gameMode = GAMESTATE:GetCurrentGame():GetName()
	local stepsType = ToEnumShortString(style:GetStepsType())
	local stepsTypeNumber = tonumber(string.match(stepsType, "%d+"))
	local special = false

	if filterAlpha == nil then filterAlpha = 0 end
	filterWidth = filterWidth * math.min(1,isOutFox(20200600) and NotefieldZoomOutFox() or NotefieldZoom())

	local file = ""
	local pomuREST = ""
	if isOutFoxV() then
		if gameMode == "be-mu" then
			special = true
			if stepsTypeNumber == 5 then
				file = stepsTypeNumber
				if not isDouble() then filterWidth = filterWidth * 1.05 else filterWidth = filterWidth * 1.025 end
			elseif stepsTypeNumber == 6 then
				file = (stepsTypeNumber-1) .. "p"
				if not isDouble() then filterWidth = filterWidth * 1.05 else filterWidth = filterWidth * 1.025 end
			elseif stepsTypeNumber == 7 then
				file = stepsTypeNumber .. pname(player)
				if not isDouble() then filterWidth = filterWidth * 1.05 else filterWidth = filterWidth / 1.05 end
			end
		elseif gameMode == "po-mu" then
			pomuREST = split('_', stepsType)[2]
			special = true
			if pomuREST == "Three" then
				file = 3
			elseif pomuREST == "Four" then
				file = 4
				special = false
			elseif pomuREST == "Five" then
				file = 5
			elseif pomuREST == "Seven" then
				file = 7
			elseif pomuREST == "Nine" then
				file = 9
			end
			file = file .. "Light"
		end
	end
	file = file .. " "
	if special and FILEMAN:DoesFileExist("/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file.."(stretch).png") then
		if isDouble() then
			local file2 = (gameMode == "be-mu" and stepsTypeNumber == 7) and "7P2" or file
			local repos = 0
			if gameMode == "be-mu" and stepsTypeNumber == 7 then repos = 30 elseif gameMode == "po-mu" and pomuREST == "Nine" then repos = 15 end
			return Def.ActorFrame{
				Def.Sprite {
					Texture = "/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file,
					InitCommand=function(self) self:x((-filterWidth/4)-repos):y(SCREEN_CENTER_Y):zoomto(filterWidth/2,(SCREEN_HEIGHT+add)/currentMini):diffusealpha(filterAlpha) end
				},
				Def.Sprite {
					Texture = "/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file2,
					InitCommand=function(self) self:x((filterWidth/4)+repos):y(SCREEN_CENTER_Y):zoomto(filterWidth/2,(SCREEN_HEIGHT+add)/currentMini):diffusealpha(filterAlpha) end
				}
			}
		else
			return Def.Sprite {
				Texture = "/Appearance/BackPlates/"..gameMode.."/"..string.gsub(gameMode,"-","")..file,
				InitCommand=function(self) self:y(SCREEN_CENTER_Y):zoomto(filterWidth,(SCREEN_HEIGHT+add)/currentMini):diffusealpha(filterAlpha) end
			}
		end
	else
		return Def.Quad{
			InitCommand=function(self) self:y(SCREEN_CENTER_Y):zoomto(filterWidth,(SCREEN_HEIGHT+add)/currentMini):diffusecolor(color("0.135,0.135,0.135,1")):diffusealpha(filterAlpha) end
		}
	end
end

local filterAlpha = tonumber(getenv("ScreenFilter"..pname(player)))
local filterWidth = GetTrueWidth(player)

t[#t+1] = Def.ActorFrame{
	getFilter(player,filterWidth,filterAlpha),
	loadfile(THEME:GetPathG("NoteField","Board Front/SpeedAssist"))(player),
	loadfile(THEME:GetPathG("NoteField","Board Front/StopAssist"))(player)
}

return t