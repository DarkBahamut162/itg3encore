local gc = Var("GameCommand");
local itemColors = {
	Dance = color("#01DE20"),
	Battle = color("#DE0101"),
	Marathon = color("#DEDB01"),
	Survival = color("#0188DE"),
	Fitness = color("#DE01B2"),
	default = color("1,1,1,1")
};

local itemColor = itemColors[gc:GetName()] or itemColors.default

return Def.ActorFrame{
	LoadFont("_ScreenTitleMenu choices")..{
		InitCommand=function(self) self:settext(gc:GetText()):halign(1) end;
		GainFocusCommand=function(self) self:diffuseshift():effectperiod(0.5):effectcolor1(itemColor):effectcolor2(Alpha(itemColor,0.5)):effectclock("timer"):zoom(0.8) end;
		LoseFocusCommand=function(self) self:stoptweening():stopeffect():zoom(0.7) end;
		DisabledCommand=function(self) self:diffuse(color("0.5,0.5,0.5,1")) end;
	};
};