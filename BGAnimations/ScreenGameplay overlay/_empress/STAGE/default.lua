if GAMESTATE:GetNumPlayersEnabled() == 2 then
	local pn = PLAYER_1
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
	local add = getenv("IIDXDouble"..pname(pn)) and 5 or 0

	return Def.ActorFrame{
		Def.Sprite {
			Texture = "../DIFFICULTY/_diff",
			InitCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):zoom(WideScreenDiff()):animate(false):setstate(DifficultyToFrame[diff] or 5):addy(WideScreenDiff()*-14):croptop(1):sleep(2.45):linear(0.35):addy(WideScreenDiff()*14):croptop(0):playcommand("Animate") end,
			AnimateCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):sleep(2):linear(0.35):addy(WideScreenDiff()*14):cropbottom(1):sleep(0):sleep(2.8):croptop(1):cropbottom(0):sleep(0.1):addy(WideScreenDiff()*-28):linear(0.35):addy(WideScreenDiff()*14):croptop(0):queuecommand("Animate") end
		},
		Def.ActorFrame{
			Def.BitmapText {
				File=THEME:GetPathF("_iidx/Difficulty", "Normal"),
				Text=string.gsub(og,"\n"," | "),
				InitCommand=function(self) if DifficultyToFrame[diff] ~= 4 then self:diffusetopedge(color("#FFFFFF")) end self:maxwidth(90):diffuse(CustomIIDXDifficultyToColor(ToEnumShortString(diff))):zoom(0.9*WideScreenDiff()):queuecommand("Animate") end,
				AnimateCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):sleep(2):linear(0.35):cropleft(1):sleep(0):sleep(2.8):cropright(1):cropleft(0):sleep(0.1):linear(0.35):cropright(0):queuecommand("Animate") end
			},
			Def.BitmapText {
				Condition=DifficultyToFrame[diff] == 4,
				File=THEME:GetPathF("_iidx/Difficulty", "Stroke"),
				Text=string.gsub(og,"\n"," | "),
				InitCommand=function(self) self:maxwidth(90):diffuse(Color("Red")):zoom(0.9*WideScreenDiff()):queuecommand("Animate") end,
				AnimateCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):sleep(2):linear(0.35):cropleft(1):sleep(0):sleep(2.8):cropright(1):cropleft(0):sleep(0.1):linear(0.35):cropright(0):queuecommand("Animate") end
			}
		},
		Def.BitmapText {
			File=THEME:GetPathF("_iidx/Speed", "White"),
			InitCommand=function(self) self:x(206*WideScreenDiff()):y(440+add):maxwidth(85):zoom(0.9*WideScreenDiff()) end,
			SpeedMessageCommand=function(self,param) if param.PLAYER == pn then self:settext("SPEED: "..param.SPEED..string.upper(param.MOD)) end end
		}
	}
else
	local StageToFrame = {
		Stage_1st		= 0,
		Stage_2nd		= 1,
		Stage_3rd		= 2,
		Stage_4th		= 3,
		Stage_5th		= 4,
		Stage_6th		= 5,
		Stage_Next		= 6,
		Stage_Final		= 7,
		Stage_Extra1	= 8,
		Stage_Extra2	= 9,
		Stage_Nonstop	= 10,
		Stage_Oni		= 11,
		Stage_Endless	= 12,
		Stage_Event		= 13,
		Stage_Demo		= 14
	}

	local add = getenv("IIDXDouble"..pname(PLAYER_1)) and 5 or 0

	return Def.ActorFrame{
		Def.Sprite {
			Texture = "_stage",
			InitCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):zoom(WideScreenDiff()):animate(false):setstate(StageToFrame[GAMESTATE:GetCurrentStage()]):addy(WideScreenDiff()*-14):croptop(1):sleep(2.45):linear(0.35):addy(WideScreenDiff()*14):croptop(0):playcommand("Animate") end,
			AnimateCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):sleep(2):linear(0.35):addy(WideScreenDiff()*14):cropbottom(1):sleep(0):sleep(2.8):croptop(1):cropbottom(0):sleep(0.1):addy(WideScreenDiff()*-28):linear(0.35):addy(WideScreenDiff()*14):croptop(0):queuecommand("Animate") end
		},
		Def.ActorFrame{
			Def.BitmapText {
				File=THEME:GetPathF("_iidx/Difficulty", "Normal"),
				Text="ITG3ENCORE",
				InitCommand=function(self) self:maxwidth(90):diffuse(color("#28C8F8")):diffusetopedge(color("#D0F8F8")):diffusealpha(2):zoom(0.9*WideScreenDiff()):queuecommand("Animate") end,
				AnimateCommand=function(self) self:x((204+add)*WideScreenDiff()):y(472+add):sleep(2):linear(0.35):cropleft(1):sleep(0):sleep(2.8):cropright(1):cropleft(0):sleep(0.1):linear(0.35):cropright(0):queuecommand("Animate") end
			}
		},
		Def.BitmapText {
			File=THEME:GetPathF("_iidx/Speed", "White"),
			InitCommand=function(self) self:x(206*WideScreenDiff()):y(440+add):maxwidth(85):zoom(0.9*WideScreenDiff()) end,
			SpeedMessageCommand=function(self,param) if param.PLAYER == PLAYER_1 then self:settext("SPEED: "..param.SPEED..string.upper(param.MOD)) end end
		}
	}
end