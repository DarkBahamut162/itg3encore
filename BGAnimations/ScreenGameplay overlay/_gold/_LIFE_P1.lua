return Def.ActorFrame{
	InitCommand=function(self) self:x(0):y(-15) end,
	Def.Sprite {
		Texture = "LIFE_P1",
		InitCommand=function(self) self:x(0):y(0) end
	},
	Def.Sprite {
		Texture = "../life/"..IIDXLifeBar(PLAYER_1),
		InitCommand=function(self) self:diffuse(.3,.3,.3,1):x(-7):y(-1):visible((GAMESTATE:IsPlayerEnabled(PLAYER_1))) end
	},
	Def.Sprite {
		Texture = "../life/"..IIDXLifeBar(PLAYER_1),
		InitCommand=function(self) self:x(-7):y(-1):visible((GAMESTATE:IsPlayerEnabled(PLAYER_1))) end,
		LifeChangedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				local life = param.LifeMeter:GetLife()
				life = math.round(life/2,2)*2
				self:cropright(1 - life)
			end
		end,
		ChangeBorderMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				if param.Color == "rainbow" then self:rainbow() else self:stopeffect():diffuse(color(param.Color)) end
			end
		end
	},
	Def.Sprite {
		Texture = "tip",
		InitCommand=function(self) self:diffuseblink():effectperiod(0.16):effectcolor1(color("1,1,1,1")):effectcolor2(color("1,1,1,0")):x(-11):y(-1):visible((GAMESTATE:IsPlayerEnabled(PLAYER_1))) end,
		LifeChangedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				local life = param.LifeMeter:GetLife()
				life = math.round(life/2,2)*2
				self:cropright(1 - life):cropleft(life - 0.02)
			end
		end
	},
	Def.Sprite {
		Texture = "tip",
		InitCommand=function(self) self:diffuseblink():effectperiod(0.1):effectcolor1(color("1,1,1,1")):effectcolor2(color("1,1,1,0")):x(-15):y(-1):visible((GAMESTATE:IsPlayerEnabled(PLAYER_1))) end,
		LifeChangedMessageCommand=function(self,param)
			if param.Player == PLAYER_1 then
				local life = param.LifeMeter:GetLife()
				life = math.round(life/2,2)*2
				self:cropright(1 - life):cropleft(life - 0.02)
			end
		end
	}
}