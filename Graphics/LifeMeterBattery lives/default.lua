local player = Var "Player"
local pnMaxLives = { PlayerNumber_P1 = 100, PlayerNumber_P2 = 100 }

return Def.ActorFrame{
	InitCommand=function(self)
		self:zoom(0.5):x( _screen.cx - _screen.w/8 + 60 ):y(80 - 7.5)
		if player == PLAYER_2 then self:x( _screen.cx + _screen.w/3.4 + 60 ) end
	end,
	Def.ActorFrame{
		InitCommand=function(self) self:rotationz(-90):zoom(2):addx(player == PLAYER_1 and -150 or 150) end,
		OnCommand=function(self) self:decelerate(0.8):addx(player == PLAYER_1 and 150 or -150) end,
		OffCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end
			self:accelerate(0.8):addx(player == PLAYER_1 and -150 or 150)
		end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == Health.Dead and param.PlayerNumber == player then
				self:accelerate(0.8):addx(player == PLAYER_1 and -150 or 150)
			end
		end,
		Def.Sprite {
			Texture = "meter black",
			InitCommand=function(self) self:zoomx(1.05) end
		},
		Def.Sprite {
			Texture = "meter grad",
			InitCommand=function(self) self:zoomx(1.05):cropright(1):sleep(1):decelerate(0.6):cropright(0) end,
			LifeChangedMessageCommand=function(self,params)
				if params.Player == player then
					if params.LivesLeft > pnMaxLives[player] then pnMaxLives[player] = params.LivesLeft end 
					self:stoptweening():accelerate(0.1):cropright(1-(params.LivesLeft/pnMaxLives[player]))
				end
			end
		},
		Def.Sprite {
			Texture = "light",
			InitCommand=function(self) self:blend(Blend.Add):addx(164-308-2):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#00EAFF")):effectcolor2(color("#FFFFFF00")):effectclock('beat'):effectperiod(4) end
		},
		Def.Sprite {
			Texture = "base "..(isFinal() and "final" or "normal"),
			InitCommand=function(self) self:addx(-5) end
		},
		Def.Sprite {
			Texture = "base glow final",
			Condition=isFinal(),
			InitCommand=function(self) self:addx(-5):blend(Blend.Add):diffuseramp():effectcolor1(color("#FFFFFF00")):effectcolor2(color("#FFFFFF")):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat') end
		},
		Def.Sprite {
			Texture = "light",
			InitCommand=function(self) self:blend(Blend.Add):addx(146-308-2):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#00EAFF")):effectcolor2(color("#FFFFFF00")):effectclock('beat'):effectperiod(4) end
		},
		Def.Sprite {
			Texture = "streak",
			InitCommand=function(self) self:addx(174-308-21):addx(-150) end,
			OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addx(150) end
		},
		Def.Sprite {
			Texture = "streak",
			InitCommand=function(self) self:addx(155-308-21):addx(-150) end,
			OnCommand=function(self) self:sleep(1):decelerate(0.6):addx(150) end
		},
		Def.Sprite {
			Texture = "glow2",
			InitCommand=function(self) self:blend(Blend.Add):addx(-5):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(1.8):decelerate(0.3):diffusealpha(1):sleep(0.2):accelerate(0.6):diffusealpha(0):queuecommand("Destroy") end,
			DestroyCommand=function(self) self:visible(false) end
		}
	},
	Def.ActorFrame{
		InitCommand=function(self) self:addx(player == PLAYER_1 and -150 or 150) end,
		OnCommand=function(self) self:decelerate(0.8):addx(player == PLAYER_1 and 150 or -150) end,
		OffCommand=function(self) self:accelerate(0.8):addx(player == PLAYER_1 and -150 or 150) end,
		HealthStateChangedMessageCommand=function(self, param)
			if param.HealthState == Health.Dead and param.PlayerNumber == player then
				self:accelerate(0.8):addx(player == PLAYER_1 and -150 or 150)
			end
		end,
		Def.BitmapText {
			File = "_angel glow",
			BeginCommand=function(self)
				local screen = SCREENMAN:GetTopScreen()
				local glifemeter = screen:GetLifeMeter(player)
				if glifemeter:GetTotalLives() > pnMaxLives[player] then pnMaxLives[player] = glifemeter:GetTotalLives() end 
				self:settext(glifemeter:GetTotalLives()):x(-1):y(-5):maxwidth(28):valign(1)
			end,
			LifeChangedMessageCommand=function(self,params)
				if params.Player == player then
					self:settext(params.LivesLeft)
				end
			end
		},
		Def.BitmapText {
			File = "_angel glow",
			BeginCommand=function(self)
				self:settext("_"):x(-1):y(-12):zoomx(2)
			end
		},
		Def.BitmapText {
			File = "_angel glow",
			BeginCommand=function(self)
				local screen = SCREENMAN:GetTopScreen()
				local glifemeter = screen:GetLifeMeter(player)
				self:settext(pnMaxLives[player]):x(-1):y(5):maxwidth(28):valign(0)
			end,
			LifeChangedMessageCommand=function(self,params)
				if params.Player == player and pnMaxLives[player] ~= tonumber(self:GetText()) then
					self:settext(pnMaxLives[player])
				end
			end
		}
	}
}