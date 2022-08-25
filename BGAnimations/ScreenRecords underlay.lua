return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_lower"))..{
		InitCommand=function(self) self:Center():zoomtowidth(SCREEN_WIDTH):diffusealpha(0.4):blend(Blend.Add) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_upper"))..{
		InitCommand=function(self) self:Center():zoomtowidth(SCREEN_WIDTH):diffusealpha(0.4):blend(Blend.Add) end;
		OnCommand=function(self) self:queuecommand("Anim") end;
		AnimCommand=function(self) self:croptop(-0.8):cropbottom(1):fadebottom(0.45):fadetop(0.45):linear(3):croptop(1):cropbottom(-0.8):sleep(1):queuecommand("Anim") end;
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_lside"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT):y(SCREEN_BOTTOM+100):halign(0):valign(1) end;
		OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
		OffCommand=function(self) self:accelerate(0.5):addy(100) end;
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/_lside"))..{
		InitCommand=function(self) self:x(SCREEN_RIGHT):y(SCREEN_BOTTOM+100):halign(0):valign(1):zoomx(-1) end;
		OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
		OffCommand=function(self) self:accelerate(0.5):addy(100) end;
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/width"))..{
		InitCommand=function(self) self:x(SCREEN_LEFT+48):y(SCREEN_BOTTOM+100):horizalign(left):vertalign(bottom):zoomtowidth(SCREEN_WIDTH-96) end;
		OnCommand=function(self) self:decelerate(0.4):y(SCREEN_BOTTOM) end;
		OffCommand=function(self) self:accelerate(0.5):addy(100) end;
	};

	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop"));

	LoadFont("_z bold gray 36px")..{
		Text="LOADING...";
		InitCommand=function(self) self:x(SCREEN_RIGHT-30):y(SCREEN_BOTTOM-50):horizalign(right):shadowlength(0.5):zoom(0.5):diffusebottomedge(color("#df0000")):diffusetopedge(color("#ff2828")) end;
		OnCommand=function(self) self:sleep(0.3):linear(0.8):diffusealpha(0) end;
	};
};