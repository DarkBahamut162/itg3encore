local player = ...
assert(player,"[ScreenEvaluation MachineRecord] requires player")
local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player);
local record = stats:GetMachineHighScoreIndex()
local hasMachineRecord = (record ~= -1) and record <= 10

return Def.ActorFrame{
	LoadFont("_v 26px bold diffuse")..{
		InitCommand=cmd(zoomx,.6;zoomy,.5;shadowlength,2;cropright,1;visible,hasMachineRecord);
		BeginCommand=function(self)
			self:settext(string.format("Machine Record #%i",record))
		end;
		OnCommand=cmd(sleep,3;linear,.3;cropright,0;diffuseshift;effectcolor1,color("#00C0FF"));
	};
};