local player = ...
assert( player )
local maxLives

local t = Def.ActorFrame{
	InitCommand=function(self)
		self:zoom(0.5):x( _screen.cx - _screen.w/8 + 60 ):y(80 - 7.5)
		if player == PLAYER_2 then
			self:x( _screen.cx + _screen.w/3.4 + 60 )
		end
	end;

	Def.ActorFrame{
		InitCommand=function(self) self:rotationz(-90):zoom(2):addx(player == PLAYER_1 and -100 or 100); end;
		OnCommand=function(self) self:decelerate(0.8):addx(player == PLAYER_1 and 100 or -100) end;
		OffCommand=function(self) self:accelerate(0.8):addx(player == PLAYER_1 and -100 or 100) end;
		LoadActor("meter black")..{
			InitCommand=function(self) self:zoomx(1.04) end;
		};
		LoadActor("meter grad")..{
			InitCommand=function(self) self:zoomx(1.04):cropright(1):sleep(1):decelerate(0.6):cropright(0) end;
			LifeChangedMessageCommand=function(self,params)
				if params.Player == player then
					local screen = SCREENMAN:GetTopScreen();
					local glifemeter = screen:GetLifeMeter(player);
					self:stoptweening():accelerate(0.1):cropright(1-(params.LivesLeft/glifemeter:GetTotalLives()));
				end;
			end;
		};
		LoadActor("light")..{
			InitCommand=function(self) self:blend(Blend.Add):addx(164-308-2):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#00EAFF")):effectcolor2(color("#FFFFFF00")):effectclock('beat'):effectperiod(4) end;
		};
		LoadActor("base")..{ InitCommand=function(self) self:addx(-5) end; };
		LoadActor("light")..{
			InitCommand=function(self) self:blend(Blend.Add):addx(146-308-2):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(2.5):accelerate(0.3):diffusealpha(1):diffuseshift():effectcolor1(color("#00EAFF")):effectcolor2(color("#FFFFFF00")):effectclock('beat'):effectperiod(4) end;
		};
		LoadActor("streak")..{
			InitCommand=function(self) self:addx(174-308-21):addx(-100) end;
			OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addx(100) end;
		};
		LoadActor("streak")..{
			InitCommand=function(self) self:addx(155-308-21):addx(-100) end;
			OnCommand=function(self) self:sleep(1):decelerate(0.6):addx(100) end;
		};
		LoadActor("glow2")..{
			InitCommand=function(self) self:blend(Blend.Add):addx(-5):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(1.8):decelerate(0.3):diffusealpha(1):sleep(0.2):accelerate(0.6):diffusealpha(0):queuecommand("Destroy") end;
			DestroyCommand=function(self) self:visible(false) end;
		};
	};
	--LIVES cur/max
	LoadFont("_angel glow")..{
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			self:settext(glifemeter:GetTotalLives());
			self:x(-1):y(-5):maxwidth(28);
			self:valign(1):halign(0.5);
			self:addx(player == PLAYER_1 and -100 or 100);
		end;
		OnCommand=function(self) self:decelerate(0.8):addx(player == PLAYER_1 and 100 or -100) end;
		OffCommand=function(self) self:accelerate(0.8):addx(player == PLAYER_1 and -100 or 100) end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player == player then
				self:settext(params.LivesLeft);
			end;
		end;
	};
	LoadFont("_angel glow")..{
		BeginCommand=function(self)
			self:settext("_");
			self:x(-1):y(-12);
			self:valign(0.5):halign(0.5);
			self:zoomx(2);
			self:addx(player == PLAYER_1 and -100 or 100);
		end;
		OnCommand=function(self) self:decelerate(0.8):addx(player == PLAYER_1 and 100 or -100) end;
		OffCommand=function(self) self:accelerate(0.8):addx(player == PLAYER_1 and -100 or 100) end;
	};
	LoadFont("_angel glow")..{
		BeginCommand=function(self)
			local screen = SCREENMAN:GetTopScreen();
			local glifemeter = screen:GetLifeMeter(player);
			self:settext(glifemeter:GetTotalLives());
			self:x(-1):y(5):maxwidth(28);
			self:valign(0):halign(0.5);
			self:addx(player == PLAYER_1 and -100 or 100);
		end;
		OnCommand=function(self) self:decelerate(0.8):addx(player == PLAYER_1 and 100 or -100) end;
		OffCommand=function(self) self:accelerate(0.8):addx(player == PLAYER_1 and -100 or 100) end;
	};
};

return t;