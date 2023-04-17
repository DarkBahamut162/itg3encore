local player = ...
assert(player,"[ScreenEvaluation MachineRecord] requires player")
local record = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetMachineHighScoreIndex()
local hasMachineRecord = (record ~= -1) and record <= 10

if hasMachineRecord and not STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed() then
	setenv("HighScoreable"..pname(player),true)
end

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(2*WideScreenDiff()):cropright(1):visible(hasMachineRecord) end,
		BeginCommand=function(self)
			self:settext(string.format("Machine Record #%i",record+1))
		end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}