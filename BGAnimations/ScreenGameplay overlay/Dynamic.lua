local player = ...
local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSong() or GAMESTATE:GetCurrentSong()
local StepOrTrails = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSteps() or GAMESTATE:GetCurrentSteps(player)
local timingData

if SongOrCourse and StepOrTrails then timingData = StepOrTrails:GetTimingData() end

local sudden = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):SuddenOffset() ~= 0
local hidden = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):HiddenOffset() ~= 0
local val = 0

local function UpdateDynamic(self)
	local YoffsetBeat = 0
	if sudden or hidden or (isVS() and GAMESTATE:IsHumanPlayer(player)) then
		YoffsetBeat = ArrowEffects.GetYOffset(GAMESTATE:GetPlayerState(player),1,timingData:GetBeatFromElapsedTime(GAMESTATE:GetSongPosition():GetMusicSecondsVisible()+1))/64
		if sudden or isVS() then
			val = YoffsetBeat / 3 - 1
			GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):SuddenOffset(val,100)
		end
		if hidden or isVS() then
			val = math.min(4,YoffsetBeat / 2) / 3 - 1
			GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):HiddenOffset(val,100)
		end
	end
end

return Def.ActorFrame{
	OnCommand=function(self) if sudden or hidden or isVS() then self:SetUpdateFunction(UpdateDynamic) end end
}