-- ScreenSelectPlayMode Scroll Choice4
return Def.ActorFrame{
	MadeChoiceP1MessageCommand=cmd(playcommand,"GoOff");
	MadeChoiceP2MessageCommand=cmd(playcommand,"GoOff");
	GoOffCommand=function(self)
		self:linear(0.5);
		local bHasFocus=math.abs(self:GetZoomZ()-1.1)<0.01;
		if bHasFocus then
			self:x(0); self:y(0); self:z(200);
			self:diffuse(1,1,1,1);
			self:zoom(1);
			self:glowblink();
			self:sleep(0.5);
			self:linear(0.5);
			self:zoom(0);
		else
			self:x(0); self:y(0); self:z(0); self:zoom(0);
		end
		self:sleep(5)
	end;
	GainFocusCommand=cmd(zoom,1.0);
	LoseFocusCommand=cmd(zoom,0.6);

	Def.ActorFrame{
		InitCommand=cmd(x,-224;y,-70;zoom,.7);
		--effectdelay,.5;
		GainFocusCommand=cmd(pulse;effectmagnitude,1.2,1,0;effectclock,'beat';effectperiod,.5;effectoffset,0.6);
		LoseFocusCommand=cmd(stopeffect);

		LoadActor("stopwatch")..{InitCommand=cmd(zbuffer,true);};
		Def.ActorFrame{
			InitCommand=cmd(x,8;y,16;rotationz,15;spin;effectmagnitude,0,0,45;effectclock,"beat");
			LoadActor("hand")..{
				InitCommand=cmd(zbuffer,true;horizalign,right;vertalign,bottom;x,24;y,16);
			};
		};
		LoadActor("center")..{
			InitCommand=cmd(x,36;y,36;zbuffer,true;horizalign,right;vertalign,bottom;);
		};
	};
	LoadActor("title")..{
		InitCommand=cmd(x,-90;y,-70;zbuffer,true);
	};
	LoadActor(THEME:GetPathG("","blueflare"))..{
		InitCommand=cmd(x,-82;y,-70;blend,Blend.Add;diffusealpha,0);
		GainFocusCommand=cmd(finishtweening;zoom,0;diffusealpha,0;zoomx,7;zoomy,4;diffusealpha,1;linear,.2;zoomy,0;diffusealpha,0);
		LoseFocusCommand=cmd(diffusealpha,0);
		OffCommand=cmd(diffusealpha,0);
	};
	LoadActor(THEME:GetPathG("","blueflare"))..{
		InitCommand=cmd(x,-82;y,-70;blend,Blend.Add;diffusealpha,0);
		GainFocusCommand=cmd(finishtweening;zoom,0;diffusealpha,0;zoomx,7;zoomy,4;diffusealpha,1;linear,.4;zoomy,0;diffusealpha,0);
		LoseFocusCommand=cmd(diffusealpha,0);
		OffCommand=cmd(diffusealpha,0);
	};
};