local player = ...
assert(player,"[ScreenEvaluation StageAward] requires player")
--[[
full combo W1	trophy bronze
full combo W2	plaque bronze
full combo W3	ribbon blue

W3 80%			ribbon green
W3 90%			plaque green
W3 100%			trophy green

OneW2			flag orange
OneW3			flag green

SingleDigitW2s	
SingleDigitW3s	
--]]

return Def.ActorFrame{
	--[[
	LoadActor()..{
		Name="Trophy";
		InitCommand=function(self) self:zoom(0.7):x(-60):y(-80):rotationy(-15) end;
	};
	--]]
	LoadFont("_eurostile normal")..{
		Name="Text";
		InitCommand=function(self) self:halign(1):shadowlength(2):maxwidth(250):settext("stage") end;
	};
};