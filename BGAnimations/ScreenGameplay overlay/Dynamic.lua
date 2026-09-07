local player = ...
local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSong() or GAMESTATE:GetCurrentSong()
local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player):GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()):GetSteps() or GAMESTATE:GetCurrentSteps(player)
local timingData

if SongOrCourse and StepsOrTrail then timingData = StepsOrTrail:GetTimingData() end

local sudden = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):SuddenOffset() ~= 0
local hidden = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):HiddenOffset() ~= 0
local val = 0

local check = sudden or hidden or (isVS() and GAMESTATE:IsHumanPlayer(player))

local function UpdateDynamic(self)
	local YoffsetBeat = 0
	if check then
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
	OnCommand=function(self)
		if check then
			if sudden then
				GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):Sudden(99999,100)
			elseif hidden then
				GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Song"):Hidden(99999,100)
			end
			self:SetUpdateFunction(UpdateDynamic)
		end
	end
}