local player = ...
assert(player,"[ScreenEvaluation AutoPlayer] requires player")
local autoPlayer = getenv("EvalCombo"..pname(player))

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		Text="AutoPlayer",
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(2*WideScreenDiff()):cropright(1):visible(not autoPlayer) end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#FF0000")) end
	}
}