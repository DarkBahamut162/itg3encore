return Def.ActorFrame{
	LoadActor("Intro by Angel")..{ InitCommand=function(self) self:FullScreen():zoomy(1.2):rate(0.92):sleep(35):diffusealpha(0) end },
	Def.ActorFrame{
		InitCommand=function(self) self:Center() end,
		LoadActor("swoosh")..{
			InitCommand=function(self) self:y(20):zoomtowidth(SCREEN_WIDTH):blend(Blend.Add):cropright(1):faderight(1) end,
			OnCommand=function(self) self:linear(0.5):cropright(0):faderight(0):sleep(4):linear(0.5):diffusealpha(0.0):addx(50):cropleft(1):fadeleft(1) end
		},
		LoadFont("_v 26px bold glow")..{
			Text="RoXoR Games Presents",
			InitCommand=function(self) self:blend(Blend.Add):cropright(1):faderight(1):zoom(WideScreenSemiDiff()) end,
			OnCommand=function(self) self:sleep(0.1):linear(0.2):cropright(0):faderight(0):sleep(2):linear(0.5):diffusealpha(0) end
		},
		LoadFont("_v credit")..{
			Text="RoXoR Games Presents",
			InitCommand=function(self) self:cropright(1):faderight(1):zoom(WideScreenSemiDiff()) end,
			OnCommand=function(self) self:sleep(0.1):linear(0.2):cropright(0):faderight(0):sleep(2):linear(0.5):diffusealpha(0) end
		}
	},
	Def.ActorFrame{
		Name="WaveLogo",
		InitCommand=function(self) self:x(SCREEN_CENTER_X-30):y(SCREEN_CENTER_Y-30):addy(20):addx(30):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:hibernate(3.2):linear(3.0):sleep(1.2):queuecommand("h") end,
		hCommand=function(self) self:visible(false) end,
		Def.ActorFrame{
			InitCommand=function(self) self:x(-SCREEN_WIDTH/2):y(-240) end,
			Def.ActorFrame{
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_topright"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.5):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.5) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_topright"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):rotationz(180):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.5):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.5) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_center"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
					OnCommand=function(self) self:sleep(0.3):diffusealpha(1):croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):sleep(0.8):diffusealpha(1):linear(3):croptop(1):cropbottom(-0.8):sleep(0.3) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_2top"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
					OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.2):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.3) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_2top"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):rotationz(180):diffusealpha(0) end,
					OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.1):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.25) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_left"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
					OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.1):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.3) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_left"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):rotationz(180):diffusealpha(0) end,
					OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.4):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.2) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_right"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
					OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.2):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.5) end
				},
				LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_2center"))..{
					InitCommand=function(self) self:FullScreen():blend(Blend.Add):diffusealpha(0) end,
					OnCommand=function(self) self:cropright(-0.8):cropleft(1):fadeleft(0.45):faderight(0.45):sleep(0.4):diffusealpha(1):linear(3):cropright(1):cropleft(-0.8):sleep(0.2) end
				}
			}
		},
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:zoom(0.9):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(1):linear(1):diffusealpha(1):zoom(1):sleep(1.5):accelerate(0.2):diffusealpha(0):zoom(2.3) end
		},
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:blend(Blend.Add):zoom(1):diffusealpha(0) end,
			OnCommand=function(self) self:sleep(1.5):accelerate(0.3):diffusealpha(0.4):linear(1.2):zoom(1.4):diffusealpha(0) end
		},
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/light "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:y(10):zoom(1):cropright(1.2):cropleft(-0.2):blend(Blend.Add) end,
			OnCommand=function(self) self:linear(1):cropright(-0.2):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(1.2):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.5) end
		}
	},
	LoadActor("songs"),
	LoadActor("charts"),
	LoadActor("courses"),
	LoadActor("mods"),
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffusealpha(0) end,
		OnCommand=function(self) self:hibernate(34.5):linear(0.5):diffusealpha(1):linear(0.5):diffusealpha(0) end
	}
}