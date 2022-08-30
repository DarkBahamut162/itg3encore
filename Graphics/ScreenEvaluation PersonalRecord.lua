local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")
local record = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPersonalHighScoreIndex()
local hasPersonalRecord = (record == 0)

if hasPersonalRecord and not STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed() then
	setenv("HighScoreable"..ToEnumShortString(player),true)
end

return Def.ActorFrame{
	LoadFont("_v 26px bold diffuse")..{
		Text="New Personal Record!",
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(2):cropright(1):visible(hasPersonalRecord) end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}