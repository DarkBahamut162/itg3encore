local player = ...
assert(player,"[ScreenEvaluation MachineRecord] requires player")
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local record = stats:GetMachineHighScoreIndex()
local hasMachineRecord = (record ~= -1) and record <= 10

return Def.ActorFrame{
	LoadFont("_v 26px bold diffuse")..{
		InitCommand=function(self) self:zoomx(.6):zoomy(.5):shadowlength(2):cropright(1):visible(hasMachineRecord) end;
		BeginCommand=function(self)
			self:settext(string.format("Machine Record #%i",record+1))
		end;
		OnCommand=function(self) self:sleep(3):linear(.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end;
	};
};