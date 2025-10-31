local master = GAMESTATE:GetMasterPlayerNumber()
local rate = math.round(GAMESTATE:GetSongOptionsObject("ModsLevel_Song"):MusicRate(),1)
local previousSeconds = 0
local firstSeconds = 0
local totalSeconds = 0
local trialSeconds = {}
local trialFirstSecond = {}
local courseMode = GAMESTATE:IsCourseMode()
local totalDelta = 0
local tmpDelta = 0
local c

if courseMode then
	local trail = GAMESTATE:GetCurrentTrail(master)
	if trail then
        local seconds = 0
		local entries = trail:GetTrailEntries()
		for i, entry in ipairs(entries) do
			seconds = seconds + (entry:GetSong():GetLastSecond()-entry:GetSong():GetFirstSecond())
			table.insert(trialSeconds, seconds)
			table.insert(trialFirstSecond, entry:GetSong():GetFirstSecond())
		end
        totalSeconds = seconds
    end
else
	local song = GAMESTATE:GetCurrentSong()
	if song then
        totalSeconds = song:GetLastSecond()-song:GetFirstSecond()
        firstSeconds = song:GetFirstSecond()
    end
end
if totalSeconds < 0 then totalSeconds = 0 end

local function Update(self, delta)
	totalDelta = totalDelta + delta
	if totalDelta - tmpDelta > 1/60 then
		tmpDelta = totalDelta
        local currentSecond = GAMESTATE:GetPlayerState(master):GetSongPosition():GetMusicSeconds()-firstSeconds
        c.Time:settext(SecondsToMMSS(math.min((math.max(0,currentSecond)+previousSeconds),courseMode and trialSeconds[GAMESTATE:GetCourseSongIndex()+1] or totalSeconds)/rate).."-"..SecondsToMMSS(totalSeconds/rate))
    end
end

return Def.ActorFrame{
    InitCommand=function(self) self:SetUpdateFunction(Update) c = self:GetChildren() end,
    OnCommand=function(self) self:addy(-100):sleep(0.5):queuecommand("TweenOn") end,
    OffCommand=function(self) totalDelta = 0 self:queuecommand("TweenOff") end,
    TweenOnCommand=function(self) self:decelerate(0.8):addy(100) end,
    TweenOffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end self:accelerate(0.8):addy(-100) end,
    CurrentSongChangedMessageCommand=function()
        if courseMode then
            previousSeconds = trialSeconds[GAMESTATE:GetCourseSongIndex()] or 0
            firstSeconds = trialFirstSecond[GAMESTATE:GetCourseSongIndex()+1] or 0
        end
    end,
	Def.BitmapText {
        Name = "Time",
		File = "_r bold numbers",
		InitCommand=function(self) self:CenterX():y(SCREEN_TOP+4*WideScreenDiff()):maxwidth(SCREEN_WIDTH/WideScreenDiff()):zoom(1/3*WideScreenDiff()) end
	}
}