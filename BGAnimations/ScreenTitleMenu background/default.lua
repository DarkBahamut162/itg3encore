local groups = SONGMAN:GetSongGroupNames()
local ITG3ADDONS, ITG3UNLOCKS, REBIRTH, REBIRTHPLUS, REBIRTHTWO = false, false, false, false, false
setenv("RotationCheck",false)
setenv("USBCheck",false)

for group in ivalues(groups) do
	if string.find(group,"In The Groove 3 Unlocks") then
		ITG3UNLOCKS = true
	elseif string.find(group,"In The Groove 3 +") then
		ITG3ADDONS = true
	elseif string.find(group,"In The Groove Rebirth 2") then
		REBIRTHTWO = true
	elseif string.find(group,"In The Groove Rebirth +") then
		REBIRTHPLUS = true
	elseif string.find(group,"In The Groove Rebirth") then
		REBIRTH = true
	end
end

local function sortArray(array)
	local check = {}
	local output = {}
	if array ~= "" then
		for _,v in ipairs(split("|",array)) do
			if not check[v] then
				output[#output+1] = v
				check[v] = true
			end
		end
	end
	return output
end

return Def.ActorFrame{
	OnCommand=function(self)
		if isOutFox() then
			GAMESTATE:UpdateDiscordGameMode(GAMESTATE:GetCurrentGame():GetName())
			GAMESTATE:UpdateDiscordScreenInfo("Title Menu","",1)
		end
	end,
	OffCommand=function(self) if isTopScreen('ScreenTitleJoin') then SOUND:StopMusic() end end,
	LoadActor(THEME:GetPathB("ScreenSelectMusic","background/CJ126 "..(isFinal() and "Final" or "Normal")))..{
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end
	},
	LoadActor("_lower")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end
	},
	LoadActor("_upper")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end
	},
	LoadActor("_lower")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end
	},
	LoadActor("_upper")..{
		InitCommand=function(self) self:Center():blend(Blend.Add):zoomtowidth(SCREEN_WIDTH) end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end
	},

	LoadActor("_topright")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:diffusealpha(1):sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.5):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3):queuecommand("Anim") end
	},
	LoadActor("_center")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:diffusealpha(1):sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.8):diffusealpha(1.5):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3):queuecommand("Anim") end
	},
	LoadActor("_2top")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.1):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.25):queuecommand("Anim") end
	},
	LoadActor("_left")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.4):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.2):queuecommand("Anim") end
	},
	LoadActor("_right")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:cropleft(-0.8):cropleft(1):faderight(0.45):fadeleft(0.45):sleep(0.2):diffusealpha(1):linear(3):cropleft(1):cropright(-0.8):sleep(0.5):queuecommand("Anim") end
	},
	LoadActor("_2center")..{
		InitCommand=function(self) self:blend(Blend.Add):FullScreen() end,
		OnCommand=function(self) self:queuecommand("Anim") end,
		AnimCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.4):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.2):queuecommand("Anim") end
	},
	Def.ActorFrame{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-10):zoom(WideScreenDiff()) end,
		OnCommand=function(self) if IsHome() and isScreenTitle() then self:CenterX():sleep(0.6):x(SCREEN_CENTER_X-(142/3)*WideScreenDiff()) end end,
		SetCommand=function(self) if IsHome() and isScreenTitle() then self:x(SCREEN_CENTER_X-(142/3)*WideScreenDiff()) else self:CenterX() end end,
		ZoomCommand=function(self) if true or SCREEN_WIDTH < 680 then self:zoom(WideScreenDiff()) end end,
		ScreenChangedMessageCommand=function(self) self:playcommand("Set"):playcommand("Zoom") end,
		Def.ActorFrame{
			Name="LogoFrame",
			LoadActor("glow "..(isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:blend(Blend.Add):zoom(0) end,
				OnCommand=function(self) self:sleep(0.1):bounceend(0.4):zoom(1):diffuseshift():effectcolor1(color("#FFFFFFFF")):effectcolor2(color("#FFFFFF00")):effectperiod(5):effectoffset(0.3) end
			},
			LoadActor("newlogo "..(isFinal() and "final" or "normal"))..{
				InitCommand=function(self) self:zoom(0) end,
				OnCommand=function(self) self:sleep(0.1):bounceend(0.4):zoom(1) end
			},
			Def.ActorFrame{
				Name="LightsFrame",
				LoadActor("light "..(isFinal() and "final" or "normal"))..{
					InitCommand=function(self) self:zoom(1):blend(Blend.Add) end,
					OnCommand=function(self) self:queuecommand("Diffuse") end,
					DiffuseCommand=function(self) self:diffusealpha(0):sleep(2):linear(0.3):diffusealpha(1):sleep(0.05):linear(0.5):diffusealpha(0):queuecommand("Diffuse") end
				},
				LoadActor("light "..(isFinal() and "final" or "normal"))..{
					InitCommand=function(self) self:zoom(1):blend(Blend.Add):diffusealpha(0) end,
					GoodEndingMessageCommand=function(self) self:stoptweening():diffuse(color("#ffc600")):linear(0.3):diffusealpha(1):sleep(0.25):linear(1):diffusealpha(0) end
				},
				LoadActor("light "..(isFinal() and "final" or "normal"))..{
					InitCommand=function(self) self:zoom(1):blend(Blend.Add):diffusealpha(0) end,
					GoodEndingMessageCommand=function(self) self:stoptweening():diffuse(color("#ffc600")):linear(0.3):diffusealpha(1):sleep(0.25):linear(1):diffusealpha(0) end
				}
			}
		},
		LoadActor("encore "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(103):y(isFinal() and 115 or 105) end,
			OnCommand=function(self) self:cropright(1.3):sleep(0.7):linear(1):cropright(-0.3) end
		},
		LoadActor("encore glow "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:x(103):y(isFinal() and 115 or 105) end,
			OnCommand=function(self) self:cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.7):linear(1):cropleft(1):cropright(-0.3) end
		}
	},
	Def.ActorFrame{
		LoadActor("../_overlay/addons")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+60+27.5*0*WideScreenDiff()):zoom(0.65*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3ADDONS and isFinal()
		},
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*0*WideScreenDiff()):zoom(0.475*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3ADDONS and not isFinal()
		},
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("ITG3 ADDONS"):shadowlength(1):x(SCREEN_RIGHT-106*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*0*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7*WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3ADDONS and not isFinal()
		},
		LoadActor("../_overlay/unlocks")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+60+27.5*1*WideScreenDiff()):zoom(0.65*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3UNLOCKS and isFinal()
		},
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*1*WideScreenDiff()):zoom(0.475*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3UNLOCKS and not isFinal()
		},
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("ITG3 UNLOCKS"):shadowlength(1):x(SCREEN_RIGHT-106*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*1*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7*WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=ITG3UNLOCKS and not isFinal()
		},
		LoadActor("../_overlay/rebirth1")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+60+27.5*2*WideScreenDiff()):zoom(0.65*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTH and isFinal()
		},
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*2*WideScreenDiff()):zoom(0.475*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTH and not isFinal()
		},
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("REBIRTH"):shadowlength(1):x(SCREEN_RIGHT-106*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*2*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7*WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTH and not isFinal()
		},
		LoadActor("../_overlay/rebirth+")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+60+27.5*3*WideScreenDiff()):zoom(0.65*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHPLUS and isFinal()
		},
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*3*WideScreenDiff()):zoom(0.475*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHPLUS and not isFinal()
		},
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("REBIRTH +"):shadowlength(1):x(SCREEN_RIGHT-106*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*3*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7*WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHPLUS and not isFinal()
		},
		LoadActor("../_overlay/rebirth2")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_CENTER_Y+60+27.5*4*WideScreenDiff()):zoom(0.65*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHTWO and isFinal()
		},
		LoadActor("../_overlay/joinin")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT+20*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*4*WideScreenDiff()):zoom(0.475*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(right):addx(200):sleep(0.9):decelerate(0.25):addx(-200):playcommand("Fade") end,
			FadeCommand=function(self) self:glow(1,1,1,0):sleep(2):linear(0.3):glow(1,1,1,0.25):sleep(0.05):glow(1,1,1,0):sleep(1):queuecommand("Fade") end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHTWO and not isFinal()
		},
		LoadFont("_v profile")..{
			InitCommand=function(self) self:settext("REBIRTH 2"):shadowlength(1):x(SCREEN_RIGHT-106*WideScreenDiff()):y(SCREEN_CENTER_Y+60+27.5*4*WideScreenDiff()):addy((IsHome() and isScreenTitle()) and -172.5 or 0) end,
			OnCommand=function(self) self:horizalign(left):addx(200):sleep(0.9):decelerate(0.25):addx(-200):zoom(0.7*WideScreenDiff()) end,
			ScreenChangedMessageCommand=function(self) self:stoptweening():playcommand("Init"):playcommand("On") end,
			Condition=REBIRTHTWO and not isFinal()
		}
	},
	Def.ActorFrame{
		LoadActor("_lside")..{
			Condition=not isFinal(),
			InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM+100*WideScreenDiff()):zoom(WideScreenDiff()):halign(0):valign(1) end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end,
			OffCommand=function(self) self:accelerate(0.5):addy(100) end
		},
		LoadActor("width")..{
			Condition=not isFinal(),
			InitCommand=function(self) self:x(SCREEN_LEFT+48*WideScreenDiff()):y(SCREEN_BOTTOM+100*WideScreenDiff()):zoom(WideScreenDiff()):halign(0):valign(1):zoomtowidth(SCREEN_WIDTH-96*WideScreenDiff()) end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end,
			OffCommand=function(self) self:accelerate(0.5):addy(100) end
		},
		LoadActor("_rside")..{
			Condition=not isFinal(),
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM+100*WideScreenDiff()):zoom(WideScreenDiff()):halign(1):valign(1) end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end,
			OffCommand=function(self) self:accelerate(0.5):addy(100) end
		},
		LoadActor("up")..{
			Condition=isFinal(),
			InitCommand=function(self) self:CenterX():y(SCREEN_TOP-500*WideScreenDiff()):zoom(WideScreenDiff()):valign(0):zoomtowidth(SCREEN_WIDTH) end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_TOP) end,
			OffCommand=function(self) self:accelerate(0.5):addy(-500) end
		},
		LoadActor("base "..(isFinal() and "final" or "normal"))..{
			InitCommand=function(self) self:CenterX():y(SCREEN_BOTTOM+100*WideScreenDiff()):zoom(WideScreenDiff()):valign(1) if isFinal() then self:zoomtowidth(SCREEN_WIDTH) end end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end,
			OffCommand=function(self) self:accelerate(0.5):addy(100) end
		}
	},
	Def.ActorFrame{
		Condition=not isFinal(),
		LoadActor("_upleft")..{
			InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_TOP-100):zoom(WideScreenDiff()):horizalign(left):vertalign(top) end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_TOP) end,
			OffCommand=function(self) self:accelerate(0.5):addy(-100) end
		},
		LoadActor("_upwidth")..{
			InitCommand=function(self) self:x(SCREEN_LEFT+310*WideScreenDiff()):zoom(WideScreenDiff()):vertalign(top):horizalign(left):zoomtowidth(SCREEN_WIDTH-630*WideScreenDiff()) end,
			OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.4):y(SCREEN_TOP) end,
			OffCommand=function(self) self:accelerate(0.5):addy(-100) end
		},
		LoadActor("_upright")..{
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_TOP-100):zoom(WideScreenDiff()):horizalign(right):vertalign(top) end,
			OnCommand=function(self) self:decelerate(0.4):y(SCREEN_TOP) end,
			OffCommand=function(self) self:accelerate(0.5):addy(-100) end
		}
	},
	LoadActor("roxor")..{
		InitCommand=function(self) self:x(isFinal() and SCREEN_LEFT+50*WideScreenDiff() or SCREEN_LEFT+135*WideScreenDiff()):y(isFinal() and SCREEN_TOP+32*WideScreenDiff() or SCREEN_TOP+30*WideScreenDiff()):valign(1):zoom(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	},
	LoadActor(isFinal() and "newbx" or THEME:GetPathB("","_thanks/_bx"))..{
		InitCommand=function(self) self:x(isFinal() and SCREEN_LEFT+155*WideScreenDiff() or SCREEN_LEFT+268*WideScreenDiff()):y(isFinal() and SCREEN_TOP+35*WideScreenDiff() or SCREEN_TOP+32*WideScreenDiff()):valign(isFinal() and 0.5 or 1):zoom(isFinal() and 0.8*WideScreenDiff() or 0.5*WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end
	},
	LoadActor(THEME:GetPathB("","_thanks/_"..(isOutFox() and "outfox" or (isITGmania() and "itgmania" or "stepmania"))))..{
		InitCommand=function(self) self:x(isFinal() and SCREEN_LEFT+105*WideScreenDiff() or SCREEN_LEFT+360*WideScreenDiff()):y(isFinal() and SCREEN_TOP+10*WideScreenDiff() or SCREEN_TOP+16*WideScreenDiff()):valign(1):zoom(WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end,
		Condition=isOutFox() and isFinal() or SCREEN_LEFT+360 < SCREEN_CENTER_X
	},
	LoadActor("icon")..{ OffCommand=function(self) self:accelerate(0.5):addy(-100) end },
	Def.Quad{
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.1):accelerate(0.5):diffusealpha(1):sleep(0.2):decelerate(0.5):diffusealpha(0) end
	},
	LoadActor(THEME:GetPathS("","_logo"))..{
		OnCommand=function(self) self:play() end
	},
	LoadFont("_v 26px bold black")..{
		InitCommand=function(self) self:CenterX():y(isFinal() and SCREEN_BOTTOM-60*WideScreenDiff() or SCREEN_BOTTOM-34*WideScreenDiff()):diffusealpha(0):shadowlength(0):zoom(0.5*WideScreenDiff()):maxwidth(SCREEN_WIDTH/2) end,
		OnCommand=function(self) self:sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Refresh") end,
		OffCommand=function(self) self:accelerate(0.5):addy(100):diffusealpha(0) end,
		ScreenChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if not isTopScreen("ScreenLogo") then
				if isFinal() then
					if 1 > GetScreenAspectRatio() then
						self:settext("ITG3Encore Final?")
					else
						self:settext("In The Groove 3 Encore Final?")
					end
				else
					if 1 > GetScreenAspectRatio() then
						self:settext("ITG3Encore r35?")
					else
						self:settext("In The Groove 3 Encore r35?")
					end
				end
			end
		end
	},
	LoadFont("ScreenOptions serial number")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X+110*WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-50*WideScreenDiff() or SCREEN_BOTTOM-42*WideScreenDiff()):shadowlength(2):horizalign(left):maxwidth((IsHome() and isScreenTitle()) and SCREEN_WIDTH/9*5/WideScreenDiff() or SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Refresh") end,
		ScreenChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if not isTopScreen("ScreenLogo") then 
				if isFinal() then
					self:settext("ITG-(?/?)-20XX/XX/XX-ITG3-Final-Encore")
				else
					self:settext("ITG-(?/?)-20XX/XX/XX-ITG3-r35-Encore")
				end
			end
		end
	},
	LoadFont("ScreenOptions serial number")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+25*WideScreenDiff()*WideScreenDiff()):y(isFinal() and SCREEN_BOTTOM-50*WideScreenDiff() or SCREEN_BOTTOM-42*WideScreenDiff()):shadowlength(2):horizalign(left):maxwidth(SCREEN_WIDTH/3*2/WideScreenDiff()):zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1):playcommand("Refresh") end,
		ScreenChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if not isTopScreen("ScreenLogo") then 
				self:settext(ProductFamily() .. " " .. ProductVersion() .. " (" .. VersionDate() .. ")")
			end
		end
	},
	LoadFont("_r bold 30px")..{
		InitCommand=function(self) self:x(isFinal() and SCREEN_CENTER_X+5*WideScreenDiff() or SCREEN_LEFT+35*WideScreenDiff()):y(isFinal() and SCREEN_TOP+50*WideScreenDiff() or SCREEN_TOP+40*WideScreenDiff()):shadowlength(2):valign(0):halign(isFinal() and 0.5 or 0):maxwidth(isFinal() and SCREEN_WIDTH/4*3/WideScreenDiff() or SCREEN_WIDTH/WideScreenDiff()):zoom(0.6*WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1) end,
		BeginCommand=function(self) self:playcommand("Refresh") end,
		ScreenChangedMessageCommand=function(self) self:playcommand("Refresh") end,
		RefreshCommand=function(self)
			if not isTopScreen("ScreenLogo") then
				local songs = SONGMAN:GetAllSongs()
				local songsSingle = 0
				local songsDouble = 0

				local groupsSingle = ""
				local groupsDouble = ""
				local groupsSingleCount = 0
				local groupsDoubleCount = 0

				local courses = SONGMAN:GetAllCourses(PREFSMAN:GetPreference("AutogenGroupCourses"))
				local coursesMarathonSingle = 0
				local coursesMarathonDouble = 0
				local coursesSurvivalSingle = 0
				local coursesSurvivalDouble = 0

				if (StepsTypeSingle() or StepsTypeDouble()) and (IsGame("dance") or isOutFoxV()) then
					local StepsTypeSingle = StepsTypeSingle()[GetUserPrefN("StylePosition")]
					local StepsTypeDouble = StepsTypeDouble()[GetUserPrefN("StylePosition")]
					if #songs > 0 then
						for i=1,#songs do
							if songs[i]:HasStepsType(StepsTypeSingle) then
								if not string.find(groupsSingle,songs[i]:GetGroupName()) then
									groupsSingle = addToOutput(groupsSingle,songs[i]:GetGroupName(),"|")
								end
								songsSingle = songsSingle + 1
							end
							if StepsTypeDouble then
								if songs[i]:HasStepsType(StepsTypeDouble) then
									if not string.find(groupsDouble,songs[i]:GetGroupName()) then
										groupsDouble = addToOutput(groupsDouble,songs[i]:GetGroupName(),"|")
									end
									songsDouble = songsDouble + 1
								end
							end
						end
					end
					if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
						if not IsGame("po-mu") and not IsGame("be-mu") then
							if #courses > 0 then
								for i=1,#courses do
									if courses[i]:GetCourseType() == "CourseType_Nonstop" then
										if courses[i]:IsPlayableIn(StepsTypeSingle) then coursesMarathonSingle = coursesMarathonSingle + 1 end
										if StepsTypeDouble and songsDouble > 0 then
											if courses[i]:IsPlayableIn(StepsTypeDouble) then coursesMarathonDouble = coursesMarathonDouble + 1 end
										end
									end
									if courses[i]:GetCourseType() == "CourseType_Oni" or courses[i]:GetCourseType() == "CourseType_Survival" then
										if courses[i]:IsPlayableIn(StepsTypeSingle) then coursesSurvivalSingle = coursesSurvivalSingle + 1 end
										if StepsTypeDouble and songsDouble > 0 then
											if courses[i]:IsPlayableIn(StepsTypeDouble) then coursesSurvivalDouble = coursesSurvivalDouble + 1 end
										end
									end
								end
							end
						end
					end

					groupsSingle = sortArray(groupsSingle)
					groupsDouble = sortArray(groupsDouble)
					groupsSingleCount = #groupsSingle
					groupsDoubleCount = #groupsDouble

					local output = ""
					if groupsSingleCount == groupsDoubleCount then
						output = addToOutput(output,"Songs: "..songsSingle.." singles & "..songsDouble.." doubles in "..SONGMAN:GetNumSongGroups().." groups","\n")
					else
						output = addToOutput(output,"Songs: "..songsSingle.." singles ("..groupsSingleCount.." groups) & "..songsDouble.." doubles ("..groupsDoubleCount.." groups)","\n")
					end

					if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
						if IsGame("po-mu") or IsGame("be-mu") then
							output = addToOutput(output,"Courses: ? marathons & ? survivals","\n")
						else
							output = addToOutput(output,"Courses: "..(coursesMarathonSingle+coursesMarathonDouble).." marathons & "..(coursesSurvivalSingle+coursesSurvivalDouble).." survivals","\n")
						end
					end
					output = addToOutput(output,"Current Game Mode: "..GAMESTATE:GetCurrentGame():GetName(),"\n")
					output = addToOutput(output,"Current Style: "..StyleName()[GetUserPrefN("StylePosition")],"\n")
					self:settext(output):vertspacing(-10)
				else
					if GameModeEnabled() then
						self:settext("Information: The song/course counter currently only works in Dance Mode!\nSome other functionalities might also be broken!\nCurrent Game Mode: "..GAMESTATE:GetCurrentGame():GetName()):diffuse(Color.Yellow)
					else
						self:settext("WARNING: This Game Mode isn't supported here!\nErrors might occur!"):diffuse(Color.Red)
					end
				end
			end
		end
	},
	Def.ActorFrame{
		Condition=ThemePrefs.Get("ShowClock"),
		Name="TIME & DATE",
		InitCommand=function(self) self:CenterX():y(isFinal() and SCREEN_BOTTOM+11 or SCREEN_BOTTOM-6) end,
		LoadFont("_v 26px bold black")..{
			SetCommand=function(self) self:settext( string.format('%02i:%02i:%02i %s %02i %04i', Hour(), Minute(), Second(), string.sub(MonthToString(MonthOfYear()),1,3), DayOfMonth(), Year()) ):sleep(1/6):queuecommand("Set") end,
			InitCommand=function(self) self:y(-48*WideScreenDiff()):zoom(0.5*WideScreenDiff()):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(0.5):playcommand("Set"):linear(0.5):diffusealpha(1) end,
			OffCommand=function(self) self:stoptweening():accelerate(0.5):addy(100) end,
			ScreenChangedMessageCommand=function(self) if not isTopScreen("ScreenLogo") then self:visible(true):playcommand("Set") else self:visible(false) end end,
		}
	}
}