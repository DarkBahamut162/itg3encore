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
		InitCommand=cmd(settext,gc:GetText();halign,1);
		--effectperiod,2;effectcolor2,color("1,1,1,0")
		GainFocusCommand=cmd(diffuseshift;effectperiod,0.5;effectcolor1,itemColor;effectcolor2,Alpha(itemColor,0.5);effectclock,"timer";zoom,0.8;);
		LoseFocusCommand=cmd(stoptweening;stopeffect;zoom,0.7);
		DisabledCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
};