local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local record = stats:GetPersonalHighScoreIndex()
local hasPersonalRecord = (record == 0)

return Def.ActorFrame{
	LoadFont("_v 26px bold diffuse")..{
		Text="New Personal Record!";
		InitCommand=function(self) self:zoomx(.6):zoomy(.5):shadowlength(2):cropright(1):visible(hasPersonalRecord) end;
		OnCommand=function(self) self:sleep(3):linear(.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end;
	};
};