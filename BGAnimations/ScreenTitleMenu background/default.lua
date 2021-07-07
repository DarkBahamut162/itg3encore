local groups = SONGMAN:GetSongGroupNames();
local ITG3ADDONS, ITG3UNLOCKS, REBIRTH, REBIRTHPLUS, REBIRTHTWO = false, false, false, false, false;

for group in ivalues(groups) do
	if string.find(group,"In The Groove 3 Unlocks") then
		ITG3UNLOCKS = true;
	elseif string.find(group,"In The Groove 3 +") then
		ITG3ADDONS = true;
	elseif string.find(group,"In The Groove Rebirth 2") then
		REBIRTHTWO = true;
	elseif string.find(group,"In The Groove Rebirth +") then
		REBIRTHPLUS = true;
	elseif string.find(group,"In The Groove Rebirth") then
		REBIRTH = true;
	end
end

local t = Def.ActorFrame{
	OnCommand=function(self)
		InitOptions()
	end;
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_fallback"))..{
		InitCommand=function(self) self:Center():diffusealpha(0) end;
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end;
	};
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/_CJ126"))..{
		InitCommand=function(self) self:Center():FullScreen():diffusealpha(0) end;
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end;
	};
	LoadActor("_lower")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};
	LoadActor("_upper")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};

	LoadActor("_lower")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};
	LoadActor("_upper")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};

	--ENCORE ADD
	LoadActor("_topright")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:diffusealpha(1):sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):sleep(0.5):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3):queuecommand("Anim") end;
	};
	LoadActor("_center")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:diffusealpha(1):sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(.45):fadetop(.45):sleep(0.8):diffusealpha(1.5):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3):queuecommand("Anim") end;
	};
	LoadActor("_2top")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(.45):faderight(.45):sleep(.1):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.25):queuecommand("Anim") end;
	};
	LoadActor("_left")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(.45):faderight(.45):sleep(.4):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.2):queuecommand("Anim") end;
	};
	LoadActor("_right")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:cropleft(-0.8):cropleft(1):faderight(.45):fadeleft(.45):sleep(.2):diffusealpha(1):linear(3):cropleft(1):cropright(-0.8):sleep(0.5):queuecommand("Anim") end;
	};
	LoadActor("_2center")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(.45):faderight(.45):sleep(.4):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.2):queuecommand("Anim") end;
	};

	Def.ActorFrame{
		Name="LogoFrame";
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-10) end;
		LoadActor("glow")..{
			InitCommand=function(self) self:blend(Blend.Add):zoom(0) end;
			OnCommand=function(self) self:sleep(0.1):bounceend(0.4):zoom(1):diffuseshift():effectcolor1(color("#FFFFFFFF")):effectcolor2(color("#FFFFFF00")):effectperiod(5):effectoffset(.3) end;
		};
		LoadActor("newlogo")..{
			InitCommand=function(self) self:zoom(0) end;
			OnCommand=function(self) self:sleep(0.1):bounceend(0.4):zoom(1) end;
		};
		Def.ActorFrame{
			Name="LightsFrame";
			LoadActor("light")..{
				InitCommand=function(self) self:zoom(1):blend(Blend.Add) end;
				OnCommand=function(self) self:queuecommand("Diffuse") end;
				DiffuseCommand=function(self) self:diffusealpha(0):sleep(2):linear(.3):diffusealpha(1):sleep(.05):linear(.5):diffusealpha(0):queuecommand("Diffuse") end;
			};
			LoadActor("light")..{
				InitCommand=function(self) self:zoom(1):blend(Blend.Add):diffusealpha(0) end;
				GoodEndingMessageCommand=function(self) self:stoptweening():diffuse(color("#ffc600")):linear(.3):diffusealpha(1):sleep(.25):linear(1):diffusealpha(0) end;
			};
			LoadActor("light")..{
				InitCommand=function(self) self:zoom(1):blend(Blend.Add):diffusealpha(0) end;
				GoodEndingMessageCommand=function(self) self:stoptweening():diffuse(color("#ffc600")):linear(.3):diffusealpha(1):sleep(.25):linear(1):diffusealpha(0) end;
			};
		};
	};

	--ENCORE ADD
	LoadActor("encore")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+103):y(SCREEN_CENTER_Y+95) end;
		OnCommand=function(self) self:horizalign(center):cropright(1.3):sleep(0.7):linear(1):cropright(-0.3) end;
	};
	LoadActor("_encoreglow")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+103):y(SCREEN_CENTER_Y+95) end;
		OnCommand=function(self) self:horizalign(center):cropleft(-0.3):cropright(1):faderight(.1):fadeleft(.1):sleep(0.7):linear(1):cropleft(1):cropright(-0.3) end;
	};

	-- ENCORE FOLDER ADD
	Def.ActorFrame{

		-- ITG3 ADDONS
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20):y(SCREEN_CENTER_Y+60+27.5*0):zoom(0.475):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end;
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=ITG3ADDONS;
		};
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("ITG3 ADDONS"):shadowlength(1):x(SCREEN_RIGHT-106):y(SCREEN_CENTER_Y+60+27.5*0):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7) end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=ITG3ADDONS;
		};
		-- ITG3 UNLOCKS
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20):y(SCREEN_CENTER_Y+60+27.5*1):zoom(0.475):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end;
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=ITG3UNLOCKS;
		};
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("ITG3 UNLOCKS"):shadowlength(1):x(SCREEN_RIGHT-106):y(SCREEN_CENTER_Y+60+27.5*1):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7) end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=ITG3UNLOCKS;
		};
		-- REBIRTH
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20):y(SCREEN_CENTER_Y+60+27.5*2):zoom(0.475):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end;
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=REBIRTH;
		};
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("REBIRTH"):shadowlength(1):x(SCREEN_RIGHT-106):y(SCREEN_CENTER_Y+60+27.5*2):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7) end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=REBIRTH;
		};
		-- REBIRTH +
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20):y(SCREEN_CENTER_Y+60+27.5*3):zoom(0.475):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end;
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=REBIRTHPLUS;
		};
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("REBIRTH +"):shadowlength(1):x(SCREEN_RIGHT-106):y(SCREEN_CENTER_Y+60+27.5*3):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7) end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=REBIRTHPLUS;
		};
		-- REBIRTH 2
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20):y(SCREEN_CENTER_Y+60+27.5*4):zoom(0.475):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end;
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=REBIRTHTWO;
		};
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("REBIRTH 2"):shadowlength(1):x(SCREEN_RIGHT-106):y(SCREEN_CENTER_Y+60+27.5*4):addy((IsHome() == true) and -172.5 or 0) end;
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7) end;
			CoinModeChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end;
			Condition=REBIRTHTWO;
		};
	};

	Def.ActorFrame{
		LoadActor("_lside")..{
			InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM+100):halign(0):valign(1) end;
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
		LoadActor("_rside")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM+100):halign(1):valign(1) end;
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
		LoadActor("width")..{
			InitCommand=function(self) self:x(SCREEN_LEFT+48):y(SCREEN_BOTTOM+100):halign(0):valign(1):zoomtowidth(SCREEN_WIDTH-96) end;
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
		LoadActor("base")..{
			InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+100):valign(1) end;
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
			OffCommand=function(self) self:accelerate(0.5):addy(100) end;
		};
	};

	Def.ActorFrame{
		LoadActor("_upwidth")..{
			InitCommand=function(self) self:x(SCREEN_LEFT+310):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH-630) end;
			OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.4):y(SCREEN_TOP) end;
			OffCommand=function(self) self:accelerate(.5):addy(-100) end;
		};
		LoadActor("_upleft")..{
			InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_TOP-100):horizalign(left):vertalign(top) end;
			OnCommand=function(self) self:decelerate(.4):y(SCREEN_TOP) end;
			OffCommand=function(self) self:accelerate(.5):addy(-100) end;
		};
		LoadActor("_upright")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_TOP-100):horizalign(right):vertalign(top) end;
			OnCommand=function(self) self:decelerate(.4):y(SCREEN_TOP) end;
			OffCommand=function(self) self:accelerate(.5):addy(-100) end;
		};
	};

	LoadActor("roxor")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+135):y(SCREEN_TOP+32):valign(1):zoom(1):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1) end;
		OffCommand=function(self) self:accelerate(.5):addy(-100) end;
	};
	LoadActor(THEME:GetPathB("","_thanks/_bx"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+268):y(SCREEN_TOP+32):valign(1):zoom(.5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1) end;
		OffCommand=function(self) self:accelerate(.5):addy(-100) end;
	};
	LoadActor(THEME:GetPathB("","_thanks/_outfox"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+360):y(SCREEN_TOP+16):valign(1):addy(-100) end;
		OnCommand=function(self) self:sleep(0.4):linear(0.25):addy(100) end;
		OffCommand=function(self) self:accelerate(.5):addy(-100) end;
	};

	LoadActor("icon")..{ OffCommand=function(self) self:accelerate(0.5):addy(-100) end; };

	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen() end;
		OnCommand=function(self) self:diffusealpha(0):sleep(0.1):accelerate(0.5):diffusealpha(1):sleep(0.2):decelerate(0.5):diffusealpha(0) end;
	};
	LoadActor(THEME:GetPathS("","_logo"))..{
		OnCommand=function(self) self:play() end;
	};
	LoadActor(THEME:GetPathS("_Menu","music"))..{
		OnCommand=function(self) self:play() end;
		OffCommand=function(self) self:stop() end;
	};

	LoadFont("_v 26px bold black")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM-33+100):diffusealpha(0):horizalign(center):shadowlength(0):zoom(.5) end;
		OnCommand=function(self) self:decelerate(0.4):addy(-100):diffusealpha(1):playcommand("Refresh") end;
		OffCommand=function(self) self:accelerate(0.5):addy(100):diffusealpha(0) end;
		RefreshCommand=function(self)
			self:settext("In The Groove 3 Encore r35?")
		end;
	};

	LoadFont("ScreenOptions serial number")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-30):y(SCREEN_BOTTOM-42):shadowlength(2):horizalign(right):wrapwidthpixels(1000):zoom(0.5) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Refresh") end;
		RefreshCommand=function(self)
			self:settext("ITG-(H/B)-2011/12/12-ITG3-r35-Encore")
		end;
	};
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+35):y(SCREEN_TOP+50):shadowlength(2):horizalign(left):wrapwidthpixels(1000):zoom(0.6) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Refresh") end;
		RefreshCommand=function(self)
			local songs = SONGMAN:GetNumSongs();
			local groups = SONGMAN:GetNumSongGroups();
			local courses = SONGMAN:GetNumCourses();
			self:settext(songs.." songs in "..groups.." groups, "..courses.." courses")
		end;
	};
};

return t;