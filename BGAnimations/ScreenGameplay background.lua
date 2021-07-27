--[[
	Let's begin by setting the enviroment that this will be placed on.
	We Center it, make a fov so depth can happen, flip the Y axis because Characters
	in StepMania are flipped, and set the Z position depending on Aspect Ratio because
	the z field changes on the current Aspect Ratio, so correct that.
]]
--The only way on making custommods work... I think... ~DarkBahamut162
local background = Def.ActorFrame {
	Name="YOU_WISH_YOU_WERE_PLAYING_BEATMANIA_RIGHT_NOW",
	OnCommand=function()
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local pX = pname(pn);
			if PREFSMAN:GetPreference("Center1Player") and GAMESTATE:GetNumPlayersEnabled() == 1 then
				if pn == PLAYER_2 then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):addx(SCREEN_WIDTH/4);
				else
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):addx(-SCREEN_WIDTH/4);
				end
			end
			if SCREENMAN:GetTopScreen():GetChild("Player"..pX) and SCREENMAN:GetTopScreen():GetChild("Player"..pX):GetChild("NoteField") then
				if getenv("RotationLeft"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):GetChild("NoteField"):rotationz(270);
					if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pX):GetChild("NoteField"):addx(-SCREEN_WIDTH/2);
					end
				elseif getenv("RotationRight"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):GetChild("NoteField"):rotationz(90);
					if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
						SCREENMAN:GetTopScreen():GetChild("Player"..pX):GetChild("NoteField"):addx(SCREEN_WIDTH/2);
					end
				elseif getenv("RotationUpsideDown"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):GetChild("NoteField"):rotationz(180):addy(20);
				elseif getenv("RotationSolo"..pX) == true then
					if pn == PLAYER_2 then
						SCREENMAN:GetTopScreen():GetChild("Player"..pX):addx(-SCREEN_WIDTH/4);
					else
						SCREENMAN:GetTopScreen():GetChild("Player"..pX):addx(SCREEN_WIDTH/4);
					end
				end

				if getenv("EffectSpin"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):spin():effectclock('beat'):effectmagnitude(0,0,45);
				elseif getenv("EffectSpinReverse"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):spin():effectclock('beat'):effectmagnitude(0,0,-45);
				elseif getenv("EffectVibrate"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):vibrate():effectmagnitude(20,20,20);
				elseif getenv("EffectBounce"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):bob():effectclock('beat'):effectmagnitude(30,30,30);
				elseif getenv("EffectPulse"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):pulse():effectclock('beat');
				elseif getenv("EffectWag"..pX) == true then
					SCREENMAN:GetTopScreen():GetChild("Player"..pX):wag():effectclock('beat');
				end
			end
		end
	end
};

return background;