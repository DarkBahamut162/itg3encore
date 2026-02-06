local pn = ...
local DifficultyToFrame = {
	Difficulty_Beginner	 = 0,
	Difficulty_Easy		 = 1,
	Difficulty_Medium	 = 2,
	Difficulty_Hard		 = 3,
	Difficulty_Challenge = 4,
	Difficulty_Edit		 = 5,
}

local song = GAMESTATE:GetCurrentSong()
local steps = GAMESTATE:GetCurrentSteps(pn)
local diff = steps:GetDifficulty()
local og = getCalculatedDifficulty(steps)
if not string.find(og,"OG") then og = "LEVEL "..og end

return Def.ActorFrame{
	Def.Sprite {
		Texture = "_diff",
		InitCommand=function(self) self:x(449*WideScreenDiff()):y(463):zoom(WideScreenDiff()):animate(false):setstate(DifficultyToFrame[diff] or 5):addy(-14):croptop(1):sleep(2.45):linear(0.35):addy(14):croptop(0):playcommand("Animate") end,
		AnimateCommand=function(self) self:x(449*WideScreenDiff()):y(463):sleep(2):linear(0.35):addy(14):cropbottom(1):sleep(0):sleep(2.8):croptop(1):cropbottom(0):sleep(0.1):addy(-28):linear(0.35):addy(14):croptop(0):queuecommand("Animate") end
	},
	Def.ActorFrame{
		Def.BitmapText {
			File=THEME:GetPathF("_iidx/Difficulty", "Normal"),
			Text=string.gsub(og,"\n"," | "),
			InitCommand=function(self) if DifficultyToFrame[diff] ~= 4 then self:diffusetopedge(color("#FFFFFF")) end self:maxwidth(80):diffuse(CustomIIDXDifficultyToColor(ToEnumShortString(diff))):zoom(0.9*WideScreenDiff()):queuecommand("Animate") end,
			AnimateCommand=function(self) self:x(449*WideScreenDiff()):y(463):sleep(2):linear(0.35):cropleft(1):sleep(0):sleep(2.8):cropright(1):cropleft(0):sleep(0.1):linear(0.35):cropright(0):queuecommand("Animate") end
		},
		Def.BitmapText {
			Condition=DifficultyToFrame[diff] == 4,
			File=THEME:GetPathF("_iidx/Difficulty", "Stroke"),
			Text=string.gsub(og,"\n"," | "),
			InitCommand=function(self) self:maxwidth(80):diffuse(Color("Red")):zoom(0.9*WideScreenDiff()):queuecommand("Animate") end,
			AnimateCommand=function(self) self:x(449*WideScreenDiff()):y(463):sleep(2):linear(0.35):cropleft(1):sleep(0):sleep(2.8):cropright(1):cropleft(0):sleep(0.1):linear(0.35):cropright(0):queuecommand("Animate") end
		}
	},
	Def.BitmapText {
		File=THEME:GetPathF("_iidx/Speed", "White"),
		InitCommand=function(self) self:x(450*WideScreenDiff()):y(435):maxwidth(85):zoom(0.9*WideScreenDiff()) end,
		SpeedMessageCommand=function(self,param) if param.PLAYER == PLAYER_2 then self:settext("SPEED: "..param.SPEED..string.upper(param.MOD)) end end
	}
}