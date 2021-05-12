local Players = GAMESTATE:GetHumanPlayers()
local t = Def.ActorFrame{ Name="GameplayUnderlay" }

t[#t+1] = Def.ActorFrame{
	LoadActor("ScreenFilter");
	LoadActor("beginner")..{
		InitCommand=function(self)
			local pm = GAMESTATE:GetPlayMode()
			local isBeginner = GAMESTATE:GetEasiestStepsDifficulty() == 'Difficulty_Beginner'
			self:visible(pm == 'PlayMode_Regular' and isBeginner)
		end;
	};
	LoadActor("stepstats")..{
		InitCommand=function(self)
			local statsP1 = getenv("StatsDisplayP1")
			local statsP2 = getenv("StatsDisplayP2")
			self:visible(statsP1 == true or statsP2 == true)
		end;
	};
	LoadActor("danger");
	LoadActor("dead");
};

for player in ivalues(Players) do
	t[#t+1] = LoadActor("score", player)
end

--- CustomMod functionality moved to here ---
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	local pX = pname(pn);
--[[
	if getenv("RotationLeft"..pX) == true then
		PlayerX:rotationz(270);
		if pn == PLAYER_1 then
			PlayerX:x(SCREEN_LEFT+190+GetLifebarAdjustment());
		else
			PlayerX:x(SCREEN_CENTER_X+160+GetLifebarAdjustment());
		end		
		if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			PlayerX:addx(-SCREEN_WIDTH/2);
		end
	elseif getenv("RotationRight"..pX) == true then
		PlayerX:rotationz(90);
		if pn == PLAYER_2 then
			PlayerX:x(SCREEN_RIGHT-190-GetLifebarAdjustment());
		else
			PlayerX:x(SCREEN_CENTER_X-160-GetLifebarAdjustment());
		end	
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
			PlayerX:addx(SCREEN_WIDTH/2);
		end
	elseif getenv("RotationUpsideDown"..pX) == true then
		PlayerX:rotationz(180):addy(20);
	elseif getenv("RotationSolo"..pX) == true then
		PlayerX:x(SCREEN_CENTER_X);
	end
	local PlayerX = SCREENMAN:GetTopScreen():GetChild('Player'..pX);

	if getenv("EffectSpin"..pX) == true then
		PlayerX:spin():effectclock('beat'):effectmagnitude(0,0,45);
	end
	if getenv("EffectSpinReverse"..pX) == true then
		PlayerX:spin():effectclock('beat'):effectmagnitude(0,0,-45);
	end
	if getenv("EffectVibrate"..pX) == true then
		PlayerX:vibrate():effectmagnitude(20,20,20);
	end
	if getenv("EffectBounce"..pX) == true then
		PlayerX:bob():effectclock('beat'):effectmagnitude(30,30,30);
	end
	if getenv("EffectPulse"..pX) == true then
		PlayerX:pulse():effectclock('beat');
	end
	if getenv("EffectWag"..pX) == true then
		PlayerX:wag():effectclock('beat');
	end
	]]--
end

return t;