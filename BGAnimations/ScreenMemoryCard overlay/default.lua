return Def.ActorFrame{
	InitCommand=function(self) self:fov(52.4) end;
	Def.ActorFrame{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+10):y(SCREEN_CENTER_Y+130):spin():effectmagnitude(60,0,0) end;
		LoadActor(THEME:GetPathG("_memory","card"))..{
			OnCommand=function(self) self:zoom(1.1):linear(4.9):accelerate(0.25):addx(75):decelerate(0.25):addx(75):sleep(4.8):accelerate(0.25):addx(-75):decelerate(0.25):addx(-75) end;
			OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
		};
		Def.Quad{ InitCommand=function(self) self:clearzbuffer(true):zoom(0) end; };
	};
	LoadActor(THEME:GetPathB("","lolhi"))..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):fadeleft(0.3):faderight(0.3):cropleft(1.3):cropright(-0.3):zoom(0.3) end;
		OnCommand=function(self) self:linear(1):cropleft(-0.3):zoom(2):linear(15):zoom(1.2) end;
		OffCommand=function(self) self:stoptweening():linear(0.5):cropright(1.3):zoom(0.5) end;
	};

	LoadActor("usecard")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+70):y(SCREEN_CENTER_Y-80):zoom(0.91):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(1.50):linear(0.4):diffusealpha(1):zoom(0.9):linear(2.9):zoom(0.83):sleep(0):linear(0.2):diffusealpha(0):zoom(0.8) end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH*1.5) end;
	};
	LoadActor("achie")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+70):y(SCREEN_CENTER_Y-80):zoom(0.91):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(4.7):linear(0.4):diffusealpha(1):zoom(0.9):linear(3.9):zoom(0.83):sleep(0):linear(0.2):diffusealpha(0):zoom(0.8) end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH*1.5) end;
	};
	LoadActor("groovestats")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+70):y(SCREEN_CENTER_Y-80):zoom(0.91):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(8.9):linear(0.4):diffusealpha(1):zoom(0.9):linear(2.9):zoom(0.83):sleep(0):accelerate(0.5):addx(SCREEN_WIDTH*1.5) end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(SCREEN_WIDTH*1.5) end;
	};

	LoadActor("usb icon")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+500):y(SCREEN_CENTER_Y-80):glow(color("1,1,1,1")) end;
		OnCommand=function(self) self:sleep(1.0):decelerate(0.5):x(SCREEN_CENTER_X-220):glowshift():effectclock("beat"):effectoffset(1):effectperiod(2):sleep(10.8):accelerate(0.5):addx(-SCREEN_WIDTH) end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
	};
	LoadActor("usb glow")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-220):y(SCREEN_CENTER_Y-80):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(1.5):diffusealpha(1):linear(0.8):zoomx(3):zoomy(3):diffusealpha(0) end;
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
	};

	Def.ActorFrame{
		OffCommand=function(self) self:stoptweening():accelerate(0.5):addx(-SCREEN_WIDTH*1.5) end;
		LoadActor(THEME:GetPathB("","_overlay/cardstats"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155):croptop(0.5):cropbottom(0.5) end;
			OnCommand=function(self) self:sleep(5.15):accelerate(0.15):croptop(0.25):cropbottom(0.25):decelerate(0.2):croptop(0):cropbottom(0):sleep(4.7):linear(0.5):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("","_overlay/p1card"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+60):y(SCREEN_CENTER_Y+165):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(5.5):linear(0.3):diffusealpha(0.6):sleep(4.4):linear(0.5):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("ScreenSelectStyle","out/horiz-line"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155):cropleft(0.5):cropright(0.5) end;
			OnCommand=function(self) self:sleep(5):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(-43):decelerate(0.2):addy(-43):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("ScreenSelectStyle","out/horiz-line"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+155):cropleft(0.5):cropright(0.5) end;
			OnCommand=function(self) self:sleep(5):accelerate(0.15):cropleft(0):cropright(0):accelerate(0.15):addy(43):decelerate(0.2):addy(43):diffusealpha(0) end;
		};
		LoadFont("_r bold 30px")..{
			Text="Player Name";
			InitCommand=function(self) self:x(SCREEN_LEFT+120):y(SCREEN_CENTER_Y+87):diffusetopedge(color("#fff000")):diffusebottomedge(color("#ffa500")):shadowlength(2):horizalign(center):zoom(0.8):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(5.4):linear(0.2):diffusealpha(1):sleep(4.4):linear(0.5):diffusealpha(0) end;
		};
		LoadFont("_v profile")..{
			Text="Number of\nplayed songs";
			InitCommand=function(self) self:x(SCREEN_LEFT+148):y(SCREEN_CENTER_Y+162):shadowlength(2):horizalign(center):zoom(0.8):diffusealpha(0) end;
			OnCommand=function(self) self:sleep(5.65):linear(0.2):diffusealpha(1):sleep(4.2):linear(0.5):diffusealpha(0) end;
		};

		LoadActor(THEME:GetPathB("","_overlay/achpane"))..{
			InitCommand=function(self) self:x(SCREEN_LEFT+242):y(SCREEN_CENTER_Y+155):addx(-54):cropleft(1) end;
			OnCommand=function(self) self:sleep(4.7+.7):decelerate(0.3):addx(54):cropleft(0):sleep(3.4):accelerate(0.3):addx(-54):cropleft(1) end;
		};
		Def.ActorFrame{
			Name="StarIcons";
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*0):horizalign(center):animate(0):zoom(0) end;
				OnCommand=function(self) self:sleep(5.35+.6):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(4):bounceend(0.4):zoom(0.55):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*0):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.35+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(5):zoom(0.55):sleep(0.9):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*0):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.35+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(6):zoom(0.55):sleep(1.55):linear(0.3):diffusealpha(1):sleep(0.4):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*0):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.35+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(7):zoom(0.55):sleep(2.25):linear(0.3):diffusealpha(1):sleep(0.4):linear(0.3):diffusealpha(0) end;
			};
		};
		Def.ActorFrame{
			Name="ThreeIcons";
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*1):horizalign(center):animate(0):zoom(0) end;
				OnCommand=function(self) self:sleep(5.40+.6):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(8):bounceend(0.4):zoom(0.55):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*1):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.40+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(9):zoom(0.55):sleep(0.9):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*1):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.40+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(10):zoom(0.55):sleep(1.55):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*1):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.40+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(11):zoom(0.55):sleep(2.25):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
		};
		Def.ActorFrame{
			Name="ArrowIcons";
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*2):horizalign(center):animate(0):zoom(0) end;
				OnCommand=function(self) self:sleep(5.45+.6):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(0):bounceend(0.4):zoom(0.55):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*2):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.45+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(1):zoom(0.55):sleep(0.9):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*2):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.45+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(2):zoom(0.55):sleep(1.55):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*2):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.45+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(3):zoom(0.55):sleep(2.25):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
		};
		Def.ActorFrame{
			Name="PlusIcons";
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*3):horizalign(center):animate(0):zoom(0) end;
				OnCommand=function(self) self:sleep(5.5+.6):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(12):bounceend(0.4):zoom(0.55):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*3):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.5+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(13):zoom(0.55):sleep(0.9):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*3):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.5+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(14):zoom(0.55):sleep(1.55):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
			LoadActor(THEME:GetPathB("","_overlay/awards"))..{
				InitCommand=function(self) self:x(SCREEN_LEFT+238):y(SCREEN_CENTER_Y+103+34*3):horizalign(center):animate(0):diffusealpha(0) end;
				OnCommand=function(self) self:sleep(5.5+.5):playcommand("Update") end;
				UpdateCommand=function(self) self:setstate(15):zoom(0.55):sleep(2.25):linear(0.3):diffusealpha(1):sleep(0.3):linear(0.3):diffusealpha(0) end;
			};
		};
	};
	LoadActor(THEME:GetPathB("ScreenAttract","overlay"));
};