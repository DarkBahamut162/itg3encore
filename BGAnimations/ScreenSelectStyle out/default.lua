return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+120):diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y+158) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-120):diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y-158) end
	},
	LoadActor(THEME:GetPathB("_statsout","style")),
	SOUND:PlayOnce("pop.ogg"),
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		Def.Sprite{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0) end,
			BeginCommand=function(self)
				self:Load(THEME:GetPathB("","profile"))
			end,
			OnCommand=function(self) self:linear(0.5):zoomy(0.68) end
		},
		LoadFont("_z 36px black")..{
			Text="LOADING PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.25):linear(0.7):cropright(-0.3) end
		},
		LoadActor(THEME:GetPathG("","blueflarerojo"))..{
			InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4) end,
			OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
		},
		LoadActor(THEME:GetPathG("","blueflarerojo"))..{
			InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4) end,
			OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
		},
		LoadActor("../_flare")..{
			InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X+10):CenterY():zoom(1.7) end,
			OnCommand=function(self) self:linear(1.6):rotationz(460):zoom(0) end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		Def.Sprite{
			InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0) end,
			BeginCommand=function(self)
				self:Load(THEME:GetPathB("","lolhi"))
			end,
			OnCommand=function(self) self:linear(0.5):zoomy(0.68) end
		},
		LoadFont("_z 36px shadowx")..{
			Text="LOADING...",
			InitCommand=function(self) self:Center():zoom(0.7):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.25):linear(0.7):cropright(-0.3) end
		},
		LoadActor(THEME:GetPathB("","_disk"))..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X-120):CenterY():diffusealpha(0) end,
			OnCommand=function(self) self:spin():diffusealpha(1) end
		},
		LoadActor(THEME:GetPathG("","blueflare.png"))..{
			InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4) end,
			OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
		},
		LoadActor("../_flare")..{
			InitCommand=function(self) self:blend(Blend.Add):x(SCREEN_CENTER_X-120):CenterY():zoom(0.5) end,
			OnCommand=function(self) self:linear(1.6):rotationz(460):zoom(0) end
		}
	}
}