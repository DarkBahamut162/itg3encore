return Def.ActorFrame{
	BeginCommand=function() InitOptions() resetRepeatCheck() end,
	Def.ActorFrame{
		Condition=isScreenTitle(),
		Def.Sprite {
			Texture = THEME:GetPathB("ScreenEndingNormal","overlay/p1gradient"),
			InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_TOP+63*WideScreenDiff()):halign(1):valign(0):zoomtoheight(SCREEN_HEIGHT):addx(150*WideScreenDiff()) end,
			OnCommand=function(self) self:sleep(0.8):decelerate(0.2):addx(-150*WideScreenDiff()) end
		}
	},
	Def.ActorFrame{
		Def.Quad{
			InitCommand=function(self) self:diffuse(color("#000000")):FullScreen() end,
			OnCommand=function(self) self:diffusealpha(0) end,
			UnlockEnteredMessageCommand=function(self) self:decelerate(1):diffusealpha(.4):sleep(3):accelerate(1):diffusealpha(0) end
		},
		Def.ActorFrame{
			InitCommand=function(self) self:draworder(9999):y(SCREEN_TOP+80):x(SCREEN_LEFT+210):cropleft(.5):cropright(.5) end,
			Def.Sprite{
				Texture = THEME:GetPathB("","_overlay/unlockbox"),
				OnCommand=function(self) self:horizalign(center):cropleft(.5):cropright(.5) end,
				UnlockEnteredMessageCommand=function(self) self:decelerate(.33):cropleft(0):cropright(0):sleep(3.3):accelerate(.7):diffusealpha(0):sleep(0):cropleft(.5):cropright(.5):diffusealpha(1) end		
			},
			Def.BitmapText{
				File = "_z bold gray 36px",
				Text="   YOU'VE UNLOCKED:   ",
				OnCommand=function(self) self:y(-18):horizalign(center):shadowlength(0.5):zoom(.5):cropleft(.5):cropright(.5) end,
				UnlockEnteredMessageCommand=function(self) self:decelerate(.33):cropleft(0):cropright(0):sleep(3):accelerate(.7):diffusealpha(0):sleep(0):cropleft(.5):cropright(.5):diffusealpha(1) end
			},
			Def.BitmapText{
				File = "_z bold gray 36px",
				OnCommand=function(self) self:y(7):x(-1):horizalign(center):shadowlength(0.5):zoom(.5):diffusebottomedge(color("#1d3283")):diffusetopedge(color("#62a8e9")):maxwidth(700):cropleft(.5):cropright(.5) end,
				UnlockEnteredMessageCommand=function(self) 
					self:settext(getenv('UnlockName')) :decelerate(.33):cropleft(0):cropright(0):sleep(3):accelerate(.7):diffusealpha(0):sleep(0):cropleft(.5):cropright(.5):diffusealpha(1)
				end,
				CoinInsertedMessageCommand=function(self) self:playcommand("UnlockEnteredMessage") end,		
				CoinModeChangedMessageCommand=function(self) self:playcommand("UnlockEnteredMessage") end
			},
			Def.Sprite{
				Texture = THEME:GetPathB("","_overlay/unlockflash"),
				OnCommand=function(self) self:horizalign(center):zoomx(0) end,
				UnlockEnteredMessageCommand=function(self) self:decelerate(.3):zoomx(1):sleep(0):linear(.2):diffusealpha(0):sleep(0):zoomx(0):diffusealpha(1) end		
			},
			Def.Sprite{
				Texture = THEME:GetPathG("","blueflare"),
				OnCommand=function(self) self:horizalign(center):diffusealpha(0):blend(Blend.Add):zoomx(2) end,
				UnlockEnteredMessageCommand=function(self) self:stoptweening():zoomy(3):zoomx(4):linear(.15):diffusealpha(1):decelerate(.22):zoom(2):diffusealpha(0) end		
			},
			Def.Sprite{
				Texture = THEME:GetPathG("","blueflare"),
				OnCommand=function(self) self:horizalign(center):diffusealpha(0):blend(Blend.Add):zoomx(2) end,
				UnlockEnteredMessageCommand=function(self) self:stoptweening():zoomy(3):zoomx(4):linear(.15):diffusealpha(1):decelerate(.22):zoom(2):diffusealpha(0) end		
			}
		}
	},
	CodeMessageCommand=function(self,params)
		if params.Name=="OkayEnding" then
			SOUND:PlayOnce(THEME:GetPathS("ScreenPlayerOptions","cancel all"))
			setenv("ForcedOkayEnding",true)
		elseif params.Name=="GoodEnding" then
			SOUND:PlayOnce(THEME:GetPathS("ScreenPlayerOptions","cancel all"))
			setenv("ForcedGoodEnding",true)
		elseif params.Name=="PerfectEnding" then
			SOUND:PlayOnce(THEME:GetPathS("ScreenPlayerOptions","cancel all"))
			setenv("ForcedPerfectEnding",true)
		elseif params.Name=="ITG1_01" then
			Unlock("In The Groove/Disconnected -Hyper-")
		elseif params.Name=="ITG1_02" then
			Unlock("In The Groove/Disconnected -Mobius-")
		elseif params.Name=="ITG1_03" then
			Unlock("In The Groove/Infection")
		elseif params.Name=="ITG1_04" then
			Unlock("In The Groove/Xuxa")
		elseif params.Name=="ITG1_05" then
			Unlock("In The Groove/Tell")
		elseif params.Name=="ITG1_06" then
			Unlock("In The Groove/Bubble Dancer")
		elseif params.Name=="ITG1_07" then
			Unlock("In The Groove/Don't Promise Me")
		elseif params.Name=="ITG1_08" then
			Unlock("In The Groove/Anubis")
		elseif params.Name=="ITG1_09" then
			Unlock("In The Groove/DJ Party")
		elseif params.Name=="ITG1_10" then
			Unlock("In The Groove/Pandemonium")
		elseif params.Name=="ITG2_01" then
			Unlock("In The Groove 2/Disconnected Disco")
		elseif params.Name=="ITG2_02" then
			Unlock("In The Groove 2/Vertex^2")
		elseif params.Name=="ITG2_03" then
			Unlock("In The Groove 2/Wanna Do")
		elseif params.Name=="ITG2_04" then
			Unlock("In The Groove 2/Know Your Enemy")
		elseif params.Name=="ITG2_05" then
			Unlock("In The Groove 2/Hardcore Symphony")
		elseif params.Name=="ITG3_01" then
			Unlock("In The Groove 3 Unlocks/Atom Bomb")
		elseif params.Name=="ITG3_02" then
			Unlock("In The Groove 3 Unlocks/Blue")
		elseif params.Name=="ITG3_03" then
			Unlock("In The Groove 3 Unlocks/Chaos Energy")
		elseif params.Name=="ITG3_04" then
			Unlock("In The Groove 3 Unlocks/Coming Alive")
		elseif params.Name=="ITG3_05" then
			Unlock("In The Groove 3 Unlocks/Cosmic Unconsciousness")
		elseif params.Name=="ITG3_06" then
			Unlock("In The Groove 3 Unlocks/Dance Vibrations (Millenium Remix)")
		elseif params.Name=="ITG3_07" then
			Unlock("In The Groove 3 Unlocks/Elder God Shrine")
		elseif params.Name=="ITG3_08" then
			Unlock("In The Groove 3 Unlocks/Hava Nagila")
		elseif params.Name=="ITG3_09" then
			Unlock("In The Groove 3 Unlocks/In The Groove")
		elseif params.Name=="ITG3_10" then
			Unlock("In The Groove 3 Unlocks/Love Eternal")
		elseif params.Name=="ITG3_11" then
			Unlock("In The Groove 3 Unlocks/Lover on the Run")
		elseif params.Name=="ITG3_12" then
			Unlock("In The Groove 3 Unlocks/Shamrock Shebang")
		elseif params.Name=="ITG3_13" then
			Unlock("In The Groove 3 Unlocks/Shooting Star")
		elseif params.Name=="ITG3_14" then
			Unlock("In The Groove 3 Unlocks/Take me Back -2007-")
		elseif params.Name=="ITG3_15" then
			Unlock("In The Groove 3 Unlocks/What you Gonna Do")
		elseif params.Name=="ITG3_16" then
			Unlock("In The Groove 3 Unlocks/Wild Thing")
		end
	end
}