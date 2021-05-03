return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+158;diffuse,color("#000000FF");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-158;diffuse,color("#000000FF");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;);
	};
	LoadActor("lolhi")..{
		InitCommand=cmd(Center;zoomx,SCREEN_WIDTH;zoomy,.68);
	};
	LoadFont("_z 36px shadowx")..{
		Text="SAVING PROFILES...";
		InitCommand=cmd(x,SCREEN_CENTER_X+42;CenterY;zoom,0.75);
		OnCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToSave() then
				self:sleep(1)
				self:linear(0.25)
				self:diffusealpha(0)
			end
		end;
	};
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=cmd(x,SCREEN_CENTER_X+42;CenterY;zoom,0.7;diffusealpha,0);
		OnCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToSave() then
				self:sleep(1)
				self:linear(0.25)
				self:diffusealpha(1)
			end
		end;
	};
	LoadActor("_disk")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120;CenterY;);
		OnCommand=cmd(spin;decelerate,0.2;addx,-56;zoom,0;rotationz,360);
	};

	Def.Actor{
		BeginCommand=function(self)
			if SCREENMAN:GetTopScreen():HaveProfileToSave() then self:sleep(1.5); end;
			self:queuecommand("Load");
		end;
		LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
	};
};