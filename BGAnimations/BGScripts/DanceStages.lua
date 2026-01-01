local DanceStageSelected = getenv("SelectDanceStage") or "OFF"
if DanceStageSelected == "OFF" then return Def.ActorFrame{} end

local gFOV = 90
if THEME:GetMetric("Common", "ScreenHeight") >= 1080 then gFOV = 91.3 end

local t = Def.ActorFrame{
	SPos = GAMESTATE:GetSongPosition(),
	OnCommand=function(self)
		self:Center():fov(gFOV)
		Camera = self
		if not (HasVideo() and _VERSION ~= "Lua 5.3") then Camera:SetUpdateFunction(SlowMotion) end
	end
}

local DanceStage

local DanceStagesDir = GetAllDanceStagesNames()
table.remove(DanceStagesDir,IndexKey(DanceStagesDir,"OFF"))
table.remove(DanceStagesDir,IndexKey(DanceStagesDir,"DEFAULT"))
table.remove(DanceStagesDir,IndexKey(DanceStagesDir,"RANDOM"))

if not GAMESTATE:IsDemonstration() then
	if DanceStageSelected == "DEFAULT" then
		DanceStage = DanceStageSong()
	elseif DanceStageSelected == "RANDOM" then
		DanceStage = DanceStagesDir[math.random(#DanceStagesDir)]
	else
		DanceStage = getenv("SelectDanceStage")
	end
else
	DanceStage = DanceStageSong()
end

if (not HasVideo() and not HasLuaCheck()) or (HasVideo() and VideoStage() and not HasLuaCheck()) or (HasVideo() and not VideoStage() and not VoverS()) then
	t[#t+1] = loadfile("/DanceStages/"..DanceStage.."/LoaderA.lua")()
	t[#t+1] = loadfile(THEME:GetPathB("","BGScripts/Characters.lua"))()

	if FILEMAN:DoesFileExist("/DanceStages/"..DanceStage.."/LoaderB.lua") then
		t[#t+1] = loadfile("/DanceStages/"..DanceStage.."/LoaderB.lua")()
	end

	t[#t+1] = loadfile("/DanceStages/"..DanceStage.."/Cameras.lua")()

	CamRan=1
	local CameraRandomList = {}

	for i = 1, NumCameras do CameraRandomList[i] = i end
	for i = 1, NumCameras do
		local CamRandNumber = math.random(1,NumCameras)
		local TempRand = CameraRandomList[i]
		CameraRandomList[i] = CameraRandomList[CamRandNumber]
		CameraRandomList[CamRandNumber] = TempRand
	end

	t[#t+1] = Def.Quad{
		OnCommand=function(self)
			self:visible(false):queuemessage("Camera"..CameraRandomList[6]):sleep(WaitTime[CameraRandomList[6]]):queuecommand("TrackTime")
		end,
		TrackTimeCommand=function(self)
			DEDICHAR:SetTimingData()
			self:sleep(1/60)
			self:queuemessage("Camera"..CameraRandomList[CamRan]):sleep(WaitTime[CameraRandomList[CamRan]])
			CurrentStageCamera = CurrentStageCamera
			CamRan=CamRan+1
			if CamRan==NumCameras then CamRan = 1 end
			self:queuecommand("TrackTime")
		end
	}
end

return t