return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+120*WideScreenDiff()):diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y+158*WideScreenDiff()) end
	},
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-120*WideScreenDiff()):diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2/WideScreenDiff()):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y-158*WideScreenDiff()) end
	},
	Def.Sprite{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0) end,
		BeginCommand=function(self) self:Load(THEME:GetPathB("","profile")) end,
		OnCommand=function(self) self:linear(0.5):zoomy(0.68*WideScreenDiff()) end
	},
	LoadActor(THEME:GetPathG("","redflare"))..{
		InitCommand=function(self) self:draworder(115):blend(Blend.Add):Center():zoomx(15*WideScreenDiff()):zoomtoheight(SCREEN_HEIGHT+SCREEN_HEIGHT/4/WideScreenDiff()) end,
		OnCommand=function(self) self:decelerate(0.9):zoomtoheight(0):diffusealpha(0.5) end
	},
	LoadActor("../_flare")..{
		InitCommand=function(self) self:blend(Blend.Add):Center():zoom(0.5*WideScreenDiff()) end,
		OnCommand=function(self) self:linear(1.6):rotationz(460):zoom(0) end
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadFont("_z 36px shadowx")..{
			Text="SAVING USB PROFILES...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.25):linear(0.7):cropright(-0.3) end
		}
	},
	Def.ActorFrame{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard(),
		LoadFont("_z 36px shadowx")..{
			Text="SAVING MACHINE STATS...",
			InitCommand=function(self) self:Center():zoom(0.7*WideScreenDiff()):cropright(1.3):faderight(0.1) end,
			OnCommand=function(self) self:sleep(0.25):linear(0.7):cropright(-0.3) end
		}
	}
}