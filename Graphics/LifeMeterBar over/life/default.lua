local pn = ...

return Def.ActorFrame{
	InitCommand=function(self) self:addy(1):zoomx(1.35):zoomy(1.1) end,
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenGameplay","overlay/life/"..IIDXLifeBar(pn)),
		InitCommand=function(self) self:diffuse(.3,.3,.3,1) end
	},
	Def.ActorFrame{
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","overlay/life/"..IIDXLifeBar(pn)),
			LifeChangedMessageCommand=function(self,param)
				if param.Player == pn then
					local life = param.LifeMeter:GetLife()
					life = math.round(life/2,2)*2
					self:cropright(1 - life)
				end
			end,
			ChangeBorderMessageCommand=function(self,param)
				if param.Player == pn then
					if param.Color == "rainbow" then self:rainbow() else self:stopeffect():diffuse(color(param.Color)) end
				end
			end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","overlay/life/"..IIDXLifeBar(pn)),
			InitCommand=function(self) self:diffuseblink():effectperiod(0.16):effectcolor1(color("1,1,1,1")):effectcolor2(color(".3,.3,.3,1")):visible((GAMESTATE:IsPlayerEnabled(pn))) end,
			LifeChangedMessageCommand=function(self,param)
				if param.Player == pn then
					local life = param.LifeMeter:GetLife()
					life = math.round(life/2,2)*2
					self:cropright(1 - life + 0.02):cropleft(life - 0.04)
				end
			end
		},
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenGameplay","overlay/life/"..IIDXLifeBar(pn)),
			InitCommand=function(self) self:diffuseblink():effectperiod(0.1):effectcolor1(color("1,1,1,1")):effectcolor2(color(".3,.3,.3,1")):visible((GAMESTATE:IsPlayerEnabled(pn))) end,
			LifeChangedMessageCommand=function(self,param)
				if param.Player == pn then
					local life = param.LifeMeter:GetLife()
					life = math.round(life/2,2)*2
					self:cropright(1 - life + 0.04):cropleft(life - 0.06)
				end
			end
		}
	}
}